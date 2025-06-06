<html>
     <meta name="viewport" content="width=device-width, initial-scale=1">
     <title>Scouting App</title>
     <link rel="stylesheet" type="text/css" href="/Style/scoutingStyle.css">
	 <head>
		<style>
			.fixTableHead {
				overflow-y: auto;
				height: 1100px;
				border: 1px solid black;
			}
			.fixTableHead thead th {
				position: sticky;
				top: 0;
			}
		</style>
	</head>
	<body>
 	<center><a class="clickme danger" href="..\index.php">Home</a></center>
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

	//Filter by all teams or playoff only
	$teams = 'A';
	if (isset($_GET['teams']))
		$teams = $_GET['teams'];

	$rankName = "$_GET[rankName]";
	$loginEmailAddress = getenv("DefaultLoginEmailAddress");
	$tsql = "select scoutGUID, playoffStarted, cntPlayoffSelected from v_PlayoffStarted where emailAddress = '$loginEmailAddress'";
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
	$playoffStarted = $row['playoffStarted'];
	$cntPlayoffSelected = $row['cntPlayoffSelected'];
	echo "<center><h1>Rank Report by " . $rankName . "</h1></center>";
	if ($playoffStarted == 1) {
		echo "<center><h2>Note: " . $cntPlayoffSelected . " Teams already selected for Playoffs are moved to the bottom of the list.</h2></center>";
		if ($teams == 'A')
			echo "<center><a class='clickme danger' href='../Reports/rankReport.php?sortOrder=" . $sortOrder . "&rankName=" . $rankName . "&teams=P'>Playoff Teams</a></center>";
		else
			echo "<center><a class='clickme danger' href='../Reports/rankReport.php?sortOrder=" . $sortOrder . "&rankName=" . $rankName . "&teams=A'>All Teams</a></center>";
	}
?>
	<br>
	<div class="fixTableHead">
	<center>
    <table cellspacing="0" cellpadding="5">
		<thead>
        <tr>
<?php
			if ($playoffStarted == 1)
				echo "<th>Playoff<br/>Alliance</th>";
?>
			<th><a href='../Reports/rankReport.php?sortOrder=Team&rankName=Team'>Team</a></th>
			<th>Scouted<br/>Matches</th>
            <th>Avg<br/>Rank</th>
			<?php
			// Display table headers for the ranks
			$tsql = "select r.name
			              , r.queryString
					   from Rank r
							inner join v_GameEvent ge
							on ge.gameId = r.gameId
                      where ge.loginGUID = '$loginGUID'
					 order by r.sortOrder";
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
				echo "<th><a href='../Reports/rankReport.php?sortOrder=" . $row['queryString'] . "&rankName=" . $row['name'] . "'>" . $row['name'] . "<br/>Rank</a></th>";
				echo "<th>" . $row['name'] . "<br/>Value</th>";
				$cnt = $cnt + 1;
			}
			sqlsrv_free_stmt($getResults);
			?>
			<th><a href='../Reports/rankReport.php?sortOrder=eventRank&rankName=Ranking Points'>Event<br/>Rank</a></th>
            <th>Rank<br/>Pts</th>
			<th><a href='../Reports/rankReport.php?sortOrder=OPR&rankName=OPR'>OPR</a></th>
			<?php
			// Display table headers for the Ranking Points/Cooperition realized
			$tsql = "select grp.tableHeader
   						  , grp.sortOrder
		 			   from GameRankingPoint grp
			  				inner join v_GameEvent ge
			  				on ge.gameId = grp.gameId
					  where ge.loginGUID = '$loginGUID'
				     union
	   				 select 'Coop' tableHeader
						  , 99 sortOrder
					   from Game g
			  				inner join v_GameEvent ge
			  				on ge.gameId = g.id
					  where ge.loginGUID = '$loginGUID'
		  				and g.tbaCoopMet is not null
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
				echo "<th>" . $row['tableHeader'] . "</th>";
			}
			sqlsrv_free_stmt($getResults);
			?>
        </tr>
		</thead>
		<tbody>
<?php
$sortOrder = "$_GET[sortOrder]";
$tsql = "execute sp_rpt_rankReport '$sortOrder', '$loginGUID'";
    $getResults = sqlsrv_query($conn, $tsql);
    if ($getResults == FALSE)
		if( ($errors = sqlsrv_errors() ) != null) {
			foreach( $errors as $error ) {
				echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
				echo "code: ".$error[ 'code']."<br />";
				echo "message: ".$error[ 'message']."<br />";
			}
		}
	$first = 1;
	$playoffAlliancePrev = '0';
    while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
		// Add blank line between playoff alliances when filtered for playoff
		if ($playoffStarted == 1 and
		    $teams == 'P' and
			$row['playoffAlliance'] != '0' and
			$row['playoffAlliance'] != $playoffAlliancePrev) {
			if ($first == 0) {
				echo "<tr><td></td></tr>";
			}
			$first = 0;
			$playoffAlliancePrev = $row['playoffAlliance'];
		}

		echo "<tr>";
		if ($playoffStarted != 1 or
		    $teams == 'A' or
			$row['playoffAlliance'] != '0') {

			if ($playoffStarted == 1) {
				if ($row['playoffAlliance'] =='0') 
					echo "<td></td>";
				else
					echo "<td>" . $row['playoffAlliance'] . "</td>";
			}
			echo "<td><a href='../Reports/robotReport.php?TeamId=" . $row['teamId'] . "'>" . $row['TeamNumber'] . "</a></td>";
			echo "<td>" . $row['cntMatches'] . "</td>";
			echo "<td>" . $row['avgRank'] . "</td>";
			if (isset($row['rankValue1'])) echo "<td>" . $row['rankValue1'] . "</td>"; elseif ($cnt >= 1) echo "<td></td>";
			if (isset($row['value1'])) echo "<td>" . number_format($row['value1'], 2) . "</td>"; elseif ($cnt >= 1) echo "<td></td>";
			if (isset($row['rankValue2'])) echo "<td>" . $row['rankValue2'] . "</td>"; elseif ($cnt >= 2) echo "<td></td>";
			if (isset($row['value2'])) echo "<td>" . number_format($row['value2'], 2) . "</td>"; elseif ($cnt >= 2) echo "<td></td>";
			if (isset($row['rankValue3'])) echo "<td>" . $row['rankValue3'] . "</td>"; elseif ($cnt >= 3) echo "<td></td>";
			if (isset($row['value3'])) echo "<td>" . number_format($row['value3'], 2) . "</td>"; elseif ($cnt >= 3) echo "<td></td>";
			if (isset($row['rankValue4'])) echo "<td>" . $row['rankValue4'] . "</td>"; elseif ($cnt >= 4) echo "<td></td>";
			if (isset($row['value4'])) echo "<td>" . number_format($row['value4'], 2) . "</td>"; elseif ($cnt >= 4) echo "<td></td>";
			if (isset($row['rankValue5'])) echo "<td>" . $row['rankValue5'] . "</td>"; elseif ($cnt >= 5) echo "<td></td>";
			if (isset($row['value5'])) echo "<td>" . number_format($row['value5'], 2) . "</td>"; elseif ($cnt >= 5) echo "<td></td>";
			if (isset($row['rankValue6'])) echo "<td>" . $row['rankValue6'] . "</td>"; elseif ($cnt >= 6) echo "<td></td>";
			if (isset($row['value6'])) echo "<td>" . number_format($row['value6'], 2) . "</td>"; elseif ($cnt >= 6) echo "<td></td>";
			if (isset($row['rankValue7'])) echo "<td>" . $row['rankValue7'] . "</td>"; elseif ($cnt >= 7) echo "<td></td>";
			if (isset($row['value7'])) echo "<td>" . number_format($row['value7'], 2) . "</td>"; elseif ($cnt >= 7) echo "<td></td>";
			if (isset($row['rankValue8'])) echo "<td>" . $row['rankValue8'] . "</td>"; elseif ($cnt >= 8) echo "<td></td>";
			if (isset($row['value8'])) echo "<td>" . number_format($row['value8'], 2) . "</td>"; elseif ($cnt >= 8) echo "<td></td>";
			if (isset($row['rankValue9'])) echo "<td>" . $row['rankValue9'] . "</td>"; elseif ($cnt >= 9) echo "<td></td>";
			if (isset($row['value9'])) echo "<td>" . number_format($row['value9'], 2) . "</td>"; elseif ($cnt >= 9) echo "<td></td>";
			if (isset($row['rankValue10'])) echo "<td>" . $row['rankValue10'] . "</td>"; elseif ($cnt >= 10) echo "<td></td>";
			if (isset($row['value10'])) echo "<td>" . number_format($row['value10'], 2) . "</td>"; elseif ($cnt >= 10) echo "<td></td>";
			echo "<td>" . $row['eventRank'] . "</td>";
			echo "<td>" . $row['rankingPointAverage'] . "</td>";
			echo "<td>" . $row['oPR'] . "</td>";
			if (isset($row['rp1TableHeader'])) echo "<td>" . $row['rp1Total'] . "</td>";
			if (isset($row['rp2TableHeader'])) echo "<td>" . $row['rp2Total'] . "</td>";
			if (isset($row['rp3TableHeader'])) echo "<td>" . $row['rp3Total'] . "</td>";
			if (isset($row['coopTableHeader'])) echo "<td>" . $row['coopTotal'] . "</td>";
			echo "</tr>";
		}
	}
	sqlsrv_free_stmt($getResults);
	sqlsrv_close($conn);
	?>
	</tbody>
    </table>
	</center>
	</div>
</body>
</html>