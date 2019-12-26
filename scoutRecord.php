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
			<h1><center>BOMB BOTZ SCOUTING APP</center></h1>
		</body>
		
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
					<p><u>MATCH SELECTION</u></p>
					<p>Scout:
						<select style="width: 161px;" name="scouts">
							<option value=""></option>
							<?php
							$tsql = "select id, lastName + ', ' + firstName fullName from Scout where isActive = 'Y' order by lastName, firstName";
							$getResults = sqlsrv_query($conn, $tsql);
							if ($getResults == FALSE)
								echo (sqlsrv_errors());
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
								echo (sqlsrv_errors());
							while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
							?>
							<option value="<?php echo ($row['matchId']);?>"><?php echo ($row['matchNumber']);?></option>
							<?php		
							}
							?>
						</select>
					</p>
					<p></p>

					<p>Robot:
						<select name="robot" style="width: 154.5px;">
						<option value="<?php echo ($teamId);?>" selected><?php echo ($teamNumber);?></option>
						<?php
							$tsql = "select t.id, t.teamNumber from Team t inner join TeamGameEvent tge on tge.teamId = t.id inner join GameEvent ge on ge.id = tge.gameEventId where t.isActive = 'Y' and ge.isActive = 'Y' order by t.teamNumber";
							$getResults = sqlsrv_query($conn, $tsql);
							if ($getResults == FALSE)
								echo (sqlsrv_errors());
							while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
							?>
							<option value="<?php echo ($row['id']);?>"><?php echo ($row['teamNumber']);?></option>
							<?php		
							}
							?>
						</select>
					</p>					
					<p></p>

					<center><p><u>SANDSTORM</u></p></center>

						Did not leave HAB? <input type="radio" checked="checked" name="leaveHab" value="0"><br>
						Exit HAB Lvl 1? <input type="radio" name="leaveHab" value="1"><br>
						Exit HAB Lvl 2? <input type="radio" name="leaveHab" value="2"><br>

					<p>
						Hatch: <input type="number" name ="ssHatchCnt" value=0 style="width: 40.5px;">
						<p></p>
						Cargo: <input type="number" name="ssCargoCnt" value=0 style="width: 40px;">
					</p>
					<p></p>

					<p><u>POST-SANDSTORM</u></p>

					Hatch:
					<input type="number" name="toHatchCnt" min="0" value=0 style="width: 40px;">
					<p></p>

					Cargo:
					<input type="number" name="toCargoCnt" min="0" value=0 style="width: 40px;">
					<p></p>

					Defense:<br>
					No Defense? <input type="radio" checked="checked" name="defense" value="0"><br>
					Poor Defense? <input type="radio" name="defense" value="1"><br>
					Good Defense? <input type="radio" name="defense" value="2"><br>
					Best Defense? <input type="radio" name="defense" value="3">

					<p><u>END GAME</u></p>

					Did not return to HAB? <input type="radio" checked="checked" name="returnHab" value="0"><br>
					HAB Lvl 1? <input type="radio" name="returnHab" value="1"><br>
					HAB Lvl 2? <input type="radio" name="returnHab" value="2"><br>
					HAB Lvl 3? <input type="radio" name="returnHab" value="3">
					<p></p>
					<center><input type="submit" value="Submit" name="submitToDatabase"></center>
				</div>
            </center>

			<?php
			$submit = $POST[submitToDatabase];
			$scouts = $_POST[scouts];
			$match = $_POST[match];
			$robot = $_POST[robot];
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
