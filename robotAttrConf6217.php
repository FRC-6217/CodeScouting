<html>
     <meta name="viewport" content="width=device-width, initial-scale=1">
     <title>Scouting App</title>
     <link rel="stylesheet" type="text/css" href="Style/scoutingStyle.css">
	 <body>
		<h1><center>Bomb Botz Scouting App</center></h1>
	</body>
	<p></p>
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
	//$submit = $POST[submitToDatabase];
	$teamId = $_POST[teamId];
	$loginEmailAddress = getenv("DefaultLoginEmailAddress");
	$tsql = "select scoutGUID from Scout where emailAddress = '$loginEmailAddress'";
	echo "Team: ".$teamId."<br />";
	echo "Email: ".$loginEmailAddress."<br />";
	echo "SQL: ".$tsql."<br />";
    $getResults = sqlsrv_query($conn, $tsql);
    if ($getResults == FALSE)
		if( ($errors = sqlsrv_errors() ) != null) {
			foreach( $errors as $error ) {
				echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
				echo "code: ".$error[ 'code']."<br />";
				echo "message: ".$error[ 'message']."<br />";
			}
		}
	$row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC);
	$loginGUID = $row['scoutGUID'];
/*
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
*/
?>
	<p></p>
	<h2>
		<center><a id="buttons" class="clickme danger" href="index6217.php">Home</a>
			    <a id="buttons" class="clickme danger" href="robotAttrList6217.php">Scout Robot</a></center>
	</h2>
	<p></p>
<?php
/*
    $tsql = "sp_ins_scoutRobot $teamId, '$loginGUID', '$value1'";
	if (isset($value2))
		$tsql .= ", '$value2'";
	if (isset($value3))
		$tsql .= ", '$value3'";
	if (isset($value4))
		$tsql .= ", '$value4'";
	if (isset($value5))
		$tsql .= ", '$value5'";
	if (isset($value6))
		$tsql .= ", '$value6'";
	if (isset($value7))
		$tsql .= ", '$value7'";
	if (isset($value8))
		$tsql .= ", '$value8'";
	if (isset($value9))
		$tsql .= ", '$value9'";
	if (isset($value10))
		$tsql .= ", '$value10'";
	$results = sqlsrv_query($conn, $tsql);
	if($results) 
		echo "<p></p><center>Submission Succeeded!</center>";
	
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