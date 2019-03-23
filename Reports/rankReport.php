<html>
<link rel="stylesheet" type="text/css" href="/Style/scoutingStyle.css">
<?php
    if( getenv( "VCAP_SERVICES" ) )
			{
				# Get database details from the VCAP_SERVICES environment variable
				#
				# *This can only work if you have used the Bluemix dashboard to 
				# create a connection from your dashDB service to your PHP App.
				#
				$details  = json_decode( getenv( "VCAP_SERVICES" ), true );
				$dsn      = $details [ "dashDB For Transactions" ][0][ "credentials" ][ "dsn" ];
				$ssl_dsn  = $details [ "dashDB For Transactions" ][0][ "credentials" ][ "ssldsn" ];

				# Build the connection string
				#
				$driver = "DRIVER={IBM DB2 ODBC DRIVER};";
				$conn_string = $driver . $dsn;     # Non-SSL
				$conn_string = $driver . $ssl_dsn; # SSL
				
				$conn = db2_connect($conn_string, "", "" );

				if(!$conn) {
					echo "<p>Connection failed.</p>";
					//db2_close( $conn );
				}

			}
			else {
				echo "<p>No credentials.</p>";
			}

$sql = "select r.TeamNumber
     , avg(rank) avgRank
     , sum(decode(measureType, 'leaveHab', rank, 0)) rankLeaveHab
     , sum(decode(measureType, 'totHatchCnt', rank, 0)) rankTotHatch
     , sum(decode(measureType, 'totCargoCnt', rank, 0)) rankTotCargo
     , sum(decode(measureType, 'playedDefense', rank, 0)) rankPlayedDefense
     , sum(decode(measureType, 'returnToHab', rank, 0)) rankReturnToHab
     , sum(decode(measureType, 'leaveHab', val, 0)) leaveHab
     , sum(decode(measureType, 'totHatchCnt', val, 0)) totHatch
     , sum(decode(measureType, 'totCargoCnt', val, 0)) totCargo
     , sum(decode(measureType, 'playedDefense', val, 0)) playedDefense
     , sum(decode(measureType, 'returnToHab', val, 0)) returnToHab
     , TeamName
     , sum(decode(measureType, 'ssHatchCnt', rank, 0)) rankSsHatch
     , sum(decode(measureType, 'ssCargoCnt', rank, 0)) rankSsCargo
     , sum(decode(measureType, 'ssHatchCnt', val, 0)) ssHatch
     , sum(decode(measureType, 'ssCargoCnt', val, 0)) ssCargo
  from (
select arr.robotId
     , 'leaveHab' measureType
     , round(arr.leaveHab, 2) val
     , (select count(*)
          from v_AvgRobotRecord arr2
         where arr2.leaveHab > arr.leaveHab) + 1 rank
  from v_AvgRobotRecord arr
union
select arr.robotId
     , 'ssHatchCnt' measureType
     , round(arr.ssHatchCnt, 2) val
     , (select count(*)
          from v_AvgRobotRecord arr2
         where arr2.ssHatchCnt > arr.ssHatchCnt ) + 1 rank
  from v_AvgRobotRecord arr
union
select arr.robotId
     , 'ssCargoCnt' measureType
     , round(arr.ssCargoCnt, 2) val
     , (select count(*)
          from v_AvgRobotRecord arr2
         where arr2.ssCargoCnt > arr.ssCargoCnt ) + 1 rank
  from v_AvgRobotRecord arr
union
select arr.robotId
     , 'totHatchCnt' measureType
     , round(arr.ssHatchCnt + arr.toHatchCnt, 2) val
     , (select count(*)
          from v_AvgRobotRecord arr2
         where arr2.ssHatchCnt + arr2.toHatchCnt > arr.ssHatchCnt + arr.toHatchCnt) + 1 rank
  from v_AvgRobotRecord arr
union
select arr.robotId
     , 'totCargoCnt' measureType
     , round(arr.ssCargoCnt + arr.toCargoCnt, 2) val
     , (select count(*)
          from v_AvgRobotRecord arr2
         where arr2.ssCargoCnt + arr2.toCargoCnt > arr.ssCargoCnt + arr.toCargoCnt) + 1 rank
  from v_AvgRobotRecord arr
union
select arr.robotId
     , 'playedDefense' measureType
     , round(arr.playedDefense, 2) val
     , (select count(*)
          from v_AvgRobotRecord arr2
         where arr2.playedDefense > arr.playedDefense) + 1 rank
  from v_AvgRobotRecord arr
union
select arr.robotId
     , 'returnToHab' measureType
     , round(arr.returnToHab, 2) val
     , (select count(*)
          from v_AvgRobotRecord arr2
         where arr2.returnToHab > arr.returnToHab) + 1 rank
  from v_AvgRobotRecord arr
) subquery
       inner join Robot r
       on r.id = subquery.robotId
 where r.isActive = 'Y'
group by r.TeamNumber
       , r.TeamName
order by " . "$_GET[sortorder]" . ";";
?>
<center>
    <table cellspacing="0" cellpadding="5">
        <tr>
            <th>Team</th>
            <th>AVG</th>
            <th>Exit</th>
            <th>Hatches</th>
            <th>Cargo</th>
            <th>Defense</th>
            <th>Return</th>
            <th>Exit</th>
            <th>Hatches</th>
            <th>Cargo</th>
            <th>Defense</th>
            <th>Return</th>
        </tr>
        <?php
        $stmt = db2_exec($conn, $sql, array('cursor' => DB2_SCROLLABLE));
        while($row = db2_fetch_array($stmt)) {
        ?>
        <tr>
            <td><?php echo "$row[0]";?></td>
            <td><?php echo "$row[1]";?></td>
            <td><?php echo "$row[2]";?></td>
            <td><?php echo "$row[3]";?></td>
            <td><?php echo "$row[4]";?></td>
            <td><?php echo "$row[5]";?></td>
            <td><?php echo "$row[6]";?></td>
            <td><?php echo "$row[7]";?></td>
            <td><?php echo "$row[8]";?></td>
            <td><?php echo "$row[9]";?></td>
            <td><?php echo "$row[10]";?></td>
             <td><?php echo "$row[11]";?></td>
        </tr>
        <?php
        }
        db2_close();
        ?>
    </table>
</center>
</html>