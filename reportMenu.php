<title>Report Menu</title>
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
<html>
    <p>Match:
        <select style="width: 157px" name="match">
            <option value=""></option>
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
		<?php
		$gettingValue = $_POST[match];
		
		//There is nothing wrong with this chunk of code.
		$match = "$_GET[match]";
		echo "<a href=\"matchReport.php?matchId=".$match."\"> Run Match Report </a>";
		?>
    </p>      
</html>