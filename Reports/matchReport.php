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

<html>
    <link rel="stylesheet" type="text/css" href="/Style/scoutingStyle.css">
	<center><h1>Match Report</h1></center>
	<center><table cellspacing="0" cellpadding="5">
		<tr>
			<th>Alliance</th>
			<th>Robot</th>
			<th>Team</th>
			<th>Matches</th>
			<th>Exit</th>
			<th>SSHatch</th>
			<th>SSCargo</th>
			<th>TotHatch</th>
			<th>TotCargo</th>
			<th>Defense</th>
			<th>Return</th>
		</tr>

		<?php
		$match = "$_GET[matchId]";
		//echo $match;
		$sql = "select m.type || ' ' || m.number matchNumber
     , mr.matchId
     , mr.robotId
     , r.TeamNumber
     , mr.alliance
     , mr.robotNumber
     , '<a href=\"robotReport.php?robotId=' || mr.robotId || '\"> ' || r.TeamNumber || '</a> ' r3RobotReportUrl
     , count(*) matchCnt
     , round(avg(sr.leaveHab),1) leaveHabAvg
     , round(avg(sr.ssHatchCnt),1) ssHatchCnt
     , round(avg(sr.ssCargoCnt),1) ssCargoCnt
     , round(avg(sr.toHatchCnt + sr.ssHatchCnt),1) totHatchCnt
     , round(avg(sr.toCargoCnt + sr.ssCargoCnt),1) totCargoCnt
     , round(avg(sr.playedDefense),1) playedDefense
     , round(avg(sr.returnToHab),1) returnToHab
 from Match m
       inner join MatchRobot mr
       on mr.matchId = m.id
       inner join Robot r
       on r.id = mr.robotId
       left outer join v_AvgScoutRecord sr
       on sr.robotId = mr.robotId
       and exists (select 1
                     from match m2
                    where m2.id = sr.matchId
					  and m2.isActive = 'Y')
					  where m.id = $match
group by m.type || ' ' || m.number
       , mr.matchId
       , mr.robotId
       , r.TeamNumber
       , mr.alliance
       , mr.robotNumber order by alliance, robotNumber;";
		  
    $stmt = db2_exec($conn, $sql, array('cursor' => DB2_SCROLLABLE));

    while($row = db2_fetch_array($stmt)) {
        ?>
       <tr>
           <td><?php echo "$row[4]";?></td>
           <td><?php echo "$row[5]";?></td>
           <td><?php echo "$row[6]";?></td>
           <td><?php echo "$row[7]";?></td>
           <td><?php echo "$row[8]";?></td>
           <td><?php echo "$row[9]";?></td>
           <td><?php echo "$row[10]";?></td>
           <td><?php echo "$row[11]";?></td>
           <td><?php echo "$row[12]";?></td>
           <td><?php echo "$row[13]";?></td>
           <td><?php echo "$row[14]";?></td>
        </tr>
    <?php
    }
    db2_close();
    ?>
    </center></table>
</html>