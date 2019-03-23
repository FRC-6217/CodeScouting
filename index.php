<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Scouting App</title>
<link rel="stylesheet" type="text/css" href="Style/scoutingStyle.css">
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
    <head>
        <link rel="apple-touch-icon" sizes="57x57" href="/Logo/apple-icon-57x57.png">
        <link rel="apple-touch-icon" sizes="60x60" href="/Logo/apple-icon-60x60.png">
        <link rel="apple-touch-icon" sizes="72x72" href="/Logo/apple-icon-72x72.png">
        <link rel="apple-touch-icon" sizes="76x76" href="/Logo/apple-icon-76x76.png">
        <link rel="apple-touch-icon" sizes="114x114" href="/Logo/apple-icon-114x114.png">
        <link rel="apple-touch-icon" sizes="120x120" href="/Logo/apple-icon-120x120.png">
        <link rel="apple-touch-icon" sizes="144x144" href="/Logo/apple-icon-144x144.png">
        <link rel="apple-touch-icon" sizes="152x152" href="/Logo/apple-icon-152x152.png">
        <link rel="apple-touch-icon" sizes="180x180" href="/Logo/apple-icon-180x180.png">
        <link rel="icon" type="image/png" sizes="192x192" href="/Logo/android-icon-192x192.png">
        <link rel="icon" type="image/png" sizes="32x32" href="/Logo/favicon-32x32.png">
        <link rel="icon" type="image/png" sizes="96x96" href="/Logo/favicon-96x96.png">
        <link rel="icon" type="image/png" sizes="16x16" href="/Logo/favicon-16x16.png">
        <link rel="manifest" href="/Logo/manifest.json">
        <meta name="msapplication-TileColor" content="#ffffff">
        <meta name="msapplication-TileImage" content="/Logo/ms-icon-144x144.png">
        <meta name="theme-color" content="#ffffff">
    </head>

    <center><h1>BOMB BOTZ SCOUTING APP</h1></center>
    <img class="image1" src="Flag/USA.png" style="max-width: 10%; float: left;">
    <img class="image2" src="Flag/Brazil.png" style="max-width: 10%; float: right;">
    <p></p>
    <h2>
          <center><a id="mainpage" class="clickme danger" href="scoutRecord.php">Scout Record</a></center>
          <p></p>
          <center><a id="mainpage" class="clickme danger" href="reportMenu.php">Reports</a></center>
          <p></p>
     </h2>
    <center><h3>
          <div id="reportsby"><a class="clickme danger" href="Reports/rankReport.php?sortorder=rankLeaveHab">Rank by Exit </a></div>
          <div id="reportsby"><a class="clickme danger" href="Reports/rankReport.php?sortorder=rankTotHatch">Rank by Hatches </a></div>
          <div id="reportsby"><a class="clickme danger" href="Reports/rankReport.php?sortorder=rankTotCargo">Rank by Cargo </a></div>
          <div id="reportsby"><a class="clickme danger" href="Reports/rankReport.php?sortorder=rankPlayedDefense">Rank by Defense </a></div>
          <div id="reportsby"><a class="clickme danger" href="Reports/rankReport.php?sortorder=rankReturnToHab">Rank by Return </a></div>
     </center> </h3>
    <br>

    <center><table cellspacing="0" cellpadding="5">
    <tr>
        <th>Match </th>
        <th>Red1</th>
        <th>R</th>
        <th>S</th>
        <th>Red2</th>
        <th>R</th>
        <th>S</th>
        <th>Red3</th>
        <th>R</th>
        <th>S</th>
        <th>Blue1</th>
        <th>R</th>
        <th>S</th>
        <th>Blue2</th>
        <th>R</th>
        <th>S</th>
        <th>Blue3</th>
        <th>R</th>
        <th>S</th>
     </tr>
    
    <?php

   $sql = "
select '<a href=\"Reports/matchReport.php?matchId=' || subquery.matchId || '\"> ' || subquery.matchNumber || '</a>' matchReportUrl
     , subquery.r1TeamNumber
     , '<a href=\"Reports/robotReport.php?robotId=' || subquery.r1RobotId || '\"> R </a>' r1RobotReportUrl
     , '<a href=\"scoutRecord.php?matchId=' || subquery.matchId || ';matchNumber=' || subquery.matchNumber || ';robotId=' || subquery.r1RobotId || '\"> S </a>' r1RobotScoutUrl
     , subquery.r2TeamNumber
     , '<a href=\"Reports/robotReport.php?robotId=' || subquery.r2RobotId || '\"> R </a>' r2RobotReportUrl
     , '<a href=\"scoutRecord.php?matchId=' || subquery.matchId || ';matchNumber=' || subquery.matchNumber || ';robotId=' || subquery.r2RobotId || '\"> S </a>' r2RobotScoutUrl
     , subquery.r3TeamNumber
     , '<a href=\"Reports/robotReport.php?robotId=' || subquery.r3RobotId || '\"> R </a>' r3RobotReportUrl
     , '<a href=\"scoutRecord.php?matchId=' || subquery.matchId || ';matchNumber=' || subquery.matchNumber || ';robotId=' || subquery.r3RobotId || '\"> S </a>' r3RobotScoutUrl
     , subquery.b1TeamNumber
     , '<a href=\"Reports/robotReport.php?robotId=' || subquery.b1RobotId || '\"> R </a>' b1RobotReportUrl
     , '<a href=\"scoutRecord.php?matchId=' || subquery.matchId || ';matchNumber=' || subquery.matchNumber || ';robotId=' || subquery.b1RobotId || '\"> S </a>' b1RobotScoutUrl
     , subquery.b2TeamNumber
     , '<a href=\"Reports/robotReport.php?robotId=' || subquery.b2RobotId || '\"> R </a>' b2RobotReportUrl
     , '<a href=\"scoutRecord.php?matchId=' || subquery.matchId || ';matchNumber=' || subquery.matchNumber || ';robotId=' || subquery.b2RobotId || '\"> S </a>' b2RobotScoutUrl
     , subquery.b3TeamNumber
     , '<a href=\"Reports/robotReport.php?robotId=' || subquery.b3RobotId || '\"> R </a>' b3RobotReportUrl
     , '<a href=\"scoutRecord.php?matchId=' || subquery.matchId || ';matchNumber=' || subquery.matchNumber || ';robotId=' || subquery.b3RobotId || '\"> S </a>' b3RobotScoutUrl
     , subquery.sortOrder
     , subquery.matchNumber
     , subquery.matchId
     , subquery.r1RobotId
     , subquery.r2RobotId
     , subquery.r3RobotId
     , subquery.b1RobotId
     , subquery.b2RobotId
     , subquery.b3RobotId
  from (
select case when timestampdiff(4, m.datetime - current timestamp) + 330 < 0 then 1 else 0 end sortOrder
     , m.type || ' ' || m.number matchNumber
     , m.id matchId
     , (select r.teamNumber
          from MatchRobot mr
               inner join Robot r
               on r.id = mr.robotId
         where mr.matchId = m.id
           and alliance = 'R'
           and robotNumber = 1) r1TeamNumber
     , (select mr.robotId
          from MatchRobot mr
               inner join Robot r
               on r.id = mr.robotId
         where mr.matchId = m.id
           and alliance = 'R'
           and robotNumber = 1) r1RobotId
     , (select r.teamNumber
          from MatchRobot mr
               inner join Robot r
               on r.id = mr.robotId
         where mr.matchId = m.id
           and alliance = 'R'
           and robotNumber = 2) r2TeamNumber
     , (select mr.robotId
          from MatchRobot mr
               inner join Robot r
               on r.id = mr.robotId
         where mr.matchId = m.id
           and alliance = 'R'
           and robotNumber = 2) r2RobotId
     , (select r.teamNumber
          from MatchRobot mr
               inner join Robot r
               on r.id = mr.robotId
         where mr.matchId = m.id
           and alliance = 'R'
           and robotNumber = 3) r3TeamNumber
     , (select mr.robotId
          from MatchRobot mr
               inner join Robot r
               on r.id = mr.robotId
         where mr.matchId = m.id
           and alliance = 'R'
           and robotNumber = 3) r3RobotId
     , (select r.teamNumber
          from MatchRobot mr
               inner join Robot r
               on r.id = mr.robotId
         where mr.matchId = m.id
           and alliance = 'B'
           and robotNumber = 1) b1TeamNumber
     , (select mr.robotId
          from MatchRobot mr
               inner join Robot r
               on r.id = mr.robotId
         where mr.matchId = m.id
           and alliance = 'B'
           and robotNumber = 1) b1RobotId
     , (select r.teamNumber
          from MatchRobot mr
               inner join Robot r
               on r.id = mr.robotId
         where mr.matchId = m.id
           and alliance = 'B'
           and robotNumber = 2) b2TeamNumber
     , (select mr.robotId
          from MatchRobot mr
               inner join Robot r
               on r.id = mr.robotId
         where mr.matchId = m.id
           and alliance = 'B'
           and robotNumber = 2) b2RobotId
     , (select r.teamNumber
          from MatchRobot mr
               inner join Robot r
               on r.id = mr.robotId
         where mr.matchId = m.id
           and alliance = 'B'
           and robotNumber = 3) b3TeamNumber
     , (select mr.robotId
          from MatchRobot mr
               inner join Robot r
               on r.id = mr.robotId
         where mr.matchId = m.id
           and alliance = 'B'
           and robotNumber = 3) b3RobotId
  from Match m
 where isActive = 'Y') subquery order by sortorder, matchnumber;";
    
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
           <td><?php echo "$row[12]";?></td>
           <td><?php echo "$row[13]";?></td>
           <td><?php echo "$row[14]";?></td>
           <td><?php echo "$row[15]";?></td>
           <td><?php echo "$row[16]";?></td>
           <td><?php echo "$row[17]";?></td>
           <td><?php echo "$row[18]";?></td>
        </tr>
    <?php
    }
    db2_close();
    ?>
    </table></center>
</html>