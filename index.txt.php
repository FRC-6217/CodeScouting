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
						<input id="robotId" type = "number" name = "robotId" min = "0" style="width: 154.5px;">
					</p>					

					<center><p><u>SANDSTORM</u></p></center>

					<form name = "exitHab">
						Did not leave HAB? <input type = "radio" value = "didNotLeave"><br>
						Exit HAB Lvl 1? <input type = "radio" value = "leftFirstOne"><br>
						Exit HAB Lvl 2? <input type = "radio" value = "leftSecondOne"><br>
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
						Did not return to HAB? <input type = "radio" value = "returnToHab"><br>
						HAB Lvl 1? <input type = "radio"><br>
						HAB Lvl 2? <input type = "radio"><br>
						HAB Lvl 3? <input type = "radio">
					</form>

					<input type="submit" name = "imsorry">
				</div>
            </center>
<?php
echo "Hello World";
/*$webmaster_email = "19ka01@cf.k12.mn.us";
$scout = $_REQUEST["scouters"];
$whatCompetition = $_REQUEST["competition"];
$whatMatch = $_REQUEST["match"];
$whosBowlsAreThese = $_REQUEST["robotId"];
$letsYeet = $_REQUEST["exitHab"];
$hatch = $_REQUEST["ssHatchCnt"];
$cargo = $_REQUEST["ssCargoCnt"];
$psHatch = $_REQUEST["toHatchCnt"];
$psCargo = $_REQUEST["toCargoCnt"];
$defensiveStuff = $_REQUEST["defense"];
$etComeHome = $_REQUEST["returnToHab"];
$izzyImGonnaCry = $_REQUEST["imsorry"];

if ($izzyImGonnaCry){
$hereWeGo =
 $scout
. $whatCompetition  
. $whatMatch 
. $whosBowlsAreThese 
. $letsYeet 
. $hatch 
. $cargo 
. $psHatch 
. $psCargo 
. $defensiveStuff 
. $etComeHome  ;


$database = 'BLUDB';
$user = 'tdq92908';
$password = 'pdm95s6scjkj@vxd';
$options = array('autocommit' => DB2_AUTOCOMMIT_OFF);

$conn = db2_connect($database, $user, $password, $options);

if ($conn) {
    echo "Connection succeeded.\n";
    if (db2_autocommit($conn)) {
         echo "Autocommit is on.\n";
    }
    else {
         echo "Autocommit is off.\n";
    }
    db2_close($conn);
}
else {
    echo "Connection failed.";
}

mail("webmaster_email", "Testing", $hereWeGo);
}
else {
    header (failure);
}*/

/* DRE - this didn't work
$database = "BLUDB";
//$hostname = "dashdb-txn-sbox-yp-dal09-04.services.dal.bluemix.net";
//$port = 50000;
//$username = "tdq92908";
//$password = "ibmdb2";

$hostname = "dashdb-txn-sbox-yp-dal09-03.services.dal.bluemix.net";
$port = 50000;
$username = "rlc65450";
$password = "v2g2pdkwdx81dz+2";

$dsn = "DATABASE=$database;HOSTNAME=$hostname;PORT=$port; PROTOCOL=TCPIP;UID=$username;PWD=$password;";
$options = array ("autocommit" => DB2_AUTOCOMMIT_OFF);
//error below this point
$tc_conn = db2_connect($dsn, "", "", $options);
if($tc_conn) {
    echo "Explicit trusted connection succeeded.\n";

    db2_close($tc_conn);
}
else {
    echo "Explicit trusted connection failed.\n";
}
*/

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
    if( $conn )
    {
echo "Hello World 4";
        echo "<p>Connection succeeded.</p>";
        db2_close( $conn );
    }
    else
    {
echo "Hello World 5";
        echo "<p>Connection failed.</p>";
    }
}
else
{
echo "Hello World 6";
    echo "<p>No credentials.</p>";
}


echo "Hello World 10";
?>
        </form>
	</head>
</html>

