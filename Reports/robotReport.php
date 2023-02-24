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
	$columns = array();
	$table = array();

	// Build column names
	$columns = array(array('label' => 'Match', 'type' => 'string'),
				     array('label' => 'Total Score', 'type' => 'number'));
	$tsql = "select distinct og.name, og.sortOrder
			   from ObjectiveGroup og
				    inner join ObjectiveGroupObjective ogo
				    on ogo.objectiveGroupId = og.id
				    inner join Objective o
				    on o.id = ogo.objectiveId
				    inner join v_GameEvent ge
				    on ge.gameId = o.gameId
              where ge.loginGUID = '$loginGUID'
			    and groupCode = 'Report Line Graph'
			 order by og.sortOrder";
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
		$columns[] = array('label' => (string) $row['name'], 'type' => 'number');
	}
	$table['cols'] = $columns;

	// Build row data
	$tsql = "select trlg.matchDateTime
                  , trlg.matchNumber
	              , totalScoreValue
                  , sum(case when objectiveGroupSortOrder = 1 then objectiveGroupScoreValue else null end) objectiveGroupScoreValue1
                  , sum(case when objectiveGroupSortOrder = 2 then objectiveGroupScoreValue else null end) objectiveGroupScoreValue2
                  , sum(case when objectiveGroupSortOrder = 3 then objectiveGroupScoreValue else null end) objectiveGroupScoreValue3
                  , sum(case when objectiveGroupSortOrder = 4 then objectiveGroupScoreValue else null end) objectiveGroupScoreValue4
                  , sum(case when objectiveGroupSortOrder = 5 then objectiveGroupScoreValue else null end) objectiveGroupScoreValue5
               from v_TeamReportLineGraph trlg
              where trlg.loginGUID = '$loginGUID'
			    and trlg.teamId = $team
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
		// Only include data with complete scout records
		if (isset($row['totalScoreValue'])) { 
			$temp = array();
			$temp[] = array('v' => (string) $row['matchNumber']); 
			$temp[] = array('v' => (float) $row['totalScoreValue']); 
			if (isset($row['objectiveGroupScoreValue1'])) $temp[] = array('v' => (float) $row['objectiveGroupScoreValue1']); 
			if (isset($row['objectiveGroupScoreValue2'])) $temp[] = array('v' => (float) $row['objectiveGroupScoreValue2']); 
			if (isset($row['objectiveGroupScoreValue3'])) $temp[] = array('v' => (float) $row['objectiveGroupScoreValue3']); 
			if (isset($row['objectiveGroupScoreValue4'])) $temp[] = array('v' => (float) $row['objectiveGroupScoreValue4']); 
			if (isset($row['objectiveGroupScoreValue5'])) $temp[] = array('v' => (float) $row['objectiveGroupScoreValue5']); 
			$rows[] = array('c' => $temp);
		}
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
			  where trpc.loginGUID = '$loginGUID'
			    and trpc.teamId = $team
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
			<?php
			$tsql = "select t.teamNumber
			              , t.teamName
					   from Team t
					  where t.id = $team";
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
			echo "<center><h1>Robot Report: Team " . $row['teamNumber'] . " - " . $row['teamName'] . "</h1></center>";
			?>

<center><table cellspacing="0" cellpadding="5">
    <tr>
            <th>Team</th>
            <th>Match</th>
            <th>Time</th>
            <th>Scout</th>
			<?php
			$cnt = 0;
			$tsql = "select o.tableHeader
					   from objective o
							inner join v_GameEvent ge
							on ge.gameId = o.gameId
                      where ge.loginGUID = '$loginGUID'
					 union
					 select g.alliancePtsHeader, 999 reportSortOrder
					   from v_GameEvent ge
					        inner join game g
					        on g.id = ge.gameId
					  where ge.loginGUID = '$loginGUID'
					    and g.alliancePtsHeader is not null
					 order by o.reportSortOrder";
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
				$cnt += 1;
			}
			$cnt -= 1; // Do not count Alliance Header
			sqlsrv_free_stmt($getResults);
			?>
			<th>Scr Imp</th>
			<th>URLs</th>
			<th>Match Comment</th>
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
              , value16
              , value17
              , value18
              , value19
              , value20
			  , portionOfAlliancePoints
			  , totalScoreValue
			  , textValue1
              , textValue2
              , textValue3
              , textValue4
              , textValue5
              , textValue6
              , textValue7
              , textValue8
              , textValue9
              , textValue10
              , textValue11
              , textValue12
              , textValue13
              , textValue14
              , textValue15
              , textValue16
              , textValue17
              , textValue18
              , textValue19
              , textValue20
			  , videos
              , TeamId
              , matchId
              , scoutId
			  , scoutRecordId
			  , scoutComment
		   from v_TeamReport
          where loginGUID = '$loginGUID'
			and teamId = $team
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
			echo "<td>" . $row['TeamNumber'] . "</td>";
			echo "<td><a href='/Reports/matchReport.php?matchId=" . $row['matchId'] . "'>" . $row['matchNumber'] . "</a></td>";
			echo "<td>" . $row['matchTimeOnly'] . "</td>";
			echo "<td>" . $row['scoutName'] . "</td>";
			if (isset($row['value1'])) echo "<td>" . number_format($row['value1'], 2) . "</td>"; elseif (isset($row['textValue1'])) echo "<td>" . $row['textValue1'] . "</td>"; elseif ($cnt >= 1) echo "<td></td>";
			if (isset($row['value2'])) echo "<td>" . number_format($row['value2'], 2) . "</td>"; elseif (isset($row['textValue2'])) echo "<td>" . $row['textValue2'] . "</td>"; elseif ($cnt >= 2) echo "<td></td>";
			if (isset($row['value3'])) echo "<td>" . number_format($row['value3'], 2) . "</td>"; elseif (isset($row['textValue3'])) echo "<td>" . $row['textValue3'] . "</td>"; elseif ($cnt >= 3) echo "<td></td>";
			if (isset($row['value4'])) echo "<td>" . number_format($row['value4'], 2) . "</td>"; elseif (isset($row['textValue4'])) echo "<td>" . $row['textValue4'] . "</td>"; elseif ($cnt >= 4) echo "<td></td>";
			if (isset($row['value5'])) echo "<td>" . number_format($row['value5'], 2) . "</td>"; elseif (isset($row['textValue5'])) echo "<td>" . $row['textValue5'] . "</td>"; elseif ($cnt >= 5) echo "<td></td>";
			if (isset($row['value6'])) echo "<td>" . number_format($row['value6'], 2) . "</td>"; elseif (isset($row['textValue6'])) echo "<td>" . $row['textValue6'] . "</td>"; elseif ($cnt >= 6) echo "<td></td>";
			if (isset($row['value7'])) echo "<td>" . number_format($row['value7'], 2) . "</td>"; elseif (isset($row['textValue7'])) echo "<td>" . $row['textValue7'] . "</td>"; elseif ($cnt >= 7) echo "<td></td>";
			if (isset($row['value8'])) echo "<td>" . number_format($row['value8'], 2) . "</td>"; elseif (isset($row['textValue8'])) echo "<td>" . $row['textValue8'] . "</td>"; elseif ($cnt >= 8) echo "<td></td>";
			if (isset($row['value9'])) echo "<td>" . number_format($row['value9'], 2) . "</td>"; elseif (isset($row['textValue9'])) echo "<td>" . $row['textValue9'] . "</td>"; elseif ($cnt >= 9) echo "<td></td>";
			if (isset($row['value10'])) echo "<td>" . number_format($row['value10'], 2) . "</td>"; elseif (isset($row['textValue10'])) echo "<td>" . $row['textValue10'] . "</td>"; elseif ($cnt >= 10) echo "<td></td>";
			if (isset($row['value11'])) echo "<td>" . number_format($row['value11'], 2) . "</td>"; elseif (isset($row['textValue11'])) echo "<td>" . $row['textValue11'] . "</td>"; elseif ($cnt >= 11) echo "<td></td>";
			if (isset($row['value12'])) echo "<td>" . number_format($row['value12'], 2) . "</td>"; elseif (isset($row['textValue12'])) echo "<td>" . $row['textValue12'] . "</td>"; elseif ($cnt >= 12) echo "<td></td>";
			if (isset($row['value13'])) echo "<td>" . number_format($row['value13'], 2) . "</td>"; elseif (isset($row['textValue13'])) echo "<td>" . $row['textValue13'] . "</td>"; elseif ($cnt >= 13) echo "<td></td>";
			if (isset($row['value14'])) echo "<td>" . number_format($row['value14'], 2) . "</td>"; elseif (isset($row['textValue14'])) echo "<td>" . $row['textValue14'] . "</td>"; elseif ($cnt >= 14) echo "<td></td>";
			if (isset($row['value15'])) echo "<td>" . number_format($row['value15'], 2) . "</td>"; elseif (isset($row['textValue15'])) echo "<td>" . $row['textValue15'] . "</td>"; elseif ($cnt >= 15) echo "<td></td>";
			if (isset($row['value16'])) echo "<td>" . number_format($row['value16'], 2) . "</td>"; elseif (isset($row['textValue16'])) echo "<td>" . $row['textValue16'] . "</td>"; elseif ($cnt >= 16) echo "<td></td>";
			if (isset($row['value17'])) echo "<td>" . number_format($row['value17'], 2) . "</td>"; elseif (isset($row['textValue17'])) echo "<td>" . $row['textValue17'] . "</td>"; elseif ($cnt >= 17) echo "<td></td>";
			if (isset($row['value18'])) echo "<td>" . number_format($row['value18'], 2) . "</td>"; elseif (isset($row['textValue18'])) echo "<td>" . $row['textValue18'] . "</td>"; elseif ($cnt >= 18) echo "<td></td>";
			if (isset($row['value19'])) echo "<td>" . number_format($row['value19'], 2) . "</td>"; elseif (isset($row['textValue19'])) echo "<td>" . $row['textValue19'] . "</td>"; elseif ($cnt >= 19) echo "<td></td>";
			if (isset($row['value20'])) echo "<td>" . number_format($row['value20'], 2) . "</td>"; elseif (isset($row['textValue20'])) echo "<td>" . $row['textValue20'] . "</td>"; elseif ($cnt >= 20) echo "<td></td>";
			if (isset($row['portionOfAlliancePoints'])) echo "<td>" . number_format($row['portionOfAlliancePoints'], 2) . "</td>";
			if (isset($row['totalScoreValue'])) echo "<td>" . number_format($row['totalScoreValue'], 2) . "</td>"; else echo "<td></td>";
			if (isset($row['videos'])) echo "<td>" . $row['videos'] . "</td>"; else echo "<td></td>";
			if (isset($row['scoutComment'])) echo "<td>" . $row['scoutComment'] . "</td>"; else echo "<td></td>";
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