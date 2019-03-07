<!DOCTYPE html>
<title>Scouting App</title>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<body>
			<h1><center>BOMB BOTZ SCOUTING APP</center></h1>
		</body>
		
		<link rel="stylesheet" type="text/css" href="scoutingCSS.css">
		
		<form>
			<center>				
				<div class="container">
					<p><u>MATCH SELECTION</u></p>

					<p>Scout:
						<select style="width: 161px;" name= "scouters">
							<option value=""></option>
							<option value="Katie"> Katie Allen </option>
							<option value="Kristy"> Kristy Allen </option>
							<option value="Sam"> Sam Auger </option>
							<option value="Sanskar"> Sanskar Bhakta </option>
							<option value="Samuel"> Samuel Coyle </option>
							<option value="Alex"> Alex Deutsch </option>
							<option value="Nick"> Nick Engebretsen </option>
							<option value="Nathaniel"> Nathaniel Garret </option>
							<option value="Matthew"> Matthew Giese </option>
							<option value="Tucker"> Tucker Jacobson </option>
							<option value="Zoe"> Zoe Jesh </option>
							<option value="Kris"> Kris Kehrberg </option>
							<option value="Wyatt"> Wyatt Klavon </option>
							<option value="Ella"> Ella Miller </option>
							<option value="Preston"> Preston Parks </option>
							<option value="Ryan"> Ryan Schlichting </option>
							<option value="Izzy"> Izzy Souza </option>
							<option value="Lena"> Lena Stadlinger </option>
							<option value="Tom"> Tom Sucher </option>
							<option value="Xander"> Xander Weinreich </option>
							<option value="Ethan"> Ethan White </option>
							<option value="Isaiah"> Isaiah Wildenberg </option>
						</select>
					</p>
					<p></p>
					
					<p> Competition:
						<select style="width: 117.5px" name= "competition">
							<option value="none"> </option>
							<option value="duluth"> Lake Superior Regional </option>
							<option value="iowa"> Iowa Regional </option>
						</select>
					</p>

					<p>Match:
						<select style="width: 157px" name="match">
							<option value = "none"></option>
							<option value = "qualifying"> Qualifying 1 </option>
						</select>
					</p>

					<p>Robot:
						<input id="robotId" type = "number" name = "robot" min = "0" style="width: 154.5px;">
					</p>					

					<center><p><u>SANDSTORM</u></p></center>

					<form name = "exitHab">
						Did not leave HAB? <input type = "radio" name="leave" value = "didNotLeave"><br>
						Exit HAB Lvl 1? <input type = "radio" name="leave" value = "leftFirstOne"><br>
						Exit HAB Lvl 2? <input type = "radio" name="leave" value = "leftSecondOne"><br>
					</form>

					<p>
						<form id="hatchCargo">
							Hatch: <input type="number" name ="ssHatchCnt" value="hatches" style="width: 40.5px;">
							<p></p>
							Cargo: <input type="number" name="ssCargoCnt" value="cargo" style="width: 40px;">
						</form>
					</p>
					<p></p>

					<p><u>POST-SANDSTORM</u></p>

					Hatch:
					<input type = "number" name = "toHatchCnt" min = "0" style="width: 40px;">
					<p></p>

					Cargo:
					<input type = "number" name = "toCargoCnt" min = "0" style="width: 40px;">
					<p></p>

					Defense:
					<input type = "checkbox" name = "defense">

					<p><u>END GAME</u></p>

					<form name= "returnToHab">
						Did not return to HAB? <input type = "radio" name="return" value = "returnToHab"><br>
						HAB Lvl 1? <input type = "radio" name="return"><br>
						HAB Lvl 2? <input type = "radio" name="return"><br>
						HAB Lvl 3? <input type = "radio" name="return">
					</form>

					<input type="submit" value="Submit" name = "submitToDatabase">
				</div>
            </center>
<?php

echo "Hello World 2";
if( getenv( "VCAP_SERVICES" ) )
{
echo "Hello World 3";
    # Get database details from the VCAP_SERVICES environment variable
    #
    # *This can only work if you have used the Bluemix dashboard to 
    # create a connection from your dashDB service to your PHP App.
    #
    $details  = json_decode( getenv( "VCAP_SERVICES" ), true );
    $dsn      = $details [ "dashDB For Transactions" ][0][ "credentials" ][ "dsn" ];
    $ssl_dsn  = $details [ "dashDB For Transactions" ][0][ "credentials" ][ "ssldsn" ];

    # Build the connection string
    #
    $driver = "DRIVER={IBM DB2 ODBC DRIVER};";
    $conn_string = $driver . $dsn;     # Non-SSL
    $conn_string = $driver . $ssl_dsn; # SSL

	echo "Hello World 3B";
	
	$conn = db2_connect( $conn_string, "", "" );
	echo "Hello World 3C";
    if( $conn ) {
		echo "Hello World 4";
        echo "<p>Connection succeeded.</p>";
        db2_close( $conn );
    }
    else {
		echo "Hello World 5";
        echo "<p>Connection failed.</p>";
    }
}
else {
	echo "Hello World 6";
    echo "<p>No credentials.</p>";
}

$submit = $POST['submitToDatabase'];
$scouters = $_POST['scouters'];
$competition = $_POST['competition'];
$match = $_POST['match'];
$robot = $_POST['robot'];
$exitHab = $_POST['exitHab'];
$ssHatchCnt = $_POST['ssHatchCnt'];
$ssCargoCnt = $_POST['ssCargoCnt'];
$toHatchCnt = $_POST['toHatchCnt'];
$toCargoCnt = $_POST['toCargoCnt'];
$defense = $_POST['defense'];
$returnToHab = $_POST['returnToHab'];

echo $_POST['competition'];
echo $competition;

//problem here
$sending = db2_exec($conn, "INSERT INTO ScoutRecord (matchId, robotId, scoutId, leaveHAB, ssHatchCnt, ssCargoCnt, toHatchCnt, toCargoCnt, playedDefense, returnToHAB) VALUES ('$match', '$robot', '$scouters', '$exitHab', '$ssHatchCnt', '$ssCargoCnt', '$toHatchCnt', '$toCargoCnt', '$defense', '$returnToHab')");
//$testing = db2_exec($conn, "INSERT INTO ScoutRecord (matchId, robotId, scoutId, leaveHAB, ssHatchCnt, ssCargoCnt, toHatchCnt, toCargoCnt, playedDefense, returnToHAB) values($_POST[match], $_POST[robot], $_POST[scouters], $_POST[exitHab], $_POST[ssHatchCnt], $_POST[ssCargoCnt], $_POST[toHatchCnt], $_POST[toCargoCnt], $_POST[defense], $_POST[returnToHab])");

if($sending) {
	echo "It is working";
}
else {
	echo db2_stmt_error();
	echo db2_stmt_errormsg();
	echo "nope";
}

echo "Hello World 10";
?>
        </form>
	</head>
</html>

