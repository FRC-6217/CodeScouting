<!DOCTYPE html>
<title>Scouting App</title>

<link rel="stylesheet" type="text/css" href="Style/scoutingStyle.css">
<html>
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
		<link rel="stylesheet" type="text/css" href="scoutingCSS.css">
		
		<form action='confirmation.php' method='post'>
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
					//db2_close( $conn );
				}

			}
			else {
				echo "<p>No credentials.</p>";
			}
			?>
			<center>				
				<div class="container" id="scout">
					<p><u>MATCH SELECTION</u></p>

					<p>Scout:
						
						<select style="width: 161px;" name="scouters">
							<option value=""></option>
							<?php
							$sql = "SELECT id, lastname || ', ' || firstname FROM scout order by lastname, firstname;";
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
							<?php
							$sql = "SELECT id, name from competition order by case when competitiondate - current date + 3 < 0 then 1 else 0 end, competitiondate;";
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
							<option value="<?php echo "$_GET[matchId]"?>"><?php echo "$_GET[matchNumber]"?></option>
							<?php
							$sql = "SELECT id, type || ' ' || number FROM match order by case when timestampdiff(4, datetime - current timestamp) + 330 < 0 then 1 else 0 end,  type, number;";
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

			//I have no idea what does this do;
			echo $_POST['competition'];
			echo $competition;

			db2_close($conn);
			?>
        </form>
	</head>
</html>