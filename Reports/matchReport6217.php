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
	$loginEmailAddress = getenv("DefaultLoginEmailAddress");
	$tsql = "select s.scoutGUID
				  , convert(nvarchar, 
				    coalesce(
				    (select top 1 (m.dateTime)
					   from v_MatchHyperlinks6217 m
						    inner join TeamMatch tm
						    on tm.matchId = m.matchId
						    and tm.teamId = s.teamId
					  where m.loginGUID = s.scoutGUID
				     order by m.sortOrder, datetime, matchNumber), getdate() - 1), 120) nextMatchDate
				  , case when coalesce(
					 (select top 1 (m.dateTime)
						from v_MatchHyperlinks6217 m
							 inner join TeamMatch tm
							 on tm.matchId = m.matchId
							 and tm.teamId = s.teamId
					   where m.loginGUID = s.scoutGUID
					  order by m.sortOrder, datetime, matchNumber), getdate() - 1) > getdate() - 0.1
					     then 1
						 else 0 end showCountdown
				 from Scout s 
               where s.emailAddress = '$loginEmailAddress'";
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
	$nextMatchDate = $row['nextMatchDate'];
	$showCountdown = $row['showCountdown'];

	// Build data for Pie Chart
	$rows = array();
	$table = array();
	$oprTable = array();
	$table['cols'] = array(
		// Labels for your chart, these represent the column titles
		// Note that one column is in "string" format and another one is in "number" format as pie chart only required "numbers" for calculating percentage and string will be used for column title
		array('label' => 'Team', 'type' => 'string'),
		array('label' => 'Avg Score', 'type' => 'number')
	);
	$oprTable['cols'] = array(
		array('label' => 'Team', 'type' => 'string'),
		array('label' => 'Opr Score', 'type' => 'number')
	);

	$tsql = "select mr.teamNumber
                  , mr.teamName
                  , mr.alliance 
	              , mr.alliancePosition
	              , mr.totalScoreValue
				  , mr.oPR
               from v_MatchReport mr
              where loginGUID = '$loginGUID'
			    and matchId = $match
                and mr.teamNumber is not null
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
	//create table for score prediction pie chart
	while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
		$temp = array();
		$temp[] = array('v' => (string) $row['teamNumber'] . ' - ' . $row['teamName']); 
		$temp[] = array('v' => (float) $row['totalScoreValue']); 
		$rows[] = array('c' => $temp);
		if ($row['alliance'] == 'Red') $redScore = $redScore + $row['totalScoreValue'];
		if ($row['alliance'] == 'Blue') $blueScore = $blueScore + $row['totalScoreValue'];
	}
	$table['rows'] = $rows;
	$jsonTablePieChart = json_encode($table);
	$tableTitle = 'Match Score Prediction: Red = ' . number_format($redScore, 2) . ', Blue = ' . number_format($blueScore, 2);

	//build data for OPR Pie Chart
	$tsql = "select mr.teamNumber
                  , mr.teamName
                  , mr.alliance 
	              , mr.alliancePosition
	              , mr.totalScoreValue
				  , mr.oPR
               from v_MatchReport mr
              where loginGUID = '$loginGUID'
			    and matchId = $match
                and mr.teamNumber is not null
             order by mr.alliance desc
			        , case when mr.alliance = 'Red' then mr.totalScoreValue
					       else - mr.totalScoreValue end
                    , mr.alliancePosition";
    $oprResults = sqlsrv_query($conn, $tsql);
    if ($oprResults == FALSE)
		if( ($errors = sqlsrv_errors() ) != null) {
			foreach( $errors as $error ) {
				echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
				echo "code: ".$error[ 'code']."<br />";
				echo "message: ".$error[ 'message']."<br />";
			}
		}
	//create table for opr prediction pie chart
	while ($oprRow = sqlsrv_fetch_array($oprResults, SQLSRV_FETCH_ASSOC)) {
		$oprTemp = array();
		$oprTemp[] = array('v' => (string) $oprRow['teamNumber'] . ' - ' . $oprRow['teamName']); 
		$oprTemp[] = array('v' => (float) $oprRow['oPR']); 
		$oprRows[] = array('c' => $oprTemp);
		if ($oprRow['alliance'] == 'Red') $redOpr = $redOpr + $oprRow['oPR'];
		if ($oprRow['alliance'] == 'Blue') $blueOpr = $blueOpr + $oprRow['oPR'];
	}
	$oprTable['rows'] = $oprRows;
	$oprJsonTablePieChart = json_encode($oprTable);
	$oprTableTitle = 'OPR Breakdown: Red = ' . number_format($redOpr, 2) . ', Blue = ' . number_format($blueOpr, 2);
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
    google.setOnLoadCallback(drawOprPieChart);

    function drawPieChart() {
      // Create our data table out of JSON data loaded from server.
      var data = new google.visualization.DataTable(<?=$jsonTablePieChart?>);
      var options = {
          legend: 'none',
		  title: '<?php echo $tableTitle;?>',
          is3D: 'false',
          width: 400,
          height: 300,
		  colors: ['#f53b3b', '#ff0000', '#b50000', '#0449c2', '#035efc', '#367cf5']
        };
      // Instantiate and draw our chart, passing in some options.
      // Do not forget to check your div ID
      var chart = new google.visualization.PieChart(document.getElementById('pie_chart_div'));
      chart.draw(data, options);
    }

	function drawOprPieChart() {
      // Create our data table out of JSON data loaded from server.
      var data = new google.visualization.DataTable(<?=$oprJsonTablePieChart?>);
      var options = {
          legend: 'right',
		  title: '<?php echo $oprTableTitle;?>',
          is3D: 'false',
          width: 400,
          height: 300,
		  colors: ['#f53b3b', '#ff0000', '#b50000', '#0449c2', '#035efc', '#367cf5']
        };
      // Instantiate and draw our chart, passing in some options.
      // Do not forget to check your div ID
      var chart = new google.visualization.PieChart(document.getElementById('opr_pie_chart_div'));
      chart.draw(data, options);
    }
    </script>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<link rel="stylesheet" type="text/css" href="/Style/jquery.countdown.css"> 
	<script type="text/javascript" src="/js/jquery.plugin.js"></script> 
	<script type="text/javascript" src="/js/jquery.countdown.js"></script>
	<style type="text/css">
		body > iframe { display: none; }
		#defaultCountdown { width: 180px; height: 45px; }
	</style>
	<script>
		$(function () {
			var austDay = new Date('<?php echo $nextMatchDate; ?>');
			$('#defaultCountdown').countdown({until: austDay, format: 'HMS'});
		});
	</script>
  </head>
  <body>
     <meta name="viewport" content="width=device-width, initial-scale=1">
     <title>Scouting App</title>
     <link rel="stylesheet" type="text/css" href="/Style/scoutingStyle.css">
	 <center><a class="clickme danger" href="..\index6217.php">Home</a></center>
	<?php
	if ($showCountdown == 1) {
		echo '<br><center>Our next match start at ' . $nextMatchDate . '... <div id="defaultCountdown"></div></center><br>';
	}

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
			$tsql = "select o.tableHeader, o.reportSortOrder
					   from objective o
							inner join v_GameEvent ge
							on ge.gameId = o.gameId
							inner join ScoringType st
							on st.id = o.scoringTypeId
                      where ge.loginGUID = '$loginGUID'
					    and st.name <> 'Free Form'
					 union
					 select g.alliancePtsHeader, 999 reportSortOrder
					   from v_GameEvent ge
					        inner join game g
					        on g.id = ge.gameId
					  where ge.loginGUID = '$loginGUID'
					    and g.alliancePtsHeader is not null
					 order by reportSortOrder";
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
			$cnt -= 1; // Do not count Alliance Header
			sqlsrv_free_stmt($getResults);
			?>
			<th>Scr Imp</th>
			<th>OPR</th>
		</tr>
	<?php
	$tsql = "execute sp_rpt_matchReport $match, '$loginGUID', 1";
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
		if (isset($row['value1'])) echo "<td>" . number_format($row['value1'], 2) . "</td>"; elseif ($cnt >= 1) echo "<td></td>";
		if (isset($row['value2'])) echo "<td>" . number_format($row['value2'], 2) . "</td>"; elseif ($cnt >= 2) echo "<td></td>";
		if (isset($row['value3'])) echo "<td>" . number_format($row['value3'], 2) . "</td>"; elseif ($cnt >= 3) echo "<td></td>";
		if (isset($row['value4'])) echo "<td>" . number_format($row['value4'], 2) . "</td>"; elseif ($cnt >= 4) echo "<td></td>";
		if (isset($row['value5'])) echo "<td>" . number_format($row['value5'], 2) . "</td>"; elseif ($cnt >= 5) echo "<td></td>";
		if (isset($row['value6'])) echo "<td>" . number_format($row['value6'], 2) . "</td>"; elseif ($cnt >= 6) echo "<td></td>";
		if (isset($row['value7'])) echo "<td>" . number_format($row['value7'], 2) . "</td>"; elseif ($cnt >= 7) echo "<td></td>";
		if (isset($row['value8'])) echo "<td>" . number_format($row['value8'], 2) . "</td>"; elseif ($cnt >= 8) echo "<td></td>";
		if (isset($row['value9'])) echo "<td>" . number_format($row['value9'], 2) . "</td>"; elseif ($cnt >= 9) echo "<td></td>";
		if (isset($row['value10'])) echo "<td>" . number_format($row['value10'], 2) . "</td>"; elseif ($cnt >= 10) echo "<td></td>";
		if (isset($row['value11'])) echo "<td>" . number_format($row['value11'], 2) . "</td>"; elseif ($cnt >= 11) echo "<td></td>";
		if (isset($row['value12'])) echo "<td>" . number_format($row['value12'], 2) . "</td>"; elseif ($cnt >= 12) echo "<td></td>";
		if (isset($row['value13'])) echo "<td>" . number_format($row['value13'], 2) . "</td>"; elseif ($cnt >= 13) echo "<td></td>";
		if (isset($row['value14'])) echo "<td>" . number_format($row['value14'], 2) . "</td>"; elseif ($cnt >= 14) echo "<td></td>";
		if (isset($row['value15'])) echo "<td>" . number_format($row['value15'], 2) . "</td>"; elseif ($cnt >= 15) echo "<td></td>";
		if (isset($row['value16'])) echo "<td>" . number_format($row['value16'], 2) . "</td>"; elseif ($cnt >= 16) echo "<td></td>";
		if (isset($row['value17'])) echo "<td>" . number_format($row['value17'], 2) . "</td>"; elseif ($cnt >= 17) echo "<td></td>";
		if (isset($row['value18'])) echo "<td>" . number_format($row['value18'], 2) . "</td>"; elseif ($cnt >= 18) echo "<td></td>";
		if (isset($row['value19'])) echo "<td>" . number_format($row['value19'], 2) . "</td>"; elseif ($cnt >= 19) echo "<td></td>";
		if (isset($row['value20'])) echo "<td>" . number_format($row['value20'], 2) . "</td>"; elseif ($cnt >= 20) echo "<td></td>";
		if (isset($row['portionOfAlliancePoints'])) echo "<td>" . number_format($row['portionOfAlliancePoints'], 2) . "</td>";
		if (isset($row['totalScoreValue'])) echo "<td>" . number_format($row['totalScoreValue'], 2) . "</td>"; elseif ($cnt >= 20) echo "<td></td>";
		if (isset($row['oPR'])) echo "<td>" . number_format($row['oPR'], 2) . "</td>"; elseif ($cnt >= 15) echo "<td></td>";
        echo "</tr>";
    }
	?>
    </table>
	</center>
    <center>
		<!--this is the div that will hold the pie chart-->
		<div style="display: flex;  justify-content: center;">
			<div id="pie_chart_div"></div>
			<div id="opr_pie_chart_div"></div>
		</div>
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
								inner join v_GameEvent ge
								on ge.gameId = a.gameId
                          where ge.loginGUID = '$loginGUID'
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
				  , attrValue11
				  , attrValue12
				  , attrValue13
				  , attrValue14
				  , attrValue15
				  , attrValue16
				  , attrValue17
				  , attrValue18
				  , attrValue19
				  , attrValue20
			   from v_MatchReportAttributes6217
			  where loginGUID = '$loginGUID'
			    and matchId = $match
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
			if (isset($row['attrValue11'])) echo "<td>" . $row['attrValue11'] . "</td>";
			if (isset($row['attrValue12'])) echo "<td>" . $row['attrValue12'] . "</td>";
			if (isset($row['attrValue13'])) echo "<td>" . $row['attrValue13'] . "</td>";
			if (isset($row['attrValue14'])) echo "<td>" . $row['attrValue14'] . "</td>";
			if (isset($row['attrValue15'])) echo "<td>" . $row['attrValue15'] . "</td>";
			if (isset($row['attrValue16'])) echo "<td>" . $row['attrValue16'] . "</td>";
			if (isset($row['attrValue17'])) echo "<td>" . $row['attrValue17'] . "</td>";
			if (isset($row['attrValue18'])) echo "<td>" . $row['attrValue18'] . "</td>";
			if (isset($row['attrValue19'])) echo "<td>" . $row['attrValue19'] . "</td>";
			if (isset($row['attrValue20'])) echo "<td>" . $row['attrValue20'] . "</td>";
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
			$tsql = "select o.tableHeader, o.reportSortOrder
					   from objective o
							inner join v_GameEvent ge
							on ge.gameId = o.gameId
							inner join ScoringType st
							on st.id = o.scoringTypeId
                      where ge.loginGUID = '$loginGUID'
					    and st.name <> 'Free Form'
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
			$cnt = 0;
			while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
				echo "<th>" . $row['tableHeader'] . "</th>";
				$cnt = $cnt + 1;
			}
			$cnt -= 1; // Do not count Alliance Header
			sqlsrv_free_stmt($getResults);
			?>
			<th>Scr Imp</th>
			<th>Fouls</th>
			<th>Match Scr</th>
		</tr>

		<?php
		$tsql = "select alliance
					  , alliancePosition alliancePos
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
					  , value16
					  , value17
					  , value18
					  , value19
					  , value20
					  , portionOfAlliancePoints
					  , totalScoreValue
					  , matchFoulPoints
					  , matchScore
					  , teamId
					  , matchCode
					  , scoutRecordId
                   from v_MatchFinalReport
				  where loginGUID = '$loginGUID'
					and matchId = $match
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
			if ($row['alliancePos'] == 98) { // Scouted data line
				echo "<td></td>";
				echo "<td>" . $row['teamNumber'] . "</td>";
			}
			else if ($row['alliancePos'] == 99) {
				echo "<td></td>";
				echo '<td><a href="https://www.thebluealliance.com/match/' . $row['matchCode'] . '" target="_blank"> ' . $row['teamNumber'] . '</a></td>';
			}
			else if (isset($row['scoutRecordId'])) {
				echo "<td>" . $row['alliancePos'] . "</td>";
				echo '<td><a href="../scoutRecord.php?scoutRecordId=' . $row['scoutRecordId'] . '"> ' . $row['teamNumber'] . '</a></td>';
			}
			else {
				echo "<td>" . $row['alliancePos'] . "</td>";
				echo '<td><a href="../Reports/robotReport6217.php?TeamId=' . $row['teamId'] . '"> ' . $row['teamNumber'] . '</a></td>';
			}
			if (isset($row['value1'])) echo "<td>" . number_format($row['value1'], 2) . "</td>"; elseif ($cnt >= 1) echo "<td></td>";
			if (isset($row['value2'])) echo "<td>" . number_format($row['value2'], 2) . "</td>"; elseif ($cnt >= 2) echo "<td></td>";
			if (isset($row['value3'])) echo "<td>" . number_format($row['value3'], 2) . "</td>"; elseif ($cnt >= 3) echo "<td></td>";
			if (isset($row['value4'])) echo "<td>" . number_format($row['value4'], 2) . "</td>"; elseif ($cnt >= 4) echo "<td></td>";
			if (isset($row['value5'])) echo "<td>" . number_format($row['value5'], 2) . "</td>"; elseif ($cnt >= 5) echo "<td></td>";
			if (isset($row['value6'])) echo "<td>" . number_format($row['value6'], 2) . "</td>"; elseif ($cnt >= 6) echo "<td></td>";
			if (isset($row['value7'])) echo "<td>" . number_format($row['value7'], 2) . "</td>"; elseif ($cnt >= 7) echo "<td></td>";
			if (isset($row['value8'])) echo "<td>" . number_format($row['value8'], 2) . "</td>"; elseif ($cnt >= 8) echo "<td></td>";
			if (isset($row['value9'])) echo "<td>" . number_format($row['value9'], 2) . "</td>"; elseif ($cnt >= 9) echo "<td></td>";
			if (isset($row['value10'])) echo "<td>" . number_format($row['value10'], 2) . "</td>"; elseif ($cnt >= 10) echo "<td></td>";
			if (isset($row['value11'])) echo "<td>" . number_format($row['value11'], 2) . "</td>"; elseif ($cnt >= 11) echo "<td></td>";
			if (isset($row['value12'])) echo "<td>" . number_format($row['value12'], 2) . "</td>"; elseif ($cnt >= 12) echo "<td></td>";
			if (isset($row['value13'])) echo "<td>" . number_format($row['value13'], 2) . "</td>"; elseif ($cnt >= 13) echo "<td></td>";
			if (isset($row['value14'])) echo "<td>" . number_format($row['value14'], 2) . "</td>"; elseif ($cnt >= 14) echo "<td></td>";
			if (isset($row['value15'])) echo "<td>" . number_format($row['value15'], 2) . "</td>"; elseif ($cnt >= 15) echo "<td></td>";
			if (isset($row['value16'])) echo "<td>" . number_format($row['value16'], 2) . "</td>"; elseif ($cnt >= 16) echo "<td></td>";
			if (isset($row['value17'])) echo "<td>" . number_format($row['value17'], 2) . "</td>"; elseif ($cnt >= 17) echo "<td></td>";
			if (isset($row['value18'])) echo "<td>" . number_format($row['value18'], 2) . "</td>"; elseif ($cnt >= 18) echo "<td></td>";
			if (isset($row['value19'])) echo "<td>" . number_format($row['value19'], 2) . "</td>"; elseif ($cnt >= 19) echo "<td></td>";
			if (isset($row['value20'])) echo "<td>" . number_format($row['value20'], 2) . "</td>"; elseif ($cnt >= 20) echo "<td></td>";
			if (isset($row['portionOfAlliancePoints'])) echo "<td>" . number_format($row['portionOfAlliancePoints'], 2) . "</td>";
			if (isset($row['totalScoreValue'])) echo "<td>" . number_format($row['totalScoreValue'], 2) . "</td>";
			if (isset($row['matchFoulPoints'])) echo "<td>" . number_format($row['matchFoulPoints'], 2) . "</td>";
			if (isset($row['matchScore'])) echo "<td>" . number_format($row['matchScore'], 2) . "</td>";
        echo "</tr>";
		}
		?>
    </table>
	<h1>Video</h1>
		<?php
		$tsql = "select case when videoType = 'youtube'
		                     then 'https://www.youtube.com/embed/'
							 else videoType end + trim(videoKey) videoUrl
                   from MatchVideo
				  where matchId = $match
				 order by id";
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
        	echo '<iframe width="560" height="315" src="' . $row['videoUrl'] . '" frameborder="0" allowfullscreen></iframe>';
			echo '<p></p>';
		}
    sqlsrv_free_stmt($getResults);
	sqlsrv_close($conn);
	?>
	</center>
	<p></p>
	<h2>
		<center><a id="audit" class="clickme danger" href="matchAuditReport.php">Report to Audit Matches</a></center>
	</h2>
</body>
</html>