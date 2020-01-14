<html>
     <meta name="viewport" content="width=device-width, initial-scale=1">
     <title>Scouting App</title>
     <link rel="stylesheet" type="text/css" href="Style/scoutingStyle.css">
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
	$game = $_POST[game];
	$event = $_POST[event];
	$option = $_POST[option];

	echo "Game: " . $game . "<br>";
	echo "Event: " . $event . "<br>";
	echo "Option: " . $option . "<br>";
/*
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
*/

    sqlsrv_free_stmt($getResults);
	sqlsrv_close($conn);
?>
</html>
