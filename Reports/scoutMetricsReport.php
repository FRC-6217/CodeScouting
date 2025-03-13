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
	$team = "$_GET[TeamId]";
	$loginEmailAddress = getenv("DefaultLoginEmailAddress");
	$tsql = "select scoutGUID from Scout where emailAddress = '$loginEmailAddress'";
    $getResults = sqlsrv_query($conn, $tsql);
    if ($getResults == FALSE)
		if( ($errors = sqlsrv_errors() ) != null) {
			foreach( $errors as $error ) {
				echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
				echo "code: ".$error[ 'code']."<br />";
				echo "message: ".$error[ 'message']."<br />";
			}
		}
	$row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC);
	$loginGUID = $row['scoutGUID'];
?>

<html>
  <head>
    <!--Load the Ajax API-->
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
  </head>
  <body>
     <meta name="viewport" content="width=device-width, initial-scale=1">
     <title>Scouting App</title>
     <link rel="stylesheet" type="text/css" href="/Style/scoutingStyle.css">
	 <center><a class="clickme danger" href="..\index6217.php">Home</a></center>
	<center><h1>Scout Metrics Report</h1></center>

<center><table cellspacing="0" cellpadding="5">
    <tr>
            <th>Scout</th>
            <th>Matches</th>
            <th>Earliest</th>
            <th>Latest</th>
    </tr>
<?php
$tsql = "select s.id, s.lastName, s.firstName, s.firstName + ' ' + s.lastName fullName, count(*) cnt, min(m.dateTime) earliest, max(m.dateTime) latest
            from v_GameEvent ge
                inner join Match m
                on m.gameEventId = ge.id
                inner join ScoutRecord sr
                on sr.matchId = m.id
                inner join Scout s
                on s.id = sr.scoutId
            where ge.loginGUID = '$loginGUID'
            and s.lastName <> 'TBA'
            group by s.id, s.lastName, s.firstName
            order by count(*) desc, s.lastName, s.firstName;";
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
			echo "<td>" . $row['fullName'] . "</td>";
			echo "<td>" . $row['count'] . "</td>";
			echo "<td>" . $row['earliest'] . "</td>";
			echo "<td>" . $row['latest'] . "</td>";
		echo "</tr>";
    }
    sqlsrv_free_stmt($getResults);

    sqlsrv_close($conn);
    ?>
	</center></table>
  </body>
</html>