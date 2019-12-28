<html>
     <meta name="viewport" content="width=device-width, initial-scale=1">
     <title>Scouting App</title>
     <link rel="stylesheet" type="text/css" href="Style/scoutingStyle.css">
	 <center><a href="scoutRecord.php">Another Scout Record</a></center>
	 <p></p>
	 <center><a href="index.php">Home</a></center>
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
?>
</html>