<?php
	$page = $_SERVER['PHP_SELF'];
	$sec = "120";
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
	$loginEmailAddress = getenv("DefaultLoginEmailAddress");
	$tsql = "select scoutGUID from Scout where emailAddress = '$loginEmailAddress'";
    $getResults = sqlsrv_query($conn, $tsql);
    if ($getResults == FALSE)
		if( ($errors = sqlsrv_errors() ) != null) {
			foreach( $errors as $error ) {
				echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
				echo "code: ".$error[ 'code']."<br />";
				echo "message: ".$error[ 'message']."<br />";
			}
		}
	$row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC);
	$loginGUID = $row['scoutGUID'];

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
			  where loginGUID = '$loginGUID'
			  and matchNumber like 'QM%'
			  and coalesce(redScore, 0) + coalesce(blueScore, 0) <> 0
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
		<meta http-equiv="refresh" content="<?php echo $sec?>;URL='<?php echo $page?>'">
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
    </head>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <h1><center>Team 6217 Bomb Botz Scouting App</center></h1>
	    <h2><center>
		<h2>
          <center><a id="mainpage" class="clickme danger" href="sponsors.php">All Sponsors</a>
		  <p></p><a href="https://geminimade.com/" target="_blank"><img class="image10" src="Sponsors/Gemini.jpg" style="max-width: 18%"></a>
		</center>
          <p></p>
     </h2>
		<?php
		$tsql = "select g.name game_name
                      , e.name event_name
                      , ge.eventDate
                   from v_GameEvent ge
                        inner join Game g on g.id = ge.gameId
                 	   inner join Event e on e.id = ge.eventId
                  where ge.loginGUID = '$loginGUID'
                 order by ge.eventDate ";
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

    <img class="image1" src="Logo/Logo.png" style="max-width: 10%; float: left; border-radius: 100%;">
    <img class="image2" src="Flag/Brazil.png" style="max-width: 10%; float: right; border-radius: 100%;">
    <p></p>
    <h2>
          <center><a id="mainpage" class="clickme danger" href="robotAttrList.php">Pit Scout</a></center>
          <p></p>
     </h2>
	 
    <center><h2>
    <?php
    $tsql = "select buttonHtml
	              , sortOrder
			   from v_RankButtons
			  where loginGUID = '$loginGUID'
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
	<center><h2>
	<?php
		// Display Webcast Links
		$tsql = "select gew.webcastURL
				   from v_GameEvent ge
				        inner join GameEventWebcast gew
				        on gew.gameEventId = ge.id
                  where ge.loginGUID = '$loginGUID'";
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
				echo '<a id="mainpage" class="clickme danger" href="' . $row['webcastURL'] . '" target="_blank">Event Webcast</a>';
			}
			sqlsrv_free_stmt($getResults);
	?>
	</h2></center>
	<center><table cellspacing="0" cellpadding="5">
    <tr>
        <th> </th>
        <th>Match </th>
        <th>Time</th>
        <th>Red 1</th>
        <th>Red 2</th>
        <th>Red 3</th>
        <th>Blu 1</th>
        <th>Blu 2</th>
        <th>Blu 3</th>
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
				  , case when r1TeamId = s.teamId or r2TeamId = s.teamId or r3TeamId = s.teamId or b1TeamId = s.teamId or b2TeamId = s.teamId or b3TeamId = s.teamId
				         then '*'
						 else ' ' end teamIndicator
			   from v_MatchHyperlinks
			        inner join Scout s
			        on s.scoutGUID = v_MatchHyperlinks.loginGUID
		      where loginGUID = '$loginGUID'
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
			echo "<td>" . ($row['teamIndicator']) . "</td>";
			echo "<td>" . ($row['matchReportUrl']) . "</td>";
			if (isset($row['datetime'])) echo "<td>" . ($row['datetime']->format('m/d H:i')) . "</td>";else echo "<td></td>";
            echo $redTdTag . ($row['r1TeamReportUrl']) . $redTdTagEnd;
            echo $redTdTag . ($row['r2TeamReportUrl']) . $redTdTagEnd;
            echo $redTdTag . ($row['r3TeamReportUrl']) . $redTdTagEnd;
            echo $blueTdTag . ($row['b1TeamReportUrl']) . $blueTdTagEnd;
            echo $blueTdTag . ($row['b2TeamReportUrl']) . $blueTdTagEnd;
            echo $blueTdTag . ($row['b3TeamReportUrl']) . $blueTdTagEnd;
            echo $redTdTag . "<center>" . ($row['redScore']) . "</center>" . $redTdTagEnd;
            echo $blueTdTag . "<center>" . ($row['blueScore']) . "</center>" . $blueTdTagEnd;
			echo "<td>" . $row['videos'] . "</td>";
		   ?>
        </tr>
    <?php
    }
    sqlsrv_free_stmt($getResults);
    ?>
    </table>
	</center>
    <center>
		<!--this is the div that will hold the pie chart-->
		<div id="line_chart_div" style="width: 70%"></div>
    <p></p>
    <img class="image3" src="Logo/QRCode.png" style="max-width: 40%">
    </center>
	<center><p></p><h1>THANK YOU! to our Amazing Bomb-Botz Sponsors</h1></center>
	<center>
	<?php
		// Display Sponsors
		$tsql = "select sh.sponsorHTML
				   from v_SponsorHyperlinks sh
                  where sh.loginGUID = '$loginGUID'
				 order by sh.sortOrder";
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
				echo $row['sponsorHTML'];
			}
			sqlsrv_free_stmt($getResults);
			sqlsrv_close($conn);
			?>
	</center>
</html> 
