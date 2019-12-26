<html>
     <meta name="viewport" content="width=device-width, initial-scale=1">
     <title>Scouting App</title>
     <link rel="stylesheet" type="text/css" href="Style/scoutingStyle.css">
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
?>
	<center><h1>Match Report</h1></center>
	<center><table cellspacing="0" cellpadding="5">
		<tr>
			<th>Alliance</th>
			<th>Robot</th>
			<th>Team</th>
			<th>Matches</th>
			<th>Exit</th>
			<th>SSHatch</th>
			<th>SSCargo</th>
			<th>TotHatch</th>
			<th>TotCargo</th>
			<th>Defense</th>
			<th>Return</th>
		</tr>

		<?php
		$match = "$_GET[matchId]";
		echo $match;
		?>
    <?php
    sqlsrv_free_stmt($getResults);
    ?>
    </center>
	</table>
</html>