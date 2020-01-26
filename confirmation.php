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

    $tsql = "sp_ins_scoutRecord $scout, $match, $team, $value1";
	if (!empty($value2))
		$tsql .= ", $value2";
	if (!empty($value3))
		$tsql .= ", $value3";
	if (!empty($value4))
		$tsql .= ", $value4";
	if (!empty($value5))
		$tsql .= ", $value5";
	if (!empty($value6))
		$tsql .= ", $value6";
	if (!empty($value7))
		$tsql .= ", $value7";
	if (!empty($value8))
		$tsql .= ", $value8";
	if (!empty($value9))
		$tsql .= ", $value9";
	if (!empty($value10))
		$tsql .= ", $value10";
	if (!empty($value11))
		$tsql .= ", $value11";
	if (!empty($value12))
		$tsql .= ", $value12";
	if (!empty($value13))
		$tsql .= ", $value13";
	if (!empty($value14))
		$tsql .= ", $value14";
	if (!empty($value15))
		$tsql .= ", $value15";
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