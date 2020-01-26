<html>
     <meta name="viewport" content="width=device-width, initial-scale=1">
     <title>Scouting App</title>
     <link rel="stylesheet" type="text/css" href="Style/scoutingStyle.css">
	 <center><a href="scoutRecord.php">Another Scout Record</a></center>
	 <p></p>
	 <center><a href="index.php">Home</a></center>
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

    // Get posted variables
	$submit = $POST[submitToDatabase];
	$scout = $_POST[scout];
	$match = $_POST[match];
	$team = $_POST[team];
	$leaveHab = $_POST[leaveHAB];
	$ssHatchCnt = $_POST[ssHatchCnt];
	$ssCargoCnt = $_POST[ssCargoCnt];
	$toHatchCnt = $_POST[toHatchCnt];
	$toCargoCnt = $_POST[toCargoCnt];
	$defense = $_POST[playedDefense];
	$returnHab = $_POST[returnToHAB];

    $tsql = "sp_ins_scoutRecord $scout, $match, $team, $leaveHab, $ssHatchCnt, $ssCargoCnt, $toHatchCnt, $toCargoCnt, $defense, $returnHab";
	$results = sqlsrv_query($conn, $tsql);
	if($results) 
		echo "Submission Succeeded!";
	
	if(!$results) 
	{
		echo "It is not working!<br />";
		if( ($errors = sqlsrv_errors() ) != null) {
			foreach( $errors as $error ) {
				echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
				echo "code: ".$error[ 'code']."<br />";
				echo "message: ".$error[ 'message']."<br />";
			}
		}
	}		

    sqlsrv_free_stmt($getResults);
	sqlsrv_close($conn);
?>
</html>