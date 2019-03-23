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
?>
<center><h1>Robot Report</h1></center>
<center><table cellspacing="0" cellpadding="5">
    <tr>
            <th>Team</th>
            <th>Match</th>
            <th>Time</th>
            <th>Scout</th>
            <th>Exit</th>
            <th>SSHatch</th>
            <th>SSCargo</th>
            <th>TotHatch</th>
            <th>TotCargo</th>
            <th>Defense</th>
            <th>Return</th>       
    </tr>

<?php
$robot = "$_GET[robotId]";
$sql = "select r.TeamNumber
     , 'N/A' matchNumber
     , max(m.datetime + 1) matchTime
     , 'Average Score' scoutName
     , round(avg(sr.leaveHab),1) leaveHab
     , round(avg(sr.ssHatchCnt),1) ssHatchCnt
     , round(avg(sr.ssCargoCnt),1) ssCargoCnt
     , round(avg(sr.toHatchCnt + sr.ssHatchCnt),1) totHatchCnt
     , round(avg(sr.toCargoCnt + sr.ssCargoCnt),1) totCargoCnt
     , round(avg(sr.playedDefense),1) playedDefense
     , round(avg(sr.returnToHab),1) returnToHab
     , r.id robotId
     , null matchId
     , null scoutId
from Robot r
      inner join v_AvgScoutRecord sr
      on sr.robotId = r.id
      inner join Match m
      on m.id = sr.matchId
where r.id = $robot
and m.isactive = 'Y'
group by r.TeamNumber
       , r.id
union
select r.TeamNumber
     , m.type || ' ' || m.number matchNumber
     , m.datetime matchTime
     , s.lastName || ', ' || firstName scoutName
     , sr.leaveHab
     , sr.ssHatchCnt
     , sr.ssCargoCnt
     , sr.toHatchCnt + sr.ssHatchCnt totHatchCnt
     , sr.toCargoCnt + sr.ssCargoCnt totCargoCnt
     , sr.playedDefense
     , sr.returnToHab
     , sr.robotId
     , sr.matchId
     , sr.scoutId
from Robot r
      inner join scoutRecord sr
      on sr.robotId = r.id
      inner join Match m
      on m.id = sr.matchId
      inner join scout s
      on s.id = sr.scoutId
where r.id = $robot
and m.isactive = 'Y'
order by matchTime, matchNumber;";

    $stmt = db2_exec($conn, $sql, array('cursor' => DB2_SCROLLABLE));

    if(!$stmt) {
        $error = db2_stmt_error();
        echo $error;
    }

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
</tr>
<?php
    }
    db2_close();
?>
</table><center>
</html>