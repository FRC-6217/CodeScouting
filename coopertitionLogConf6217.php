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
		<p></p>
		<p></p>
		<h2>
			<center><a id="buttons" class="clickme danger" href="index6217.php">Home</a>
					<a id="buttons" class="clickme danger" href="coopertitionLogList6217.php">Coopertition Log</a></center>
		</h2>
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

	// Get Login info
	$loginEmailAddress = getenv("DefaultLoginEmailAddress");
	$tsql = "select s.scoutGUID
					, g.gameYear
					from Scout s
						inner join Team t
						on t.id = s.teamId
						inner join GameEvent ge
						on ge.id = t.gameEventId
						inner join Game g
						on g.id = ge.gameId
				where isActive = 'Y' and emailAddress = '$loginEmailAddress'";
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
	$gameYear = $row['gameYear'];

	// Get posted variables
	$coopertitionLogId = $_POST['coopertitionLogId'];

	// Get Query String Parameters
	$scoutId = $_POST['scoutId'];
	$logDate = $_POST['logDate'];
	$teamId = $_POST['teamId'];
	$logNotes = $_POST['logNotes'];
	$logType = $_POST['logType'];
	$eventId = $_POST['eventId'];
	$logLocation = $_POST['logLocation'];

	$tsql = "sp_ins_coopertitionLog $coopertitionLogId, $scoutId, '$logDate', $teamId, '$logNotes', '$logType', $eventId, '$logLocation'";
	$results = sqlsrv_query($conn, $tsql);
	if($results) 
		echo "<p></p><center>Submission Succeeded!</center>";
	if(!$results) 
	{
		echo "It is not working!<br />";
		echo $tsql . "<br />";
		if( ($errors = sqlsrv_errors() ) != null) {
			foreach( $errors as $error ) {
				echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
				echo "code: ".$error[ 'code']."<br />";
				echo "message: ".$error[ 'message']."<br />";
			}
		}
	}		

?>
	</form>
	<p></p>

<?php
	// Close SQL
	sqlsrv_free_stmt($getResults);
	sqlsrv_close($conn);
?>
    </head>
</html>