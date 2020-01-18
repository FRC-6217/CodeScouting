<html>
     <meta name="viewport" content="width=device-width, initial-scale=1">
     <title>Scouting App</title>
     <link rel="stylesheet" type="text/css" href="Style/scoutingStyle.css">
<?php
    $serverName = getenv("ScoutAppDatabaseServerName");
	$database = getenv("Database");
	$userName = getenv("DatabaseUserName");
	$password = getenv("DatabasePassword");
    $connectionOptions = array(
        "Database" => "$database",
        "Uid" => "$userName",
        "PWD" => "$password"
    );
    //Establishes the connection
    $conn = sqlsrv_connect($serverName, $connectionOptions);
?>
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

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <h1><center>Bomb Botz Scouting App</center></h1>
	    <h2><center>Infinite Recharge, Lake Superior Regional</center></h2>
    <img class="image1" src="Flag/USA.png" style="max-width: 10%; float: left; border-radius: 100%;">
    <img class="image2" src="Flag/Brazil.png" style="max-width: 10%; float: right; border-radius: 100%;">
    <p></p>
    <h2>
          <center><a id="mainpage" class="clickme danger" href="scoutRecord.php">Scout Record</a></center>
          <p></p>
     </h2>
    <center><h2>
    <?php
    $tsql = "select buttonHtml
	              , sortOrder
			   from v_RankButtons
			  order by sortOrder";
    $getResults = sqlsrv_query($conn, $tsql);
    if ($getResults == FALSE)
		if( ($errors = sqlsrv_errors() ) != null) {
			foreach( $errors as $error ) {
				echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
				echo "code: ".$error[ 'code']."<br />";
				echo "message: ".$error[ 'message']."<br />";
			}
		}
    while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
		echo ($row['buttonHtml']);
    }
    sqlsrv_free_stmt($getResults);
    ?>
     </center> </h2>
    <h2>
          <center><a id="mainpage" class="clickme danger" href="eventSetup.php">Event Setup</a></center>
          <p></p>
     </h2>
    <br>

    <center><table cellspacing="0" cellpadding="5">
    <tr>
        <th>Match </th>
        <th>Time</th>
        <th>Red 1</th>
        <th>S</th>
        <th>Red 2</th>
        <th>S</th>
        <th>Red 3</th>
        <th>S</th>
        <th>Blu 1</th>
        <th>S</th>
        <th>Blu 2</th>
        <th>S</th>
        <th>Blu 3</th>
        <th>S</th>
        <th>Red Sc</th>
        <th>Blu Sc</th>
     </tr>

    <?php
    $tsql = "select matchReportUrl
	              , r1TeamNumber
				  , r1TeamReportUrl
				  , r1TeamScoutUrl
				  , r2TeamNumber
				  , r2TeamReportUrl
				  , r2TeamScoutUrl
				  , r3TeamNumber
				  , r3TeamReportUrl
				  , r3TeamScoutUrl
				  , b1TeamNumber
				  , b1TeamReportUrl
				  , b1TeamScoutUrl
				  , b2TeamNumber
				  , b2TeamReportUrl
				  , b2TeamScoutUrl
				  , b3TeamNumber
				  , b3TeamReportUrl
				  , b3TeamScoutUrl
				  , sortOrder
				  , matchNumber
				  , matchId
				  , datetime
				  , redScore
				  , blueScore
				  , r1TeamId
				  , r2TeamId
				  , r3TeamId
				  , b1TeamId
				  , b2TeamId
				  , b3TeamId
			   from v_MatchHyperlinks
			  order by sortOrder, datetime, matchNumber";
    $getResults = sqlsrv_query($conn, $tsql);
    if ($getResults == FALSE)
		if( ($errors = sqlsrv_errors() ) != null) {
			foreach( $errors as $error ) {
				echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
				echo "code: ".$error[ 'code']."<br />";
				echo "message: ".$error[ 'message']."<br />";
			}
		}
    while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
        ?>
       <tr>
           <td><?php echo ($row['matchReportUrl']);?></td>
           <td><?php echo ($row['datetime'])->format('m/d H:i');?></td>
           <td><?php echo ($row['r1TeamReportUrl']);?></td>
           <td><?php echo ($row['r1TeamScoutUrl']);?></td>
           <td><?php echo ($row['r2TeamReportUrl']);?></td>
           <td><?php echo ($row['r2TeamScoutUrl']);?></td>
           <td><?php echo ($row['r3TeamReportUrl']);?></td>
           <td><?php echo ($row['r3TeamScoutUrl']);?></td>
           <td><?php echo ($row['b1TeamReportUrl']);?></td>
           <td><?php echo ($row['b1TeamScoutUrl']);?></td>
           <td><?php echo ($row['b2TeamReportUrl']);?></td>
           <td><?php echo ($row['b2TeamScoutUrl']);?></td>
           <td><?php echo ($row['b3TeamReportUrl']);?></td>
           <td><?php echo ($row['b3TeamScoutUrl']);?></td>
           <td><center><?php echo ($row['redScore']);?></center></td>
           <td><center><?php echo ($row['blueScore']);?></center></td>
        </tr>
    <?php
    }
    sqlsrv_free_stmt($getResults);
	sqlsrv_close($conn);
    ?>
    </table>
	</center>
</html> 
