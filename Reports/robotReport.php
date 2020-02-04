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
	$team = "$_GET[TeamId]";
?>
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
			echo "<td><a href='\Reports\robotReport.php?TeamId=" . $row['TeamId'] . "'>" . $row['TeamNumber'] . "</a></td>";
			echo "<td>" . $row['matchNumber'] . "</td>";
			echo "<td>" . $row['matchTimeOnly'] . "</td>";
			echo "<td>" . $row['scoutName'] . "</td>";
			if (isset($row['value1'])) echo "<td>" . $row['value1'] . "</td>";
			if (isset($row['value2'])) echo "<td>" . $row['value2'] . "</td>";
			if (isset($row['value3'])) echo "<td>" . $row['value3'] . "</td>";
			if (isset($row['value4'])) echo "<td>" . $row['value4'] . "</td>";
			if (isset($row['value5'])) echo "<td>" . $row['value5'] . "</td>";
			if (isset($row['value6'])) echo "<td>" . $row['value6'] . "</td>";
			if (isset($row['value7'])) echo "<td>" . $row['value7'] . "</td>";
			if (isset($row['value8'])) echo "<td>" . $row['value8'] . "</td>";
			if (isset($row['value9'])) echo "<td>" . $row['value9'] . "</td>";
			if (isset($row['value10'])) echo "<td>" . $row['value10'] . "</td>";
			if (isset($row['value11'])) echo "<td>" . $row['value11'] . "</td>";
			if (isset($row['value12'])) echo "<td>" . $row['value12'] . "</td>";
			if (isset($row['value13'])) echo "<td>" . $row['value13'] . "</td>";
			if (isset($row['value14'])) echo "<td>" . $row['value14'] . "</td>";
			if (isset($row['value15'])) echo "<td>" . $row['value15'] . "</td>";
		echo "</tr>";
    }
    sqlsrv_free_stmt($getResults);
	sqlsrv_close($conn);
    ?>
    </center>
    </table>
</html>