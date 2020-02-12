<html>
     <meta name="viewport" content="width=device-width, initial-scale=1">
     <title>Scouting App</title>
     <link rel="stylesheet" type="text/css" href="Style/scoutingStyle.css">
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
	$alliancePosition = $_POST[alliancePosition];
	$value1 = $_POST[value1];
	$value2 = $_POST[value2];
	$value3 = $_POST[value3];
	$value4 = $_POST[value4];
	$value5 = $_POST[value5];
	$value6 = $_POST[value6];
	$value7 = $_POST[value7];
	$value8 = $_POST[value8];
	$value9 = $_POST[value9];
	$value10 = $_POST[value10];
	$value11 = $_POST[value11];
	$value12 = $_POST[value12];
	$value13 = $_POST[value13];
	$value14 = $_POST[value14];
	$value15 = $_POST[value15];

	echo "<center><a class='clickme danger' href='scoutRecord.php?matchId=" . $matchId + 1 . "&matchNumber=PR 5&teamId=NA&teamNumber=NA&alliancePosition=" . $alliancePosition . "'>Another Scout Record</a></center>";
?>
	 <p></p>
	 <center><a class="clickme danger" href="index.php">Home</a></center>
<?php
    $tsql = "sp_ins_scoutRecord $scout, $match, $team, $alliancePosition, $value1";
	if (isset($value2))
		$tsql .= ", $value2";
	if (isset($value3))
		$tsql .= ", $value3";
	if (isset($value4))
		$tsql .= ", $value4";
	if (isset($value5))
		$tsql .= ", $value5";
	if (isset($value6))
		$tsql .= ", $value6";
	if (isset($value7))
		$tsql .= ", $value7";
	if (isset($value8))
		$tsql .= ", $value8";
	if (isset($value9))
		$tsql .= ", $value9";
	if (isset($value10))
		$tsql .= ", $value10";
	if (isset($value11))
		$tsql .= ", $value11";
	if (isset($value12))
		$tsql .= ", $value12";
	if (isset($value13))
		$tsql .= ", $value13";
	if (isset($value14))
		$tsql .= ", $value14";
	if (isset($value15))
		$tsql .= ", $value15";
	$results = sqlsrv_query($conn, $tsql);
	echo $tql;
	if($results) 
		echo "<center>Submission Succeeded!</center>";
	
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