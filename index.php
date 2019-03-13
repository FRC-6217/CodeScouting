<!DOCTYPE html>
<title>Scouting App</title>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<body>
			<h1><center>BOMB BOTZ SCOUTING APP</center></h1>
		</body>
		<link rel="stylesheet" type="text/css" href="scoutingCSS.css">
		
		<form action='confirmation.php' method='post'>
		<!--<form action='confirmform.php' method='post' onsubmit='return checkform(this);'> -->
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
			?>
			<center>				
				<div class="container">
					<p><u>MATCH SELECTION</u></p>

					<p>Scout:
						
						<select style="width: 161px;" name="scouters">
							<option value=""></option>
							<?php
							$sql = "SELECT id, lastname || ', ' || firstname FROM scout order by firstname, lastname;";
							$stmt = db2_exec($conn, $sql, array('cursor' => DB2_SCROLLABLE));
							while ($row = db2_fetch_array($stmt)) {	
							?>
							<option value="<?php echo "$row[0]" ;?>"><?php echo "$row[1]" ; ?></option>

							<?php		
							}
							?>
							
						</select>
						</p>

					<p></p>
					
					<p> Competition:
						<select style="width: 117.5px" name="competition">
							<option value=""> </option>
							<?php
							$sql = "SELECT id, name FROM competition order by name;";
							$stmt = db2_exec($conn, $sql, array('cursor' => DB2_SCROLLABLE));
							while ($row = db2_fetch_array($stmt)) {	
							?>
							<option value="<?php echo "$row[0]" ;?>"><?php echo "$row[1]" ; ?></option>

							<?php		
							}
							?>

						</select>
					</p>

					<p></p>

					<p>Match:
						<select style="width: 157px" name="match">
							<option value=""></option>
							<?php
							$sql = "SELECT id, type || ' ' || number FROM match order by type, number;";
							$stmt = db2_exec($conn, $sql, array('cursor' => DB2_SCROLLABLE));
							while ($row = db2_fetch_array($stmt)) {	
							?>
							<option value="<?php echo "$row[0]" ;?>"><?php echo "$row[1]" ; ?></option>

							<?php		
							}
							?>
						</select>
					</p>

					<p></p>

					<p>Robot:
						<select name="robot" style="width: 154.5px;">
						<option value = ""></option>
						<?php
							$sql = "SELECT id, teamnumber FROM robot order by teamnumber;";
							$stmt = db2_exec($conn, $sql, array('cursor' => DB2_SCROLLABLE));
							while ($row = db2_fetch_array($stmt)) {	
							?>
							<option value="<?php echo "$row[0]" ;?>"><?php echo "$row[1]" ; ?></option>

							<?php		
							}
							?>
						</select>
					</p>					
					<p></p>

					<center><p><u>SANDSTORM</u></p></center>

					<form name="exitHab">
						Did not leave HAB? <input type="radio" name="leave" value="0"><br>
						Exit HAB Lvl 1? <input type="radio" name="leave" value="1"><br>
						Exit HAB Lvl 2? <input type="radio" name="leave" value="2"><br>
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
					<input type="number" name="toHatchCnt" min="0" style="width: 40px;">
					<p></p>

					Cargo:
					<input type="number" name="toCargoCnt" min="0" style="width: 40px;">
					<p></p>

					Defense:
					<input type="checkbox" name="defense">

					<p><u>END GAME</u></p>

					<form name= "returnToHab">
						Did not return to HAB? <input type="radio" name="return" value="0"><br>
						HAB Lvl 1? <input type="radio" name="return" value="1"><br>
						HAB Lvl 2? <input type="radio" name="return" value="2"><br>
						HAB Lvl 3? <input type="radio" name="return" value="3">
					</form>
					<p></p>
					<center><input type="submit" value="Submit" name="submitToDatabase"></center>
				</div>
            </center>

			<?php
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

			echo $_POST['competition'];
			echo $competition;

			//problem here
			//$sending = db2_exec($conn, "INSERT INTO ScoutRecord (matchId, robotId, scoutId, leaveHAB, ssHatchCnt, ssCargoCnt, toHatchCnt, toCargoCnt, playedDefense, returnToHAB) VALUES ('$match', '$robot', '$scouters', '$exitHab', '$ssHatchCnt', '$ssCargoCnt', '$toHatchCnt', '$toCargoCnt', '$defense', '$returnToHab')");
			//$testing = db2_exec($conn, "INSERT INTO ScoutRecord (matchId, robotId, scoutId, leaveHAB, ssHatchCnt, ssCargoCnt, toHatchCnt, toCargoCnt, playedDefense, returnToHAB) values($_POST[match], $_POST[robot], $_POST[scouters], $_POST[exitHab], $_POST[ssHatchCnt], $_POST[ssCargoCnt], $_POST[toHatchCnt], $_POST[toCargoCnt], $_POST[defense], $_POST[returnToHab])");
			?>
        </form>
	</head>
</html>

