<html>
     <meta name="viewport" content="width=device-width, initial-scale=1">
     <title>Scouting App</title>
     <link rel="stylesheet" type="text/css" href="Style/scoutingStyle.css">
	<body>
		<h1><center>Bomb Botz Scouting App</center></h1>
	</body>
	<p></p>
	<h2>
		<center><a id="home" class="clickme danger" href="index.php">Home</a></center>
		<p></p>
		<center><a id="eventSetup" class="clickme danger" href="eventSetup.php">Event Setup</a></center>
		<p></p>
	</h2>
<?php
	// Initial setup of Database Connection
	ini_set('display_errors', '1');
    $serverName = getenv("ScoutAppDatabaseServerName");
	$database = getenv("Database");
	$userName = getenv("DatabaseUserName");
	$password = getenv("DatabasePassword");
    $connectionOptions = array(
        "Database" => "$database",
        "Uid" => "$userName",
        "PWD" => "$password"
    );
    // Establishes the DB connection
    $conn = sqlsrv_connect($serverName, $connectionOptions);

	// Setup Blue Alliance API calls
	$TBAAuthKey = getenv("TheBlueAllianceAuthKey");
	$TBAURL = getenv("TheBlueAllianceAPIURL");
	$aHTTP['http']['method']  = "GET";
	$aHTTP['http']['header']  = "X-TBA-Auth-Key: " . $TBAAuthKey. "\r\n";
	$aHTTP['http']['header'] .= "Accept: application/json\r\n";
	$context = stream_context_create($aHTTP);

    // Get posted variables
	$submit = $POST['submitToDatabase'];
	$gameYear = $_POST['gameYear'];
	$eventCode = $_POST['eventCode'];
	$option = $_POST['option'];

	// Options
	// M = Update Match Schedule
	// P = Create Practice Matches
	// Q = Activate Qualifying Matches
	// L = Activate Playoff Matches
	// A = Activate Game Event
	// T = Update Team List

	// First step is always to get TBA Event information and insert/update Event in the database
	$sURL = $TBAURL. "event/" . $gameYear . $eventCode . "/simple";
	$eventJSON = file_get_contents($sURL, false, $context);
	$eventValue = json_decode($eventJSON, true);
	// Add/Update Event Info to the database
	if (!empty($eventValue)) {
		$tsql = "merge Event as target " . 
		        "using (select '" . str_replace("'", "", $eventValue["name"]) . "', '" . str_replace("'", "", $eventValue["city"]) . ", " . str_replace("'", "", $eventValue["state_prov"]) . "', '" . $eventValue["event_code"] . "') " .
                "as source (name, location, eventCode) " .
				"on (target.eventCode = source.eventCode) " .
				"WHEN matched THEN " .
				"UPDATE set name = source.name, location = source.location " .
				"WHEN not matched THEN " .
				"INSERT (name, location, eventCode) " .
				"VALUES (source.name, source.location, source.eventCode);";
		$results = sqlsrv_query($conn, $tsql);
		if(!$results) 
		{
			echo "Update of Event failed!<br />";
			if( ($errors = sqlsrv_errors() ) != null) {
				foreach( $errors as $error ) {
					echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
					echo "code: ".$error[ 'code']."<br />";
					echo "message: ".$error[ 'message']."<br />";
				}
			}
		}		
		if($results) 
			echo "<center>Event Update Succeeded!</center><br>";
	}
    sqlsrv_free_stmt($results);
	
	// Update teams from this event and link teams to the event
	if ($option == "T") {
		$sURL = $TBAURL. "event/" . $gameYear . $eventCode . "/teams/simple";
		$teamsJSON = file_get_contents($sURL, false, $context);
		$teamsArray = json_decode($teamsJSON, true);
		// Remove all team assignments for the event
		$tsql = "delete from TeamGameEvent " .
		        " where gameEventId = " .
				"       (select ge.id " .
				"          from GameEvent ge " .
				"               inner join Game g on g.id = ge.gameId " .
				"               inner join Event e on e.id = ge.eventId " .
				"         where g.gameYear = " . $gameYear .
				"           and e.eventCode = '" . $eventCode . "');";
		$results = sqlsrv_query($conn, $tsql);
		// Check for errors
		if(!$results) 
		{
			echo "Delete of Team Game Events failed!<br />";
			if( ($errors = sqlsrv_errors() ) != null) {
				foreach( $errors as $error ) {
					echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
					echo "code: ".$error[ 'code']."<br />";
					echo "message: ".$error[ 'message']."<br />";
				}
			}
		}
		sqlsrv_free_stmt($results);
		
		$cnt = 0;
		// Add/update team information and assign to event
		foreach($teamsArray as $key => $value) {
			// Update/insert Team
			$tsql = "merge Team as target " . 
					"using (select " . $value["team_number"] . ", '" . str_replace("'", "", $value["nickname"]) . "', '" . str_replace("'", "", $value["city"]) . ", " . str_replace("'", "", $value["state_prov"]) . "') " .
					"as source (teamNumber, teamName, location) " .
					"on (target.teamNumber = source.teamNumber) " .
					"WHEN matched THEN " .
					"UPDATE set teamName = source.teamName, location = source.location, isActive = 'Y' " .
					"WHEN not matched THEN " .
					"INSERT (teamNumber, teamName, location, isActive) " .
					"VALUES (source.teamNumber, source.teamName, source.location, 'Y');";
			$results = sqlsrv_query($conn, $tsql);
			if(!$results) 
			{
				echo "Update of Team " . $value["team_number"] . " failed!<br />";
				if( ($errors = sqlsrv_errors() ) != null) {
					foreach( $errors as $error ) {
						echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
						echo "code: ".$error[ 'code']."<br />";
						echo "message: ".$error[ 'message']."<br />";
					}
				}
				break;
			}

			// Create Team/Event Cross-Reference
			$tsql = "insert into TeamGameEvent (teamId, gameEventId) " . 
					"select t.id, ge.id " .
					"  from Team t, " .
					"       GameEvent ge " .
				    "       inner join Game g on g.id = ge.gameId " .
				    "       inner join Event e on e.id = ge.eventId " .
				    " where t.teamNumber = " . $value["team_number"] .
					"   and g.gameYear = " . $gameYear .
				    "   and e.eventCode = '" . $eventCode . "';";
			$results = sqlsrv_query($conn, $tsql);
			if(!$results) 
			{
				echo "Insert of Team Game Event for Team " . $value["team_number"] . " failed!<br />";
				if( ($errors = sqlsrv_errors() ) != null) {
					foreach( $errors as $error ) {
						echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
						echo "code: ".$error[ 'code']."<br />";
						echo "message: ".$error[ 'message']."<br />";
					}
				}
				break;
			}
			else $cnt += 1;
		}
		if ($results)
			echo "<center>Updated " . $cnt . " Teams Successfully!</center><br>";
		sqlsrv_free_stmt($results);
	}	
	
	sqlsrv_close($conn);
?>
</html>
