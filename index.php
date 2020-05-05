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

	// Build data for Line Graph
	$rows = array();
	$table = array();

	$table['cols'] = array(
	 array('label' => 'Match', 'type' => 'number'),
	 array('label' => 'Red Score', 'type' => 'number'),
	 array('label' => 'Blue Score', 'type' => 'number'),
	 array('label' => 'Total Score', 'type' => 'number'),
	);
	$tsql = "select row_number() over(order by datetime) rowNumber
                  , matchNumber
				  , redScore
				  , blueScore
				  , redScore + blueScore totalScore
			   from v_MatchHyperlinks
			 order by datetime, matchNumber";
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
		$temp = array();
		$temp[] = array('v' => (float) $row['rowNumber']); 
		$temp[] = array('v' => (float) $row['redScore']); 
		$temp[] = array('v' => (float) $row['blueScore']); 
		$temp[] = array('v' => (float) $row['totalScore']); 
		$rows[] = array('c' => $temp);
	}
	$table['rows'] = $rows;
	$jsonTableLineGraph = json_encode($table);

?>
<html>
     <meta name="viewport" content="width=device-width, initial-scale=1">
	 <script src="https://apis.google.com/js/platform.js" async defer></script>
     <title>Team 6217 Scouting App</title>
     <link rel="stylesheet" type="text/css" href="Style/scoutingStyle.css">
    <head>
		<!--Load the Ajax API-->
		<script type="text/javascript" src="https://www.google.com/jsapi"></script>
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
		<script type="text/javascript">

		// Load the Visualization API and the piechart package.
		google.load('visualization', '1', {'packages':['corechart']});

		// Set a callback to run when the Google Visualization API is loaded.
		google.setOnLoadCallback(drawLineGraph);

		function drawLineGraph() {

		  // Create our data table out of JSON data loaded from server.
		  var data = new google.visualization.DataTable(<?=$jsonTableLineGraph?>);
		  var options = {
			   title: 'Match Scoring Trend',
			   legend: {position: 'bottom'},
			   colors: ['#ff0000', '#0000ff', '#ff00ff'],
			   hAxis: {title: 'Match'},
               vAxis: {title: 'Score'},
			   chartArea:{width:'90%', height:'60%'},
               trendlines: { 2: {labelInLegend: 'Total Score Trend'
			                   , visibleInLegend: true
			                   , color: '#013220' // Dark Green
							   , lineWidth: 5
							   , opacity: 0.3} }    // Draw a trendline for total score.
			};
		  // Instantiate and draw our chart, passing in some options.
		  // Do not forget to check your div ID
		  var chart = new google.visualization.LineChart(document.getElementById('line_chart_div'));
		  chart.draw(data, options);
		}

		</script>
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
		<meta name="google-signin-client_id" content="521347466058-vnmcclmps4a1galclba7jq6rpkj813ca.apps.googleusercontent.com">
    </head>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <h1><center>Team 6217 Bomb Botz Scouting App</center></h1>
	    <h2><center>
		<?php
		$tsql = "select g.name game_name
                      , e.name event_name
	                  , ge.eventDate
                   from GameEvent ge
                        inner join Game g
	                    on g.id = ge.gameId
	                    inner join Event e
	                    on e.id = ge.eventId
                  where ge.isActive = 'Y'
                 order by ge.eventDate";
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
			echo $row['game_name'] . ", " . $row['event_name'];
		}
		sqlsrv_free_stmt($getResults);
		?>
		</center></h2>

    <img class="image1" src="Flag/USA.png" style="max-width: 10%; float: left; border-radius: 100%;">
    <img class="image2" src="Flag/Brazil.png" style="max-width: 10%; float: right; border-radius: 100%;">
    <p></p>
    <h2>
          <center><a id="mainpage" class="clickme danger" href="scoutRecord.php">Scout Match</a>
		  <a id="mainpage" class="clickme danger" href="robotAttrList.php">Scout Robot</a></center>
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
	echo '<div id="reportsby"><a class="clickme danger" href="Reports/rankReport.php?sortOrder=eventRank&rankName=Ranking Points">Rank by Ranking Pts</a></div>';
    ?>
     </center> </h2>
    <h2>
          <center><a id="mainpage" class="clickme danger" href="eventSetup.php">Event Setup</a></center>
          <p></p>
     </h2>
    <br>
	<center><div class="g-signin2" data-onsuccess="onSignIn"></div></center>
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
        <th>Links</th>
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
				  , videos
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
			<?php
			if ($row['redScore'] > $row['blueScore']) {
				$redTdTag = "<td><b>";
				$redTdTagEnd = "</b></td>";
			}
			else {
				$redTdTag = "<td>";
				$redTdTagEnd = "</td>";
			}
			if ($row['blueScore'] > $row['redScore']) {
				$blueTdTag = "<td><b>";
				$blueTdTagEnd = "</b></td>";
			}
			else {
				$blueTdTag = "<td>";
				$blueTdTagEnd = "</td>";
			}
			echo "<td>" . ($row['matchReportUrl']) . "</td>";
			echo "<td>" . ($row['datetime']->format('m/d H:i')) . "</td>";
            echo $redTdTag . ($row['r1TeamReportUrl']) . $redTdTagEnd;
            echo $redTdTag . ($row['r1TeamScoutUrl']) . $redTdTagEnd;
            echo $redTdTag . ($row['r2TeamReportUrl']) . $redTdTagEnd;
            echo $redTdTag . ($row['r2TeamScoutUrl']) . $redTdTagEnd;
            echo $redTdTag . ($row['r3TeamReportUrl']) . $redTdTagEnd;
            echo $redTdTag . ($row['r3TeamScoutUrl']) . $redTdTagEnd;
            echo $blueTdTag . ($row['b1TeamReportUrl']) . $blueTdTagEnd;
            echo $blueTdTag . ($row['b1TeamScoutUrl']) . $blueTdTagEnd;
            echo $blueTdTag . ($row['b2TeamReportUrl']) . $blueTdTagEnd;
            echo $blueTdTag . ($row['b2TeamScoutUrl']) . $blueTdTagEnd;
            echo $blueTdTag . ($row['b3TeamReportUrl']) . $blueTdTagEnd;
            echo $blueTdTag . ($row['b3TeamScoutUrl']) . $blueTdTagEnd;
            echo $redTdTag . "<center>" . ($row['redScore']) . "</center>" . $redTdTagEnd;
            echo $blueTdTag . "<center>" . ($row['blueScore']) . "</center>" . $blueTdTagEnd;
			echo "<td>" . $row['videos'] . "</td>";
		   ?>
        </tr>
    <?php
    }
    sqlsrv_free_stmt($getResults);
	sqlsrv_close($conn);
    ?>
    </table>
	</center>
    <center>
		<!--this is the div that will hold the pie chart-->
		<div id="line_chart_div" style="width: 70%"></div>
    </center>
</html> 
