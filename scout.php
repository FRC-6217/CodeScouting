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
		<h2>
			<center><a id="buttons" class="clickme danger" href="index.php">Home</a>
			<a id="buttons" class="clickme danger" href="scoutList.php">Scout List</a></center>
		</h2>
		
		<form enctype="multipart/form-data" action='scoutConf.php' method='post'>
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
	$isAdmin = $row['isAdmin'];
	// Handle if logged in user is not active/configured in Scout table
	if (empty($loginGUID)) {
		$loginEmailAddress = getenv("DefaultLoginEmailAddress");
		$tsql = "select s.scoutGUID
						, s.isAdmin
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
		$isAdmin = $row['isAdmin'];
	}

    // Get Query String Parameters
	$scoutId = "$_GET[scoutId]";
?>
			<center>				
				<div class="container" id="scout">
					<?php
					$tsql = "select s.id
                                  , s.lastName
                             	  , s.firstName
                             	  , s.emailAddress
                             	  , s.isActive
                                  , s.isAdmin
                               from Scout s
                              where s.id = $scoutId";
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
					if (isset($row['emailAddress'])) {
						echo '<br>Last Name<br><input type="text" name ="lastName" value="' . $row['lastName'] . '" required style="width: 320px"><br>';
						echo '<br>First Name<br><input type="text" name ="firstName" value="' . $row['firstName'] . '" required style="width: 320px"><br>';
						echo '<br>Email Address<br><input type="text" name ="emailAddress" value="' . $row['emailAddress'] . '" required tyle="width: 320px"><br>';
						echo '<br>Active:<br>&nbsp;&nbsp;&nbsp;No<input type="radio"';
						if ($row['isActive'] = "N") echo ' checked="checked"';
						echo ' name ="isActive" value="N">&nbsp;&nbsp;&nbsp;Yes<input type="radio"';
						if ($row['isActive'] = "Y") echo ' checked="checked"';
						echo ' name ="isActive" value="Y"><br>';
						echo '<br>Admin:<br>&nbsp;&nbsp;&nbsp;No<input type="radio"';
						if ($row['isAdmin'] = "N") echo ' checked="checked"';
						echo ' name ="isAdmin" value="N">&nbsp;&nbsp;&nbsp;Yes<input type="radio"';
						if ($row['isAdmin'] = "Y") echo ' checked="checked"';
						echo ' name ="isAdmin" value="Y"><br>';
					}
					else {
						echo '<br>Last Name<br><input type="text" name ="lastName" value="" required style="width: 320px"><br>';
						echo '<br>First Name<br><input type="text" name ="firstName" value="" required style="width: 320px"><br>';
						echo '<br>Email Address<br><input type="text" name ="emailAddress" value="" required style="width: 320px"><br>';
						echo '<br>Active:<br>&nbsp;&nbsp;&nbsp;No<input type="radio" name ="isActive" value="N">&nbsp;&nbsp;&nbsp;Yes<input type="radio" checked="checked" name ="isActive" value="Y"><br>';
						echo '<br>Admin:<br>&nbsp;&nbsp;&nbsp;No<input type="radio" name ="isAdmin" value="N">&nbsp;&nbsp;&nbsp;Yes<input type="radio" checked="checked" name ="isAdmin" value="Y"><br>';
						$scoutId = -1;
					}
					echo '<input type="hidden" id="scoutId" name="scoutId" value="' . $scoutId . '">'; 
					sqlsrv_free_stmt($getResults);
					sqlsrv_close($conn);

					// Only show form submit button when Admin
					if ($isAdmin == "Y") {
						echo '<p></p>';
						echo '<center>';
							echo '<input type="submit" value="Submit" name="submitToDatabase">';
						echo '</center>';
					}
					?>
				</div>
            </center>
        </form>
	</head>
</html>
