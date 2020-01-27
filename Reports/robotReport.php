<html>
     <meta name="viewport" content="width=device-width, initial-scale=1">
     <title>Scouting App</title>
     <link rel="stylesheet" type="text/css" href="/Style/scoutingStyle.css">
	 <center><a href="..\index.php">Home</a></center>
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
			sqlsrv_close($conn);
			?>
    </tr>
<?php
$team = "$_GET[TeamId]";
$tsql = "select TeamNumber
              , matchNumber
              , left(convert(varchar, matchTime, 24), 5) matchTimeOnly
              , scoutName
              , leaveHab
              , ssHatchCnt
              , ssCargoCnt
              , totHatchCnt
              , totCargoCnt
              , playedDefense
              , returnToHab
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
?>
	<tr>
        <td><a href="\Reports\robotReport.php?TeamId=<?php echo ($row['TeamId']);?>"><?php echo ($row['TeamNumber']);?></a></td>
        <td><?php echo ($row['matchNumber']);?></td>
        <td><?php echo ($row['matchTimeOnly']);?></td>
        <td><?php echo ($row['scoutName']);?></td>
        <td><?php echo ($row['leaveHab']);?></td>
        <td><?php echo ($row['ssHatchCnt']);?></td>
        <td><?php echo ($row['ssCargoCnt']);?></td>
        <td><?php echo ($row['totHatchCnt']);?></td>
        <td><?php echo ($row['totCargoCnt']);?></td>
        <td><?php echo ($row['playedDefense']);?></td>
        <td><?php echo ($row['returnToHab']);?></td>
	</tr>
    <?php
    }
    sqlsrv_free_stmt($getResults);
	sqlsrv_close($conn);
    ?>
    </center>
    </table>
</html>