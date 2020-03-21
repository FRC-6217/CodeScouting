<html>
     <meta name="viewport" content="width=device-width, initial-scale=1">
     <title>Scouting App</title>
     <link rel="stylesheet" type="text/css" href="/Style/scoutingStyle.css">
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

	$rankName = "$_GET[rankName]";
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
							inner join gameEvent ge
							on ge.gameId = r.gameId
					  where ge.isActive = 'Y'
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
			while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
				echo "<th><a href='../Reports/rankReport.php?sortOrder=" . $row['queryString'] . "&rankName=" . $row['name'] . "'>" . $row['name'] . "<br/>Rank</a></th>";
				echo "<th>" . $row['name'] . "<br/>Value</th>";
			}
			sqlsrv_free_stmt($getResults);
			<th>Event<br/>Rank</th>
            <th>Rank<br/>Pts</th>
			?>
        </tr>
<?php
$sortOrder = "$_GET[sortOrder]";
$tsql = "execute sp_rpt_rankReport '$sortOrder'";
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
			echo "<td><a href='../Reports/robotReport.php?TeamId=" . $row['teamId'] . "'>" . $row['TeamNumber'] . "</a></td>";
			echo "<td>" . $row['cntMatches'] . "</td>";
			echo "<td>" . $row['avgRank'] . "</td>";
			if (isset($row['rankValue1'])) echo "<td>" . $row['rankValue1'] . "</td>";
			if (isset($row['value1'])) echo "<td>" . number_format($row['value1'], 2) . "</td>";
			if (isset($row['rankValue2'])) echo "<td>" . $row['rankValue2'] . "</td>";
			if (isset($row['value2'])) echo "<td>" . number_format($row['value2'], 2) . "</td>";
			if (isset($row['rankValue3'])) echo "<td>" . $row['rankValue3'] . "</td>";
			if (isset($row['value3'])) echo "<td>" . number_format($row['value3'], 2) . "</td>";
			if (isset($row['rankValue4'])) echo "<td>" . $row['rankValue4'] . "</td>";
			if (isset($row['value4'])) echo "<td>" . number_format($row['value4'], 2) . "</td>";
			if (isset($row['rankValue5'])) echo "<td>" . $row['rankValue5'] . "</td>";
			if (isset($row['value5'])) echo "<td>" . number_format($row['value5'], 2) . "</td>";
			if (isset($row['rankValue6'])) echo "<td>" . $row['rankValue6'] . "</td>";
			if (isset($row['value6'])) echo "<td>" . number_format($row['value6'], 2) . "</td>";
			if (isset($row['rankValue7'])) echo "<td>" . $row['rankValue7'] . "</td>";
			if (isset($row['value7'])) echo "<td>" . number_format($row['value7'], 2) . "</td>";
			if (isset($row['rankValue8'])) echo "<td>" . $row['rankValue8'] . "</td>";
			if (isset($row['value8'])) echo "<td>" . number_format($row['value8'], 2) . "</td>";
			if (isset($row['rankValue9'])) echo "<td>" . $row['rankValue9'] . "</td>";
			if (isset($row['value9'])) echo "<td>" . number_format($row['value9'], 2) . "</td>";
			if (isset($row['rankValue10'])) echo "<td>" . $row['rankValue10'] . "</td>";
			if (isset($row['value10'])) echo "<td>" . number_format($row['value10'], 2) . "</td>";
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