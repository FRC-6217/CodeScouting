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
		<center><a class="clickme danger" href="index.php">Home</a></center>
		
		<form action='confirmation.php' method='post'>
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

    // Get Query String Parameters
	$scoutId = "$_GET[scoutId]";
	$matchId = "$_GET[matchId]";
	$matchNumber = "$_GET[matchNumber]";
	$teamId = "$_GET[teamId]";
	$teamNumber = "$_GET[teamNumber]";
	$alliancePosition = "$_GET[alliancePosition]";
	
?>
			<center>				
				<div class="container" id="scout">
					<p><u><b>Match Selection</b></u></p>
					<p>Scout:
						<select style="width: 161px;" name="scout">
							<?php
							$tsql = "select id, lastName + ', ' + firstName fullName from Scout where isActive = 'Y' order by lastName, firstName";
							$getResults = sqlsrv_query($conn, $tsql);
							if ($getResults == FALSE)
								if( ($errors = sqlsrv_errors() ) != null) {
									foreach( $errors as $error ) {
										echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
										echo "code: ".$error[ 'code']."<br />";
										echo "message: ".$error[ 'message']."<br />";
									}
								}
							$cnt = 0;
							while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
								if ($row['id'] == @scoutId)
									echo "<option value=" . $row['id'] . " selected>" . $row['fullName'] . "</option>";
								else
									echo "<option value=" . $row['id'] . ">" . $row['fullName'] . "</option>";
							}
							?>
						</select>
						</p>
					<p>Match:
						<select style="width: 157px" name="match">
							<option value="<?php echo ($matchId);?>" selected><?php echo ($matchNumber);?></option>
							<?php
							$tsql = "select m.matchId, m.matchNumber from v_MatchHyperlinks m order by m.sortOrder, m.matchSort, m.matchNumber";
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
							?>
							<option value="<?php echo ($row['matchId']);?>"><?php echo ($row['matchNumber']);?></option>
							<?php		
							}
							?>
						</select>
					</p>
					<p>Team:
						<select name="team" style="width: 154.5px;">
						<?php
							if ($teamId == "NA")
								echo "<option value=''></option>";
							else
								echo "<option value=" . $teamId . " selected>" . $teamNumber . "</option>";
							$tsql = "select t.id, t.teamNumber from Team t inner join TeamGameEvent tge on tge.teamId = t.id inner join GameEvent ge on ge.id = tge.gameEventId where t.isActive = 'Y' and ge.isActive = 'Y' order by t.teamNumber";
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
							?>
							<option value="<?php echo ($row['id']);?>"><?php echo ($row['teamNumber']);?></option>
							<?php		
							}
							?>
						</select>
					</p>
					<p>Alliance Position:
						<select name="alliancePosition" style="width: 154.5px;">
						<?php
						    if ($alliancePosition != "B1")
								echo "<option value='B1'>Blue 1</option>";
							else
								echo "<option value='B1' selected>Blue 1</option>";
						    if ($alliancePosition != "B2")
								echo "<option value='B2'>Blue 2</option>";
							else
								echo "<option value='B2' selected>Blue 2</option>";
						    if ($alliancePosition != "B3")
								echo "<option value='B3'>Blue 3</option>";
							else
								echo "<option value='B3' selected>Blue 3</option>";
						    if ($alliancePosition != "R1")
								echo "<option value='R1'>Red 1</option>";
							else
								echo "<option value='R1' selected>Red 1</option>";
						    if ($alliancePosition != "R2")
								echo "<option value='R2'>Red 2</option>";
							else
								echo "<option value='R2' selected>Red 2</option>";
						    if ($alliancePosition != "R3")
								echo "<option value='R3'>Red 3</option>";
							else
								echo "<option value='R3' selected>Red 3</option>";
						?>
						</select>
					</p>
					<?php
					$tsql = "select groupName
								  , objectiveName
								  , objectiveLabel
								  , displayValue
								  , integerValue
								  , groupSort
								  , objectiveSort
								  , objectiveValueSort
								  , scoutRecordHtml
							   from v_EnterScoutRecordHTML
							 order by groupSort, objectiveSort, objectiveValueSort";
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
						echo $row['scoutRecordHtml'];
					}
					sqlsrv_free_stmt($getResults);
					sqlsrv_close($conn);
					?>
					<p></p>
					<center><input type="submit" value="Submit" name="submitToDatabase"></center>
				</div>
            </center>
        </form>
	</head>
</html>
