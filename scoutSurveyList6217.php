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
	$loginEmailAddress = getenv("DefaultLoginEmailAddress");
	$tsql = "select s.scoutGUID
				 from Scout s
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

    <h2>
          <center><a class="clickme danger" href="index6217.php">Home</a></center>
          <p></p>
     </h2>
	 
<center><h1>Scouting Surveys</h1></center>
<center>

    <br>
	<center><div class="g-signin2" data-onsuccess="onSignIn"></div></center>
	<br>
	<center><table cellspacing="0" cellpadding="5">
    <tr>
        <th>Team</th>
        <th>Team Name</th>
        <th>Scout?</th>
        <th>Pit?</th>
        <th>Colaborate?</th>
        <th>TBA Match?</th>
        <th>TBA Alliance?</th>
        <th>Want BBScout?</th>
        <th>Need Overview?</th>
        <th>Scout Description</th>
        <th>Scout Data Storage</th>
     </tr>

    <?php
    $tsql = "select teamUrl
	              , teamNumber
	              , teamName
	              , teamId
	              , scoutMatch
	              , scoutRobot
	              , colaborate
	              , tbaForMatches
	              , tbaForAllianceSelection
	              , wantBBScout
	              , overviewOfBBScout
	              , scoutingDesc
	              , scoutingDataStored
               from v_ScoutSurveyTeamHyperlinks6217
              where loginGUID = '$loginGUID'
			 order by teamNumber";
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
			echo "<td>" . $row['teamUrl'] . "</td>";
			echo '<td align="left">' . $row["teamName"] . '</td>';
			if (isset($row['scoutMatch'])) { echo "<td>" . $row['scoutMatch'] . "</td>"; }
			else { echo "<td></td>"; }
			if (isset($row['scoutRobot'])) { echo "<td>" . $row['scoutRobot'] . "</td>"; }
			else { echo "<td></td>"; }
			if (isset($row['colaborate'])) { echo "<td>" . $row['colaborate'] . "</td>"; }
			else { echo "<td></td>"; }
			if (isset($row['tbaForMatches'])) { echo "<td>" . $row['tbaForMatches'] . "</td>"; }
			else { echo "<td></td>"; }
			if (isset($row['tbaForAllianceSelection'])) { echo "<td>" . $row['tbaForAllianceSelection'] . "</td>"; }
			else { echo "<td></td>"; }
			if (isset($row['wantBBScout'])) { echo "<td>" . $row['wantBBScout'] . "</td>"; }
			else { echo "<td></td>"; }
			if (isset($row['overviewOfBBScout'])) { echo "<td>" . $row['overviewOfBBScout'] . "</td>"; }
			else { echo "<td></td>"; }
			if (isset($row['scoutingDesc'])) { echo "<td>" . $row['scoutingDesc'] . "</td>"; }
			else { echo "<td></td>"; }
			if (isset($row['scoutingDataStored'])) { echo "<td>" . $row['scoutingDataStored'] . "</td>"; }
			else { echo "<td></td>"; }
       echo "</tr>";
    }
    sqlsrv_free_stmt($getResults);
	sqlsrv_close($conn);
    ?>
    </table>
	</center>
</html> 
