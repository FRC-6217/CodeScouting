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
			if($results) {
				$tsql = "insert into GameEvent (eventId, gameId, eventDate, isActive) " . 
						"select e.id, g.id, '" . $eventValue["start_date"] . "', 'N' " .
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
			$tsql = "select ge.id " . 
					"  from GameEvent ge " .
					"       inner join Event e on e.id = ge.eventId " .
					"       inner join Game g on g.id = ge.gameId " .
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
		$matchesJSON = file_get_contents($sURL, false, $context);
		$matchesArray = json_decode($matchesJSON, true);
		$cnt = 0;
		// Add/update match information and assign to teams to the match
		foreach($matchesArray as $key => $value) {
			$dt->setTimestamp($value["time"]);
			$datetime = $dt->format('Y-m-d H:i:s');
			$matchNumber = $value["match_number"];
			if ($value["comp_level"] != 'qm')
				$matchNumber = $value["set_number"] . "-" . $matchNumber;
			// Update/insert Match
			if ($value["score_breakdown"]["red"]["endgameRungIsLevel"] == "IsLevel" &&
			    $value["score_breakdown"]["red"]["endgamePoints"] >= 40 &&
				$gameYear = 2020)
				$redAlliancePoints = 15;
			else
				$redAlliancePoints = 0;
			if ($value["score_breakdown"]["blue"]["endgameRungIsLevel"] == "IsLevel" &&
			    $value["score_breakdown"]["blue"]["endgamePoints"] >= 40 &&
				$gameYear = 2020)
				$blueAlliancePoints = 15;
			else
				$blueAlliancePoints = 0;
			$tsql = "merge Match as target " . 
		            "using (select " . $gameEventId . ", '" . $matchNumber . "', '" . $datetime . "', '" . strtoupper($value["comp_level"]) . "', " .
 					                   $value["alliances"]["red"]["score"] . ", " . $value["alliances"]["blue"]["score"] . ", " .
 					                   $redAlliancePoints . ", " . $value["score_breakdown"]["red"]["foulPoints"] . ", " .
 					                   $blueAlliancePoints . ", " . $value["score_breakdown"]["blue"]["foulPoints"] . ", '" . $value["key"] . "') " .
					"as source (gameEventId, number, dateTime, type, redScore, blueScore, redAlliancePoints, redFoulPoints, blueAlliancePoints, blueFoulPoints, matchCode) " .
					"on (target.gameEventId = source.gameEventId and target.number = source.number and target.type = source.type) " .
					"WHEN matched THEN " .
					"UPDATE set number = source.number, dateTime = source.dateTime, " .
					          " redScore = source.redScore, blueScore = source.blueScore, " .
					          " redAlliancePoints = source.redAlliancePoints, redFoulPoints = source.redFoulPoints, " .
					          " blueAlliancePoints = source.blueAlliancePoints, blueFoulPoints = source.blueFoulPoints, " .
					          " matchCode = source.matchCode " .
					"WHEN not matched THEN " .
					"INSERT (gameEventId, number, dateTime, type, isActive, redScore, blueScore, redAlliancePoints, redFoulPoints, blueAlliancePoints, blueFoulPoints, matchCode) " .
					"VALUES (source.gameEventId, source.number, source.dateTime, source.type, 'N', source.redScore, source.blueScore, source.redAlliancePoints, source.redFoulPoints, source.blueAlliancePoints, source.blueFoulPoints, source.matchCode);";
			$results = sqlsrv_query($conn, $tsql);
			if(!$results) 
			{
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
			echo "New";
			for($i=0; $i<count($value['videos']); $i++) {
				echo "Video is " . $matchId . ":" . $value['videos'][$i]["type"] . ":" . $value['videos'][$i]["key"] . "<BR>";
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
			$tsql = "insert into TeamMatch (matchId, teamId, alliance, alliancePosition) " . 
					"select " . $matchId . ", t.id, 'R', 1 " .
					"  from Team t " .
				    " where t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][0], 3) .
					"   and not exists (select 1 " .
					"                     from TeamMatch tm " .
					"                    where tm.matchId = " . $matchId .
					"                      and tm.teamId = t.id) " .
					"union " .
					"select " . $matchId . ", t.id, 'R', 2 " .
					"  from Team t " .
				    " where t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][1], 3) .
					"   and not exists (select 1 " .
					"                     from TeamMatch tm " .
					"                    where tm.matchId = " . $matchId .
					"                      and tm.teamId = t.id) " .
					"union " .
					"select " . $matchId . ", t.id, 'R', 3 " .
					"  from Team t " .
				    " where t.teamNumber = " . substr($value["alliances"]["red"]["team_keys"][2], 3) .
					"   and not exists (select 1 " .
					"                     from TeamMatch tm " .
					"                    where tm.matchId = " . $matchId .
					"                      and tm.teamId = t.id) " .
					"union " .
					"select " . $matchId . ", t.id, 'B', 1 " .
					"  from Team t " .
				    " where t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][0], 3) .
					"   and not exists (select 1 " .
					"                     from TeamMatch tm " .
					"                    where tm.matchId = " . $matchId .
					"                      and tm.teamId = t.id) " .
					"union " .
					"select " . $matchId . ", t.id, 'B', 2 " .
					"  from Team t " .
				    " where t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][1], 3) .
					"   and not exists (select 1 " .
					"                     from TeamMatch tm " .
					"                    where tm.matchId = " . $matchId .
					"                      and tm.teamId = t.id) " .
					"union " .
					"select " . $matchId . ", t.id, 'B', 3 " .
					"  from Team t " .
				    " where t.teamNumber = " . substr($value["alliances"]["blue"]["team_keys"][2], 3) .
					"   and not exists (select 1 " .
					"                     from TeamMatch tm " .
					"                    where tm.matchId = " . $matchId .
					"                      and tm.teamId = t.id);";
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
			else $cnt += 1;
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

		// Update team's portion Of Alliance Points
		$tsql = "sp_upd_portionOfAlliancePoints $gameYear, $gameEventId";
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

		// Update Team Rank and Ranking Point Average
		$sURL = $TBAURL. "event/" . $gameYear . $eventCode . "/teams/statuses";
		$teamsJSON = file_get_contents($sURL, false, $context);
		$teamsArray = json_decode($teamsJSON, true);
		$cnt = 0;
		// Update team information
		foreach($teamsArray as $key => $value) {
			if (isset($value)) {
				// Update Team/Event Cross-Reference
				$tsql = "update TeamGameEvent " . 
						"   set rank = " . $value["qual"]["ranking"]["rank"] . " " .
						"     , rankingPointAverage = " . $value["qual"]["ranking"]["sort_orders"][0] . " " .
						"  where id = " .
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
						"         where t.teamNumber = " . substr($value["qual"]["ranking"]["team_key"], 3) .
						"           and g.gameYear = " . $gameYear .
						"           and e.eventCode = '" . $eventCode . "');";
				$results = sqlsrv_query($conn, $tsql);
				if(!$results) 
				{
					echo "Update of Team Game Event for Team " . substr($value["qual"].["ranking"].["team_key"], 3) . " failed!<br />";
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
		if ($cnt > 0) {
			echo "<center>Updated " . $cnt . " Teams Successfully!</center><br>";
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
				"  from (select  1 number union select  2 number union select  3 number union select  4 number union select  5 number " .
				"  union select 6 number union select  7 number union select  8 number union select  9 number union select 10 number " .
				"  union select 11 number union select 12 number union select 13 number union select 14 number union select 15 number " .
				"  union select 16 number union select 17 number union select 18 number union select 19 number union select 20 number " .
				"  union select 21 number union select 22 number union select 23 number union select 24 number union select 25 number " .
				"  union select 26 number union select 27 number union select 28 number union select 29 number union select 30 number " .
				"  union select 31 number union select 32 number union select 33 number union select 34 number union select 35 number " .
				"  union select 36 number union select 37 number union select 38 number union select 39 number union select 40 number) t, " .
				"        GameEvent ge " .
				"       inner join Game g on g.id = ge.gameId " .
				"       inner join Event e on e.id = ge.eventId " .
				" where g.gameYear = " . $gameYear .
				"   and e.eventCode = '" . $eventCode . "' " .
				"   and not exists (select 1 " .
				"                     from Match m " .
				"                    where m.gameEventId = ge.id " .
				"                      and m.datetime = dateadd(mi, 2160 + (10 * (t.number - 1)), convert(datetime, ge.eventDate)))";
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

	// Set Game Event active and inactivate all others
	if ($option == "A") {
		// Inactivate all game events
		$tsql = "update GameEvent " .
		        "   set isActive = 'N' " .
		        " where isActive = 'Y' " .
				"   and id not in " .
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
			echo "Inactivate of Game Events failed!<br />";
			if( ($errors = sqlsrv_errors() ) != null) {
				foreach( $errors as $error ) {
					echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
					echo "code: ".$error[ 'code']."<br />";
					echo "message: ".$error[ 'message']."<br />";
				}
			}
		}
		if($results) sqlsrv_free_stmt($results);
		
		// Inactivate all game events
		$tsql = "update GameEvent " .
		        "   set isActive = 'Y' " .
		        " where isActive = 'N' " .
				"   and id in " .
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
		if ($results) {
			echo "<center>Updated " . $cnt . " Teams Successfully!</center><br>";
			sqlsrv_free_stmt($results);
		}
	}	
	sqlsrv_close($conn);
?>
</html>
