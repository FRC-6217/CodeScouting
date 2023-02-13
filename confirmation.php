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
    //Establishes the connection to database
    $conn = sqlsrv_connect($serverName, $connectionOptions);

    // Get posted variables
	$scout = $_POST['scout'];
	$match = $_POST['match'];
	$team = $_POST['team'];
	$alliancePosition = $_POST['alliancePosition'];
	$scoutComment = $_POST['scoutComment'];
	$loginEmailAddress = getenv("DefaultLoginEmailAddress");
	$tsql = "select scoutGUID from Scout where emailAddress = '$loginEmailAddress'";
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
	$value1 = $_POST['value1'];
	$value2 = $_POST['value2'];
	$value3 = $_POST['value3'];
	$value4 = $_POST['value4'];
	$value5 = $_POST['value5'];
	$value6 = $_POST['value6'];
	$value7 = $_POST['value7'];
	$value8 = $_POST['value8'];
	$value9 = $_POST['value9'];
	$value10 = $_POST['value10'];
	$value11 = $_POST['value11'];
	$value12 = $_POST['value12'];
	$value13 = $_POST['value13'];
	$value14 = $_POST['value14'];
	$value15 = $_POST['value15'];
	$value16 = $_POST['value16'];
	$value17 = $_POST['value17'];
	$value18 = $_POST['value18'];
	$value19 = $_POST['value19'];
	$value20 = $_POST['value20'];
	$alliance = substr($alliancePosition, 0, 1);
	$position = substr($alliancePosition, 1, 1);

	$tsql = "select m.id matchId
				  , m.type + ' ' + m.number matchNumber
				  , coalesce(convert(varchar, tm.teamId), 'NA') teamId
				  , coalesce(convert(varchar, t.teamNumber), 'NA') teamNumber
			   from Match m
				    left outer join TeamMatch tm
				    on tm.matchId = m.id 
					and tm.alliance = '$alliance'
                    and tm.alliancePosition = $position
				    left outer join Team t
				    on t.id = tm.teamId
			  where m.id =
				    (select top 1 m2.id
				 	   from Match m
						    inner join Match m2
						    on m2.gameEventId = m.gameEventId
					  where m2.isActive = 'Y'
					    and m2.dateTime > m.dateTime
					    and m.id = $match
			         order by m2.dateTime)";
	$getResults = sqlsrv_query($conn, $tsql);
	if ($getResults == FALSE)
		if( ($errors = sqlsrv_errors() ) != null) {
			foreach( $errors as $error ) {
				echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
				echo "code: ".$error[ 'code']."<br />";
				echo "message: ".$error[ 'message']."<br />";
			}
		}
	$cnt = 0;
	while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
		echo "<center><a class='clickme danger' href='scoutRecord.php?matchId=" . $row['matchId'] . "&matchNumber=" . $row['matchNumber'] . "&teamId=" . $row['teamId'] . "&teamNumber=" . $row['teamNumber'] .  "&alliancePosition=" . $alliancePosition . "&scoutId=" . $scout . "'>Another Scout Record</a></center>";
		$cnt += 1;
	}
	if ($cnt == 0) {
		echo "<center><a class='clickme danger' href='scoutRecord.php'>Another Scout Record</a></center>";
	}
	echo "<p></p>";
	echo "<center><a class='clickme danger' href='Reports/matchReport6217.php?matchId=" . $match . "'>Match Report</a></center>";
   ?>
	 <p></p>
	 <center><a class="clickme danger" href="index6217.php">Home</a></center>
<?php
    $tsql = "sp_ins_scoutRecord $scout, $match, $team, $alliancePosition, '$scoutComment', '$loginGUID', '$value1'";
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
	if (isset($value11))
		$tsql .= ", '$value11'";
	if (isset($value12))
		$tsql .= ", '$value12'";
	if (isset($value13))
		$tsql .= ", '$value13'";
	if (isset($value14))
		$tsql .= ", '$value14'";
	if (isset($value15))
		$tsql .= ", '$value15'";
	if (isset($value16))
		$tsql .= ", '$value16'";
	if (isset($value17))
		$tsql .= ", '$value17'";
	if (isset($value18))
		$tsql .= ", '$value18'";
	if (isset($value19))
		$tsql .= ", '$value19'";
	if (isset($value20))
		$tsql .= ", '$value20'";
	$results = sqlsrv_query($conn, $tsql);
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