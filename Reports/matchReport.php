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
	$match = "$_GET[matchId]";
	// Build data for Pie Chart
	$rows = array();
	$table = array();
	$table['cols'] = array(
		// Labels for your chart, these represent the column titles
		// Note that one column is in "string" format and another one is in "number" format as pie chart only required "numbers" for calculating percentage and string will be used for column title
		array('label' => 'Team', 'type' => 'string'),
		array('label' => 'Avg Score', 'type' => 'number')
	);

	$tsql = "select mr.TeamNumber
                  , mr.alliance 
	              , mr.alliancePosition
	              , mr.totalScoreValue
               from v_MatchReport mr
              where matchId = $match
                and mr.TeamNumber is not null
             order by mr.alliance desc
			        , case when mr.alliance = 'Red' then mr.totalScoreValue
					       else - mr.totalScoreValue end
                    , mr.alliancePosition";
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
		$temp[] = array('v' => (string) $row['TeamNumber']); 
		$temp[] = array('v' => (float) $row['totalScoreValue']); 
		$rows[] = array('c' => $temp);
		if ($row['alliance'] == 'Red') $redScore = $redScore + $row['totalScoreValue'];
		if ($row['alliance'] == 'Blue') $blueScore = $blueScore + $row['totalScoreValue'];
	}
	$table['rows'] = $rows;
	$jsonTablePieChart = json_encode($table);
	$tableTitle = 'Match Score Prediction: Red = ' . number_format($redScore, 2) . ', Blue = ' . number_format($blueScore, 2);
?>
  <head>
    <!--Load the Ajax API-->
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script type="text/javascript">

    // Load the Visualization API and the piechart package.
    google.load('visualization', '1', {'packages':['corechart']});

    // Set a callback to run when the Google Visualization API is loaded.
    google.setOnLoadCallback(drawPieChart);

    function drawPieChart() {

      // Create our data table out of JSON data loaded from server.
      var data = new google.visualization.DataTable(<?=$jsonTablePieChart?>);
      var options = {
          legend:'left',
		  title: '<?php echo $tableTitle;?>',
          is3D: 'false',
          width: 800,
          height: 600,
		  colors: ['#f53b3b', '#ff0000', '#b50000', '#0449c2', '#035efc', '#367cf5']
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
	$tsql = "select m.type + ' ' + m.number matchNumber
               from Match m
			  where m.id = $match";
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
	$matchNumber = $row['matchNumber'];
	echo "<center><h1>Match " . $matchNumber . " - Team Objective Averages</h1></center>";
?>
	<center><table cellspacing="0" cellpadding="5">
		<tr>
			<th>Alliance</th>
			<th>Robot</th>
			<th>Team</th>
			<th>Matches</th>
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
		$tsql = "select matchNumber
                      , matchId
				 	  , TeamId
				 	  , TeamNumber
					  , alliance
					  , case when alliancePosition = 99 then null else alliancePosition end alliancePos
					  , teamReportUrl
					  , matchCnt
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
                   from v_MatchReport
				  where matchId = $match
				 order by allianceSort, alliance desc, alliancePosition";
	$getResults = sqlsrv_query($conn, $tsql);
    if ($getResults == FALSE)
		if( ($errors = sqlsrv_errors() ) != null) {
			foreach( $errors as $error ) {
				echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
				echo "code: ".$error[ 'code']."<br />";
				echo "message: ".$error[ 'message']."<br />";
			}
		}
	$alliance = 'Red';
    while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
        echo "<tr>";
		echo "<td>" . $row['alliance'] . "</td>";
		echo "<td>" . $row['alliancePos'] . "</td>";
		echo "<td>" . $row['teamReportUrl'] . "</td>";
		echo "<td>" . $row['matchCnt'] . "</td>";
		if (isset($row['value1'])) {
			echo "<td>" . number_format($row['value1'], 2) . "</td>";
			$allianceValue1 = $allianceValue1 + $row['value1'];
		}
		if (isset($row['value2'])) {
			echo "<td>" . number_format($row['value2'], 2) . "</td>";
			$allianceValue2 = $allianceValue2 + $row['value2'];
		}
		if (isset($row['value3'])) {
			echo "<td>" . number_format($row['value3'], 2) . "</td>";
			$allianceValue3 = $allianceValue3 + $row['value3'];
		}
		if (isset($row['value4'])) {
			echo "<td>" . number_format($row['value4'], 2) . "</td>";
			$allianceValue4 = $allianceValue4 + $row['value4'];
		}
		if (isset($row['value5'])) {
			echo "<td>" . number_format($row['value5'], 2) . "</td>";
			$allianceValue5 = $allianceValue5 + $row['value5'];
		}
		if (isset($row['value6'])) {
			echo "<td>" . number_format($row['value6'], 2) . "</td>";
			$allianceValue6 = $allianceValue6 + $row['value6'];
		}
		if (isset($row['value7'])) {
			echo "<td>" . number_format($row['value7'], 2) . "</td>";
			$allianceValue7 = $allianceValue7 + $row['value7'];
		}
		if (isset($row['value8'])) {
			echo "<td>" . number_format($row['value8'], 2) . "</td>";
			$allianceValue8 = $allianceValue8 + $row['value8'];
		}
		if (isset($row['value9'])) {
			echo "<td>" . number_format($row['value9'], 2) . "</td>";
			$allianceValue9 = $allianceValue9 + $row['value9'];
		}
		if (isset($row['value10'])) {
			echo "<td>" . number_format($row['value10'], 2) . "</td>";
			$allianceValue10 = $allianceValue10 + $row['value10'];
		}
		if (isset($row['value11'])) {
			echo "<td>" . number_format($row['value11'], 2) . "</td>";
			$allianceValue11 = $allianceValue11 + $row['value11'];
		}
		if (isset($row['value12'])) {
			echo "<td>" . number_format($row['value12'], 2) . "</td>";
			$allianceValue12 = $allianceValue12 + $row['value12'];
		}
		if (isset($row['value13'])) {
			echo "<td>" . number_format($row['value13'], 2) . "</td>";
			$allianceValue13 = $allianceValue13 + $row['value13'];
		}
		if (isset($row['value14'])) {
			echo "<td>" . number_format($row['value14'], 2) . "</td>";
			$allianceValue14 = $allianceValue14 + $row['value14'];
		}
		if (isset($row['value15'])) {
			echo "<td>" . number_format($row['value15'], 2) . "</td>";
			$allianceValue15 = $allianceValue15 + $row['value15'];
		}
		if (isset($row['totalScoreValue'])) {
			echo "<td>" . number_format($row['totalScoreValue'], 2) . "</td>";
			$allianceTotalScoreValue = $allianceTotalScoreValue + $row['totalScoreValue'];
		}
        echo "</tr>";
		// Add Row for the Alliance Total
		if ($row['alliancePos'] == 3) {
			echo "<tr>";
			echo "<td>" . $row['alliance'] . "</td>";
			echo "<td></td>";
			echo "<td></td>";
			echo "<td></td>";
			if (isset($row['value1'])) {
				echo "<td>" . number_format($allianceValue1, 2) . "</td>";
				$allianceValue1 = 0;
			}
			if (isset($row['value2'])) {
				echo "<td>" . number_format($allianceValue2, 2) . "</td>";
				$allianceValue2 = 0;
			}
			if (isset($row['value3'])) {
				echo "<td>" . number_format($allianceValue3, 2) . "</td>";
				$allianceValue3 = 0;
			}
			if (isset($row['value4'])) {
				echo "<td>" . number_format($allianceValue4, 2) . "</td>";
				$allianceValue4 = 0;
			}
			if (isset($row['value5'])) {
				echo "<td>" . number_format($allianceValue5, 2) . "</td>";
				$allianceValue5 = 0;
			}
			if (isset($row['value6'])) {
				echo "<td>" . number_format($allianceValue6, 2) . "</td>";
				$allianceValue6 = 0;
			}
			if (isset($row['value7'])) {
				echo "<td>" . number_format($allianceValue7, 2) . "</td>";
				$allianceValue7 = 0;
			}
			if (isset($row['value8'])) {
				echo "<td>" . number_format($allianceValue8, 2) . "</td>";
				$allianceValue8 = 0;
			}
			if (isset($row['value9'])) {
				echo "<td>" . number_format($allianceValue9, 2) . "</td>";
				$allianceValue9 = 0;
			}
			if (isset($row['value10'])) {
				echo "<td>" . number_format($allianceValue10, 2) . "</td>";
				$allianceValue10 = 0;
			}
			if (isset($row['value11'])) {
				echo "<td>" . number_format($allianceValue11, 2) . "</td>";
				$allianceValue11 = 0;
			}
			if (isset($row['value12'])) {
				echo "<td>" . number_format($allianceValue12, 2) . "</td>";
				$allianceValue12 = $allianceValue12 + 1;
			}
			if (isset($row['value13'])) {
				echo "<td>" . number_format($allianceValue13, 2) . "</td>";
				$allianceValue13 = $allianceValue13 + 1;
			}
			if (isset($row['value14'])) {
				echo "<td>" . number_format($allianceValue14, 2) . "</td>";
				$allianceValue14 = $allianceValue14 + 1;
			}
			if (isset($row['value15'])) {
				echo "<td>" . number_format($allianceValue15, 2) . "</td>";
				$allianceValue15 = $allianceValue15 + 1;
			}
			if (isset($row['totalScoreValue'])) {
				echo "<td>" . number_format($allianceTotalScoreValue, 2) . "</td>";
				$allianceTotalScoreValue = 0;
			}
			echo "</tr>";
		}
    }
	?>
    </table>
	</center>
    <center>
		<!--this is the div that will hold the pie chart-->
		<div id="pie_chart_div"></div>
    </center>
	<center><h1>Robot Attributes</h1></center>
	<center><table cellspacing="0" cellpadding="5">
		<tr>
			<th>Alliance</th>
			<th>Robot</th>
			<th>Team</th>
			<?php
				// Display table headers for robot attributes
				$tsql = "select a.tableheader
						   from Attribute a
								inner join gameEvent ge
								on ge.gameId = a.gameId
						  where ge.isActive = 'Y'
						 order by a.sortOrder";
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
					echo "<th>" . $row['tableheader'] . "</th>";
				}
				sqlsrv_free_stmt($getResults);
			?>
     </tr>
    <?php
    $tsql = "select alliance
				  , alliancePosition
				  , teamUrl
				  , attrValue1
				  , attrValue2
				  , attrValue3
				  , attrValue4
				  , attrValue5
				  , attrValue6
				  , attrValue7
				  , attrValue8
				  , attrValue9
				  , attrValue10
			   from v_MatchReportAttributes
			  where matchId = $match
			 order by allianceSort, alliance desc, alliancePosition";
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
        	echo "<td>" . $row['alliance'] . "</td>";
			echo "<td>" . $row['alliancePosition'] . "</td>";
			echo "<td>" . $row['teamUrl'] . "</td>";
			if (isset($row['attrValue1'])) echo "<td>" . $row['attrValue1'] . "</td>";
			if (isset($row['attrValue2'])) echo "<td>" . $row['attrValue2'] . "</td>";
			if (isset($row['attrValue3'])) echo "<td>" . $row['attrValue3'] . "</td>";
			if (isset($row['attrValue4'])) echo "<td>" . $row['attrValue4'] . "</td>";
			if (isset($row['attrValue5'])) echo "<td>" . $row['attrValue5'] . "</td>";
			if (isset($row['attrValue6'])) echo "<td>" . $row['attrValue6'] . "</td>";
			if (isset($row['attrValue7'])) echo "<td>" . $row['attrValue7'] . "</td>";
			if (isset($row['attrValue8'])) echo "<td>" . $row['attrValue8'] . "</td>";
			if (isset($row['attrValue9'])) echo "<td>" . $row['attrValue9'] . "</td>";
			if (isset($row['attrValue10'])) echo "<td>" . $row['attrValue10'] . "</td>";
       echo "</tr>";
    }
    ?>
    </table>
	</center>
	<center><h1>Final Match Score Breakdown</h1></center>
	<center><table cellspacing="0" cellpadding="5">
		<tr>
			<th>Alliance</th>
			<th>Robot</th>
			<th>Team</th>
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
			$cnt = 0;
			while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
				echo "<th>" . $row['tableHeader'] . "</th>";
				$cnt = $cnt + 1;
			}
			sqlsrv_free_stmt($getResults);
			?>
			<th>Scr Imp</th>
			<th>Fouls</th>
			<th>Match Scr</th>
		</tr>

		<?php
		$tsql = "select alliance
					  , case when alliancePosition = 99 then null else alliancePosition end alliancePos
					  , teamNumber
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
					  , matchFoulPoints
					  , matchScore
                   from v_MatchFinalReport
				  where matchId = $match
				 order by allianceSort, alliance desc, alliancePosition";
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
        	echo "<td>" . $row['alliance'] . "</td>";
			echo "<td>" . $row['alliancePos'] . "</td>";
			echo "<td>" . $row['teamNumber'] . "</td>";
			if (isset($row['value1'])) echo "<td>" . number_format($row['value1'], 2) . "</td>"; elseif ($cnt >= 1) echo "<td></td>";
			if (isset($row['value2']) || $cnt >= 2) echo "<td>" . number_format($row['value2'], 2) . "</td>";
			if (isset($row['value3']) || $cnt >= 3) echo "<td>" . number_format($row['value3'], 2) . "</td>";
			if (isset($row['value4']) || $cnt >= 4) echo "<td>" . number_format($row['value4'], 2) . "</td>";
			if (isset($row['value5']) || $cnt >= 5) echo "<td>" . number_format($row['value5'], 2) . "</td>";
			if (isset($row['value6']) || $cnt >= 6) echo "<td>" . number_format($row['value6'], 2) . "</td>";
			if (isset($row['value7']) || $cnt >= 7) echo "<td>" . number_format($row['value7'], 2) . "</td>";
			if (isset($row['value8']) || $cnt >= 8) echo "<td>" . number_format($row['value8'], 2) . "</td>";
			if (isset($row['value9']) || $cnt >= 9) echo "<td>" . number_format($row['value9'], 2) . "</td>";
			if (isset($row['value10']) || $cnt >= 10) echo "<td>" . number_format($row['value10'], 2) . "</td>";
			if (isset($row['value11']) || $cnt >= 11) echo "<td>" . number_format($row['value11'], 2) . "</td>";
			if (isset($row['value12']) || $cnt >= 12) echo "<td>" . number_format($row['value12'], 2) . "</td>";
			if (isset($row['value13']) || $cnt >= 13) echo "<td>" . number_format($row['value13'], 2) . "</td>";
			if (isset($row['value14']) || $cnt >= 14) echo "<td>" . number_format($row['value14'], 2) . "</td>";
			if (isset($row['value15']) || $cnt >= 15) echo "<td>" . number_format($row['value15'], 2) . "</td>";
			if (isset($row['totalScoreValue'])) echo "<td>" . number_format($row['totalScoreValue'], 2) . "</td>";
			if (isset($row['matchFoulPoints'])) echo "<td>" . number_format($row['matchFoulPoints'], 2) . "</td>";
			if (isset($row['matchScore'])) echo "<td>" . number_format($row['matchScore'], 2) . "</td>";
        echo "</tr>";
    }
    sqlsrv_free_stmt($getResults);
	sqlsrv_close($conn);
	?>
	</body>
</html>