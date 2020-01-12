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
		
		<form action='confirmation.php' method='post'>
<?php
    $serverName = "team6217.database.windows.net";
	$database = "ScoutApp";
	$userName = "frc6217";
	$password = "Cfbombers6217";
    $connectionOptions = array(
        "Database" => "$database",
        "Uid" => "$userName",
        "PWD" => "$password"
    );
    //Establishes the connection
    $conn = sqlsrv_connect($serverName, $connectionOptions);

    // Get Query String Parameters
	$matchId = "$_GET[matchId]";
	$matchNumber = "$_GET[matchNumber]";
	$teamId = "$_GET[teamId]";
	$teamNumber = "$_GET[teamNumber]";
?>
			<center>				
				<div class="container" id="scout">
					<p><u>Match Selection</u></p>
					<p>Scout:
						<select style="width: 161px;" name="scout">
							<option value=""></option>
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
							while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
							?>
							<option value="<?php echo ($row['id']);?>"><?php echo ($row['fullName']);?></option>
							<?php		
							}
							?>
						</select>
						</p>
					<p></p>
					
					<p>Match:
						<select style="width: 157px" name="match">
							<option value="<?php echo ($matchId);?>" selected><?php echo ($matchNumber);?></option>
							<?php
							$tsql = "select m.matchId, m.matchNumber from v_MatchHyperlinks m order by m.sortOrder, m.matchNumber";
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
					<p></p>

					<p>Team:
						<select name="team" style="width: 154.5px;">
						<option value="<?php echo ($teamId);?>" selected><?php echo ($teamNumber);?></option>
						<?php
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
					<p></p>

<u>Autonomous</u><br>
PC Lower Cnt: <input type="number" name ="aPcLower" value=0 style="width: 40px;"><br>
PC Outer Cnt: <input type="number" name ="aPcOuter" value=0 style="width: 40px;"><br>
PC Inner Cnt: <input type="number" name ="aPcInner" value=0 style="width: 40px;"><br>
Move Off Line:<br>No<input type="radio" checked="checked" name ="aMove" value=0"><br>
Yes<input type="radio" name ="aMove" value=1"><br>
<u>Tele Op</u><br>
PC Lower Cnt: <input type="number" name ="toPcLower" value=0 style="width: 40px;"><br>
PC Outer Cnt: <input type="number" name ="toPcOuter" value=0 style="width: 40px;"><br>
PC Inner Cnt: <input type="number" name ="toPcInner" value=0 style="width: 40px;"><br>
Ctrl Pnl Rotation:<br>No<input type="radio" checked="checked" name ="toCpRotation" value=0"><br>
Yes<input type="radio" name ="toCpRotation" value=1"><br>
Rotation Time: <input type="number" name ="toCpRotationTime" value=0 style="width: 40px;"><br>
Ctrl Pnl Position:<br>No<input type="radio" checked="checked" name ="toCpPosition" value=0"><br>
Yes<input type="radio" name ="toCpPosition" value=1"><br>
Position Time: <input type="number" name ="toCpPositionTime" value=0 style="width: 40px;"><br>
Defense:<br>No Defense<input type="radio" checked="checked" name ="toDefense" value=0"><br>
Poor Defense<input type="radio" name ="toDefense" value=-1"><br>
Good Defense<input type="radio" name ="toDefense" value=1"><br>
Excellent Defense<input type="radio" name ="toDefense" value=2"><br>
<u>End Game</u><br>
Final Position:<br>None<input type="radio" checked="checked" name ="toFinalPosition" value=0"><br>
Park<input type="radio" name ="toFinalPosition" value=1"><br>
Hang Unassisted<input type="radio" name ="toFinalPosition" value=2"><br>
Hang Assisted<input type="radio" name ="toFinalPosition" value=1"><br>
Hang Assist 1<input type="radio" name ="toFinalPosition" value=3"><br>
Hang Assist 2<input type="radio" name ="toFinalPosition" value=4"><br>
					<p></p>
					<center><input type="submit" value="Submit" name="submitToDatabase"></center>
				</div>
            </center>

			<?php
			$submit = $POST[submitToDatabase];
			$scout = $_POST[scout];
			$match = $_POST[match];
			$team = $_POST[team];
			$leaveHab = $_POST[leaveHab];
			$ssHatchCnt = $_POST[ssHatchCnt];
			$ssCargoCnt = $_POST[ssCargoCnt];
			$toHatchCnt = $_POST[toHatchCnt];
			$toCargoCnt = $_POST[toCargoCnt];
			$defense = $_POST[defense];
			$returnHab = $_POST[returnHab];

			sqlsrv_free_stmt($getResults);
			?>
        </form>
	</head>
</html>
