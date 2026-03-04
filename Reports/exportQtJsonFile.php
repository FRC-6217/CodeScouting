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
	$loginEmailAddress = $_SERVER['HTTP_X_MS_CLIENT_PRINCIPAL_NAME'] ?? getenv("DefaultLoginEmailAddress");
	$tsql = "select s.scoutGUID
	              , s.isAdmin
				  , g.autoAuditFunction
				 from Scout s
				      inner join Team t
					  on t.id = s.teamId
					  inner join GameEvent ge
					  on ge.id = t.gameEventId
					  inner join Game g
					  on g.id = ge.gameId
				where s.isActive = 'Y' and s.emailAddress = '$loginEmailAddress'";
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
 				      , g.autoAuditFunction
				 from Scout s
				      inner join Team t
					  on t.id = s.teamId
					  inner join GameEvent ge
					  on ge.id = t.gameEventId
					  inner join Game g
					  on g.id = ge.gameId
				  where s.isActive = 'Y' and s.emailAddress = '$loginEmailAddress'";
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
?>

<html>
  <head>
    <!--Load the Ajax API-->
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
  </head>
  <body>
     <meta name="viewport" content="width=device-width, initial-scale=1">
     <title>Scouting App</title>
     <link rel="stylesheet" type="text/css" href="/Style/scoutingStyle.css">
	 <center><a class="clickme danger" href="..\index.php">Home</a></center>
	<center><h1>Export QT JSON File</h1></center>
<?php
	// Non-Admin should not be on this page
	if ($isAdmin != "Y") {
		echo '<center>';				
		echo 'Email: ' . $loginEmailAddress . ' is not authorized on this page.';
		echo '</center>';
		sqlsrv_close($conn);
	    echo '</body>';
		echo '</html>'; 
		exit(0);
	}

	$tsql = "select js.JsonFile
               from v_JsonSetupFile js
              where loginGUID = '$loginGUID';";
    $getResults = sqlsrv_query($conn, $tsql);
    if ($getResults == FALSE)
		if( ($errors = sqlsrv_errors() ) != null) {
			foreach( $errors as $error ) {
				echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
				echo "code: ".$error[ 'code']."<br />";
				echo "message: ".$error[ 'message']."<br />";
			}
		}
    while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
		$jsonFile = $row['JsonFile'];
    }
	sqlsrv_free_stmt($getResults);
	sqlsrv_close($conn);

	echo "<p></p>JSON_Encode<p></p>";
	echo json_encode($jsonFile, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE );

?>
  </body>
</html>