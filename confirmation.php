<html>
     <meta name="viewport" content="width=device-width, initial-scale=1">
     <title>Scouting App</title>
     <link rel="stylesheet" type="text/css" href="Style/scoutingStyle.css">
<?php
    $serverName = "team6217.database.windows.net";
	$database = "ScoutApp";
	$userName = "frc6217";
	$password = "Cfbombers6217";
    $connectionOptions = array(
        "Database" => "$database",
        "Uid" => "$userName",
        "PWD" => "$password"
    );
    //Establishes the connection
    $conn = sqlsrv_connect($serverName, $connectionOptions);

    // Get posted variables
	$submit = $POST[submitToDatabase];
	$scout = $_POST[scout];
	$match = $_POST[match];
	$team = $_POST[team];
	$leaveHab = $_POST[leaveHab];
	$ssHatchCnt = $_POST[ssHatchCnt];
	$ssCargoCnt = $_POST[ssCargoCnt];
	$toHatchCnt = $_POST[toHatchCnt];
	$toCargoCnt = $_POST[toCargoCnt];
	$defense = $_POST[defense];
	$returnHab = $_POST[returnHab];

	echo $submit;
	echo $scout;
	echo $match;
	echo $team;
	echo $leaveHab;
	echo $ssHatchCnt;
	echo $ssCargoCnt;
	echo $toHatchCnt;
	echo $toCargoCnt;
	echo $defense;
	echo $returnHab;

    $insertingData = "INSERT into scoutrecord (matchId, robotId, scoutId, leaveHAB, ssHatchCnt, ssCargoCnt, toHatchCnt, toCargoCnt, playedDefense, returnToHAB) values ($match, $robot, $scouts, '$lev', $ssHatchCnt, $ssCargoCnt, $toHatchCnt, $toCargoCnt, '$def', '$ret');";

    $tsql = "execute sp_ins_scoutRecord $scout, $match, $team, $leaveHab, $ssHatchCnt, $ssCargoCnt, $toHatchCnt, $toCargoCnt, $defense, $returnHab";
	$results = sqlsrv_query($conn, $tsql);
	if($executing) {
		echo "Submittion Succeeded!";
	}
	if(!$executing) {
		echo "It is not working!";
	}

    sqlsrv_free_stmt($getResults);
?>
	<center><a href="scoutRecord.php">Click here to go back to the Scout Record page! </a></center>
</html>