<html>
     <meta name="viewport" content="width=device-width, initial-scale=1">
	 <script src="https://apis.google.com/js/platform.js" async defer></script>
     <title>Scouting App</title>
     <link rel="stylesheet" type="text/css" href="Style/scoutingStyle.css">
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
				  , t.teamNumber
			   from Scout s
				    inner join Team t
					on t.id = s.teamId
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
	$teamNumber = $row['teamNumber'];
	// Handle if logged in user is not active/configured in Scout table
	if (empty($loginGUID)) {
		$loginEmailAddress = getenv("DefaultLoginEmailAddress");
		$tsql = "select s.scoutGUID
					  , s.isAdmin
				      , t.teamNumber
				   from Scout s
				    	inner join Team t
						on t.id = s.teamId
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
		$teamNumber = $row['teamNumber'];
	}
?>
    <head>
        <link rel="apple-touch-icon" sizes="57x57" href="/Logo/apple-icon-57x57.png">
        <link rel="apple-touch-icon" sizes="60x60" href="/Logo/apple-icon-60x60.png">
        <link rel="apple-touch-icon" sizes="72x72" href="/Logo/apple-icon-72x72.png">
        <link rel="apple-touch-icon" sizes="76x76" href="/Logo/apple-icon-76x76.png">
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
    </head>

	<center><h1>Coopertition Log</h1></center>
    <h2>
        <p></p>
        <center>
			<a class="clickme danger" href="index.php">Home</a>
			<?php
			   // Only show add button for Team 6217
			   if ($isAdmin == "Y" && $teamNumber == "6217") {
				    echo '<a class="clickme danger" href="coopertitionLog.php?coopertitionLogId=0">New Log Entry</a>';
			   }
			?>
		</center>
        <p></p>
     </h2>
<center>

    <br>
	<center><div class="g-signin2" data-onsuccess="onSignIn"></div></center>
	<br>
	<center><table cellspacing="0" cellpadding="5">
    <tr>
        <th>Date</th>
        <th>Entered By</th>
        <th>Team</th>
        <th>Type</th>
        <th>Cooperition Description</th>
        <th>Event</th>
        <th>Location</th>
     </tr>

    <?php
    $tsql = "select logUrl
	              , scoutName
				  , teamNumber
	              , logNotes
	              , logType
	              , eventName
	              , logLocation
	              , id
	              , logDate
               from v_CoopertitionLogHyperlinks
			 order by logDate desc";
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
       echo "<tr>";
			echo "<td>" . $row['logUrl'] . "</td>";
			echo '<td max-width: 150px;>' . $row["scoutName"] . '</td>';
			echo '<td style="max-width: 150px;">' . $row["teamNumber"] . '</td>';
			echo '<td>' . $row["logType"] . '</td>';
			echo '<td style="max-width: 360px;">' . $row["logNotes"] . '</td>';
			if (isset($row['eventName'])) { echo "<td max-width: 150px;>" . $row['eventName'] . "</td>"; }
			else { echo "<td></td>"; }
			if (isset($row['logLocation'])) { echo "<td max-width: 150px;>" . $row['logLocation'] . "</td>"; }
			else { echo "<td></td>"; }
       echo "</tr>";
    }
    sqlsrv_free_stmt($getResults);
	sqlsrv_close($conn);
    ?>
    </table>
	</center>
</html> 
