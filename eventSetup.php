<html>
     <meta name="viewport" content="width=device-width, initial-scale=1">
     <title>Scouting App</title>
     <link rel="stylesheet" type="text/css" href="Style/scoutingStyle.css">
	<head>
		<link rel="apple-touch-icon" sizes="57x57" href="/Logo/apple-icon-57x57.png">
        <link rel="apple-touch-icon" sizes="60x60" href="/Logo/apple-icon-60x60.png">
        <link rel="apple-touch-icon" sizes="72x72" href="/Logo/apple-icon-72x72.png">
        <link rel="apple-touch-icon" sizes="76x76" href="/Logo/apple-icon-76x76.png">
        <link rel="apple-touch-icon" sizes="114x114" href="/Logo/apple-icon-114x114.png">
        <link rel="apple-touch-icon" sizes="120x120" href="/Logo/apple-icon-120x120.png">
        <link rel="apple-touch-icon" sizes="144x144" href="/Logo/apple-icon-144x144.png">
        <link rel="apple-touch-icon" sizes="152x152" href="/Logo/apple-icon-152x152.png">
        <link rel="apple-touch-icon" sizes="180x180" href="/Logo/apple-icon-180x180.png">
        <link rel="icon" type="image/png" sizes="192x192" href="/Logo/android-icon-192x192.png">
        <link rel="icon" type="image/png" sizes="32x32" href="/Logo/favicon-32x32.png">
        <link rel="icon" type="image/png" sizes="96x96" href="/Logo/favicon-96x96.png">
        <link rel="icon" type="image/png" sizes="16x16" href="/Logo/favicon-16x16.png">
        <link rel="manifest" href="/Logo/manifest.json">
        <meta name="msapplication-TileColor" content="#ffffff">
        <meta name="msapplication-TileImage" content="/Logo/ms-icon-144x144.png">
        <meta name="theme-color" content="#ffffff">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<body>
			<h1><center>Bomb Botz Scouting App</center></h1>
		</body>
		<center><a href="index.php">Home</a></center>
		<form action='eventModify.php' method='post'>
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
?>
			<center>				
				<div class="container" id="event">
					<p><u><b>Event Setup / Configuration</b></u></p>
					<p>Game:
						<select style="width: 161px;" name="game">
							<?php
							$tsql = "select id, name, gameYear from game order by gameYear desc";
							$getResults = sqlsrv_query($conn, $tsql);
							if ($getResults == FALSE)
								if( ($errors = sqlsrv_errors() ) != null) {
									foreach( $errors as $error ) {
										echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
										echo "code: ".$error[ 'code']."<br />";
										echo "message: ".$error[ 'message']."<br />";
									}
								}
							$first = TRUE;
							while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
								if ($first) {
									echo '<option value="' . $row["gameYear"] . '" selected>' . $row["name"] . '</option>';
									$gameYear = $row["gameYear"];
									$first = FALSE;
								}
								else
									echo '<option value="' . $row["gameYear"] . '">' . $row["name"] . '</option>';
							}
							sqlsrv_free_stmt($getResults);
							?>
						</select>
						</p>
					<p></p>
					
					<p>Event:
							<?php
							$tsql = "select e.eventCode from event e inner join gameEvent ge on ge.eventId = e.id where ge.isActive = 'Y' ";
							$getResults = sqlsrv_query($conn, $tsql);
							if ($getResults == FALSE)
								if( ($errors = sqlsrv_errors() ) != null) {
									foreach( $errors as $error ) {
										echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
										echo "code: ".$error[ 'code']."<br />";
										echo "message: ".$error[ 'message']."<br />";
									}
								}
							echo '<select style="width: 157px" name="event">';
							while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
								if (empty($row))
									echo '<option value="" selected></option>';
								else
									$eventCode = $row["event_code"];
							}
							sqlsrv_free_stmt($getResults);

							// Events from Blue Alliance
							$sURL = "https://www.thebluealliance.com/api/v3/events/" . $gameYear . "/simple";
							$eventsJSON = file_get_contents($sURL, false, $context);
							// Sort by name
							$eventsArray = json_decode($eventsJSON, true);
							usort($eventsArray, function($a, $b) { //Sort the array using a user defined function
								return $a["name"] < $b["name"] ? -1 : 1;
							});
							// Add Event Info to the select list
							foreach($eventsArray as $key => $value) {
								if ($value["event_code"] == $eventCode)
									echo '<option value="' . $value["event_code"] . '" selected>' . $value["name"] . '</option>';
								else
									echo '<option value="' . $value["event_code"] . '">' . $value["name"] . '</option>';
							}
							?>
						</select>
					</p>
					<p></p>
					<p>Change?
						<select style="width: 161px;" name="option">
							<option value="M" selected>Update Match Schedule</option>';
							<option value="A">Activate Game Event</option>';
							<option value="T">Update Team List</option>';
						</select>
					</p>
					<p></p>
					<center><input type="submit" value="Submit" name="submitToDatabase"></center>
				</div>
            </center>
			<?php
			sqlsrv_close($conn);
			?>
        </form>
    </head>
</html> 
