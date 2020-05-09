<html>
     <meta name="viewport" content="width=device-width, initial-scale=1">
	 <script src="https://apis.google.com/js/platform.js" async defer></script>
     <title>Scouting App</title>
     <link rel="stylesheet" type="text/css" href="Style/scoutingStyle.css">
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
?>
    <head>
        <link rel="apple-touch-icon" sizes="57x57" href="/Logo/apple-icon-57x57.png">
        <link rel="apple-touch-icon" sizes="60x60" href="/Logo/apple-icon-60x60.png">
        <link rel="apple-touch-icon" sizes="72x72" href="/Logo/apple-icon-72x72.png">
        <link rel="apple-touch-icon" sizes="76x76" href="/Logo/apple-icon-76x76.png">
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
    </head>

    <h2>
          <center><a class="clickme danger" href="index.php">Home</a></center>
          <p></p>
     </h2>
	 
<center><h1>Robot Attributes</h1></center>
<center>

    <br>
	<center><div class="g-signin2" data-onsuccess="onSignIn"></div></center>
	<br>
	<center><table cellspacing="0" cellpadding="5">
    <tr>
        <th>Team</th>
      	<?php
			// Display table headers for robot attributes
			$tsql = "select a.tableheader
					   from Attribute a
							inner join v_GameEvent ge
							on ge.gameId = a.gameId
                      where ge.scoutEmailAddress = 'golfrat7@gmail.com'
					 order by a.sortOrder";
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
				echo "<th>" . $row['tableheader'] . "</th>";
			}
			sqlsrv_free_stmt($getResults);
			?>
     </tr>

    <?php
    $tsql = "select teamUrl
	              , teamNumber
	              , teamId
				  , attrValue1
				  , attrValue2
				  , attrValue3
				  , attrValue4
				  , attrValue5
				  , attrValue6
				  , attrValue7
				  , attrValue8
				  , attrValue9
				  , attrValue10
               from v_ScoutTeamHyperlinks
              where scoutEmailAddress = 'golfrat7@gmail.com'
			 order by teamNumber";
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
       echo "<tr>";
			echo "<td>" . $row['teamUrl'] . "</td>";
			if (isset($row['attrValue1'])) echo "<td>" . $row['attrValue1'] . "</td>";
			if (isset($row['attrValue2'])) echo "<td>" . $row['attrValue2'] . "</td>";
			if (isset($row['attrValue3'])) echo "<td>" . $row['attrValue3'] . "</td>";
			if (isset($row['attrValue4'])) echo "<td>" . $row['attrValue4'] . "</td>";
			if (isset($row['attrValue5'])) echo "<td>" . $row['attrValue5'] . "</td>";
			if (isset($row['attrValue6'])) echo "<td>" . $row['attrValue6'] . "</td>";
			if (isset($row['attrValue7'])) echo "<td>" . $row['attrValue7'] . "</td>";
			if (isset($row['attrValue8'])) echo "<td>" . $row['attrValue8'] . "</td>";
			if (isset($row['attrValue9'])) echo "<td>" . $row['attrValue9'] . "</td>";
			if (isset($row['attrValue10'])) echo "<td>" . $row['attrValue10'] . "</td>";
       echo "</tr>";
    }
    sqlsrv_free_stmt($getResults);
	sqlsrv_close($conn);
    ?>
    </table>
	</center>
</html> 
