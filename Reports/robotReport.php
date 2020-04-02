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
	$team = "$_GET[TeamId]";

	// Build data for Line Graph
	$rows = array();
	$table = array();

	$table['cols'] = array(
	 array('label' => 'Match', 'type' => 'string'),
	 array('label' => 'Total Score', 'type' => 'number'),
	 array('label' => 'Autonomous', 'type' => 'number'),
	 array('label' => 'Power Cells', 'type' => 'number'),
	 array('label' => 'Control Panel', 'type' => 'number'),
	 array('label' => 'End Game', 'type' => 'number'),
	);
	$tsql = "select trlg.matchDateTime
                  , trlg.matchNumber
	              , totalScoreValue
                  , max(case when objectiveGroupSortOrder = 1 then trlg.objectiveGroupName else null end) objectiveGroupName1
                  , sum(case when objectiveGroupSortOrder = 1 then objectiveGroupScoreValue else null end) objectiveGroupScoreValue1
                  , max(case when objectiveGroupSortOrder = 2 then trlg.objectiveGroupName else null end) objectiveGroupName2
                  , sum(case when objectiveGroupSortOrder = 2 then objectiveGroupScoreValue else null end) objectiveGroupScoreValue2
                  , max(case when objectiveGroupSortOrder = 3 then trlg.objectiveGroupName else null end) objectiveGroupName3
                  , sum(case when objectiveGroupSortOrder = 3 then objectiveGroupScoreValue else null end) objectiveGroupScoreValue3
                  , max(case when objectiveGroupSortOrder = 4 then trlg.objectiveGroupName else null end) objectiveGroupName4
                  , sum(case when objectiveGroupSortOrder = 4 then objectiveGroupScoreValue else null end) objectiveGroupScoreValue4
               from v_TeamReportLineGraph trlg
              where trlg.teamId = $team
             group by trlg.matchDateTime
                    , trlg.matchNumber
	                , totalScoreValue
             order by trlg.matchDateTime";
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
		$temp[] = array('v' => (string) $row['matchNumber']); 
		$temp[] = array('v' => (float) $row['totalScoreValue']); 
		$temp[] = array('v' => (float) $row['objectiveGroupScoreValue1']); 
		$temp[] = array('v' => (float) $row['objectiveGroupScoreValue2']); 
		$temp[] = array('v' => (float) $row['objectiveGroupScoreValue3']); 
		$temp[] = array('v' => (float) $row['objectiveGroupScoreValue4']); 
		$rows[] = array('c' => $temp);
	}
	$table['rows'] = $rows;
	$jsonTableLineGraph = json_encode($table);

	// Build data for Pie Chart
	$rows = array();
	$table = array();
	$table['cols'] = array(
		// Labels for your chart, these represent the column titles
		// Note that one column is in "string" format and another one is in "number" format as pie chart only required "numbers" for calculating percentage and string will be used for column title
		array('label' => 'Scoring Group', 'type' => 'string'),
		array('label' => 'Score', 'type' => 'number')
	);

	$tsql = "select trpc.teamNumber
	              , trpc.objectiveGroupName
				  , trpc.teamId
				  , trpc.objectiveGroupScoreValue
			   from v_TeamReportPieChart trpc
			  where trpc.teamId = $team
			 order by objectiveGroupSortOrder";
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
		$temp[] = array('v' => (string) $row['objectiveGroupName']); 
		$temp[] = array('v' => (float) $row['objectiveGroupScoreValue']); 
		$rows[] = array('c' => $temp);
	}
	$table['rows'] = $rows;
	$jsonTablePieChart = json_encode($table);
?>
<html>
  <head>
    <!--Load the Ajax API-->
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script type="text/javascript">

    // Load the Visualization API and the piechart package.
    google.load('visualization', '1', {'packages':['corechart']});

    // Set a callback to run when the Google Visualization API is loaded.
    google.setOnLoadCallback(drawLineGraph);
    google.setOnLoadCallback(drawPieChart);

    function drawLineGraph() {

      // Create our data table out of JSON data loaded from server.
      var data = new google.visualization.DataTable(<?=$jsonTableLineGraph?>);
      var options = {
           title: 'Team Scoring Trend',
		   legend: {position: 'bottom'},
           chartArea:{width:'95%', height:'65%'}
        };
      // Instantiate and draw our chart, passing in some options.
      // Do not forget to check your div ID
      var chart = new google.visualization.LineChart(document.getElementById('line_chart_div'));
      chart.draw(data, options);
    }

    function drawPieChart() {

      // Create our data table out of JSON data loaded from server.
      var data = new google.visualization.DataTable(<?=$jsonTablePieChart?>);
      var options = {
           title: 'Average Scoring Breakdown',
          is3D: 'true',
          width: 800,
          height: 600
        };
      // Instantiate and draw our chart, passing in some options.
      // Do not forget to check your div ID
      var chart = new google.visualization.PieChart(document.getElementById('pie_chart_div'));
      chart.draw(data, options);
    }
    </script>
  </head>
  <body>
     <meta name="viewport" content="width=device-width, initial-scale=1">
     <title>Scouting App</title>
     <link rel="stylesheet" type="text/css" href="/Style/scoutingStyle.css">
	 <center><a class="clickme danger" href="..\index.php">Home</a></center>
<center><h1>Robot Report</h1></center>
<center><table cellspacing="0" cellpadding="5">
    <tr>
            <th>Team</th>
            <th>Match</th>
            <th>Time</th>
            <th>Scout</th>
			<?php
			$tsql = "select o.tableHeader
					   from objective o
							inner join gameEvent ge
							on ge.gameId = o.gameId
					  where ge.isActive = 'Y'
					 order by o.sortOrder";
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
				echo "<th>" . $row['tableHeader'] . "</th>";
			}
			sqlsrv_free_stmt($getResults);
			?>
			<th>Scr Imp</th>
    </tr>
<?php
$tsql = "select TeamNumber
              , matchNumber
              , left(convert(varchar, matchTime, 24), 5) matchTimeOnly
              , scoutName
              , value1
              , value2
              , value3
              , value4
              , value5
              , value6
              , value7
              , value8
              , value9
              , value10
              , value11
              , value12
              , value13
              , value14
              , value15
			  , totalScoreValue
              , TeamId
              , matchId
              , scoutId
		   from v_TeamReport
          where TeamId = $team
		order by matchTime, matchNumber";
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
		echo "<tr>";
			echo "<td><a href='/Reports/robotReport.php?TeamId=" . $row['TeamId'] . "'>" . $row['TeamNumber'] . "</a></td>";
			echo "<td><a href='/Reports/matchReport.php?matchId=" . $row['matchId'] . "'>" . $row['matchNumber'] . "</a></td>";
			echo "<td>" . $row['matchTimeOnly'] . "</td>";
			echo "<td>" . $row['scoutName'] . "</td>";
			if (isset($row['value1'])) echo "<td>" . number_format($row['value1'], 2) . "</td>";
			if (isset($row['value2'])) echo "<td>" . number_format($row['value2'], 2) . "</td>";
			if (isset($row['value3'])) echo "<td>" . number_format($row['value3'], 2) . "</td>";
			if (isset($row['value4'])) echo "<td>" . number_format($row['value4'], 2) . "</td>";
			if (isset($row['value5'])) echo "<td>" . number_format($row['value5'], 2) . "</td>";
			if (isset($row['value6'])) echo "<td>" . number_format($row['value6'], 2) . "</td>";
			if (isset($row['value7'])) echo "<td>" . number_format($row['value7'], 2) . "</td>";
			if (isset($row['value8'])) echo "<td>" . number_format($row['value8'], 2) . "</td>";
			if (isset($row['value9'])) echo "<td>" . number_format($row['value9'], 2) . "</td>";
			if (isset($row['value10'])) echo "<td>" . number_format($row['value10'], 2) . "</td>";
			if (isset($row['value11'])) echo "<td>" . number_format($row['value11'], 2) . "</td>";
			if (isset($row['value12'])) echo "<td>" . number_format($row['value12'], 2) . "</td>";
			if (isset($row['value13'])) echo "<td>" . number_format($row['value13'], 2) . "</td>";
			if (isset($row['value14'])) echo "<td>" . number_format($row['value14'], 2) . "</td>";
			if (isset($row['value15'])) echo "<td>" . number_format($row['value15'], 2) . "</td>";
			if (isset($row['totalScoreValue'])) echo "<td>" . number_format($row['totalScoreValue'], 2) . "</td>";
		echo "</tr>";
    }
    sqlsrv_free_stmt($getResults);
	sqlsrv_close($conn);
    ?>
    </center>
    </table>
    <center>
		<!--this is the div that will hold the pie chart-->
		<div id="line_chart_div"></div>
		<div id="pie_chart_div"></div>
    </center>
  </body>
</html>