<html>
     <meta name="viewport" content="width=device-width, initial-scale=1">
     <title>Scouting App</title>
     <link rel="stylesheet" type="text/css" href="Style/scoutingStyle.css">
	 <center><a href="index.php">Home</a></center>
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
	$aHTTP['http']['method']  = "GET";
	$aHTTP['http']['header']  = "X-TBA-Auth-Key: " . $TBAAuthKey. "\r\n";
	$aHTTP['http']['header'] .= "Accept: application/json\r\n";
	$context = stream_context_create($aHTTP);

    // Get posted variables
	$submit = $POST['submitToDatabase'];
	$game = $_POST['game'];
	$event = $_POST['event'];
	$option = $_POST['option'];

	echo "Game: " . $game . "<br>";
	echo "Event: " . $event . "<br>";
	echo "Option: " . $option . "<br>";
	
	// Options - M = Update Match Schedule, A = Activate Game Event, T = Update Team List
	// First step is always to get TBA Event information and insert/update Event in the database
	$sURL = "https://www.thebluealliance.com/api/v3/event/" . $game . $event . "/simple";
	$eventJSON = file_get_contents($sURL, false, $context);
	$event = json_decode($eventJSON, true);
	echo $sURL . "<br>";
	echo $event . "<br>";
	
	// Add Event Info to the select list
	if (not empty($event)) {
		$tsql = "merge Event as target " . 
		        "using select ('" . $event["name"] . "', '" . $event["city"] . ", " . $event["state_prov"] . "', '" . $event["event_code"] . "') " .
                "as source (name, location, eventCode) " .
				"on (target.eventCode = source.eventCode) " .
				"WHEN matched THEN " .
				"UPDATE set name = source.name, location = source.location " .
				"WHEN not matced THEN " .
				"INSERT (name, location, isActive, eventCode) " .
				"VALUES (source.name, source.location, 'N', source.eventCode) ";
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
	}

    sqlsrv_free_stmt($getResults);
	sqlsrv_close($conn);
?>
</html>
