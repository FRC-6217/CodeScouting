<?php
if( getenv( "VCAP_SERVICES" ) )
			{
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
				
				$conn = db2_connect($conn_string, "", "" );

				if(!$conn) {
					echo "<p>Connection failed.</p>";
					//echo "<p>Connection succeeded.</p>";
					//db2_close( $conn );
				}

			}
			else {
				echo "<p>No credentials.</p>";
			}

			$submit = $POST[submitToDatabase];
			$scouters = $_POST[scouters];
			$competition = $_POST[competition];
			$match = $_POST[match];
			$robot = $_POST[robot];
			$leaveHab = $_POST[leaveHab];
			$ssHatchCnt = $_POST[ssHatchCnt];
			$ssCargoCnt = $_POST[ssCargoCnt];
			$toHatchCnt = $_POST[toHatchCnt];
			$toCargoCnt = $_POST[toCargoCnt];
			$defense = $_POST[defense];
			$returnHab = $_POST[returnHab];

			if(isset($leaveHab)) {
				$lev = $leaveHab;
			}
			else {
				$lev = "N";
			}

			if(isset($defense)) {
				$def = $defense;
			}
			else {
				$def = "N";
			}

			if(isset($returnHab)) {
				$ret = $returnHab;
			}
			else {
				$ret = "N";
			}

$insertingData = "INSERT into scoutrecord (matchId, robotId, scoutId, leaveHAB, ssHatchCnt, ssCargoCnt, toHatchCnt, toCargoCnt, playedDefense, returnToHAB) values ($match, $robot, $scouters, '$lev', $ssHatchCnt, $ssCargoCnt, $toHatchCnt, $toCargoCnt, '$def', '$ret');";

$executing = db2_exec($conn, $insertingData);

if($executing) {
	echo "Submittion Succeeded!";
}

if(!$executing) {
	echo "It is not working!";
}

db2_close( $conn );
?>
<html>
	<center><a href="scoutRecord.php">Click here to go back to the Scout Record page! </a></center>
</html>