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
?>
	<center><h1>Pre-Match Report (Team Objective Averages)</h1></center>
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
		</tr>

		<?php
		$match = "$_GET[matchId]";
		$tsql = "select matchNumber
                      , matchId
				 	  , TeamId
				 	  , TeamNumber
					  , alliance
					  , alliancePosition
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
    while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
        echo "<tr>";
        	echo "<td>" . $row['alliance'] . "</td>";
			echo "<td>" . $row['alliancePosition'] . "</td>";
			echo "<td>" . $row['teamReportUrl'] . "</td>";
			echo "<td>" . $row['matchCnt'] . "</td>";
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
        echo "</tr>";
    }
    sqlsrv_free_stmt($getResults);
	sqlsrv_close($conn);
    ?>
    </center>
    </table>
</html>