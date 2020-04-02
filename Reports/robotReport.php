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

	// Build data for Pie Chart
	$table = array();
	$table['cols'] = array(
		// Labels for your chart, these represent the column titles
		// Note that one column is in "string" format and another one is in "number" format as pie chart only required "numbers" for calculating percentage and string will be used for column title
		array('label' => 'Scoring Type', 'type' => 'string'),
		array('label' => 'Score', 'type' => 'number')
	);

	$rows = array();
	$tsql = "select subquery.*
				 , (select tableHeader from Objective o inner join GameEvent ge on ge.gameId = o.gameId where ge.id = subquery.gameEventId and sortOrder = 1) objective1
				 , (select tableHeader from Objective o inner join GameEvent ge on ge.gameId = o.gameId where ge.id = subquery.gameEventId and sortOrder = 2) objective2
				 , (select tableHeader from Objective o inner join GameEvent ge on ge.gameId = o.gameId where ge.id = subquery.gameEventId and sortOrder = 3) objective3
				 , (select tableHeader from Objective o inner join GameEvent ge on ge.gameId = o.gameId where ge.id = subquery.gameEventId and sortOrder = 4) objective4
				 , (select tableHeader from Objective o inner join GameEvent ge on ge.gameId = o.gameId where ge.id = subquery.gameEventId and sortOrder = 5) objective5
				 , (select tableHeader from Objective o inner join GameEvent ge on ge.gameId = o.gameId where ge.id = subquery.gameEventId and sortOrder = 6) objective6
				 , (select tableHeader from Objective o inner join GameEvent ge on ge.gameId = o.gameId where ge.id = subquery.gameEventId and sortOrder = 7) objective7
				 , (select tableHeader from Objective o inner join GameEvent ge on ge.gameId = o.gameId where ge.id = subquery.gameEventId and sortOrder = 8) objective8
				 , (select tableHeader from Objective o inner join GameEvent ge on ge.gameId = o.gameId where ge.id = subquery.gameEventId and sortOrder = 9) objective9
				 , (select tableHeader from Objective o inner join GameEvent ge on ge.gameId = o.gameId where ge.id = subquery.gameEventId and sortOrder = 10) objective10
				 , (select tableHeader from Objective o inner join GameEvent ge on ge.gameId = o.gameId where ge.id = subquery.gameEventId and sortOrder = 11) objective11
				 , (select tableHeader from Objective o inner join GameEvent ge on ge.gameId = o.gameId where ge.id = subquery.gameEventId and sortOrder = 12) objective12
				 , (select tableHeader from Objective o inner join GameEvent ge on ge.gameId = o.gameId where ge.id = subquery.gameEventId and sortOrder = 13) objective13
				 , (select tableHeader from Objective o inner join GameEvent ge on ge.gameId = o.gameId where ge.id = subquery.gameEventId and sortOrder = 14) objective14
				 , (select tableHeader from Objective o inner join GameEvent ge on ge.gameId = o.gameId where ge.id = subquery.gameEventId and sortOrder = 15) objective15
			  from (
			select t.TeamNumber
				 , sr.gameEventId
				 , round(avg(sr.value1),2) value1
				 , round(avg(sr.value2),2) value2
				 , round(avg(sr.value3),2) value3
				 , round(avg(sr.value4),2) value4
				 , round(avg(sr.value5),2) value5
				 , round(avg(sr.value6),2) value6
				 , round(avg(sr.value7),2) value7
				 , round(avg(sr.value8),2) value8
				 , round(avg(sr.value9),2) value9
				 , round(avg(sr.value10),2) value10
				 , round(avg(sr.value11),2) value11
				 , round(avg(sr.value12),2) value12
				 , round(avg(sr.value13),2) value13
				 , round(avg(sr.value14),2) value14
				 , round(avg(sr.value15),2) value15
			 from Team t
				  inner join v_AvgScoutRecord sr
				  on sr.TeamId = t.id
				  inner join Match m
				  on m.id = sr.matchId
			where sr.teamId = $team
			group by t.TeamNumber
				   , sr.gameEventId) subquery";
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
	$temp = array();
	// the following line will be used to slice the Pie chart
	$temp[] = array('v' => (string) $row['objective1']); 
	// Values of each slice
	$temp[] = array('v' => (float) $row['value1']); 
	$rows[] = array('c' => $temp);
	$temp = array();
	$temp[] = array('v' => (string) $row['objective2']); 
	$temp[] = array('v' => (float) $row['value2']); 
	$rows[] = array('c' => $temp);
	$temp = array();
	$temp[] = array('v' => (string) $row['objective3']); 
	$temp[] = array('v' => (float) $row['value3']); 
	$rows[] = array('c' => $temp);
	$temp = array();
	$temp[] = array('v' => (string) $row['objective4']); 
	$temp[] = array('v' => (float) $row['value4']); 
	$rows[] = array('c' => $temp);
	$temp = array();
	$temp[] = array('v' => (string) $row['objective5']); 
	$temp[] = array('v' => (float) $row['value5']); 
	$rows[] = array('c' => $temp);
	$temp = array();
	$temp[] = array('v' => (string) $row['objective6']); 
	$temp[] = array('v' => (float) $row['value6']); 
	$rows[] = array('c' => $temp);
	$temp = array();
	$temp[] = array('v' => (string) $row['objective7']); 
	$temp[] = array('v' => (float) $row['value7']); 
	$rows[] = array('c' => $temp);
	$temp = array();
	$temp[] = array('v' => (string) $row['objective8']); 
	$temp[] = array('v' => (float) $row['value8']); 
	$rows[] = array('c' => $temp);

	$table['rows'] = $rows;
	$jsonTable = json_encode($table);
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
    google.setOnLoadCallback(drawChart);

    function drawChart() {

      // Create our data table out of JSON data loaded from server.
      var data = new google.visualization.DataTable(<?=$jsonTable?>);
      var options = {
           title: 'Scoring Breakdown',
          is3D: 'true',
          width: 800,
          height: 600
        };
      // Instantiate and draw our chart, passing in some options.
      // Do not forget to check your div ID
      var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
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
		<div id="chart_div"></div>
    </center>
  </body>
</html>