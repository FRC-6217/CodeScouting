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

				if($conn) {
					echo "<p>Connection succeeded.</p>";
					//db2_close( $conn );
				}
				else {
					echo "<p>Connection failed.</p>";
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
			$exitHab = $_POST[exitHab];
			$ssHatchCnt = $_POST[ssHatchCnt];
			$ssCargoCnt = $_POST[ssCargoCnt];
			$toHatchCnt = $_POST[toHatchCnt];
			$toCargoCnt = $_POST[toCargoCnt];
			$defense = $_POST[defense];
			$returnToHab = $_POST[returnToHab];

if(isset($defense)) {
	$def = "Y";
}
else {
	$def = "N";
}
$insertingData = "INSERT into scoutrecord (matchId, robotId, scoutId, leavehab, sshatchcnt, sscargocnt, tohatchcnt, tocargocnt, playedDefense, returnToHab) values ($match, $robot, $scouters, '$exitHab', $ssHatchCnt, $ssCargoCnt, $toHatchCnt, $toCargoCnt, '$def', '$returnToHab');";

//$insertingData = "INSERT into scoutrecord (matchId, robotId, scoutId, leavehab, sshatchcnt, sscargocnt, tohatchcnt, tocargocnt, playedDefense, returnToHab) values (8, 4, 1, 'Y', 5, 2, 10, 0, 'Y', '0');";
$executing = db2_exec($conn, $insertingData);

if($executing) {
    echo "It is working!";
}

else {
    $errormsg = db2_conn_errormsg($conn);
    echo $errormsg;
    echo "It is not working \n";
    echo $insertingData;
}
db2_close( $conn );
?>