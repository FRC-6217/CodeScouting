<html>
     <meta name="viewport" content="width=device-width, initial-scale=1">
     <title>Scouting App</title>
     <link rel="stylesheet" type="text/css" href="Style/scoutingStyle.css">
	 <body>
		<h1><center>Bomb Botz Scouting App</center></h1>
	</body>
	<p></p>
	<center><a class="clickme danger" href="index.php">Home</a></center>
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
    //Establishes the connection to database
    $conn = sqlsrv_connect($serverName, $connectionOptions);

    // Get pQuery String variables
	$scoutId = $_GET['scoutId'];
	$matchId = $_GET['matchId'];
	$teamId = $_GET['teamId'];
	$alliancePosition = $_GET['alliancePosition'];
	$scoutComment = $_GET['scoutComment'];
	$value1 = $_GET['value1'];
	$value2 = $_GET['value2'];
	$value3 = $_GET['value3'];
	$value4 = $_GET['value4'];
	$value5 = $_GET['value5'];
	$value6 = $_GET['value6'];
	$value7 = $_GET['value7'];
	$value8 = $_GET['value8'];
	$value9 = $_GET['value9'];
	$value10 = $_GET['value10'];
	$value11 = $_GET['value11'];
	$value12 = $_GET['value12'];
	$value13 = $_GET['value13'];
	$value14 = $_GET['value14'];
	$value15 = $_GET['value15'];
	$value16 = $_GET['value16'];
	$value17 = $_GET['value17'];
	$value18 = $_GET['value18'];
	$value19 = $_GET['value19'];
	$value20 = $_GET['value20'];

	// Ensure key values are set
	if (!isset($scoutId) || !isset($matchId) || !isset($teamId) || !isset($alliancePosition) ||
		empty($scoutId) || empty($matchId) || empty($teamId) || empty($alliancePosition))
	{
		echo '<center>';				
		echo "The Scout, Match, Team, and Alliance Position must be provided for a new Scout Record.<br />";
		echo '</center>';
		sqlsrv_close($conn);
		echo '</html>'; 
		exit(0);
	}

	// Lookup Scout Record
	$tsql = "select s.scoutGUID
	              , isAdmin
				  , (select count(*)
                       from team t
                            inner join GameEvent ge
	                        on ge.id = t.gameEventId
	                        inner join Objective o
	                        on o.gameId = ge.gameId
                      where t.id = s.teamId) cntObjectives
				 from Scout s
				where isActive = 'Y'
				  and id = '$scoutId'";
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
	$isAdmin = $row['isAdmin'];
	$cntObjectives = $row['cntObjectives'];

	// Non-Admin should not be on this page
	if ($isAdmin != "Y") {
		echo '<center>';				
		echo 'Scout Id: ' . $scoutId . ' does not exist or is not authorized for this function.';
		echo '</center>';
		sqlsrv_close($conn);
		echo '</html>'; 
		exit(0);
	}

	// Create stored procedure call
	$tsql = "sp_ins_scoutRecord 0, $scoutId, $matchId, $teamId, $alliancePosition, '$scoutComment', '$loginGUID'";
	$cnt = 0;
	if (isset($value1)) {
		$tsql .= ", '$value1'";
		$cnt += 1;
	}
	if (isset($value2)) {
		$tsql .= ", '$value2'";
		$cnt += 1;
	}
	if (isset($value3)) {
		$tsql .= ", '$value3'";
		$cnt += 1;
	}
	if (isset($value4)) {
		$tsql .= ", '$value4'";
		$cnt += 1;
	}
	if (isset($value5)) {
		$tsql .= ", '$value5'";
		$cnt += 1;
	}
	if (isset($value6)) {
		$tsql .= ", '$value6'";
		$cnt += 1;
	}
	if (isset($value7)) {
		$tsql .= ", '$value7'";
		$cnt += 1;
	}
	if (isset($value8)) {
		$tsql .= ", '$value8'";
		$cnt += 1;
	}
	if (isset($value9)) {
		$tsql .= ", '$value9'";
		$cnt += 1;
	}
	if (isset($value10)) {
		$tsql .= ", '$value10'";
		$cnt += 1;
	}
	if (isset($value11)) {
		$tsql .= ", '$value11'";
		$cnt += 1;
	}
	if (isset($value12)) {
		$tsql .= ", '$value12'";
		$cnt += 1;
	}
	if (isset($value13)) {
		$tsql .= ", '$value13'";
		$cnt += 1;
	}
	if (isset($value14)) {
		$tsql .= ", '$value14'";
		$cnt += 1;
	}
	if (isset($value15)) {
		$tsql .= ", '$value15'";
		$cnt += 1;
	}
	if (isset($value16)) {
		$tsql .= ", '$value16'";
		$cnt += 1;
	}
	if (isset($value17)) {
		$tsql .= ", '$value17'";
		$cnt += 1;
	}
	if (isset($value18)) {
		$tsql .= ", '$value18'";
		$cnt += 1;
	}
	if (isset($value19)) {
		$tsql .= ", '$value19'";
		$cnt += 1;
	}
	if (isset($value20)) {
		$tsql .= ", '$value20'";
		$cnt += 1;
	}

	// Not enough objectives provided
	if ($cnt < $cntObjectives) {
		echo '<center>';				
		echo 'Scout Record requires ' . $cntObjectives . ' values.';
		echo '</center>';
		sqlsrv_close($conn);
		echo '</html>'; 
		exit(0);
	}

	// Run DB Stored procedure call
	$results = sqlsrv_query($conn, $tsql);
	if($results) 
		echo "<p></p>";
		echo "<center><a class='clickme danger' href='Reports/matchReport.php?matchId=" . $matchId . "'>Match Report</a></center>";
		echo "<p></p>";
		echo "<center>Submission Succeeded!</center>";
	
	if(!$results) 
	{
		echo "It is not working!<br />";
		echo $tsql."<br />";
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