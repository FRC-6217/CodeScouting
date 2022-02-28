<html>
     <meta name="viewport" content="width=device-width, initial-scale=1">
     <title>Scouting App</title>
     <link rel="stylesheet" type="text/css" href="/Style/scoutingStyle.css">
	 <center><a class="clickme danger" href="..\index6217.php">Home</a></center>
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

	$rankName = "$_GET[rankName]";
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
	echo "<center><h1>Rank Report by " . $rankName . "</h1></center>";
?>
<center>
    <table cellspacing="0" cellpadding="5">
        <tr>
            <th>Team</th>
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
				echo "<th><a href='../Reports/rankReport6217.php?sortOrder=" . $row['queryString'] . "&rankName=" . $row['name'] . "'>" . $row['name'] . "<br/>Rank</a></th>";
				echo "<th>" . $row['name'] . "<br/>Value</th>";
				$cnt = $cnt + 1;
			}
			sqlsrv_free_stmt($getResults);
			echo "<th><a href='../Reports/rankReport6217.php?sortOrder=eventRank&rankName=Ranking Points'>Event<br/>Rank</a></th>";
			?>
            <th>Rank<br/>Pts</th>
        </tr>
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
    while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
		echo "<tr>";
			echo "<td><a href='../Reports/robotReport6217.php?TeamId=" . $row['teamId'] . "'>" . $row['TeamNumber'] . "</a></td>";
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
		echo "</tr>";
	}
	sqlsrv_free_stmt($getResults);
	sqlsrv_close($conn);
	?>
    </table>
</center>
</html>