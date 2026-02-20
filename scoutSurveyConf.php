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
			<center><a id="buttons" class="clickme danger" href="index.php">Home</a>
					<a id="buttons" class="clickme danger" href="scoutSurveyList.php">Scout Survey</a></center>
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
	$loginEmailAddress = $_SERVER['HTTP_X_MS_CLIENT_PRINCIPAL_NAME'] ?? getenv("DefaultLoginEmailAddress");
	$tsql = "select s.scoutGUID
					, s.isAdmin
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
	$isAdmin = $row['isAdmin'];
	// Handle if logged in user is not active/configured in Scout table
	if (empty($loginGUID)) {
		$loginEmailAddress = getenv("DefaultLoginEmailAddress");
		$tsql = "select s.scoutGUID
						, s.isAdmin
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
		$loginGUID = $row['scoutGUID'];
		$gameYear = $row['gameYear'];
		$isAdmin = "N";
	}
	// Non-Admin should not be on this page
	if ($isAdmin != "Y") {
		echo '<center>';				
		echo 'Email: ' . $loginEmailAddress . ' is not authorized on this page.';
		echo '</center>';
		sqlsrv_close($conn);
		echo '</head>'; 
		echo '</html>'; 
		exit(0);
	}

    // Get posted variables
	$teamId = $_POST['teamId'];
	$teamNumber = $_POST['teamNumber'];

	// Get Query String Parameters
	$scoutMatch = $_POST['scoutMatch'];
	$scoutRobot = $_POST['scoutRobot'];
	$scoutingDesc = $_POST['scoutingDesc'];
	$scoutingDataStored = $_POST['scoutingDataStored'];
	$collaborate = $_POST['collaborate'];
	$tbaForMatches = $_POST['tbaForMatches'];
	$tbaForAllianceSelection = $_POST['tbaForAllianceSelection'];
	$wantBBScout = $_POST['wantBBScout'];
	$overviewOfBBScout = $_POST['overviewOfBBScout'];

	$tsql = "sp_ins_scoutSurvey $teamId, '$loginGUID', '$scoutMatch', '$scoutRobot', '$scoutingDesc', '$scoutingDataStored', '$collaborate', '$tbaForMatches', '$tbaForMatches', '$tbaForAllianceSelection', '$wantBBScout', '$overviewOfBBScout'";
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

	echo '<input type="hidden" id="teamNumber" name="teamNumber" value="' . $teamNumber . '">'; 
	echo '<input type="hidden" id="teamId" name="teamId" value="' . $teamId . '">'; 
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