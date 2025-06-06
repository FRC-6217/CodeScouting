<html>
     <meta name="viewport" content="width=device-width, initial-scale=1">
     <title>Scouting App</title>
     <link rel="stylesheet" type="text/css" href="Style/scoutingStyle.css">
	<body>
		<h1><center>Bomb Botz Scouting App</center></h1>
	</body>
	<p></p>
	<h2>
		<center><a id="home" class="clickme danger" href="index6217.php">Home</a></center>
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
	// I = Import Match CSV File

    // Determine if event exists in TBA
	$sURL = $TBAURL. "events/" . $gameYear . "/simple";
	$eventsJSON = file_get_contents($sURL, false, $context);
	$eventsArray = json_decode($eventsJSON, true);
	$eventTBAExists = false;
	foreach($eventsArray as $key => $value) {
		if ($value["event_code"] == $eventCode) {
			$eventTBAExists = true;
			break;
		}
	}
	
	// Get TBA Event information and insert/update Event in the database
	if ($eventTBAExists) {
		$sURL = $TBAURL. "event/" . $gameYear . $eventCode;
		$eventJSON = file_get_contents($sURL, false, $context);
		$eventValue = json_decode($eventJSON, true);
		// Add/Update Event Info to the database
		if (!empty($eventValue)) {
			$tsql = "merge Event as target " . 
					"using (select '" . str_replace("'", "", $eventValue["name"]) . "', '" . str_replace("'", "", $eventValue["city"]) . ", " . str_replace("'", "", $eventValue["state_prov"]) . "', '" . $eventValue["event_code"] . "') " .
					"as source (name, location, eventCode) " .
					"on (target.eventCode = source.eventCode) " .
					"WHEN matched AND (target.name <> source.name OR target.location <> source.location) THEN " .
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
			if($results) {
				$tsql = "insert into GameEvent (eventId, gameId, eventDate) " . 
						"select e.id, g.id, '" . $eventValue["start_date"] . "' " .
						"  from Event e, Game g " .
						" where e.eventCode = '" . $eventCode . "' " .
						"   and g.gameYear = " . $gameYear .
						"   and not exists (select 1 " .
						"                     from GameEvent ge " .
						"                          inner join Event e on e.id = ge.eventId " .
						"                          inner join Game g on g.id = ge.gameId " .
						"                    where e.eventCode = '" . $eventCode . "' " .
						"                      and g.gameYear = " . $gameYear . ");";
				$results = sqlsrv_query($conn, $tsql);
				if(!$results) 
				{
					echo "Insert of Game Event failed!<br />";
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

			// Get Game Event Id
			$tsql = "select ge.id, ge.eTag, g.tbaCoopMet, g.tbaCoopAchieved, grp1.tbaKey tbaRPKey1, grp2.tbaKey tbaRPKey2, grp3.tbaKey tbaRPKey3 " . 
					"  from GameEvent ge " .
					"       inner join Event e on e.id = ge.eventId " .
					"       inner join Game g on g.id = ge.gameId " .
					"       left outer join GameRankingPoint grp1 on grp1.gameId = ge.gameId and grp1.sortOrder = 1 " .
					"       left outer join GameRankingPoint grp2 on grp2.gameId = ge.gameId and grp2.sortOrder = 2 " .
					"       left outer join GameRankingPoint grp3 on grp3.gameId = ge.gameId and grp3.sortOrder = 3 " .
					" where e.eventCode = '" . $eventCode . "' " .
					"   and g.gameYear = " . $gameYear . ";";
			$results = sqlsrv_query($conn, $tsql);
			if(!$results) {
				echo "Query of Game Event failed!<br />";
				if( ($errors = sqlsrv_errors() ) != null) {
					foreach( $errors as $error ) {
						echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
						echo "code: ".$error[ 'code']."<br />";
						echo "message: ".$error[ 'message']."<br />";
					}
				}
			}
			else {
				while ($row = sqlsrv_fetch_array($results, SQLSRV_FETCH_ASSOC)) {
					$gameEventId = $row['id'];
					$eTag = $row['eTag'];
					$tbaCoopMet = $row['tbaCoopMet'];
					$tbaCoopAchieved = $row['tbaCoopAchieved'];
					$tbaRPKey1 = $row['tbaRPKey1'];
					$tbaRPKey2 = $row['tbaRPKey2'];
					$tbaRPKey3 = $row['tbaRPKey3'];
				}
			}
			// Add webcasts for the GameEvent
			for($i=0; $i<count($eventValue['webcasts']); $i++) {
				// If not exist, then add Event Webcast
				$tsql = "insert into GameEventWebcast (gameEventId, webcastType, webcastChannel)
						 select " . $gameEventId . ", '" . $eventValue['webcasts'][$i]["type"] . "', '" . $eventValue['webcasts'][$i]["channel"] . "'
						  where not exists
						        (select 1
								   from GameEventWebcast gew
								  where gew.gameEventId = " . $gameEventId .
								"   and gew.webcastType = '" . $eventValue['webcasts'][$i]["type"] . "'
								    and gew.webcastChannel = '" . $eventValue['webcasts'][$i]["channel"] . "');";
				$results = sqlsrv_query($conn, $tsql);
				if(!$results) 
				{
					echo "Insert for Game Event Webcast " . $eventValue['webcasts'][$i]["type"] . ", " . $eventValue['webcasts'][$i]["channel"] . " failed!<br />";
					if( ($errors = sqlsrv_errors() ) != null) {
						foreach( $errors as $error ) {
							echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
							echo "code: ".$error[ 'code']."<br />";
							echo "message: ".$error[ 'message']."<br />";
						}
					}
					break;
				}
			}
		}
		if($results) sqlsrv_free_stmt($results);
	}
	
	// Add/update matches on this event and teams in each match
	if ($eventTBAExists && $option == "M") {
		$timezone = "America/Chicago";
		$dt = new DateTime();
		$dt->setTimezone(new DateTimeZone($timezone));
		$sURL = $TBAURL. "event/" . $gameYear . $eventCode . "/matches";
		$aHTTP['http']['header'] .= "If-None-Match: " . $eTag . "\r\n";
		$context2 = stream_context_create($aHTTP);
		$matchesJSON = file_get_contents($sURL, false, $context2);
		// Check return status
		$status_line = $http_response_header[0];
		preg_match('{HTTP\/\S*\s(\d{3})}', $status_line, $match);
	    $status = $match[1];
		foreach ($http_response_header as $header) {
			if (substr($header, 0, 4) == "ETag") {
				if (substr($header, 0, 8) == "ETag: W/") {
					$eTag = substr($header, 9, 40);
				}
				else {
					$eTag = substr($header, 7, 40);
				}
				// Store eTag on Game Event
				$tsql = "update GameEvent " .
						"   set eTag = '" . $eTag . "'" .
						"     , lastUpdated = getdate() " .
						" where id = " . $gameEventId . ";";
				$results = sqlsrv_query($conn, $tsql);
				if(!$results) {
					echo "Update of Game Event failed!<br />";
					if( ($errors = sqlsrv_errors() ) != null) {
						foreach( $errors as $error ) {
							echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
							echo "code: ".$error[ 'code']."<br />";
							echo "message: ".$error[ 'message']."<br />";
						}
					}
				}
			}
		} 
	    if ($status !== "200" && $status !== "304") {
    	    throw new RuntimeException("Match Update unexpected HTTP response status: {$status_line}\n" . $response);
	    }
		//echo print_r(http_parse_headers($http_response_header));
		$matchesArray = json_decode($matchesJSON, true);
		$cnt = 0;
		// Skip if no data in array (either 304 (Not Modified) or matches haven't started)
		if (isset($matchesArray)) {
		// Add/update match information and assign to teams to the match
		foreach($matchesArray as $key => $value) {
			$dt->setTimestamp($value["time"]);
			$datetime = $dt->format('Y-m-d H:i:s');
			$matchNumber = $value["match_number"];
			if ($value["comp_level"] != 'qm')
				$matchNumber = $value["set_number"] . "-" . $matchNumber;
			// Update/insert Match
			if ($gameYear == 2020 &&
			    $value["score_breakdown"]["red"]["endgameRungIsLevel"] == "IsLevel" &&
			    $value["score_breakdown"]["red"]["endgamePoints"] >= 40)
				$redAlliancePoints = 15;
			elseif ($gameYear == 2023)
				if (isset($value["score_breakdown"]["red"]["linkPoints"])) {
					$redAlliancePoints = $value["score_breakdown"]["red"]["linkPoints"];
				}
				else {
					$redAlliancePoints = 0;
				}
			elseif ($gameYear == 2024)
				if (isset($value["score_breakdown"]["red"]["teleopSpeakerNoteAmplifiedCount"])) {
					$redAlliancePoints = $value["score_breakdown"]["red"]["teleopSpeakerNoteAmplifiedCount"] * 3;
				}
				else {
					$redAlliancePoints = 0;
				}
			else
				$redAlliancePoints = 0;
			if ($gameYear == 2020 &&
				$value["score_breakdown"]["blue"]["endgameRungIsLevel"] == "IsLevel" &&
			    $value["score_breakdown"]["blue"]["endgamePoints"] >= 40)
				$blueAlliancePoints = 15;
			elseif ($gameYear == 2023)
				if (isset($value["score_breakdown"]["red"]["linkPoints"])) {
					$blueAlliancePoints = $value["score_breakdown"]["blue"]["linkPoints"];
				}
				else {
					$blueAlliancePoints = 0;
				}
			elseif ($gameYear == 2024)
				if (isset($value["score_breakdown"]["blue"]["teleopSpeakerNoteAmplifiedCount"])) {
					$blueAlliancePoints = $value["score_breakdown"]["blue"]["teleopSpeakerNoteAmplifiedCount"] * 3;
				}
				else {
					$blueAlliancePoints = 0;
				}
			else
				$blueAlliancePoints = 0;
			$tsql = "merge Match as target " . 
		            "using (select " . $gameEventId . ", '" . $matchNumber . "', '" . $datetime . "', '" . strtoupper($value["comp_level"]) . "', ";
			if ($value["alliances"]["red"]["score"] == '-1') {
				$matchComplete = 0;
				$tsql .= "null, null, null, null, null, null, '" . $value["key"] . "', null, null, null, null, null, null, null, null) ";
			}
			else {
				$matchComplete = 1;
				$tsql .= $value["alliances"]["red"]["score"] . ", " . $value["alliances"]["blue"]["score"] . ", " .
 					     $redAlliancePoints . ", " . $value["score_breakdown"]["red"]["foulPoints"] . ", " .
 					     $blueAlliancePoints . ", " . $value["score_breakdown"]["blue"]["foulPoints"] . ", '" . $value["key"] . "', ";
				if (!empty($tbaRPKey1) && $value["comp_level"] == 'qm')
				{
					if (!empty($value["score_breakdown"]["red"][$tbaRPKey1]))
					{
						$tsql .= $value["score_breakdown"]["red"][$tbaRPKey1] . ", ";
					}
					else
					{
						$tsql .= "0, ";
					}
				}
				else
				{
					$tsql .= "null, ";
				}
				if (!empty($tbaRPKey2) && $value["comp_level"] == 'qm')
				{
					if (!empty($value["score_breakdown"]["red"][$tbaRPKey2]))
					{
						$tsql .= $value["score_breakdown"]["red"][$tbaRPKey2] . ", ";
					}
					else
					{
						$tsql .= "0, ";
					}
				}
				else
				{
					$tsql .= "null, ";
				}
				if (!empty($tbaRPKey3) && $value["comp_level"] == 'qm')
				{
					if (!empty($value["score_breakdown"]["red"][$tbaRPKey3]))
					{
						$tsql .= $value["score_breakdown"]["red"][$tbaRPKey3] . ", ";
					}
					else
					{
						$tsql .= "0, ";
					}
				}
				else
				{
					$tsql .= "null, ";
				}
				if (!empty($tbaRPKey1) && $value["comp_level"] == 'qm')
				{
					if (!empty($value["score_breakdown"]["blue"][$tbaRPKey1]))
					{
						$tsql .= $value["score_breakdown"]["blue"][$tbaRPKey1] . ", ";
					}
					else
					{
						$tsql .= "0, ";
					}
				}
				else
				{
					$tsql .= "null, ";
				}
				if (!empty($tbaRPKey2) && $value["comp_level"] == 'qm')
				{
					if (!empty($value["score_breakdown"]["blue"][$tbaRPKey2]))
					{
						$tsql .= $value["score_breakdown"]["blue"][$tbaRPKey2] . ", ";
					}
					else
					{
						$tsql .= "0, ";
					}
				}
				else
				{
					$tsql .= "null, ";
				}
				if (!empty($tbaRPKey3) && $value["comp_level"] == 'qm')
				{
					if (!empty($value["score_breakdown"]["blue"][$tbaRPKey3]))
					{
						$tsql .= $value["score_breakdown"]["blue"][$tbaRPKey3] . ", ";
					}
					else
					{
						$tsql .= "0, ";
					}
				}
				else
				{
					$tsql .= "null, ";
				}
				if (!empty($tbaCoopMet) && $value["comp_level"] == 'qm')
				{
					if (!empty($value["score_breakdown"]["red"][$tbaCoopMet]))
					{
						$tsql .= $value["score_breakdown"]["red"][$tbaCoopMet] . ", ";
					}
					else
					{
						$tsql .= "0, ";
					}
				}
				else
				{
					$tsql .= "null, ";
				}
				if (!empty($tbaCoopMet)  && $value["comp_level"] == 'qm')
				{
					if (!empty($value["score_breakdown"]["blue"][$tbaCoopMet]))
					{
						$tsql .= $value["score_breakdown"]["blue"][$tbaCoopMet] . ") ";
					}
					else
					{
						$tsql .= "0) ";
					}
				}
				else
				{
					$tsql .= "null) ";
				}
			}
			$tsql .= "as source (gameEventId, number, dateTime, type, redScore, blueScore, redAlliancePoints, redFoulPoints, blueAlliancePoints, blueFoulPoints, matchCode, " .
					            "redRP1, redRP2, redRP3, blueRP1, blueRP2, blueRP3, redCoop, blueCoop) " .
					"on (target.gameEventId = source.gameEventId and target.number = source.number and target.type = source.type) " .
					"WHEN matched AND (target.dateTime <> source.dateTime OR " .
					                  "coalesce(target.redScore, -1) <> source.redScore OR coalesce(target.blueScore, -1) <> source.blueScore OR " .
									  "coalesce(target.redAlliancePoints, -1) <> source.redAlliancePoints OR coalesce(target.redFoulPoints, -1) <> source.redFoulPoints OR " .
									  "coalesce(target.blueAlliancePoints, -1) <> source.blueAlliancePoints OR coalesce(target.blueFoulPoints, -1) <> source.blueFoulPoints OR " .
									  "coalesce(target.matchCode, 'xxx') <> source.matchCode OR " .
									  "coalesce(target.redRP1, -1) <> coalesce(source.redRP1, -1) OR coalesce(target.redRP2, -1) <> coalesce(source.redRP2, -1) OR " .
									  "coalesce(target.redRP3, -1) <> coalesce(source.redRP3, -1) OR coalesce(target.blueRP1, -1) <> coalesce(source.blueRP1, -1) OR " .
									  "coalesce(target.blueRP2, -1) <> coalesce(source.blueRP2, -1) OR coalesce(target.blueRP3, -1) <> coalesce(source.blueRP3, -1) OR " .
									  "coalesce(target.redCoop, -1) <> coalesce(source.redCoop, -1) OR coalesce(target.blueCoop, -1) <> coalesce(source.blueCoop, -1)) THEN " .
					"UPDATE set number = source.number, dateTime = source.dateTime, " .
					          " redScore = source.redScore, blueScore = source.blueScore, " .
					          " redAlliancePoints = source.redAlliancePoints, redFoulPoints = source.redFoulPoints, " .
					          " blueAlliancePoints = source.blueAlliancePoints, blueFoulPoints = source.blueFoulPoints, " .
					          " matchCode = source.matchCode, redRP1 = source.redRP1, redRP2 = source.redRP2, redRP3 = source.redRP3, " .
					          " blueRP1 = source.blueRP1, blueRP2 = source.blueRP2, blueRP3 = source.blueRP3, redCoop = source.redCoop, blueCoop = source.blueCoop " .
					"WHEN not matched THEN " .
					"INSERT (gameEventId, number, dateTime, type, isActive, redScore, blueScore, redAlliancePoints, redFoulPoints, blueAlliancePoints, blueFoulPoints, matchCode, " .
							"redRP1, redRP2, redRP3, blueRP1, blueRP2, blueRP3, redCoop, blueCoop) " .
					"VALUES (source.gameEventId, source.number, source.dateTime, source.type, 'N', source.redScore, source.blueScore, source.redAlliancePoints, source.redFoulPoints, source.blueAlliancePoints, source.blueFoulPoints, source.matchCode, source.redRP1, source.redRP2, source.redRP3, source.blueRP1, source.blueRP2, source.blueRP3, source.redCoop, source.blueCoop);";
			$results = sqlsrv_query($conn, $tsql);
			if(!$results) 
			{
				echo $tsql;
				echo "Update of Match " . $value["comp_level"] . $matchNumber . " failed!<br />";
				if( ($errors = sqlsrv_errors() ) != null) {
					foreach( $errors as $error ) {
						echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
						echo "code: ".$error[ 'code']."<br />";
						echo "message: ".$error[ 'message']."<br />";
					}
				}
				break;
			}

			// Get Match Id
			$tsql = "select m.id
			           from Match m
					  where m.gameEventId = " . $gameEventId .
				    "   and m.type = '" . strtoupper($value["comp_level"]) . "' " .
					"   and m.number = '" . $matchNumber . "';";
			$results = sqlsrv_query($conn, $tsql);
			if(!$results) 
			{
				echo "Search for Match " . $value["comp_level"] . $matchNumber . " failed!<br />";
				if( ($errors = sqlsrv_errors() ) != null) {
					foreach( $errors as $error ) {
						echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
						echo "code: ".$error[ 'code']."<br />";
						echo "message: ".$error[ 'message']."<br />";
					}
				}
				break;
			}
			$row = sqlsrv_fetch_array($results, SQLSRV_FETCH_ASSOC);
			$matchId = $row['id'];
			
			// Add/update Match Videos
			for($i=0; $i<count($value['videos']); $i++) {
				// If not exist, then add Match Video
				$tsql = "insert into MatchVideo (matchId, videoKey, videoType)
						 select " . $matchId . ", '" . $value['videos'][$i]["key"] . "', '" . $value['videos'][$i]["type"] . "'
						  where not exists
						        (select 1
								   from MatchVideo mv
								  where mv.matchId = " . $matchId .
								"   and mv.videoKey = '" . $value['videos'][$i]["key"] . "'
								    and mv.videoType = '" . $value['videos'][$i]["type"] . "');";
				$results = sqlsrv_query($conn, $tsql);
				if(!$results) 
				{
					echo "Insert for Match Video " . $value["comp_level"] . $matchNumber . " failed!<br />";
					if( ($errors = sqlsrv_errors() ) != null) {
						foreach( $errors as $error ) {
							echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
							echo "code: ".$error[ 'code']."<br />";
							echo "message: ".$error[ 'message']."<br />";
						}
					}
					break;
				}
			}
			
			// Delete from Team/Match, if team not part of the match
			$tsql = "delete from TeamMatch " .
			        " where matchId = " . $matchId .
					"   and teamId not in " .
					"      (select t.id " .
					"         from Team t " .
					"        where t.teamNumber in (" . substr($value["alliances"]["red"]["team_keys"][0], 3) . ", " .
					                                    substr($value["alliances"]["red"]["team_keys"][1], 3) . ", " .
					                                    substr($value["alliances"]["red"]["team_keys"][2], 3) . ", " .
					                                    substr($value["alliances"]["blue"]["team_keys"][0], 3) . ", " .
					                                    substr($value["alliances"]["blue"]["team_keys"][1], 3) . ", " .
					                                    substr($value["alliances"]["blue"]["team_keys"][2], 3) . "));";
			$results = sqlsrv_query($conn, $tsql);
			if(!$results) 
			{
				echo "Delete of Team Matches for Match " . $matchNumber . " failed!<br />";
				echo "SQL " . $tsql . "<br>";
				if( ($errors = sqlsrv_errors() ) != null) {
					foreach( $errors as $error ) {
						echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
						echo "code: ".$error[ 'code']."<br />";
						echo "message: ".$error[ 'message']."<br />";
					}
				}
				break;
			}
			
			// Create Match/Team Cross-Reference
			$tsql = "merge TeamMatch as target using ( " . 
					"select " . $matchId . ", t.id, 'R', 1 " .
					"  from Team t " .
				    " where t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][0], 3) . " " .
					"union " .
					"select " . $matchId . ", t.id, 'R', 2 " .
					"  from Team t " .
				    " where t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][1], 3) . " " .
					"union " .
					"select " . $matchId . ", t.id, 'R', 3 " .
					"  from Team t " .
				    " where t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][2], 3) . " " .
					"union " .
					"select " . $matchId . ", t.id, 'B', 1 " .
					"  from Team t " .
				    " where t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][0], 3) . " " .
					"union " .
					"select " . $matchId . ", t.id, 'B', 2 " .
					"  from Team t " .
				    " where t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][1], 3) . " " .
					"union " .
					"select " . $matchId . ", t.id, 'B', 3 " .
					"  from Team t " .
				    " where t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][2], 3) . ") " .
					" as source (matchId, teamId, alliance, alliancePosition) " .
					" on (target.matchId = source.matchId and target.teamId = source.teamId) " .
					" when matched and (target.alliance <> source.alliance or target.alliancePosition <> source.alliancePosition) " .
					" then update set alliance = source.alliance, alliancePosition = source.alliancePosition, lastUpdated = getdate() " .
					" when not matched " .
					" then insert (matchId, teamId, alliance, alliancePosition) " .
					"      values (source.matchId, source.teamId, source.alliance, source.alliancePosition);";
	$results = sqlsrv_query($conn, $tsql);
			if(!$results) 
			{
				echo "Insert of Team Matches for Match " . $matchNumber . ", Team " . substr($value["alliances"].["red"]["team_keys"][0], 3) . " failed!<br />";
				echo "SQL " . $tsql . "<br>";
				if( ($errors = sqlsrv_errors() ) != null) {
					foreach( $errors as $error ) {
						echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
						echo "code: ".$error[ 'code']."<br />";
						echo "message: ".$error[ 'message']."<br />";
					}
				}
				break;
			}

			// Update TeamMatch Scout Data from TBA for 2019 Deep Space
			if ($gameYear == 2019 && $matchComplete == 1) {
				$tsql = "merge TeamMatchObjective as Target
							using (
							select tm.id teamMatchId
								 , o.id objectiveId
								 , ov.integerValue
							  from Team t
								   inner join TeamMatch tm
								   on tm.teamId = t.id,
								   GameEvent ge
								   inner join Game g
								   on g.id = ge.gameId
								   inner join Objective o
								   on o.gameId = g.id
								   inner join ObjectiveValue ov
								   on ov.objectiveId = o.id
							 where tm.matchId = " . $matchId .
							"  and ge.id = " . $gameEventId .
							"  and ((t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][0], 3) . 
							   " and o.name = 'leaveHAB' and ((ov.tbaValue = '" . $value["score_breakdown"]["red"]["habLineRobot1"] . "' and ov.tbaValue3 = '" . $value["score_breakdown"]["red"]["preMatchLevelRobot1"] . "')
								                           or (ov.tbaValue = '" . $value["score_breakdown"]["red"]["habLineRobot1"] . "' and ov.tbaValue4 = '" . $value["score_breakdown"]["red"]["preMatchLevelRobot1"] . "')
								                           or (ov.tbaValue = '" . $value["score_breakdown"]["red"]["habLineRobot1"] . "' and ov.tbaValue5 = '" . $value["score_breakdown"]["red"]["preMatchLevelRobot1"] . "')
								                           or (ov.tbaValue2 = '" . $value["score_breakdown"]["red"]["habLineRobot1"] . "' and ov.tbaValue3 = '" . $value["score_breakdown"]["red"]["preMatchLevelRobot1"] . "')
								                           or (ov.tbaValue2 = '" . $value["score_breakdown"]["red"]["habLineRobot1"] . "' and ov.tbaValue4 = '" . $value["score_breakdown"]["red"]["preMatchLevelRobot1"] . "')
								                           or (ov.tbaValue2 = '" . $value["score_breakdown"]["red"]["habLineRobot1"] . "' and ov.tbaValue5 = '" . $value["score_breakdown"]["red"]["preMatchLevelRobot1"] . "')
								                           or (ov.tbaValue = '" . $value["score_breakdown"]["red"]["habLineRobot1"] . "' and ov.tbaValue2 = '" . $value["score_breakdown"]["red"]["preMatchLevelRobot1"] . "')
								                           or (ov.tbaValue = '" . $value["score_breakdown"]["red"]["habLineRobot1"] . "' and ov.tbaValue2 = '" . $value["score_breakdown"]["red"]["preMatchLevelRobot1"] . "')))
								 or (t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][1], 3) . 
							   " and o.name = 'leaveHAB' and ((ov.tbaValue = '" . $value["score_breakdown"]["red"]["habLineRobot2"] . "' and ov.tbaValue3 = '" . $value["score_breakdown"]["red"]["preMatchLevelRobot2"] . "')
								                           or (ov.tbaValue = '" . $value["score_breakdown"]["red"]["habLineRobot2"] . "' and ov.tbaValue4 = '" . $value["score_breakdown"]["red"]["preMatchLevelRobot2"] . "')
								                           or (ov.tbaValue = '" . $value["score_breakdown"]["red"]["habLineRobot2"] . "' and ov.tbaValue5 = '" . $value["score_breakdown"]["red"]["preMatchLevelRobot2"] . "')
								                           or (ov.tbaValue2 = '" . $value["score_breakdown"]["red"]["habLineRobot2"] . "' and ov.tbaValue3 = '" . $value["score_breakdown"]["red"]["preMatchLevelRobot2"] . "')
								                           or (ov.tbaValue2 = '" . $value["score_breakdown"]["red"]["habLineRobot2"] . "' and ov.tbaValue4 = '" . $value["score_breakdown"]["red"]["preMatchLevelRobot2"] . "')
								                           or (ov.tbaValue2 = '" . $value["score_breakdown"]["red"]["habLineRobot2"] . "' and ov.tbaValue5 = '" . $value["score_breakdown"]["red"]["preMatchLevelRobot2"] . "')
								                           or (ov.tbaValue = '" . $value["score_breakdown"]["red"]["habLineRobot2"] . "' and ov.tbaValue2 = '" . $value["score_breakdown"]["red"]["preMatchLevelRobot2"] . "')
								                           or (ov.tbaValue = '" . $value["score_breakdown"]["red"]["habLineRobot2"] . "' and ov.tbaValue2 = '" . $value["score_breakdown"]["red"]["preMatchLevelRobot2"] . "')))
								 or (t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][2], 3) . 
							   " and o.name = 'leaveHAB' and ((ov.tbaValue = '" . $value["score_breakdown"]["red"]["habLineRobot3"] . "' and ov.tbaValue3 = '" . $value["score_breakdown"]["red"]["preMatchLevelRobot3"] . "')
								                           or (ov.tbaValue = '" . $value["score_breakdown"]["red"]["habLineRobot3"] . "' and ov.tbaValue4 = '" . $value["score_breakdown"]["red"]["preMatchLevelRobot3"] . "')
								                           or (ov.tbaValue = '" . $value["score_breakdown"]["red"]["habLineRobot3"] . "' and ov.tbaValue5 = '" . $value["score_breakdown"]["red"]["preMatchLevelRobot3"] . "')
								                           or (ov.tbaValue2 = '" . $value["score_breakdown"]["red"]["habLineRobot3"] . "' and ov.tbaValue3 = '" . $value["score_breakdown"]["red"]["preMatchLevelRobot3"] . "')
								                           or (ov.tbaValue2 = '" . $value["score_breakdown"]["red"]["habLineRobot3"] . "' and ov.tbaValue4 = '" . $value["score_breakdown"]["red"]["preMatchLevelRobot3"] . "')
								                           or (ov.tbaValue2 = '" . $value["score_breakdown"]["red"]["habLineRobot3"] . "' and ov.tbaValue5 = '" . $value["score_breakdown"]["red"]["preMatchLevelRobot3"] . "')
								                           or (ov.tbaValue = '" . $value["score_breakdown"]["red"]["habLineRobot3"] . "' and ov.tbaValue2 = '" . $value["score_breakdown"]["red"]["preMatchLevelRobot3"] . "')
								                           or (ov.tbaValue = '" . $value["score_breakdown"]["red"]["habLineRobot3"] . "' and ov.tbaValue2 = '" . $value["score_breakdown"]["red"]["preMatchLevelRobot3"] . "')))
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][0], 3) . 
							   " and o.name = 'leaveHAB' and ((ov.tbaValue = '" . $value["score_breakdown"]["blue"]["habLineRobot1"] . "' and ov.tbaValue3 = '" . $value["score_breakdown"]["blue"]["preMatchLevelRobot1"] . "')
								                           or (ov.tbaValue = '" . $value["score_breakdown"]["blue"]["habLineRobot1"] . "' and ov.tbaValue4 = '" . $value["score_breakdown"]["blue"]["preMatchLevelRobot1"] . "')
								                           or (ov.tbaValue = '" . $value["score_breakdown"]["blue"]["habLineRobot1"] . "' and ov.tbaValue5 = '" . $value["score_breakdown"]["blue"]["preMatchLevelRobot1"] . "')
								                           or (ov.tbaValue2 = '" . $value["score_breakdown"]["blue"]["habLineRobot1"] . "' and ov.tbaValue3 = '" . $value["score_breakdown"]["blue"]["preMatchLevelRobot1"] . "')
								                           or (ov.tbaValue2 = '" . $value["score_breakdown"]["blue"]["habLineRobot1"] . "' and ov.tbaValue4 = '" . $value["score_breakdown"]["blue"]["preMatchLevelRobot1"] . "')
								                           or (ov.tbaValue2 = '" . $value["score_breakdown"]["blue"]["habLineRobot1"] . "' and ov.tbaValue5 = '" . $value["score_breakdown"]["blue"]["preMatchLevelRobot1"] . "')
								                           or (ov.tbaValue = '" . $value["score_breakdown"]["blue"]["habLineRobot1"] . "' and ov.tbaValue2 = '" . $value["score_breakdown"]["blue"]["preMatchLevelRobot1"] . "')
								                           or (ov.tbaValue = '" . $value["score_breakdown"]["blue"]["habLineRobot1"] . "' and ov.tbaValue2 = '" . $value["score_breakdown"]["blue"]["preMatchLevelRobot1"] . "')))
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][1], 3) . 
							   " and o.name = 'leaveHAB' and ((ov.tbaValue = '" . $value["score_breakdown"]["blue"]["habLineRobot2"] . "' and ov.tbaValue3 = '" . $value["score_breakdown"]["blue"]["preMatchLevelRobot2"] . "')
								                           or (ov.tbaValue = '" . $value["score_breakdown"]["blue"]["habLineRobot2"] . "' and ov.tbaValue4 = '" . $value["score_breakdown"]["blue"]["preMatchLevelRobot2"] . "')
								                           or (ov.tbaValue = '" . $value["score_breakdown"]["blue"]["habLineRobot2"] . "' and ov.tbaValue5 = '" . $value["score_breakdown"]["blue"]["preMatchLevelRobot2"] . "')
								                           or (ov.tbaValue2 = '" . $value["score_breakdown"]["blue"]["habLineRobot2"] . "' and ov.tbaValue3 = '" . $value["score_breakdown"]["blue"]["preMatchLevelRobot2"] . "')
								                           or (ov.tbaValue2 = '" . $value["score_breakdown"]["blue"]["habLineRobot2"] . "' and ov.tbaValue4 = '" . $value["score_breakdown"]["blue"]["preMatchLevelRobot2"] . "')
								                           or (ov.tbaValue2 = '" . $value["score_breakdown"]["blue"]["habLineRobot2"] . "' and ov.tbaValue5 = '" . $value["score_breakdown"]["blue"]["preMatchLevelRobot2"] . "')
								                           or (ov.tbaValue = '" . $value["score_breakdown"]["blue"]["habLineRobot2"] . "' and ov.tbaValue2 = '" . $value["score_breakdown"]["blue"]["preMatchLevelRobot2"] . "')
								                           or (ov.tbaValue = '" . $value["score_breakdown"]["blue"]["habLineRobot2"] . "' and ov.tbaValue2 = '" . $value["score_breakdown"]["blue"]["preMatchLevelRobot2"] . "')))
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][2], 3) . 
							   " and o.name = 'leaveHAB' and ((ov.tbaValue = '" . $value["score_breakdown"]["blue"]["habLineRobot3"] . "' and ov.tbaValue3 = '" . $value["score_breakdown"]["blue"]["preMatchLevelRobot3"] . "')
								                           or (ov.tbaValue = '" . $value["score_breakdown"]["blue"]["habLineRobot3"] . "' and ov.tbaValue4 = '" . $value["score_breakdown"]["blue"]["preMatchLevelRobot3"] . "')
								                           or (ov.tbaValue = '" . $value["score_breakdown"]["blue"]["habLineRobot3"] . "' and ov.tbaValue5 = '" . $value["score_breakdown"]["blue"]["preMatchLevelRobot3"] . "')
								                           or (ov.tbaValue2 = '" . $value["score_breakdown"]["blue"]["habLineRobot3"] . "' and ov.tbaValue3 = '" . $value["score_breakdown"]["blue"]["preMatchLevelRobot3"] . "')
								                           or (ov.tbaValue2 = '" . $value["score_breakdown"]["blue"]["habLineRobot3"] . "' and ov.tbaValue4 = '" . $value["score_breakdown"]["blue"]["preMatchLevelRobot3"] . "')
								                           or (ov.tbaValue2 = '" . $value["score_breakdown"]["blue"]["habLineRobot3"] . "' and ov.tbaValue5 = '" . $value["score_breakdown"]["blue"]["preMatchLevelRobot3"] . "')
								                           or (ov.tbaValue = '" . $value["score_breakdown"]["blue"]["habLineRobot3"] . "' and ov.tbaValue2 = '" . $value["score_breakdown"]["blue"]["preMatchLevelRobot3"] . "')
								                           or (ov.tbaValue = '" . $value["score_breakdown"]["blue"]["habLineRobot3"] . "' and ov.tbaValue2 = '" . $value["score_breakdown"]["blue"]["preMatchLevelRobot3"] . "')))
								 or (t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][0], 3) .
							   " and o.name = 'returnToHAB' and ((ov.tbaValue = '" . $value["score_breakdown"]["red"]["endgameRobot1"] . "' and coalesce(ov.tbaValue2, 'XXX') <> '" . $value["score_breakdown"]["red"]["habLineRobot1"] . "')
							                                  or (ov.tbaValue3 = '" . $value["score_breakdown"]["red"]["habLineRobot1"] . "')))
								 or (t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][1], 3) .
							   " and o.name = 'returnToHAB' and ((ov.tbaValue = '" . $value["score_breakdown"]["red"]["endgameRobot2"] . "' and coalesce(ov.tbaValue2, 'XXX') <> '" . $value["score_breakdown"]["red"]["habLineRobot2"] . "')
							                                  or (ov.tbaValue3 = '" . $value["score_breakdown"]["red"]["habLineRobot2"] . "')))
								 or (t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][2], 3) .
							   " and o.name = 'returnToHAB' and ((ov.tbaValue = '" . $value["score_breakdown"]["red"]["endgameRobot3"] . "' and coalesce(ov.tbaValue2, 'XXX') <> '" . $value["score_breakdown"]["red"]["habLineRobot3"] . "')
							                                  or (ov.tbaValue3 = '" . $value["score_breakdown"]["red"]["habLineRobot3"] . "')))
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][0], 3) .
							   " and o.name = 'returnToHAB' and ((ov.tbaValue = '" . $value["score_breakdown"]["blue"]["endgameRobot1"] . "' and coalesce(ov.tbaValue2, 'XXX') <> '" . $value["score_breakdown"]["blue"]["habLineRobot1"] . "')
							                                  or (ov.tbaValue3 = '" . $value["score_breakdown"]["blue"]["habLineRobot1"] . "')))
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][1], 3) .
							   " and o.name = 'returnToHAB' and ((ov.tbaValue = '" . $value["score_breakdown"]["blue"]["endgameRobot2"] . "' and coalesce(ov.tbaValue2, 'XXX') <> '" . $value["score_breakdown"]["blue"]["habLineRobot2"] . "')
							                                  or (ov.tbaValue3 = '" . $value["score_breakdown"]["blue"]["habLineRobot2"] . "')))
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][2], 3) .
							   " and o.name = 'returnToHAB' and ((ov.tbaValue = '" . $value["score_breakdown"]["blue"]["endgameRobot3"] . "' and coalesce(ov.tbaValue2, 'XXX') <> '" . $value["score_breakdown"]["blue"]["habLineRobot3"] . "')
							                                  or (ov.tbaValue3 = '" . $value["score_breakdown"]["blue"]["habLineRobot3"] . "')))))
							     as source (teamMatchId, objectiveId, integerValue)
							on (target.teamMatchId = source.teamMatchId and target.objectiveId = source.objectiveId)
							when matched and target.integerValue <> source.integerValue
							then update set integerValue = source.integerValue
							when not matched
							then insert (teamMatchId, objectiveId, integerValue)
								 values (source.teamMatchId, source.objectiveId, source.integerValue);";
				$results = sqlsrv_query($conn, $tsql);
				if(!$results) 
				{
					echo "Merge of Team Match Scout Records for Match " . $matchNumber . ", Team " . substr($value["alliances"].["red"]["team_keys"][0], 3) . " failed!<br />";
					echo "SQL " . $tsql . "<br>";
					if( ($errors = sqlsrv_errors() ) != null) {
						foreach( $errors as $error ) {
							echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
							echo "code: ".$error[ 'code']."<br />";
							echo "message: ".$error[ 'message']."<br />";
						}
					}
					break;
				}
				// Update Match objective data not tied to a Team for 2019
				$tsql = "merge MatchObjective as Target
							using (
							select m.id matchId
							     , tba.alliance
								 , o.id objectiveId
								 , tba.integerValue
							  from Match m
							       inner join GameEvent ge
								   on ge.id = m.gameEventId
								   inner join Game g
								   on g.id = ge.gameId
								   inner join Objective o
								   on o.gameId = g.id
								   inner join 
								   (select 'R' alliance, " . $value["score_breakdown"]["red"]["hatchPanelPoints"] . " / 2 integerValue, 'toHatchCnt' objectiveName
								    union
									select 'R' alliance, " . $value["score_breakdown"]["red"]["cargoPoints"] . " / 3 integerValue, 'toCargoCnt' objectiveName
								    union
									select 'B' alliance, " . $value["score_breakdown"]["blue"]["hatchPanelPoints"] . " / 2 integerValue, 'toHatchCnt' objectiveName
								    union
									select 'B' alliance, " . $value["score_breakdown"]["blue"]["cargoPoints"] . " / 3 integerValue, 'toCargoCnt' objectiveName
								    ) tba";
				$tsql .= " on tba.objectiveName = o.name
							 where m.id = " . $matchId .
							"  and ge.id = " . $gameEventId . ")" .
							"     as source (matchId, alliance, objectiveId, integerValue)
							on (target.matchId = source.matchId and target.alliance = source.alliance and target.objectiveId = source.objectiveId)
							when matched and target.integerValue <> source.integerValue
							then update set integerValue = source.integerValue
							when not matched
							then insert (matchId, alliance, objectiveId, integerValue)
								 values (source.matchId, source.alliance, source.objectiveId, source.integerValue);";
				$results = sqlsrv_query($conn, $tsql);
				if(!$results) 
				{
					echo "Merge of Match Alliance Objective Records " . $matchNumber . ", Team " . substr($value["alliances"].["red"]["team_keys"][0], 3) . " failed!<br />";
					echo "SQL " . $tsql . "<br>";
					if( ($errors = sqlsrv_errors() ) != null) {
						foreach( $errors as $error ) {
							echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
							echo "code: ".$error[ 'code']."<br />";
							echo "message: ".$error[ 'message']."<br />";
						}
					}
					break;
				}
			}

			// Update TeamMatch Scout Data from TBA for 2020 - Infinite Recharge
			if ($gameYear == 2020 && $matchComplete == 1) {
				$tsql = "merge TeamMatchObjective as Target
							using (
							select tm.id teamMatchId
								 , o.id objectiveId
								 , ov.integerValue
							  from Team t
								   inner join TeamMatch tm
								   on tm.teamId = t.id,
								   GameEvent ge
								   inner join Game g
								   on g.id = ge.gameId
								   inner join Objective o
								   on o.gameId = g.id
								   inner join ObjectiveValue ov
								   on ov.objectiveId = o.id
							 where tm.matchId = " . $matchId .
							"  and ge.id = " . $gameEventId .
							"  and ((t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][0], 3) . 
							   " and o.name = 'aMove' and ov.tbaValue = '" . $value["score_breakdown"]["red"]["initLineRobot1"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][1], 3) .
							   " and o.name = 'aMove' and ov.tbaValue = '" . $value["score_breakdown"]["red"]["initLineRobot2"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][2], 3) .
							   " and o.name = 'aMove' and ov.tbaValue = '" . $value["score_breakdown"]["red"]["initLineRobot3"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][0], 3) .
							   " and o.name = 'aMove' and ov.tbaValue = '" . $value["score_breakdown"]["blue"]["initLineRobot1"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][1], 3) .
							   " and o.name = 'aMove' and ov.tbaValue = '" . $value["score_breakdown"]["blue"]["initLineRobot2"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][2], 3) .
							   " and o.name = 'aMove' and ov.tbaValue = '" . $value["score_breakdown"]["blue"]["initLineRobot3"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][0], 3) .
							   " and o.name = 'toEndGame' and ov.tbaValue = '" . $value["score_breakdown"]["red"]["endgameRobot1"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][1], 3) .
							   " and o.name = 'toEndGame' and ov.tbaValue = '" . $value["score_breakdown"]["red"]["endgameRobot2"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][2], 3) .
							   " and o.name = 'toEndGame' and ov.tbaValue = '" . $value["score_breakdown"]["red"]["endgameRobot3"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][0], 3) .
							   " and o.name = 'toEndGame' and ov.tbaValue = '" . $value["score_breakdown"]["blue"]["endgameRobot1"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][1], 3) .
							   " and o.name = 'toEndGame' and ov.tbaValue = '" . $value["score_breakdown"]["blue"]["endgameRobot2"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][2], 3) .
							   " and o.name = 'toEndGame' and ov.tbaValue = '" . $value["score_breakdown"]["blue"]["endgameRobot3"] . "')))
							     as source (teamMatchId, objectiveId, integerValue)
							on (target.teamMatchId = source.teamMatchId and target.objectiveId = source.objectiveId)
							when matched and target.integerValue <> source.integerValue
							then update set integerValue = source.integerValue
							when not matched
							then insert (teamMatchId, objectiveId, integerValue)
								 values (source.teamMatchId, source.objectiveId, source.integerValue);";
				$results = sqlsrv_query($conn, $tsql);
				if(!$results) 
				{
					echo "Merge of Team Match Scout Records for Match " . $matchNumber . ", Team " . substr($value["alliances"].["red"]["team_keys"][0], 3) . " failed!<br />";
					echo "SQL " . $tsql . "<br>";
					if( ($errors = sqlsrv_errors() ) != null) {
						foreach( $errors as $error ) {
							echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
							echo "code: ".$error[ 'code']."<br />";
							echo "message: ".$error[ 'message']."<br />";
						}
					}
					break;
				}
				// Update Match objective data not tied to a Team for 2020
				$tsql = "merge MatchObjective as Target
							using (
							select m.id matchId
							     , tba.alliance
								 , o.id objectiveId
								 , tba.integerValue
							  from Match m
							       inner join GameEvent ge
								   on ge.id = m.gameEventId
								   inner join Game g
								   on g.id = ge.gameId
								   inner join Objective o
								   on o.gameId = g.id
								   inner join 
								   (select 'R' alliance, " . $value["score_breakdown"]["red"]["autoCellsBottom"] . " integerValue, 'aPcLower' objectiveName
								    union
									select 'R' alliance, " . $value["score_breakdown"]["red"]["autoCellsOuter"] . " integerValue, 'aPcOuter' objectiveName
								    union
									select 'R' alliance, " . $value["score_breakdown"]["red"]["autoCellsInner"] . " integerValue, 'aPcInner' objectiveName
								    union
									select 'B' alliance, " . $value["score_breakdown"]["blue"]["autoCellsBottom"] . " integerValue, 'aPcLower' objectiveName
								    union
									select 'B' alliance, " . $value["score_breakdown"]["blue"]["autoCellsOuter"] . " integerValue, 'aPcOuter' objectiveName
								    union
									select 'B' alliance, " . $value["score_breakdown"]["blue"]["autoCellsInner"] . " integerValue, 'aPcInner' objectiveName
								    union
									select 'R' alliance, " . $value["score_breakdown"]["red"]["teleopCellsBottom"] . " integerValue, 'toPcLower' objectiveName
								    union
									select 'R' alliance, " . $value["score_breakdown"]["red"]["teleopCellsOuter"] . " integerValue, 'toPcOuter' objectiveName
								    union
									select 'R' alliance, " . $value["score_breakdown"]["red"]["teleopCellsInner"] . " integerValue, 'toPcInner' objectiveName
								    union
									select 'B' alliance, " . $value["score_breakdown"]["blue"]["teleopCellsBottom"] . " integerValue, 'toPcLower' objectiveName
								    union
									select 'B' alliance, " . $value["score_breakdown"]["blue"]["teleopCellsOuter"] . " integerValue, 'toPcOuter' objectiveName
								    union
									select 'B' alliance, " . $value["score_breakdown"]["blue"]["teleopCellsInner"] . " integerValue, 'toPcInner' objectiveName
								    union ";
							if (!$value["score_breakdown"]["red"]["stage2Activated"])
								$tsql .= "select 'R' alliance, 0 integerValue, 'toCpRotation' objectiveName union ";
							else
								$tsql .= "select 'R' alliance, 1 integerValue, 'toCpRotation' objectiveName union ";
							if (!$value["score_breakdown"]["blue"]["stage2Activated"])
								$tsql .= "select 'B' alliance, 0 integerValue, 'toCpRotation' objectiveName union ";
							else
								$tsql .= "select 'B' alliance, 1 integerValue, 'toCpRotation' objectiveName union ";
							if (!$value["score_breakdown"]["red"]["stage3Activated"])
								$tsql .= "select 'R' alliance, 0 integerValue, 'toCpPosition' objectiveName union ";
							else
								$tsql .= "select 'R' alliance, 1 integerValue, 'toCpPosition' objectiveName union ";
							if (!$value["score_breakdown"]["blue"]["stage3Activated"])
								$tsql .= "select 'B' alliance, 0 integerValue, 'toCpPosition' objectiveName) tba";
							else
								$tsql .= "select 'B' alliance, 1 integerValue, 'toCpPosition' objectiveName) tba";
				$tsql .= " on tba.objectiveName = o.name
							 where m.id = " . $matchId .
							"  and ge.id = " . $gameEventId . ")" .
							"     as source (matchId, alliance, objectiveId, integerValue)
							on (target.matchId = source.matchId and target.alliance = source.alliance and target.objectiveId = source.objectiveId)
							when matched and target.integerValue <> source.integerValue
							then update set integerValue = source.integerValue
							when not matched
							then insert (matchId, alliance, objectiveId, integerValue)
								 values (source.matchId, source.alliance, source.objectiveId, source.integerValue);";
				$results = sqlsrv_query($conn, $tsql);
				if(!$results) 
				{
					echo "Merge of Match Alliance Objective Records " . $matchNumber . ", Team " . substr($value["alliances"].["red"]["team_keys"][0], 3) . " failed!<br />";
					echo "SQL " . $tsql . "<br>";
					if( ($errors = sqlsrv_errors() ) != null) {
						foreach( $errors as $error ) {
							echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
							echo "code: ".$error[ 'code']."<br />";
							echo "message: ".$error[ 'message']."<br />";
						}
					}
					break;
				}
			}

			// Update TeamMatch Scout Data from TBA for 2022 - Rapid React
			if ($gameYear == 2022 && $matchComplete == 1) {
				$tsql = "merge TeamMatchObjective as Target
							using (
							select tm.id teamMatchId
								 , o.id objectiveId
								 , ov.integerValue
							  from Team t
								   inner join TeamMatch tm
								   on tm.teamId = t.id,
								   GameEvent ge
								   inner join Game g
								   on g.id = ge.gameId
								   inner join Objective o
								   on o.gameId = g.id
								   inner join ObjectiveValue ov
								   on ov.objectiveId = o.id
							 where tm.matchId = " . $matchId .
							"  and ge.id = " . $gameEventId .
							"  and ((t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][0], 3) . 
							   " and o.name = 'aTaxi' and ov.tbaValue = '" . $value["score_breakdown"]["red"]["taxiRobot1"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][1], 3) .
							   " and o.name = 'aTaxi' and ov.tbaValue = '" . $value["score_breakdown"]["red"]["taxiRobot2"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][2], 3) .
							   " and o.name = 'aTaxi' and ov.tbaValue = '" . $value["score_breakdown"]["red"]["taxiRobot3"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][0], 3) .
							   " and o.name = 'aTaxi' and ov.tbaValue = '" . $value["score_breakdown"]["blue"]["taxiRobot1"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][1], 3) .
							   " and o.name = 'aTaxi' and ov.tbaValue = '" . $value["score_breakdown"]["blue"]["taxiRobot2"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][2], 3) .
							   " and o.name = 'aTaxi' and ov.tbaValue = '" . $value["score_breakdown"]["blue"]["taxiRobot3"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][0], 3) .
							   " and o.name = 'toHang' and ov.tbaValue = '" . $value["score_breakdown"]["red"]["endgameRobot1"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][1], 3) .
							   " and o.name = 'toHang' and ov.tbaValue = '" . $value["score_breakdown"]["red"]["endgameRobot2"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][2], 3) .
							   " and o.name = 'toHang' and ov.tbaValue = '" . $value["score_breakdown"]["red"]["endgameRobot3"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][0], 3) .
							   " and o.name = 'toHang' and ov.tbaValue = '" . $value["score_breakdown"]["blue"]["endgameRobot1"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][1], 3) .
							   " and o.name = 'toHang' and ov.tbaValue = '" . $value["score_breakdown"]["blue"]["endgameRobot2"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][2], 3) .
							   " and o.name = 'toHang' and ov.tbaValue = '" . $value["score_breakdown"]["blue"]["endgameRobot3"] . "')))
							     as source (teamMatchId, objectiveId, integerValue)
							on (target.teamMatchId = source.teamMatchId and target.objectiveId = source.objectiveId)
							when matched and target.integerValue <> source.integerValue
							then update set integerValue = source.integerValue
							when not matched
							then insert (teamMatchId, objectiveId, integerValue)
								 values (source.teamMatchId, source.objectiveId, source.integerValue);";
				$results = sqlsrv_query($conn, $tsql);
				if(!$results) 
				{
					echo "Merge of Team Match Scout Records for Match " . $matchNumber . ", Team " . substr($value["alliances"].["red"]["team_keys"][0], 3) . " failed!<br />";
					echo "SQL " . $tsql . "<br>";
					if( ($errors = sqlsrv_errors() ) != null) {
						foreach( $errors as $error ) {
							echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
							echo "code: ".$error[ 'code']."<br />";
							echo "message: ".$error[ 'message']."<br />";
						}
					}
					break;
				}
				// Update Match objective data not tied to a Team for 2022
				$tsql = "merge MatchObjective as Target
							using (
							select m.id matchId
							     , tba.alliance
								 , o.id objectiveId
								 , tba.integerValue
							  from Match m
							       inner join GameEvent ge
								   on ge.id = m.gameEventId
								   inner join Game g
								   on g.id = ge.gameId
								   inner join Objective o
								   on o.gameId = g.id
								   inner join 
								   (select 'R' alliance, " . $value["score_breakdown"]["red"]["autoCargoLowerBlue"] . " + " . $value["score_breakdown"]["red"]["autoCargoLowerFar"] . " + " . $value["score_breakdown"]["red"]["autoCargoLowerNear"] . " + " . $value["score_breakdown"]["red"]["autoCargoLowerRed"] . " integerValue, 'aCLower' objectiveName
								    union
									select 'R' alliance, " . $value["score_breakdown"]["red"]["autoCargoUpperBlue"] . " + " . $value["score_breakdown"]["red"]["autoCargoUpperFar"] . " + " . $value["score_breakdown"]["red"]["autoCargoUpperNear"] . " + " . $value["score_breakdown"]["red"]["autoCargoUpperRed"] . " integerValue, 'aCUpper' objectiveName
								    union
									select 'B' alliance, " . $value["score_breakdown"]["blue"]["autoCargoLowerBlue"] . " + " . $value["score_breakdown"]["blue"]["autoCargoLowerFar"] . " + " . $value["score_breakdown"]["blue"]["autoCargoLowerNear"] . " + " . $value["score_breakdown"]["blue"]["autoCargoLowerRed"] . " integerValue, 'aCLower' objectiveName
								    union
									select 'B' alliance, " . $value["score_breakdown"]["blue"]["autoCargoUpperBlue"] . " + " . $value["score_breakdown"]["blue"]["autoCargoUpperFar"] . " + " . $value["score_breakdown"]["blue"]["autoCargoUpperNear"] . " + " . $value["score_breakdown"]["blue"]["autoCargoUpperRed"] . " integerValue, 'aCUpper' objectiveName
								    union
									select 'R' alliance, " . $value["score_breakdown"]["red"]["teleopCargoLowerBlue"] . " + " . $value["score_breakdown"]["red"]["teleopCargoLowerFar"] . " + " . $value["score_breakdown"]["red"]["teleopCargoLowerNear"] . " + " . $value["score_breakdown"]["red"]["teleopCargoLowerRed"] . " integerValue, 'toCLower' objectiveName
								    union
									select 'R' alliance, " . $value["score_breakdown"]["red"]["teleopCargoUpperBlue"] . " + " . $value["score_breakdown"]["red"]["teleopCargoUpperFar"] . " + " . $value["score_breakdown"]["red"]["teleopCargoUpperNear"] . " + " . $value["score_breakdown"]["red"]["teleopCargoUpperRed"] . " integerValue, 'toCUpper' objectiveName
								    union
									select 'B' alliance, " . $value["score_breakdown"]["blue"]["teleopCargoLowerBlue"] . " + " . $value["score_breakdown"]["blue"]["teleopCargoLowerFar"] . " + " . $value["score_breakdown"]["blue"]["teleopCargoLowerNear"] . " + " . $value["score_breakdown"]["blue"]["teleopCargoLowerRed"] . " integerValue, 'toCLower' objectiveName
								    union
									select 'B' alliance, " . $value["score_breakdown"]["blue"]["teleopCargoUpperBlue"] . " + " . $value["score_breakdown"]["blue"]["teleopCargoUpperFar"] . " + " . $value["score_breakdown"]["blue"]["teleopCargoUpperNear"] . " + " . $value["score_breakdown"]["blue"]["teleopCargoUpperRed"] . " integerValue, 'toCUpper' objectiveName
								    ) tba ";
				$tsql .= " on tba.objectiveName = o.name
							 where m.id = " . $matchId .
							"  and ge.id = " . $gameEventId . ")" .
							"     as source (matchId, alliance, objectiveId, integerValue)
							on (target.matchId = source.matchId and target.alliance = source.alliance and target.objectiveId = source.objectiveId)
							when matched and target.integerValue <> source.integerValue
							then update set integerValue = source.integerValue
							when not matched
							then insert (matchId, alliance, objectiveId, integerValue)
								 values (source.matchId, source.alliance, source.objectiveId, source.integerValue);";
				$results = sqlsrv_query($conn, $tsql);
				if(!$results) 
				{
					echo "Merge of Match Alliance Objective Records " . $matchNumber . ", Team " . substr($value["alliances"].["red"]["team_keys"][0], 3) . " failed!<br />";
					echo "SQL " . $tsql . "<br>";
					if( ($errors = sqlsrv_errors() ) != null) {
						foreach( $errors as $error ) {
							echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
							echo "code: ".$error[ 'code']."<br />";
							echo "message: ".$error[ 'message']."<br />";
						}
					}
					break;
				}
				// Log problem with TBA data -- Red Auto Cargo
				if($value["score_breakdown"]["red"]["autoCargoTotal"] == 0 &&
				   $value["score_breakdown"]["red"]["autoCargoPoints"] > 0)
				{
					echo "TBA data inconsistent for Red Auto Cargo Count and Total - Match " . $matchNumber . ", skipping import<br />";
					$tsql = "delete from MatchObjective 
					          where matchId = " . $matchId .
						    "   and alliance = 'R'
							    and objectiveId in (select o.id from objective o where o.name in ('aCLower', 'aCUpper'));";
					$results = sqlsrv_query($conn, $tsql);
					if(!$results) 
					{
						echo "Delete of Red Auto Cargo Objective Records " . $matchNumber . ", Team " . substr($value["alliances"].["red"]["team_keys"][0], 3) . " failed!<br />";
						echo "SQL " . $tsql . "<br>";
						if( ($errors = sqlsrv_errors() ) != null) {
							foreach( $errors as $error ) {
								echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
								echo "code: ".$error[ 'code']."<br />";
								echo "message: ".$error[ 'message']."<br />";
							}
						}
						break;
					}
				}
				// Log problem with TBA data -- Red Teleop Cargo
				if($value["score_breakdown"]["red"]["teleopCargoTotal"] == 0 &&
				   $value["score_breakdown"]["red"]["teleopCargoPoints"] > 0)
				{
					echo "TBA data inconsistent for Red Teleop Cargo Count and Total - Match " . $matchNumber . ", skipping import<br />";
					$tsql = "delete from MatchObjective 
					          where matchId = " . $matchId .
						    "   and alliance = 'R'
							    and objectiveId in (select o.id from objective o where o.name in ('toCLower', 'toCUpper'));";
					$results = sqlsrv_query($conn, $tsql);
					if(!$results) 
					{
						echo "Delete of Red TeleOp Cargo Objective Records " . $matchNumber . ", Team " . substr($value["alliances"].["red"]["team_keys"][0], 3) . " failed!<br />";
						echo "SQL " . $tsql . "<br>";
						if( ($errors = sqlsrv_errors() ) != null) {
							foreach( $errors as $error ) {
								echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
								echo "code: ".$error[ 'code']."<br />";
								echo "message: ".$error[ 'message']."<br />";
							}
						}
						break;
					}
				}
				// Log problem with TBA data -- Blue Auto Cargo
				if($value["score_breakdown"]["blue"]["autoCargoTotal"] == 0 &&
				   $value["score_breakdown"]["blue"]["autoCargoPoints"] > 0)
				{
					echo "TBA data inconsistent for Blue Auto Cargo Count and Total - Match " . $matchNumber . ", skipping import<br />";
					$tsql = "delete from MatchObjective 
					          where matchId = " . $matchId .
						    "   and alliance = 'B'
							    and objectiveId in (select o.id from objective o where o.name in ('aCLower', 'aCUpper'));";
					$results = sqlsrv_query($conn, $tsql);
					if(!$results) 
					{
						echo "Delete of Blue Auto Cargo Objective Records " . $matchNumber . ", Team " . substr($value["alliances"].["blue"]["team_keys"][0], 3) . " failed!<br />";
						echo "SQL " . $tsql . "<br>";
						if( ($errors = sqlsrv_errors() ) != null) {
							foreach( $errors as $error ) {
								echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
								echo "code: ".$error[ 'code']."<br />";
								echo "message: ".$error[ 'message']."<br />";
							}
						}
						break;
					}
				}
				// Log problem with TBA data -- Blue Teleop Cargo
				if($value["score_breakdown"]["blue"]["teleopCargoTotal"] == 0 &&
				   $value["score_breakdown"]["blue"]["teleopCargoPoints"] > 0)
				{
					echo "TBA data inconsistent for Blue Teleop Cargo Count and Total - Match " . $matchNumber . ", skipping import<br />";
					$tsql = "delete from MatchObjective 
					          where matchId = " . $matchId .
						    "   and alliance = 'B'
							    and objectiveId in (select o.id from objective o where o.name in ('toCLower', 'toCUpper'));";
					$results = sqlsrv_query($conn, $tsql);
					if(!$results) 
					{
						echo "Delete of Blue TeleOp Cargo Objective Records " . $matchNumber . ", Team " . substr($value["alliances"].["blue"]["team_keys"][0], 3) . " failed!<br />";
						echo "SQL " . $tsql . "<br>";
						if( ($errors = sqlsrv_errors() ) != null) {
							foreach( $errors as $error ) {
								echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
								echo "code: ".$error[ 'code']."<br />";
								echo "message: ".$error[ 'message']."<br />";
							}
						}
						break;
					}
				}
			}
			// Update TeamMatch Scout Data from TBA for 2023 - Charged Up
			if ($gameYear == 2023 && $matchComplete == 1) {
				$tsql = "merge TeamMatchObjective as Target
							using (
							select tm.id teamMatchId
								 , o.id objectiveId
								 , ov.integerValue
							  from Team t
								   inner join TeamMatch tm
								   on tm.teamId = t.id,
								   GameEvent ge
								   inner join Game g
								   on g.id = ge.gameId
								   inner join Objective o
								   on o.gameId = g.id
								   inner join ObjectiveValue ov
								   on ov.objectiveId = o.id
							 where tm.matchId = " . $matchId .
							"  and ge.id = " . $gameEventId .
							"  and ((t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][0], 3) . 
							   " and o.name = 'aMove' and ov.tbaValue = '" . $value["score_breakdown"]["red"]["mobilityRobot1"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][1], 3) .
							   " and o.name = 'aMove' and ov.tbaValue = '" . $value["score_breakdown"]["red"]["mobilityRobot2"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][2], 3) .
							   " and o.name = 'aMove' and ov.tbaValue = '" . $value["score_breakdown"]["red"]["mobilityRobot3"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][0], 3) .
							   " and o.name = 'aMove' and ov.tbaValue = '" . $value["score_breakdown"]["blue"]["mobilityRobot1"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][1], 3) .
							   " and o.name = 'aMove' and ov.tbaValue = '" . $value["score_breakdown"]["blue"]["mobilityRobot2"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][2], 3) .
							   " and o.name = 'aMove' and ov.tbaValue = '" . $value["score_breakdown"]["blue"]["mobilityRobot3"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][0], 3) .
							   " and o.name = 'aCS' and ov.tbaValue = case when '" . $value["score_breakdown"]["red"]["autoChargeStationRobot1"] . "' = 'Docked' then case when '" . $value["score_breakdown"]["red"]["autoBridgeState"] . "' = 'Level' then 'Engaged' else 'Docked' end else 'None' end)
								 or (t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][1], 3) .
							   " and o.name = 'aCS' and ov.tbaValue = case when '" . $value["score_breakdown"]["red"]["autoChargeStationRobot2"] . "' = 'Docked' then case when '" . $value["score_breakdown"]["red"]["autoBridgeState"] . "' = 'Level' then 'Engaged' else 'Docked' end else 'None' end)
								 or (t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][2], 3) .
							   " and o.name = 'aCS' and ov.tbaValue = case when '" . $value["score_breakdown"]["red"]["autoChargeStationRobot3"] . "' = 'Docked' then case when '" . $value["score_breakdown"]["red"]["autoBridgeState"] . "' = 'Level' then 'Engaged' else 'Docked' end else 'None' end)
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][0], 3) .
							   " and o.name = 'aCS' and ov.tbaValue = case when '" . $value["score_breakdown"]["blue"]["autoChargeStationRobot1"] . "' = 'Docked' then case when '" . $value["score_breakdown"]["blue"]["autoBridgeState"] . "' = 'Level' then 'Engaged' else 'Docked' end else 'None' end)
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][1], 3) .
							   " and o.name = 'aCS' and ov.tbaValue = case when '" . $value["score_breakdown"]["blue"]["autoChargeStationRobot2"] . "' = 'Docked' then case when '" . $value["score_breakdown"]["blue"]["autoBridgeState"] . "' = 'Level' then 'Engaged' else 'Docked' end else 'None' end)
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][2], 3) .
							   " and o.name = 'aCS' and ov.tbaValue = case when '" . $value["score_breakdown"]["blue"]["autoChargeStationRobot3"] . "' = 'Docked' then case when '" . $value["score_breakdown"]["blue"]["autoBridgeState"] . "' = 'Level' then 'Engaged' else 'Docked' end else 'None' end)
							     or (t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][0], 3) .
							   " and o.name = 'toEnd' and ov.tbaValue = case '" . $value["score_breakdown"]["red"]["endGameChargeStationRobot1"] . "' when 'Docked' then case when '" . $value["score_breakdown"]["red"]["endGameBridgeState"] . "' = 'Level' then 'Engaged' else 'Docked' end when 'Park' then 'Park' else 'None' end)
								 or (t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][1], 3) .
							   " and o.name = 'toEnd' and ov.tbaValue = case '" . $value["score_breakdown"]["red"]["endGameChargeStationRobot2"] . "' when 'Docked' then case when '" . $value["score_breakdown"]["red"]["endGameBridgeState"] . "' = 'Level' then 'Engaged' else 'Docked' end when 'Park' then 'Park' else 'None' end)
								 or (t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][2], 3) .
							   " and o.name = 'toEnd' and ov.tbaValue = case '" . $value["score_breakdown"]["red"]["endGameChargeStationRobot3"] . "' when 'Docked' then case when '" . $value["score_breakdown"]["red"]["endGameBridgeState"] . "' = 'Level' then 'Engaged' else 'Docked' end when 'Park' then 'Park' else 'None' end)
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][0], 3) .
							   " and o.name = 'toEnd' and ov.tbaValue = case '" . $value["score_breakdown"]["blue"]["endGameChargeStationRobot1"] . "' when 'Docked' then case when '" . $value["score_breakdown"]["blue"]["endGameBridgeState"] . "' = 'Level' then 'Engaged' else 'Docked' end when 'Park' then 'Park' else 'None' end)
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][1], 3) .
							   " and o.name = 'toEnd' and ov.tbaValue = case '" . $value["score_breakdown"]["blue"]["endGameChargeStationRobot2"] . "' when 'Docked' then case when '" . $value["score_breakdown"]["blue"]["endGameBridgeState"] . "' = 'Level' then 'Engaged' else 'Docked' end when 'Park' then 'Park' else 'None' end)
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][2], 3) .
							   " and o.name = 'toEnd' and ov.tbaValue = case '" . $value["score_breakdown"]["blue"]["endGameChargeStationRobot3"] . "' when 'Docked' then case when '" . $value["score_breakdown"]["blue"]["endGameBridgeState"] . "' = 'Level' then 'Engaged' else 'Docked' end when 'Park' then 'Park' else 'None' end)))
							     as source (teamMatchId, objectiveId, integerValue)
							on (target.teamMatchId = source.teamMatchId and target.objectiveId = source.objectiveId)
							when matched and target.integerValue <> source.integerValue
							then update set integerValue = source.integerValue
							when not matched
							then insert (teamMatchId, objectiveId, integerValue)
								 values (source.teamMatchId, source.objectiveId, source.integerValue);";
				$results = sqlsrv_query($conn, $tsql);
				if(!$results) 
				{
					echo "Merge of Team Match Scout Records for Match " . $matchNumber . ", Team " . substr($value["alliances"].["red"]["team_keys"][0], 3) . " failed!<br />";
					echo "SQL " . $tsql . "<br>";
					if( ($errors = sqlsrv_errors() ) != null) {
						foreach( $errors as $error ) {
							echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
							echo "code: ".$error[ 'code']."<br />";
							echo "message: ".$error[ 'message']."<br />";
						}
					}
					break;
				}

				// Update Match objective data not tied to a Team for 2023
				$aCoLowR = 0;
				$aCoMidR = 0;
				$aCoHiR = 0;
				$aCuLowR = 0;
				$aCuMidR = 0;
				$aCuHiR = 0;
				$toCoLowR = 0;
				$toCoMidR = 0;
				$toCoHiR = 0;
				$toCuLowR = 0;
				$toCuMidR = 0;
				$toCuHiR = 0;
				$aCoLowB = 0;
				$aCoMidB = 0;
				$aCoHiB = 0;
				$aCuLowB = 0;
				$aCuMidB = 0;
				$aCuHiB = 0;
				$toCoLowB = 0;
				$toCoMidB = 0;
				$toCoHiB = 0;
				$toCuLowB = 0;
				$toCuMidB = 0;
				$toCuHiB = 0;
				// Loop through arrays for counts of Cubes/Cones on Auto Red
				$arr = $value["score_breakdown"]["red"]["autoCommunity"]["B"];
				foreach ($arr as $gamePiece) {
					if ($gamePiece == "Cone")
						$aCoLowR = $aCoLowR + 1;
					if ($gamePiece == "Cube")
						$aCuLowR = $aCuLowR + 1;
				}
				unset($gamePiece);
				$arr = $value["score_breakdown"]["red"]["autoCommunity"]["M"];
				foreach ($arr as $gamePiece) {
					if ($gamePiece == "Cone")
						$aCoMidR = $aCoMidR + 1;
					if ($gamePiece == "Cube")
						$aCuMidR = $aCuMidR + 1;
				}
				unset($gamePiece);
				$arr = $value["score_breakdown"]["red"]["autoCommunity"]["T"];
				foreach ($arr as $gamePiece) {
					if ($gamePiece == "Cone")
						$aCoHiR = $aCoHiR + 1;
					if ($gamePiece == "Cube")
						$aCuHiR = $aCuHiR + 1;
				}
				unset($gamePiece);
				// Loop through arrays for counts of Cubes/Cones on TeleOp Red
				$arr = $value["score_breakdown"]["red"]["teleopCommunity"]["B"];
				foreach ($arr as $gamePiece) {
					if ($gamePiece == "Cone")
						$toCoLowR = $toCoLowR + 1;
					if ($gamePiece == "Cube")
						$toCuLowR = $toCuLowR + 1;
				}
				unset($gamePiece);
				$arr = $value["score_breakdown"]["red"]["teleopCommunity"]["M"];
				foreach ($arr as $gamePiece) {
					if ($gamePiece == "Cone")
						$toCoMidR = $toCoMidR + 1;
					if ($gamePiece == "Cube")
						$toCuMidR = $toCuMidR + 1;
				}
				unset($gamePiece);
				$arr = $value["score_breakdown"]["red"]["teleopCommunity"]["T"];
				foreach ($arr as $gamePiece) {
					if ($gamePiece == "Cone")
						$toCoHiR = $toCoHiR + 1;
					if ($gamePiece == "Cube")
						$toCuHiR = $toCuHiR + 1;
				}
				unset($gamePiece);
				// Loop through arrays for counts of Cubes/Cones on Auto Blue
				$arr = $value["score_breakdown"]["blue"]["autoCommunity"]["B"];
				foreach ($arr as $gamePiece) {
					if ($gamePiece == "Cone")
						$aCoLowB = $aCoLowB + 1;
					if ($gamePiece == "Cube")
						$aCuLowB = $aCuLowB + 1;
				}
				unset($gamePiece);
				$arr = $value["score_breakdown"]["blue"]["autoCommunity"]["M"];
				foreach ($arr as $gamePiece) {
					if ($gamePiece == "Cone")
						$aCoMidB = $aCoMidB + 1;
					if ($gamePiece == "Cube")
						$aCuMidB = $aCuMidB + 1;
				}
				unset($gamePiece);
				$arr = $value["score_breakdown"]["blue"]["autoCommunity"]["T"];
				foreach ($arr as $gamePiece) {
					if ($gamePiece == "Cone")
						$aCoHiB = $aCoHiB + 1;
					if ($gamePiece == "Cube")
						$aCuHiB = $aCuHiB + 1;
				}
				unset($gamePiece);
				// Loop through arrays for counts of Cubes/Cones on TeleOp Blue
				$arr = $value["score_breakdown"]["blue"]["teleopCommunity"]["B"];
				foreach ($arr as $gamePiece) {
					if ($gamePiece == "Cone")
						$toCoLowB = $toCoLowB + 1;
					if ($gamePiece == "Cube")
						$toCuLowB = $toCuLowB + 1;
				}
				unset($gamePiece);
				$arr = $value["score_breakdown"]["blue"]["teleopCommunity"]["M"];
				foreach ($arr as $gamePiece) {
					if ($gamePiece == "Cone")
						$toCoMidB = $toCoMidB + 1;
					if ($gamePiece == "Cube")
						$toCuMidB = $toCuMidB + 1;
				}
				unset($gamePiece);
				$arr = $value["score_breakdown"]["blue"]["teleopCommunity"]["T"];
				foreach ($arr as $gamePiece) {
					if ($gamePiece == "Cone")
						$toCoHiB = $toCoHiB + 1;
					if ($gamePiece == "Cube")
						$toCuHiB = $toCuHiB + 1;
				}
				unset($gamePiece);
				// Don't double count auto/teleop
				$toCoLowR -= $aCoLowR;
				$toCoMidR -= $aCoMidR;
				$toCoHiR -= $aCoHiR;
				$toCuLowR -= $aCuLowR;
				$toCuMidR -= $aCuMidR;
				$toCuHiR -= $aCuHiR;
				$toCoLowB -= $aCoLowB;
				$toCoMidB -= $aCoMidB;
				$toCoHiB -= $aCoHiB;
				$toCuLowB -= $aCuLowB;
				$toCuMidB -= $aCuMidB;
				$toCuHiB -= $aCuHiB;
				// Merge new data
				$tsql = "merge MatchObjective as Target
							using (
							select m.id matchId
							     , tba.alliance
								 , o.id objectiveId
								 , tba.integerValue
							  from Match m
							       inner join GameEvent ge
								   on ge.id = m.gameEventId
								   inner join Game g
								   on g.id = ge.gameId
								   inner join Objective o
								   on o.gameId = g.id
								   inner join 
								   (select 'R' alliance, " . $aCoLowR . " integerValue, 'aCoLow' objectiveName
								    union
									select 'R' alliance, " . $aCoMidR . " integerValue, 'aCoMid' objectiveName
								    union
									select 'R' alliance, " . $aCoHiR . " integerValue, 'aCoHi' objectiveName
								    union
									select 'R' alliance, " . $aCuLowR . " integerValue, 'aCuLow' objectiveName
								    union
									select 'R' alliance, " . $aCuMidR . " integerValue, 'aCuMid' objectiveName
								    union
									select 'R' alliance, " . $aCuHiR . " integerValue, 'aCuHi' objectiveName
								    union
									select 'R' alliance, " . $toCoLowR . " integerValue, 'toCoLow' objectiveName
								    union
									select 'R' alliance, " . $toCoMidR . " integerValue, 'toCoMid' objectiveName
								    union
									select 'R' alliance, " . $toCoHiR . " integerValue, 'toCoHi' objectiveName
								    union
									select 'R' alliance, " . $toCuLowR . " integerValue, 'toCuLow' objectiveName
								    union
									select 'R' alliance, " . $toCuMidR . " integerValue, 'toCuMid' objectiveName
								    union
									select 'R' alliance, " . $toCuHiR . " integerValue, 'toCuHi' objectiveName
								    union
									select 'B' alliance, " . $aCoLowB . " integerValue, 'aCoLow' objectiveName
								    union
									select 'B' alliance, " . $aCoMidB . " integerValue, 'aCoMid' objectiveName
								    union
									select 'B' alliance, " . $aCoHiB . " integerValue, 'aCoHi' objectiveName
								    union
									select 'B' alliance, " . $aCuLowB . " integerValue, 'aCuLow' objectiveName
								    union
									select 'B' alliance, " . $aCuMidB . " integerValue, 'aCuMid' objectiveName
								    union
									select 'B' alliance, " . $aCuHiB . " integerValue, 'aCuHi' objectiveName
								    union
									select 'B' alliance, " . $toCoLowB . " integerValue, 'toCoLow' objectiveName
								    union
									select 'B' alliance, " . $toCoMidB . " integerValue, 'toCoMid' objectiveName
								    union
									select 'B' alliance, " . $toCoHiB . " integerValue, 'toCoHi' objectiveName
								    union
									select 'B' alliance, " . $toCuLowB . " integerValue, 'toCuLow' objectiveName
								    union
									select 'B' alliance, " . $toCuMidB . " integerValue, 'toCuMid' objectiveName
								    union
									select 'B' alliance, " . $toCuHiB . " integerValue, 'toCuHi' objectiveName) tba";
				$tsql .= " on tba.objectiveName = o.name
							 where m.id = " . $matchId .
							"  and ge.id = " . $gameEventId . ")" .
							"     as source (matchId, alliance, objectiveId, integerValue)
							on (target.matchId = source.matchId and target.alliance = source.alliance and target.objectiveId = source.objectiveId)
							when matched and target.integerValue <> source.integerValue
							then update set integerValue = source.integerValue
							when not matched
							then insert (matchId, alliance, objectiveId, integerValue)
								 values (source.matchId, source.alliance, source.objectiveId, source.integerValue);";
				$results = sqlsrv_query($conn, $tsql);
				if(!$results) {
					echo "Merge of Match Alliance Objective Records " . $matchNumber . ", Team " . substr($value["alliances"].["red"]["team_keys"][0], 3) . " failed!<br />";
					echo "SQL " . $tsql . "<br>";
					if( ($errors = sqlsrv_errors() ) != null) {
						foreach( $errors as $error ) {
							echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
							echo "code: ".$error[ 'code']."<br />";
							echo "message: ".$error[ 'message']."<br />";
						}
					}
					break;
				}

			}
			// Update TeamMatch Scout Data from TBA for 2024 - Crescendo
			if ($gameYear == 2024 && $matchComplete == 1) {
				$tsql = "merge TeamMatchObjective as Target
							using (
							select tm.id teamMatchId
								 , o.id objectiveId
								 , ov.integerValue +
								 case when tm.alliance = 'R' and o.name = 'toEnd' and " . $value["score_breakdown"]["red"]["endGameSpotLightBonusPoints"] . " > 0
								 then case when tm.alliancePosition = 1 and ov.integerValue > 0
											and ('" . $value["score_breakdown"]["red"]["endGameRobot1"] . "' = 'StageLeft' and '" . $value["score_breakdown"]["red"]["micStageLeft"] . "' = '1'
											  or '" . $value["score_breakdown"]["red"]["endGameRobot1"] . "' = 'StageRight' and '" . $value["score_breakdown"]["red"]["micStageRight"] . "' = '1'
											  or '" . $value["score_breakdown"]["red"]["endGameRobot1"] . "' = 'CenterStage' and '" . $value["score_breakdown"]["red"]["micCenterStage"] . "' = '1')
										   then 1
										   when tm.alliancePosition = 2 and ov.integerValue > 0
											and ('" . $value["score_breakdown"]["red"]["endGameRobot2"] . "' = 'StageLeft' and '" . $value["score_breakdown"]["red"]["micStageLeft"] . "' = '1'
											  or '" . $value["score_breakdown"]["red"]["endGameRobot2"] . "' = 'StageRight' and '" . $value["score_breakdown"]["red"]["micStageRight"] . "' = '1'
											  or '" . $value["score_breakdown"]["red"]["endGameRobot2"] . "' = 'CenterStage' and '" . $value["score_breakdown"]["red"]["micCenterStage"] . "' = '1')
										   then 1
										   when tm.alliancePosition = 3 and ov.integerValue > 0
											and ('" . $value["score_breakdown"]["red"]["endGameRobot3"] . "' = 'StageLeft' and '" . $value["score_breakdown"]["red"]["micStageLeft"] . "' = '1'
											  or '" . $value["score_breakdown"]["red"]["endGameRobot3"] . "' = 'StageRight' and '" . $value["score_breakdown"]["red"]["micStageRight"] . "' = '1'
											  or '" . $value["score_breakdown"]["red"]["endGameRobot3"] . "' = 'CenterStage' and '" . $value["score_breakdown"]["red"]["micCenterStage"] . "' = '1')
										   then 1
										   else 0 end
								 else 0 end +
							case when tm.alliance = 'B' and o.name = 'toEnd' and " . $value["score_breakdown"]["blue"]["endGameSpotLightBonusPoints"] . " > 0
								 then case when tm.alliancePosition = 1 and ov.integerValue > 0
											and ('" . $value["score_breakdown"]["blue"]["endGameRobot1"] . "' = 'StageLeft' and '" . $value["score_breakdown"]["blue"]["micStageLeft"] . "' = '1'
											  or '" . $value["score_breakdown"]["blue"]["endGameRobot1"] . "' = 'StageRight' and '" . $value["score_breakdown"]["blue"]["micStageRight"] . "' = '1'
											  or '" . $value["score_breakdown"]["blue"]["endGameRobot1"] . "' = 'CenterStage' and '" . $value["score_breakdown"]["blue"]["micCenterStage"] . "' = '1')
										   then 1
										   when tm.alliancePosition = 2 and ov.integerValue > 0
											and ('" . $value["score_breakdown"]["blue"]["endGameRobot2"] . "' = 'StageLeft' and '" . $value["score_breakdown"]["blue"]["micStageLeft"] . "' = '1'
											  or '" . $value["score_breakdown"]["blue"]["endGameRobot2"] . "' = 'StageRight' and '" . $value["score_breakdown"]["blue"]["micStageRight"] . "' = '1'
											  or '" . $value["score_breakdown"]["blue"]["endGameRobot2"] . "' = 'CenterStage' and '" . $value["score_breakdown"]["blue"]["micCenterStage"] . "' = '1')
										   then 1
										   when tm.alliancePosition = 3 and ov.integerValue > 0
											and ('" . $value["score_breakdown"]["blue"]["endGameRobot3"] . "' = 'StageLeft' and '" . $value["score_breakdown"]["blue"]["micStageLeft"] . "' = '1'
											  or '" . $value["score_breakdown"]["blue"]["endGameRobot3"] . "' = 'StageRight' and '" . $value["score_breakdown"]["blue"]["micStageRight"] . "' = '1'
											  or '" . $value["score_breakdown"]["blue"]["endGameRobot3"] . "' = 'CenterStage' and '" . $value["score_breakdown"]["blue"]["micCenterStage"] . "' = '1')
										   then 1
										   else 0 end
								 else 0 end +
							case when tm.alliance = 'R' and o.name = 'toEnd' and " . $value["score_breakdown"]["red"]["endGameHarmonyPoints"] . " > 0
								        then case when tm.alliancePosition = 1 and ov.integerValue > 0
										           and ('" . $value["score_breakdown"]["red"]["endGameRobot1"] . "' = '" . $value["score_breakdown"]["red"]["endGameRobot2"] . "' 
										             or '" . $value["score_breakdown"]["red"]["endGameRobot1"] . "' = '" . $value["score_breakdown"]["red"]["endGameRobot3"] . "')
												  then 2
												  when tm.alliancePosition = 2 and ov.integerValue > 0
										           and ('" . $value["score_breakdown"]["red"]["endGameRobot2"] . "' = '" . $value["score_breakdown"]["red"]["endGameRobot1"] . "' 
										             or '" . $value["score_breakdown"]["red"]["endGameRobot2"] . "' = '" . $value["score_breakdown"]["red"]["endGameRobot3"] . "')
												  then 2
												  when tm.alliancePosition = 3 and ov.integerValue > 0
										           and ('" . $value["score_breakdown"]["red"]["endGameRobot3"] . "' = '" . $value["score_breakdown"]["red"]["endGameRobot1"] . "' 
										             or '" . $value["score_breakdown"]["red"]["endGameRobot3"] . "' = '" . $value["score_breakdown"]["red"]["endGameRobot2"] . "')
												  then 2
												  else 0 end
										else 0 end +
								   case when tm.alliance = 'B' and o.name = 'toEnd' and " . $value["score_breakdown"]["blue"]["endGameHarmonyPoints"] . " > 0
								        then case when tm.alliancePosition = 1 and ov.integerValue > 0
										           and ('" . $value["score_breakdown"]["blue"]["endGameRobot1"] . "' = '" . $value["score_breakdown"]["blue"]["endGameRobot2"] . "' 
										             or '" . $value["score_breakdown"]["blue"]["endGameRobot1"] . "' = '" . $value["score_breakdown"]["blue"]["endGameRobot3"] . "')
												  then 2
												  when tm.alliancePosition = 2 and ov.integerValue > 0
										           and ('" . $value["score_breakdown"]["blue"]["endGameRobot2"] . "' = '" . $value["score_breakdown"]["blue"]["endGameRobot1"] . "' 
										             or '" . $value["score_breakdown"]["blue"]["endGameRobot2"] . "' = '" . $value["score_breakdown"]["blue"]["endGameRobot3"] . "')
												  then 2
												  when tm.alliancePosition = 3 and ov.integerValue > 0
										           and ('" . $value["score_breakdown"]["blue"]["endGameRobot3"] . "' = '" . $value["score_breakdown"]["blue"]["endGameRobot1"] . "' 
										             or '" . $value["score_breakdown"]["blue"]["endGameRobot3"] . "' = '" . $value["score_breakdown"]["blue"]["endGameRobot2"] . "')
												  then 2
												  else 0 end
										else 0 end
							  from Team t
								   inner join TeamMatch tm
								   on tm.teamId = t.id,
								   GameEvent ge
								   inner join Game g
								   on g.id = ge.gameId
								   inner join Objective o
								   on o.gameId = g.id
								   inner join ObjectiveValue ov
								   on ov.objectiveId = o.id
							 where tm.matchId = " . $matchId .
							"  and ge.id = " . $gameEventId .
							"  and ((t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][0], 3) . 
							   " and o.name = 'aLeave' and ov.tbaValue = '" . $value["score_breakdown"]["red"]["autoLineRobot1"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][1], 3) .
							   " and o.name = 'aLeave' and ov.tbaValue = '" . $value["score_breakdown"]["red"]["autoLineRobot2"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][2], 3) .
							   " and o.name = 'aLeave' and ov.tbaValue = '" . $value["score_breakdown"]["red"]["autoLineRobot3"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][0], 3) .
							   " and o.name = 'aLeave' and ov.tbaValue = '" . $value["score_breakdown"]["blue"]["autoLineRobot1"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][1], 3) .
							   " and o.name = 'aLeave' and ov.tbaValue = '" . $value["score_breakdown"]["blue"]["autoLineRobot2"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][2], 3) .
							   " and o.name = 'aLeave' and ov.tbaValue = '" . $value["score_breakdown"]["blue"]["autoLineRobot3"] . "')
							     or (t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][0], 3) .
							   " and o.name = 'toEnd' and (ov.tbaValue = '" . $value["score_breakdown"]["red"]["endGameRobot1"] . "'
							                            or ov.tbaValue2 = '" . $value["score_breakdown"]["red"]["endGameRobot1"] . "'
							                            or ov.tbaValue3 = '" . $value["score_breakdown"]["red"]["endGameRobot1"] . "'))
								 or (t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][1], 3) .
							   " and o.name = 'toEnd' and (ov.tbaValue = '" . $value["score_breakdown"]["red"]["endGameRobot2"] . "'
							                            or ov.tbaValue2 = '" . $value["score_breakdown"]["red"]["endGameRobot2"] . "'
							                            or ov.tbaValue3 = '" . $value["score_breakdown"]["red"]["endGameRobot2"] . "'))
								 or (t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][2], 3) .
							   " and o.name = 'toEnd' and (ov.tbaValue = '" . $value["score_breakdown"]["red"]["endGameRobot3"] . "'
							                            or ov.tbaValue2 = '" . $value["score_breakdown"]["red"]["endGameRobot3"] . "'
							                            or ov.tbaValue3 = '" . $value["score_breakdown"]["red"]["endGameRobot3"] . "'))
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][0], 3) .
							   " and o.name = 'toEnd' and (ov.tbaValue = '" . $value["score_breakdown"]["blue"]["endGameRobot1"] . "'
							                            or ov.tbaValue2 = '" . $value["score_breakdown"]["blue"]["endGameRobot1"] . "'
							                            or ov.tbaValue3 = '" . $value["score_breakdown"]["blue"]["endGameRobot1"] . "'))
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][1], 3) .
							   " and o.name = 'toEnd' and (ov.tbaValue = '" . $value["score_breakdown"]["blue"]["endGameRobot2"] . "'
							                            or ov.tbaValue2 = '" . $value["score_breakdown"]["blue"]["endGameRobot2"] . "'
							                            or ov.tbaValue3 = '" . $value["score_breakdown"]["blue"]["endGameRobot2"] . "'))
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][2], 3) .
							   " and o.name = 'toEnd' and (ov.tbaValue = '" . $value["score_breakdown"]["blue"]["endGameRobot3"] . "'
							                            or ov.tbaValue2 = '" . $value["score_breakdown"]["blue"]["endGameRobot3"] . "'
							                            or ov.tbaValue3 = '" . $value["score_breakdown"]["blue"]["endGameRobot3"] . "'))))
							     as source (teamMatchId, objectiveId, integerValue)
							on (target.teamMatchId = source.teamMatchId and target.objectiveId = source.objectiveId)
							when matched and target.integerValue <> source.integerValue
							then update set integerValue = source.integerValue, scoreValue = source.integerValue
							when not matched
							then insert (teamMatchId, objectiveId, integerValue, scoreValue)
								 values (source.teamMatchId, source.objectiveId, source.integerValue, source.integerValue);";
				$results = sqlsrv_query($conn, $tsql);
				if(!$results) 
				{
					echo "Merge of Team Match Scout Records for Match " . $matchNumber . ", Team " . substr($value["alliances"].["red"]["team_keys"][0], 3) . " failed!<br />";
					echo "SQL " . $tsql . "<br>";
					if( ($errors = sqlsrv_errors() ) != null) {
						foreach( $errors as $error ) {
							echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
							echo "code: ".$error[ 'code']."<br />";
							echo "message: ".$error[ 'message']."<br />";
						}
					}
					break;
				}

				// Update Match objective data not tied to a Team for 2024
				$tsql = "merge MatchObjective as Target
							using (
							select m.id matchId
							     , tba.alliance
								 , o.id objectiveId
								 , tba.integerValue
							  from Match m
							       inner join GameEvent ge
								   on ge.id = m.gameEventId
								   inner join Game g
								   on g.id = ge.gameId
								   inner join Objective o
								   on o.gameId = g.id
								   inner join 
								   (select 'R' alliance, " . $value["score_breakdown"]["red"]["autoSpeakerNoteCount"] . " integerValue, 'aSpeaker' objectiveName
								    union
									select 'R' alliance, " . $value["score_breakdown"]["red"]["autoAmpNoteCount"] . " integerValue, 'aAmp' objectiveName
								    union
									select 'B' alliance, " . $value["score_breakdown"]["blue"]["autoSpeakerNoteCount"] . " integerValue, 'aSpeaker' objectiveName
								    union
									select 'B' alliance, " . $value["score_breakdown"]["blue"]["autoAmpNoteCount"] . " integerValue, 'aAmp' objectiveName
								    union
									select 'R' alliance, " . $value["score_breakdown"]["red"]["teleopSpeakerNoteAmplifiedCount"] . " + " . $value["score_breakdown"]["red"]["teleopSpeakerNoteCount"] . " integerValue, 'toSpeaker' objectiveName
								    union
									select 'R' alliance, " . $value["score_breakdown"]["red"]["teleopAmpNoteCount"] . " integerValue, 'toAmp' objectiveName
								    union
									select 'R' alliance, " . $value["score_breakdown"]["red"]["endGameNoteInTrapPoints"] . " / 5.0 integerValue, 'toTrap' objectiveName
								    union
									select 'B' alliance, " . $value["score_breakdown"]["blue"]["teleopSpeakerNoteAmplifiedCount"] . " + " . $value["score_breakdown"]["blue"]["teleopSpeakerNoteCount"] . " integerValue, 'toSpeaker' objectiveName
								    union
									select 'B' alliance, " . $value["score_breakdown"]["blue"]["teleopAmpNoteCount"] . " integerValue, 'toAmp' objectiveName
								    union
									select 'B' alliance, " . $value["score_breakdown"]["blue"]["endGameNoteInTrapPoints"] . " / 5.0 integerValue, 'toTrap' objectiveName
								    ) tba ";
				$tsql .= " on tba.objectiveName = o.name
							 where m.id = " . $matchId .
							"  and ge.id = " . $gameEventId . ")" .
							"     as source (matchId, alliance, objectiveId, integerValue)
							on (target.matchId = source.matchId and target.alliance = source.alliance and target.objectiveId = source.objectiveId)
							when matched and target.integerValue <> source.integerValue
							then update set integerValue = source.integerValue
							when not matched
							then insert (matchId, alliance, objectiveId, integerValue)
								 values (source.matchId, source.alliance, source.objectiveId, source.integerValue);";
				$results = sqlsrv_query($conn, $tsql);
				if(!$results) 
				{
					echo "Merge of Match Alliance Objective Records " . $matchNumber . ", Team " . substr($value["alliances"].["red"]["team_keys"][0], 3) . " failed!<br />";
					echo "SQL " . $tsql . "<br>";
					if( ($errors = sqlsrv_errors() ) != null) {
						foreach( $errors as $error ) {
							echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
							echo "code: ".$error[ 'code']."<br />";
							echo "message: ".$error[ 'message']."<br />";
						}
					}
					break;
				}

			}
			// Update TeamMatch Scout Data from TBA for 2025 - Reefscape
			if ($gameYear == 2025 && $matchComplete == 1) {
				$tsql = "merge TeamMatchObjective as Target
							using (
							select tm.id teamMatchId
								 , o.id objectiveId
								 , ov.integerValue
							  from Team t
								   inner join TeamMatch tm
								   on tm.teamId = t.id,
								   GameEvent ge
								   inner join Game g
								   on g.id = ge.gameId
								   inner join Objective o
								   on o.gameId = g.id
								   inner join ObjectiveValue ov
								   on ov.objectiveId = o.id
							 where tm.matchId = " . $matchId .
							"  and ge.id = " . $gameEventId .
							"  and ((t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][0], 3) . 
							   " and o.name = 'aLeave' and ov.tbaValue = '" . $value["score_breakdown"]["red"]["autoLineRobot1"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][1], 3) .
							   " and o.name = 'aLeave' and ov.tbaValue = '" . $value["score_breakdown"]["red"]["autoLineRobot2"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][2], 3) .
							   " and o.name = 'aLeave' and ov.tbaValue = '" . $value["score_breakdown"]["red"]["autoLineRobot3"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][0], 3) .
							   " and o.name = 'aLeave' and ov.tbaValue = '" . $value["score_breakdown"]["blue"]["autoLineRobot1"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][1], 3) .
							   " and o.name = 'aLeave' and ov.tbaValue = '" . $value["score_breakdown"]["blue"]["autoLineRobot2"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][2], 3) .
							   " and o.name = 'aLeave' and ov.tbaValue = '" . $value["score_breakdown"]["blue"]["autoLineRobot3"] . "')
							     or (t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][0], 3) .
							   " and o.name = 'toEnd' and ov.tbaValue = '" . $value["score_breakdown"]["red"]["endGameRobot1"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][1], 3) .
							   " and o.name = 'toEnd' and ov.tbaValue = '" . $value["score_breakdown"]["red"]["endGameRobot2"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][2], 3) .
							   " and o.name = 'toEnd' and ov.tbaValue = '" . $value["score_breakdown"]["red"]["endGameRobot3"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][0], 3) .
							   " and o.name = 'toEnd' and ov.tbaValue = '" . $value["score_breakdown"]["blue"]["endGameRobot1"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][1], 3) .
							   " and o.name = 'toEnd' and ov.tbaValue = '" . $value["score_breakdown"]["blue"]["endGameRobot2"] . "')
								 or (t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][2], 3) .
							   " and o.name = 'toEnd' and ov.tbaValue = '" . $value["score_breakdown"]["blue"]["endGameRobot3"] . "')))
							     as source (teamMatchId, objectiveId, integerValue)
							on (target.teamMatchId = source.teamMatchId and target.objectiveId = source.objectiveId)
							when matched and target.integerValue <> source.integerValue
							then update set integerValue = source.integerValue, scoreValue = source.integerValue
							when not matched
							then insert (teamMatchId, objectiveId, integerValue, scoreValue)
								 values (source.teamMatchId, source.objectiveId, source.integerValue, source.integerValue);";
				$results = sqlsrv_query($conn, $tsql);
				if(!$results) 
				{
					echo "Merge of Team Match Scout Records for Match " . $matchNumber . ", Team " . substr($value["alliances"].["red"]["team_keys"][0], 3) . " failed!<br />";
					echo "SQL " . $tsql . "<br>";
					if( ($errors = sqlsrv_errors() ) != null) {
						foreach( $errors as $error ) {
							echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
							echo "code: ".$error[ 'code']."<br />";
							echo "message: ".$error[ 'message']."<br />";
						}
					}
					break;
				}

				// Update Match objective data not tied to a Team for 2025
				$aL2R = 0;
				$aL3R = 0;
				$aL4R = 0;
				$toL2R = 0;
				$toL3R = 0;
				$toL4R = 0;
				$aL2B = 0;
				$aL3B = 0;
				$aL4B = 0;
				$toL2B = 0;
				$toL3B = 0;
				$toL4B = 0;
				// Total up L2 Coral for Auto Red
				if ($value["score_breakdown"]["red"]["autoReef"]["botRow"]["nodeA"] == '1') { $aL2R += 1; }
				if ($value["score_breakdown"]["red"]["autoReef"]["botRow"]["nodeB"] == '1') { $aL2R += 1; }
				if ($value["score_breakdown"]["red"]["autoReef"]["botRow"]["nodeC"] == '1') { $aL2R += 1; }
				if ($value["score_breakdown"]["red"]["autoReef"]["botRow"]["nodeD"] == '1') { $aL2R += 1; }
				if ($value["score_breakdown"]["red"]["autoReef"]["botRow"]["nodeE"] == '1') { $aL2R += 1; }
				if ($value["score_breakdown"]["red"]["autoReef"]["botRow"]["nodeF"] == '1') { $aL2R += 1; }
				if ($value["score_breakdown"]["red"]["autoReef"]["botRow"]["nodeG"] == '1') { $aL2R += 1; }
				if ($value["score_breakdown"]["red"]["autoReef"]["botRow"]["nodeH"] == '1') { $aL2R += 1; }
				if ($value["score_breakdown"]["red"]["autoReef"]["botRow"]["nodeI"] == '1') { $aL2R += 1; }
				if ($value["score_breakdown"]["red"]["autoReef"]["botRow"]["nodeJ"] == '1') { $aL2R += 1; }
				if ($value["score_breakdown"]["red"]["autoReef"]["botRow"]["nodeK"] == '1') { $aL2R += 1; }
				if ($value["score_breakdown"]["red"]["autoReef"]["botRow"]["nodeL"] == '1') { $aL2R += 1; }
				// Total up L3 Coral for Auto Red
				if ($value["score_breakdown"]["red"]["autoReef"]["midRow"]["nodeA"] == '1') { $aL3R += 1; }
				if ($value["score_breakdown"]["red"]["autoReef"]["midRow"]["nodeB"] == '1') { $aL3R += 1; }
				if ($value["score_breakdown"]["red"]["autoReef"]["midRow"]["nodeC"] == '1') { $aL3R += 1; }
				if ($value["score_breakdown"]["red"]["autoReef"]["midRow"]["nodeD"] == '1') { $aL3R += 1; }
				if ($value["score_breakdown"]["red"]["autoReef"]["midRow"]["nodeE"] == '1') { $aL3R += 1; }
				if ($value["score_breakdown"]["red"]["autoReef"]["midRow"]["nodeF"] == '1') { $aL3R += 1; }
				if ($value["score_breakdown"]["red"]["autoReef"]["midRow"]["nodeG"] == '1') { $aL3R += 1; }
				if ($value["score_breakdown"]["red"]["autoReef"]["midRow"]["nodeH"] == '1') { $aL3R += 1; }
				if ($value["score_breakdown"]["red"]["autoReef"]["midRow"]["nodeI"] == '1') { $aL3R += 1; }
				if ($value["score_breakdown"]["red"]["autoReef"]["midRow"]["nodeJ"] == '1') { $aL3R += 1; }
				if ($value["score_breakdown"]["red"]["autoReef"]["midRow"]["nodeK"] == '1') { $aL3R += 1; }
				if ($value["score_breakdown"]["red"]["autoReef"]["midRow"]["nodeL"] == '1') { $aL3R += 1; }
				// Total up L4 Coral for Auto Red
				if ($value["score_breakdown"]["red"]["autoReef"]["topRow"]["nodeA"] == '1') { $aL4R += 1; }
				if ($value["score_breakdown"]["red"]["autoReef"]["topRow"]["nodeB"] == '1') { $aL4R += 1; }
				if ($value["score_breakdown"]["red"]["autoReef"]["topRow"]["nodeC"] == '1') { $aL4R += 1; }
				if ($value["score_breakdown"]["red"]["autoReef"]["topRow"]["nodeD"] == '1') { $aL4R += 1; }
				if ($value["score_breakdown"]["red"]["autoReef"]["topRow"]["nodeE"] == '1') { $aL4R += 1; }
				if ($value["score_breakdown"]["red"]["autoReef"]["topRow"]["nodeF"] == '1') { $aL4R += 1; }
				if ($value["score_breakdown"]["red"]["autoReef"]["topRow"]["nodeG"] == '1') { $aL4R += 1; }
				if ($value["score_breakdown"]["red"]["autoReef"]["topRow"]["nodeH"] == '1') { $aL4R += 1; }
				if ($value["score_breakdown"]["red"]["autoReef"]["topRow"]["nodeI"] == '1') { $aL4R += 1; }
				if ($value["score_breakdown"]["red"]["autoReef"]["topRow"]["nodeJ"] == '1') { $aL4R += 1; }
				if ($value["score_breakdown"]["red"]["autoReef"]["topRow"]["nodeK"] == '1') { $aL4R += 1; }
				if ($value["score_breakdown"]["red"]["autoReef"]["topRow"]["nodeL"] == '1') { $aL4R += 1; }
				// Total up L2 Coral for TeleOp Red
				if ($value["score_breakdown"]["red"]["teleopReef"]["botRow"]["nodeA"] == '1') { $toL2R += 1; }
				if ($value["score_breakdown"]["red"]["teleopReef"]["botRow"]["nodeB"] == '1') { $toL2R += 1; }
				if ($value["score_breakdown"]["red"]["teleopReef"]["botRow"]["nodeC"] == '1') { $toL2R += 1; }
				if ($value["score_breakdown"]["red"]["teleopReef"]["botRow"]["nodeD"] == '1') { $toL2R += 1; }
				if ($value["score_breakdown"]["red"]["teleopReef"]["botRow"]["nodeE"] == '1') { $toL2R += 1; }
				if ($value["score_breakdown"]["red"]["teleopReef"]["botRow"]["nodeF"] == '1') { $toL2R += 1; }
				if ($value["score_breakdown"]["red"]["teleopReef"]["botRow"]["nodeG"] == '1') { $toL2R += 1; }
				if ($value["score_breakdown"]["red"]["teleopReef"]["botRow"]["nodeH"] == '1') { $toL2R += 1; }
				if ($value["score_breakdown"]["red"]["teleopReef"]["botRow"]["nodeI"] == '1') { $toL2R += 1; }
				if ($value["score_breakdown"]["red"]["teleopReef"]["botRow"]["nodeJ"] == '1') { $toL2R += 1; }
				if ($value["score_breakdown"]["red"]["teleopReef"]["botRow"]["nodeK"] == '1') { $toL2R += 1; }
				if ($value["score_breakdown"]["red"]["teleopReef"]["botRow"]["nodeL"] == '1') { $toL2R += 1; }
				// Total up L3 Coral for TeleOp Red
				if ($value["score_breakdown"]["red"]["teleopReef"]["midRow"]["nodeA"] == '1') { $toL3R += 1; }
				if ($value["score_breakdown"]["red"]["teleopReef"]["midRow"]["nodeB"] == '1') { $toL3R += 1; }
				if ($value["score_breakdown"]["red"]["teleopReef"]["midRow"]["nodeC"] == '1') { $toL3R += 1; }
				if ($value["score_breakdown"]["red"]["teleopReef"]["midRow"]["nodeD"] == '1') { $toL3R += 1; }
				if ($value["score_breakdown"]["red"]["teleopReef"]["midRow"]["nodeE"] == '1') { $toL3R += 1; }
				if ($value["score_breakdown"]["red"]["teleopReef"]["midRow"]["nodeF"] == '1') { $toL3R += 1; }
				if ($value["score_breakdown"]["red"]["teleopReef"]["midRow"]["nodeG"] == '1') { $toL3R += 1; }
				if ($value["score_breakdown"]["red"]["teleopReef"]["midRow"]["nodeH"] == '1') { $toL3R += 1; }
				if ($value["score_breakdown"]["red"]["teleopReef"]["midRow"]["nodeI"] == '1') { $toL3R += 1; }
				if ($value["score_breakdown"]["red"]["teleopReef"]["midRow"]["nodeJ"] == '1') { $toL3R += 1; }
				if ($value["score_breakdown"]["red"]["teleopReef"]["midRow"]["nodeK"] == '1') { $toL3R += 1; }
				if ($value["score_breakdown"]["red"]["teleopReef"]["midRow"]["nodeL"] == '1') { $toL3R += 1; }
				// Total up L4 Coral for TeleOp Red
				if ($value["score_breakdown"]["red"]["teleopReef"]["topRow"]["nodeA"] == '1') { $toL4R += 1; }
				if ($value["score_breakdown"]["red"]["teleopReef"]["topRow"]["nodeB"] == '1') { $toL4R += 1; }
				if ($value["score_breakdown"]["red"]["teleopReef"]["topRow"]["nodeC"] == '1') { $toL4R += 1; }
				if ($value["score_breakdown"]["red"]["teleopReef"]["topRow"]["nodeD"] == '1') { $toL4R += 1; }
				if ($value["score_breakdown"]["red"]["teleopReef"]["topRow"]["nodeE"] == '1') { $toL4R += 1; }
				if ($value["score_breakdown"]["red"]["teleopReef"]["topRow"]["nodeF"] == '1') { $toL4R += 1; }
				if ($value["score_breakdown"]["red"]["teleopReef"]["topRow"]["nodeG"] == '1') { $toL4R += 1; }
				if ($value["score_breakdown"]["red"]["teleopReef"]["topRow"]["nodeH"] == '1') { $toL4R += 1; }
				if ($value["score_breakdown"]["red"]["teleopReef"]["topRow"]["nodeI"] == '1') { $toL4R += 1; }
				if ($value["score_breakdown"]["red"]["teleopReef"]["topRow"]["nodeJ"] == '1') { $toL4R += 1; }
				if ($value["score_breakdown"]["red"]["teleopReef"]["topRow"]["nodeK"] == '1') { $toL4R += 1; }
				if ($value["score_breakdown"]["red"]["teleopReef"]["topRow"]["nodeL"] == '1') { $toL4R += 1; }
				// Total up L2 Coral for Auto Blue
				if ($value["score_breakdown"]["blue"]["autoReef"]["botRow"]["nodeA"] == '1') { $aL2B += 1; }
				if ($value["score_breakdown"]["blue"]["autoReef"]["botRow"]["nodeB"] == '1') { $aL2B += 1; }
				if ($value["score_breakdown"]["blue"]["autoReef"]["botRow"]["nodeC"] == '1') { $aL2B += 1; }
				if ($value["score_breakdown"]["blue"]["autoReef"]["botRow"]["nodeD"] == '1') { $aL2B += 1; }
				if ($value["score_breakdown"]["blue"]["autoReef"]["botRow"]["nodeE"] == '1') { $aL2B += 1; }
				if ($value["score_breakdown"]["blue"]["autoReef"]["botRow"]["nodeF"] == '1') { $aL2B += 1; }
				if ($value["score_breakdown"]["blue"]["autoReef"]["botRow"]["nodeG"] == '1') { $aL2B += 1; }
				if ($value["score_breakdown"]["blue"]["autoReef"]["botRow"]["nodeH"] == '1') { $aL2B += 1; }
				if ($value["score_breakdown"]["blue"]["autoReef"]["botRow"]["nodeI"] == '1') { $aL2B += 1; }
				if ($value["score_breakdown"]["blue"]["autoReef"]["botRow"]["nodeJ"] == '1') { $aL2B += 1; }
				if ($value["score_breakdown"]["blue"]["autoReef"]["botRow"]["nodeK"] == '1') { $aL2B += 1; }
				if ($value["score_breakdown"]["blue"]["autoReef"]["botRow"]["nodeL"] == '1') { $aL2B += 1; }
				// Total up L3 Coral for Auto Blue
				if ($value["score_breakdown"]["blue"]["autoReef"]["midRow"]["nodeA"] == '1') { $aL3B += 1; }
				if ($value["score_breakdown"]["blue"]["autoReef"]["midRow"]["nodeB"] == '1') { $aL3B += 1; }
				if ($value["score_breakdown"]["blue"]["autoReef"]["midRow"]["nodeC"] == '1') { $aL3B += 1; }
				if ($value["score_breakdown"]["blue"]["autoReef"]["midRow"]["nodeD"] == '1') { $aL3B += 1; }
				if ($value["score_breakdown"]["blue"]["autoReef"]["midRow"]["nodeE"] == '1') { $aL3B += 1; }
				if ($value["score_breakdown"]["blue"]["autoReef"]["midRow"]["nodeF"] == '1') { $aL3B += 1; }
				if ($value["score_breakdown"]["blue"]["autoReef"]["midRow"]["nodeG"] == '1') { $aL3B += 1; }
				if ($value["score_breakdown"]["blue"]["autoReef"]["midRow"]["nodeH"] == '1') { $aL3B += 1; }
				if ($value["score_breakdown"]["blue"]["autoReef"]["midRow"]["nodeI"] == '1') { $aL3B += 1; }
				if ($value["score_breakdown"]["blue"]["autoReef"]["midRow"]["nodeJ"] == '1') { $aL3B += 1; }
				if ($value["score_breakdown"]["blue"]["autoReef"]["midRow"]["nodeK"] == '1') { $aL3B += 1; }
				if ($value["score_breakdown"]["blue"]["autoReef"]["midRow"]["nodeL"] == '1') { $aL3B += 1; }
				// Total up L4 Coral for Auto Blue
				if ($value["score_breakdown"]["blue"]["autoReef"]["topRow"]["nodeA"] == '1') { $aL4B += 1; }
				if ($value["score_breakdown"]["blue"]["autoReef"]["topRow"]["nodeB"] == '1') { $aL4B += 1; }
				if ($value["score_breakdown"]["blue"]["autoReef"]["topRow"]["nodeC"] == '1') { $aL4B += 1; }
				if ($value["score_breakdown"]["blue"]["autoReef"]["topRow"]["nodeD"] == '1') { $aL4B += 1; }
				if ($value["score_breakdown"]["blue"]["autoReef"]["topRow"]["nodeE"] == '1') { $aL4B += 1; }
				if ($value["score_breakdown"]["blue"]["autoReef"]["topRow"]["nodeF"] == '1') { $aL4B += 1; }
				if ($value["score_breakdown"]["blue"]["autoReef"]["topRow"]["nodeG"] == '1') { $aL4B += 1; }
				if ($value["score_breakdown"]["blue"]["autoReef"]["topRow"]["nodeH"] == '1') { $aL4B += 1; }
				if ($value["score_breakdown"]["blue"]["autoReef"]["topRow"]["nodeI"] == '1') { $aL4B += 1; }
				if ($value["score_breakdown"]["blue"]["autoReef"]["topRow"]["nodeJ"] == '1') { $aL4B += 1; }
				if ($value["score_breakdown"]["blue"]["autoReef"]["topRow"]["nodeK"] == '1') { $aL4B += 1; }
				if ($value["score_breakdown"]["blue"]["autoReef"]["topRow"]["nodeL"] == '1') { $aL4B += 1; }
				// Total up L2 Coral for TeleOp Blue
				if ($value["score_breakdown"]["blue"]["teleopReef"]["botRow"]["nodeA"] == '1') { $toL2B += 1; }
				if ($value["score_breakdown"]["blue"]["teleopReef"]["botRow"]["nodeB"] == '1') { $toL2B += 1; }
				if ($value["score_breakdown"]["blue"]["teleopReef"]["botRow"]["nodeC"] == '1') { $toL2B += 1; }
				if ($value["score_breakdown"]["blue"]["teleopReef"]["botRow"]["nodeD"] == '1') { $toL2B += 1; }
				if ($value["score_breakdown"]["blue"]["teleopReef"]["botRow"]["nodeE"] == '1') { $toL2B += 1; }
				if ($value["score_breakdown"]["blue"]["teleopReef"]["botRow"]["nodeF"] == '1') { $toL2B += 1; }
				if ($value["score_breakdown"]["blue"]["teleopReef"]["botRow"]["nodeG"] == '1') { $toL2B += 1; }
				if ($value["score_breakdown"]["blue"]["teleopReef"]["botRow"]["nodeH"] == '1') { $toL2B += 1; }
				if ($value["score_breakdown"]["blue"]["teleopReef"]["botRow"]["nodeI"] == '1') { $toL2B += 1; }
				if ($value["score_breakdown"]["blue"]["teleopReef"]["botRow"]["nodeJ"] == '1') { $toL2B += 1; }
				if ($value["score_breakdown"]["blue"]["teleopReef"]["botRow"]["nodeK"] == '1') { $toL2B += 1; }
				if ($value["score_breakdown"]["blue"]["teleopReef"]["botRow"]["nodeL"] == '1') { $toL2B += 1; }
				// Total up L3 Coral for TeleOp Blue
				if ($value["score_breakdown"]["blue"]["teleopReef"]["midRow"]["nodeA"] == '1') { $toL3B += 1; }
				if ($value["score_breakdown"]["blue"]["teleopReef"]["midRow"]["nodeB"] == '1') { $toL3B += 1; }
				if ($value["score_breakdown"]["blue"]["teleopReef"]["midRow"]["nodeC"] == '1') { $toL3B += 1; }
				if ($value["score_breakdown"]["blue"]["teleopReef"]["midRow"]["nodeD"] == '1') { $toL3B += 1; }
				if ($value["score_breakdown"]["blue"]["teleopReef"]["midRow"]["nodeE"] == '1') { $toL3B += 1; }
				if ($value["score_breakdown"]["blue"]["teleopReef"]["midRow"]["nodeF"] == '1') { $toL3B += 1; }
				if ($value["score_breakdown"]["blue"]["teleopReef"]["midRow"]["nodeG"] == '1') { $toL3B += 1; }
				if ($value["score_breakdown"]["blue"]["teleopReef"]["midRow"]["nodeH"] == '1') { $toL3B += 1; }
				if ($value["score_breakdown"]["blue"]["teleopReef"]["midRow"]["nodeI"] == '1') { $toL3B += 1; }
				if ($value["score_breakdown"]["blue"]["teleopReef"]["midRow"]["nodeJ"] == '1') { $toL3B += 1; }
				if ($value["score_breakdown"]["blue"]["teleopReef"]["midRow"]["nodeK"] == '1') { $toL3B += 1; }
				if ($value["score_breakdown"]["blue"]["teleopReef"]["midRow"]["nodeL"] == '1') { $toL3B += 1; }
				// Total up L4 Coral for TeleOp Blue
				if ($value["score_breakdown"]["blue"]["teleopReef"]["topRow"]["nodeA"] == '1') { $toL4B += 1; }
				if ($value["score_breakdown"]["blue"]["teleopReef"]["topRow"]["nodeB"] == '1') { $toL4B += 1; }
				if ($value["score_breakdown"]["blue"]["teleopReef"]["topRow"]["nodeC"] == '1') { $toL4B += 1; }
				if ($value["score_breakdown"]["blue"]["teleopReef"]["topRow"]["nodeD"] == '1') { $toL4B += 1; }
				if ($value["score_breakdown"]["blue"]["teleopReef"]["topRow"]["nodeE"] == '1') { $toL4B += 1; }
				if ($value["score_breakdown"]["blue"]["teleopReef"]["topRow"]["nodeF"] == '1') { $toL4B += 1; }
				if ($value["score_breakdown"]["blue"]["teleopReef"]["topRow"]["nodeG"] == '1') { $toL4B += 1; }
				if ($value["score_breakdown"]["blue"]["teleopReef"]["topRow"]["nodeH"] == '1') { $toL4B += 1; }
				if ($value["score_breakdown"]["blue"]["teleopReef"]["topRow"]["nodeI"] == '1') { $toL4B += 1; }
				if ($value["score_breakdown"]["blue"]["teleopReef"]["topRow"]["nodeJ"] == '1') { $toL4B += 1; }
				if ($value["score_breakdown"]["blue"]["teleopReef"]["topRow"]["nodeK"] == '1') { $toL4B += 1; }
				if ($value["score_breakdown"]["blue"]["teleopReef"]["topRow"]["nodeL"] == '1') { $toL4B += 1; }
				// Don't double count auto/teleop
				$toL2R -= $aL2R;
				$toL3R -= $aL3R;
				$toL4R -= $aL4R;
				$toL2B -= $aL2B;
				$toL3B -= $aL3B;
				$toL4B -= $aL4B;
				$tsql = "merge MatchObjective as Target
							using (
							select m.id matchId
							     , tba.alliance
								 , o.id objectiveId
								 , tba.integerValue
							  from Match m
							       inner join GameEvent ge
								   on ge.id = m.gameEventId
								   inner join Game g
								   on g.id = ge.gameId
								   inner join Objective o
								   on o.gameId = g.id
								   inner join 
								   (select 'R' alliance, " . $value["score_breakdown"]["red"]["autoReef"]["trough"] . " integerValue, 'aL1' objectiveName
								    union
									select 'R' alliance, " . $value["score_breakdown"]["red"]["teleopReef"]["trough"] . " integerValue, 'toL1' objectiveName
								    union
									select 'R' alliance, " . $value["score_breakdown"]["red"]["wallAlgaeCount"] . " integerValue, 'toProc' objectiveName
								    union
									select 'R' alliance, " . $value["score_breakdown"]["red"]["netAlgaeCount"] . " integerValue, 'toNet' objectiveName
								    union
									select 'B' alliance, " . $value["score_breakdown"]["blue"]["autoReef"]["trough"] . " integerValue, 'aL1' objectiveName
								    union
									select 'B' alliance, " . $value["score_breakdown"]["blue"]["teleopReef"]["trough"] . " integerValue, 'toL1' objectiveName
								    union
									select 'B' alliance, " . $value["score_breakdown"]["blue"]["wallAlgaeCount"] . " integerValue, 'toProc' objectiveName
								    union
									select 'B' alliance, " . $value["score_breakdown"]["blue"]["netAlgaeCount"] . " integerValue, 'toNet' objectiveName
									union
									select 'R' alliance, " . $aL2R . " integerValue, 'aL2' objectiveName
								    union
									select 'R' alliance, " . $aL3R . " integerValue, 'aL3' objectiveName
								    union
									select 'R' alliance, " . $aL4R . " integerValue, 'aL4' objectiveName
								    union
									select 'R' alliance, " . $toL2R . " integerValue, 'toL2' objectiveName
								    union
									select 'R' alliance, " . $toL3R . " integerValue, 'toL3' objectiveName
								    union
									select 'R' alliance, " . $toL4R . " integerValue, 'toL4' objectiveName
								    union
									select 'B' alliance, " . $aL2B . " integerValue, 'aL2' objectiveName
								    union
									select 'B' alliance, " . $aL3B . " integerValue, 'aL3' objectiveName
								    union
									select 'B' alliance, " . $aL4B . " integerValue, 'aL4' objectiveName
								    union
									select 'B' alliance, " . $toL2B . " integerValue, 'toL2' objectiveName
								    union
									select 'B' alliance, " . $toL3B . " integerValue, 'toL3' objectiveName
								    union
									select 'B' alliance, " . $toL4B . " integerValue, 'toL4' objectiveName
									) tba ";
				$tsql .= " on tba.objectiveName = o.name
							 where m.id = " . $matchId .
							"  and ge.id = " . $gameEventId . ")" .
							"     as source (matchId, alliance, objectiveId, integerValue)
							on (target.matchId = source.matchId and target.alliance = source.alliance and target.objectiveId = source.objectiveId)
							when matched and target.integerValue <> source.integerValue
							then update set integerValue = source.integerValue
							when not matched
							then insert (matchId, alliance, objectiveId, integerValue)
								 values (source.matchId, source.alliance, source.objectiveId, source.integerValue);";
				$results = sqlsrv_query($conn, $tsql);
				if(!$results) 
				{
					echo "Merge of Match Alliance Objective Records " . $matchNumber . ", Team " . substr($value["alliances"].["red"]["team_keys"][0], 3) . " failed!<br />";
					echo "SQL " . $tsql . "<br>";
					if( ($errors = sqlsrv_errors() ) != null) {
						foreach( $errors as $error ) {
							echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
							echo "code: ".$error[ 'code']."<br />";
							echo "message: ".$error[ 'message']."<br />";
						}
					}
					break;
				}

			}
			$cnt += 1;
		}
		}

		// Delete from scout objective records created for Team/Matches that do not exist
		$tsql = "delete from ScoutObjectiveRecord " .
		        " where scoutRecordId in " .
		        "      (select sr.id " .
		        "	      from ScoutRecord sr " .
				"              inner join Match m " .
				"              on m.id = sr.matchId " .
				"              inner join GameEvent ge " .
				"              on ge.id = m.gameEventId " .
				"		 where m.gameEventId = " . $gameEventId . ") " .
				"   and not exists " .
				"      (select 1 " .
				"	      from TeamMatch tm " .
				"		       inner join ScoutRecord sr " .
				"			   on tm.matchId = sr.matchId " .
				"			   and tm.teamId = sr.teamId " .
				"              inner join Match m " .
				"              on m.id = tm.matchId " .
				"		 where m.gameEventId = " . $gameEventId .
				"          and sr.id = ScoutObjectiveRecord.scoutRecordId);";
		$results = sqlsrv_query($conn, $tsql);
		if(!$results) 
		{
			echo "Delete of Team Scout Objective Records failed!<br />";
			echo "SQL " . $tsql . "<br>";
			if( ($errors = sqlsrv_errors() ) != null) {
				foreach( $errors as $error ) {
					echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
					echo "code: ".$error[ 'code']."<br />";
					echo "message: ".$error[ 'message']."<br />";
				}
			}
		}

		// Delete from scout records created for Team/Matches that do not exist
		$tsql = "delete from ScoutRecord " .
		        " where matchId in " .
		        "      (select m.id " .
		        "	      from Match m " .
				"              inner join GameEvent ge " .
				"              on ge.id = m.gameEventId " .
				"		 where m.gameEventId = " . $gameEventId . ") " .
				"   and not exists " .
		        "      (select 1 " .
		        "	      from TeamMatch tm " .
				"              inner join Match m " .
				"              on m.id = tm.matchId " .
				"		 where m.gameEventId = " . $gameEventId .
		        "		   and tm.matchId = ScoutRecord.matchId " .
		        "		   and tm.teamId = ScoutRecord.teamId);";
		$results = sqlsrv_query($conn, $tsql);
		if(!$results) 
		{
			echo "Delete of Team Scout Records failed!<br />";
			echo "SQL " . $tsql . "<br>";
			if( ($errors = sqlsrv_errors() ) != null) {
				foreach( $errors as $error ) {
					echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
					echo "code: ".$error[ 'code']."<br />";
					echo "message: ".$error[ 'message']."<br />";
				}
			}
		}

		// Update scout records based on TBA data
		$tsql = "exec sp_upd_scoutDataFromTba '$loginGUID';";
		$results = sqlsrv_query($conn, $tsql);
		if(!$results) 
		{
			echo "Update of Scout Records failed!<br />";
			echo "SQL " . $tsql . "<br>";
			if( ($errors = sqlsrv_errors() ) != null) {
				foreach( $errors as $error ) {
					echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
					echo "code: ".$error[ 'code']."<br />";
					echo "message: ".$error[ 'message']."<br />";
				}
			}
		}

		// Update team's portion Of Alliance Points
		$tsql = "exec sp_upd_portionOfAlliancePoints $gameYear, $gameEventId";
		$results = sqlsrv_query($conn, $tsql);
		if(!$results) 
		{
			echo "Update of Team's Portion of Alliance Points failed!<br />";
			echo "SQL " . $tsql . "<br>";
			if( ($errors = sqlsrv_errors() ) != null) {
				foreach( $errors as $error ) {
					echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
					echo "code: ".$error[ 'code']."<br />";
					echo "message: ".$error[ 'message']."<br />";
				}
			}
		}

		echo "<center>Updated " . $cnt . " Matches Successfully!</center><br>";
		if ($cnt > 0) {
			sqlsrv_free_stmt($results);
		}

		// Get Team OPRs (Offensive Power Ranking)
		$sURL = $TBAURL. "event/" . $gameYear . $eventCode . "/oprs";
		$oprJSON = file_get_contents($sURL, false, $context);
		$oprArray = json_decode($oprJSON, true);

		// Update Team Rank and Ranking Point Average
		$sURL = $TBAURL. "event/" . $gameYear . $eventCode . "/rankings";
		$rankingJSON = file_get_contents($sURL, false, $context);
		$rankingArray = json_decode($rankingJSON, true);
		$cnt = 0;
		$idx = 0;
		// Update team information
		if (isset($rankingArray)) {
		foreach($rankingArray as $key => $valueArray) {
			$idx += 1;
			// Second array has the rankings
			if ($idx == 2) {
				foreach($valueArray as $key => $value) {
					// Update Team/Event Cross-Reference
					$tsql = "update TeamGameEvent " . 
							"   set rank = " . $value["rank"] . " " .
							"     , rankingPointAverage = " . $value["sort_orders"][0] . " ";
					if (isset($oprArray))
						$tsql .= "     , oPR = " . $oprArray["oprs"][$value["team_key"]] . " ";
					$tsql .= "  where id = " .
							 "       (select tge.id " .
							 "          from TeamGameEvent tge " .
							 "               inner join Team t " .
							 "               on t.id = tge.teamId " .
							 "			    inner join GameEvent ge " .
							 "			    on ge.id = tge.gameEventId " .
							 "               inner join Game g " .
							 "               on g.id = ge.gameId " .
							 "               inner join Event e " .
							 "               on e.id = ge.eventId " .
							 "         where t.teamNumber = " . substr($value["team_key"], 3) .
							 "           and g.gameYear = " . $gameYear .
							 "           and e.eventCode = '" . $eventCode . "');";
					$results = sqlsrv_query($conn, $tsql);
					if(!$results) 
					{
						echo "Update of Ranking for Team " . substr($value["team_key"], 3) . " failed!<br />";
						if( ($errors = sqlsrv_errors() ) != null) {
							echo $tsql;
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
			}
		}
		}
		if ($cnt > 0) {
			echo "<center>Updated Ranking for " . $cnt . " Teams Successfully!</center><br>";
			sqlsrv_free_stmt($results);
		}
	}

	// Create 40 empty practice matches and activate these matches
	if ($option == "P") {
		// Inactivate all matches for the game event
		$tsql = "update Match " .
		        "   set isActive = 'N' " .
		        " where isActive = 'Y' " .
				"   and type <> 'PR' " .
				"   and gameEventId = " .
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
			echo "Inactivate of Game Event Matches failed!<br />";
			if( ($errors = sqlsrv_errors() ) != null) {
				foreach( $errors as $error ) {
					echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
					echo "code: ".$error[ 'code']."<br />";
					echo "message: ".$error[ 'message']."<br />";
				}
			}
		}
		if($results) sqlsrv_free_stmt($results);
		
		// Activate all practice matches for the game event
		$tsql = "update Match " .
		        "   set isActive = 'Y' " .
		        " where isActive = 'N' " .
				"   and type = 'PR' " .
				"   and gameEventId = " .
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
			echo "Activate of Game Event Practice Matches failed!<br />";
			if( ($errors = sqlsrv_errors() ) != null) {
				foreach( $errors as $error ) {
					echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
					echo "code: ".$error[ 'code']."<br />";
					echo "message: ".$error[ 'message']."<br />";
				}
			}
		}
		if($results) sqlsrv_free_stmt($results);
		
		// Create any missing practice matches for the game event
		$tsql = "insert into Match (gameEventId, number, datetime, type, isActive) " .
		        // Starting at noon on 2nd day of event with 10 minute interval
		        "select ge.id, t.number, dateadd(mi, 2160 + (10 * (t.number - 1)), convert(datetime, ge.eventDate)), 'PR', 'Y' " . 
				"  from (select '1' number union  select  '2' number union select  '3' number union select  '4' number union select  '5' number " .
				"  union select '6' number union  select  '7' number union select  '8' number union select  '9' number union select '10' number " .
				"  union select '11' number union select '12' number union select '13' number union select '14' number union select '15' number " .
				"  union select '16' number union select '17' number union select '18' number union select '19' number union select '20' number " .
				"  union select '21' number union select '22' number union select '23' number union select '24' number union select '25' number " .
				"  union select '26' number union select '27' number union select '28' number union select '29' number union select '30' number " .
				"  union select '31' number union select '32' number union select '33' number union select '34' number union select '35' number " .
				"  union select '36' number union select '37' number union select '38' number union select '39' number union select '40' number) t, " .
				"        GameEvent ge " .
				"       inner join Game g on g.id = ge.gameId " .
				"       inner join Event e on e.id = ge.eventId " .
				" where g.gameYear = " . $gameYear .
				"   and e.eventCode = '" . $eventCode . "' " .
				"   and not exists (select 1 " .
				"                     from Match m " .
				"                    where m.gameEventId = ge.id " .
				"                      and m.number = t.number)";
		$results = sqlsrv_query($conn, $tsql);
		// Check for errors
		if(!$results) 
		{
			echo "Adding Game Event Practice Matches failed!<br />";
			if( ($errors = sqlsrv_errors() ) != null) {
				foreach( $errors as $error ) {
					echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
					echo "code: ".$error[ 'code']."<br />";
					echo "message: ".$error[ 'message']."<br />";
				}
			}
		}
		if ($results) {
			echo "<center>Adding Game Event Practice Matches Successful!</center><br>";
			sqlsrv_free_stmt($results);
		}
	}	

	// Activate qualifying matches
	if ($option == "Q") {
		// Inactivate all matches for the game event
		$tsql = "update Match " .
		        "   set isActive = 'N' " .
		        " where isActive = 'Y' " .
				"   and type <> 'QM' " .
				"   and gameEventId = " .
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
			echo "Inactivate of Game Event Matches failed!<br />";
			if( ($errors = sqlsrv_errors() ) != null) {
				foreach( $errors as $error ) {
					echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
					echo "code: ".$error[ 'code']."<br />";
					echo "message: ".$error[ 'message']."<br />";
				}
			}
		}
		if($results) sqlsrv_free_stmt($results);
		
		// Activate all qualifying matches for the game event
		$tsql = "update Match " .
		        "   set isActive = 'Y' " .
		        " where isActive = 'N' " .
				"   and type = 'QM' " .
				"   and gameEventId = " .
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
			echo "Activate of Game Event Qualifying Matches failed!<br />";
			if( ($errors = sqlsrv_errors() ) != null) {
				foreach( $errors as $error ) {
					echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
					echo "code: ".$error[ 'code']."<br />";
					echo "message: ".$error[ 'message']."<br />";
				}
			}
		}
		if ($results) {
			echo "<center>Activating Game Event Qualifying Matches Successful!</center><br>";
			sqlsrv_free_stmt($results);
		}
	}	

	// Activate playoff matches
	if ($option == "L") {
		// Inactivate all matches for the game event
		$tsql = "update Match " .
		        "   set isActive = 'N' " .
		        " where isActive = 'Y' " .
				"   and type in ('PR') " .
				"   and gameEventId = " .
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
			echo "Inactivate of Game Event Matches failed!<br />";
			if( ($errors = sqlsrv_errors() ) != null) {
				foreach( $errors as $error ) {
					echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
					echo "code: ".$error[ 'code']."<br />";
					echo "message: ".$error[ 'message']."<br />";
				}
			}
		}
		if($results) sqlsrv_free_stmt($results);
		
		// Activate all playoff matches for the game event
		$tsql = "update Match " .
		        "   set isActive = 'Y' " .
		        " where isActive = 'N' " .
				"   and type not in ('PR') " .
				"   and gameEventId = " .
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
			echo "Activate of Game Event Playoff Matches failed!<br />";
			if( ($errors = sqlsrv_errors() ) != null) {
				foreach( $errors as $error ) {
					echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
					echo "code: ".$error[ 'code']."<br />";
					echo "message: ".$error[ 'message']."<br />";
				}
			}
		}
		if ($results) {
			echo "<center>Activating Game Event Playoff Matches Successful!</center><br>";
			sqlsrv_free_stmt($results);
		}
	}	

	// Set Game Event active
	if ($option == "A") {
		// Activate game event for the Team associated with the scout
		$tsql = "update t
                    set t.gameEventId = ge.id
				   from Team t
				        inner join Scout s
						on s.teamId = t.id,
						GameEvent ge
						inner join Game g
						on g.id = ge.gameId
						inner join Event e
						on e.id = ge.eventId
				  where s.scoutGUID = '$loginGUID'
				    and g.gameYear = $gameYear 
					and e.eventCode = '$eventCode';";
		$results = sqlsrv_query($conn, $tsql);
		// Check for errors
		if(!$results) 
		{
			echo "Inactivate of Game Events failed!<br />";
			if( ($errors = sqlsrv_errors() ) != null) {
				foreach( $errors as $error ) {
					echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
					echo "code: ".$error[ 'code']."<br />";
					echo "message: ".$error[ 'message']."<br />";
				}
			}
		}
		if ($results) {
			echo "<center>Activation of Game Event Successful!</center><br>";
			sqlsrv_free_stmt($results);
		}
	}	

	// Add/update teams on this event and link teams to the event
	if ($eventTBAExists && $option == "T") {
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
		if($results) sqlsrv_free_stmt($results);
		
		$cnt = 0;
		// Add/update team information and assign to event
		foreach($teamsArray as $key => $value) {
			// Update/insert Team
			$tsql = "merge Team as target " . 
					"using (select " . $value["team_number"] . ", '" . str_replace("'", "", $value["nickname"]) . "', '" . str_replace("'", "", $value["city"]) . ", " . str_replace("'", "", $value["state_prov"]) . "') " .
					"as source (teamNumber, teamName, location) " .
					"on (target.teamNumber = source.teamNumber) " .
					"WHEN matched AND (target.teamName <> source.teamName OR target.location <> source.location) THEN " .
					"UPDATE set teamName = source.teamName, location = source.location " .
					"WHEN not matched THEN " .
					"INSERT (teamNumber, teamName, location) " .
					"VALUES (source.teamNumber, source.teamName, source.location);";
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
		if ($results) {
			echo "<center>Updated " . $cnt . " Teams Successfully!</center><br>";
			sqlsrv_free_stmt($results);
		}
	}	

	// Clear all Playoff Alliance Selections
	if ($option == "C") {
		$tsql = "exec sp_upd_ClearPlayoffSelection '$loginGUID';";
		$results = sqlsrv_query($conn, $tsql);
		// Check for errors
		if(!$results) 
		{
			echo "Update of Playoff Alliances failed!<br />";
			echo "SQL " . $tsql . "<br>";
			if( ($errors = sqlsrv_errors() ) != null) {
				foreach( $errors as $error ) {
					echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
					echo "code: ".$error[ 'code']."<br />";
					echo "message: ".$error[ 'message']."<br />";
				}
			}
		}
		if($results) sqlsrv_free_stmt($results);
	}

	// Clear Game Event eTag to get fresh update from The Blue Alliance API
	if ($option == "E") {
		$tsql = "update ge " .
		        "   set etag = null " .
		        "     , lastUpdated = getdate() " .
				"  from GameEvent ge " .
				"       inner join game g " .
				"	    on g.id = ge.gameId " .
				"       inner join event e " .
				"	    on e.id = ge.eventId " .
				" where g.gameYear = " . $gameYear .
				"   and e.eventCode = '" . $eventCode . "' " .
				"   and eTag is not null;";
		$results = sqlsrv_query($conn, $tsql);
		// Check for errors
		if(!$results) 
		{
			echo "Update Game Event failed!<br />";
			if( ($errors = sqlsrv_errors() ) != null) {
				foreach( $errors as $error ) {
					echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
					echo "code: ".$error[ 'code']."<br />";
					echo "message: ".$error[ 'message']."<br />";
				}
			}
		}
		if($results) sqlsrv_free_stmt($results);
	}

	// Import Match CSV File
	if ($option == "I") {
		$continue = "Y";
		if (isset($_FILES['userfile'])) {
			$tmpName = $_FILES['userfile']['tmp_name'];
		}
		else {
			$continue = "N";
			echo "Import Match CSV File failed!<br />";
			echo "File upload error or file not selected<br />";
		}
		if ($continue == "Y") {
			$file = fopen($tmpName, 'r');
			if (($line = fgetcsv($file)) !== FALSE) {
				if ($line[0] != "type" ||
				    $line[1] != "number" ||
					$line[2] != "dateTime" ||
					$line[3] != "r1" ||
					$line[4] != "r2" ||
					$line[5] != "r3" ||
					$line[6] != "b1" ||
					$line[7] != "b2" ||
					$line[8] != "b3") {
					$continue = "N";
					print_r($line);
					echo "<br>";
					echo "Import Match CSV File failed!<br />";
					echo "File header line does not match expected<br />";
				}
			}
		}
		$cnt = 0;
		if ($continue == "Y") {
			while (($line = fgetcsv($file)) !== FALSE) {
				// Update/insert matches
				$tsql = "merge Match as Target " .
				        "using (select '" . $line[0] . "', '" . $line[1] . "', '" . $line[2] . "', ge.id " .
				        "from gameEvent ge " .
				        "	  inner join game g " .
				        "	  on g.id = ge.gameId " .
				        "	  inner join event e " .
				        "	  on e.id = ge.eventId " .
				        "where g.gameYear = " . $gameYear .
				        " and e.eventCode = '" . $eventCode . "') " .
				        "as source (typ, nbr, dt, gameEventId) " .
						"on (target.gameEventId = source.gameEventId " .
						"and target.type = source.typ " .
						"and target.number = source.nbr) " .
		   				"when matched and (target.dateTime <> source.dt or isActive <> 'Y') " .
		   				"then update set dateTime = source.dt, isActive = 'Y' " .
		   				"when not matched " .
		   				"then insert (gameEventId, number, dateTime, type, isActive) " .
						"values (source.gameEventId, source.nbr, source.dt, source.typ, 'Y'); ";
				$results = sqlsrv_query($conn, $tsql);
				// Check for errors
				if(!$results) 
				{
					print_r($line);
					echo "<br>";
					echo "Update of match data failed!<br />";
					if( ($errors = sqlsrv_errors() ) != null) {
						foreach( $errors as $error ) {
							echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
							echo "code: ".$error[ 'code']."<br />";
							echo "message: ".$error[ 'message']."<br />";
							$continue = "N";
							break;
						}
					}
				}

				// Update/insert team matches
				$tsql = "merge TeamMatch as Target " .
				        "using (select m.id matchId, t.id teamId, csv.alliance, csv.alliancePosition " .
						"		 from gameEvent ge " .
						"        inner join match m " .
						"	  on m.gameEventId = ge.id " .
						"	  inner join game g " .
						"	  on g.id = ge.gameId " .
						"	  inner join event e " .
						"	  on e.id = ge.eventId " .
						"	  inner join TeamGameEvent tge " .
						"	  on tge.gameEventId = ge.id " .
						"	  inner join Team t " .
						"	  on t.id = tge.teamId " .
						"	  inner join ( " .
						"				  select 'XX' typ, '0' nbr, -99 teamNumber, 'X' alliance, 0 alliancePosition ";
				if (is_numeric($line[3])) {
					$tsql = $tsql . " union select '" . $line[0] . "' typ, '" . $line[1] . "' nbr, " . $line[3] . " teamNumber, 'R' alliance, 1 alliancePosition ";
				}
				if (is_numeric($line[4])) {
					$tsql = $tsql . " union select '" . $line[0] . "' typ, '" . $line[1] . "' nbr, " . $line[4] . " teamNumber, 'R' alliance, 2 alliancePosition ";
				}
				if (is_numeric($line[5])) {
					$tsql = $tsql . " union select '" . $line[0] . "' typ, '" . $line[1] . "' nbr, " . $line[5] . " teamNumber, 'R' alliance, 3 alliancePosition ";
				}
				if (is_numeric($line[6])) {
					$tsql = $tsql . " union select '" . $line[0] . "' typ, '" . $line[1] . "' nbr, " . $line[6] . " teamNumber, 'B' alliance, 1 alliancePosition ";
				}
				if (is_numeric($line[7])) {
					$tsql = $tsql . " union select '" . $line[0] . "' typ, '" . $line[1] . "' nbr, " . $line[7] . " teamNumber, 'B' alliance, 2 alliancePosition ";
				}
				if (is_numeric($line[8])) {
					$tsql = $tsql . " union select '" . $line[0] . "' typ, '" . $line[1] . "' nbr, " . $line[8] . " teamNumber, 'B' alliance, 3 alliancePosition ";
				}
				$tsql = $tsql . ") csv " .
						"	  on csv.teamNumber = t.teamNumber " .
						"	  and csv.typ = m.type " .
						"	  and csv.nbr = m.number " .
				        "where g.gameYear = " . $gameYear .
				        " and e.eventCode = '" . $eventCode . "') " .
						"as source (matchId, teamId, alliance, alliancePosition) " .
						"on (target.matchId = source.matchId " .
						"and target.teamId = source.teamId) " .
						"when matched and (target.alliance <> source.alliance or target.alliancePosition <> source.alliancePosition) " .
						"then update set alliance = source.alliance, alliancePosition = source.alliancePosition " .
						"when not matched " .
						"then insert (matchId, teamId, alliance, alliancePosition) " .
						"	values (source.matchId, source.teamId, source.alliance, source.alliancePosition);";
				$results = sqlsrv_query($conn, $tsql);
				// Check for errors
				if(!$results) 
				{
					print_r($tsql);
					echo "<br>";
					print_r($line);
					echo "Update of team match data failed!<br />";
					if( ($errors = sqlsrv_errors() ) != null) {
						foreach( $errors as $error ) {
							echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
							echo "code: ".$error[ 'code']."<br />";
							echo "message: ".$error[ 'message']."<br />";
							$continue = "N";
							break;
						}
					}
				}
		  
				$cnt += 1;
			}
			fclose($file);
		}
		if ($continue == "Y") {
			echo "<center>Imported " . $cnt . " Matches from CSV File Successfully!</center><br>";
		}
	}	
	
	sqlsrv_close($conn);
?>
</html>
