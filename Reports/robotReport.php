<html>
     <meta name="viewport" content="width=device-width, initial-scale=1">
     <title>Scouting App</title>
     <link rel="stylesheet" type="text/css" href="/Style/scoutingStyle.css">
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
<center><h1>Robot Report</h1></center>
<center><table cellspacing="0" cellpadding="5">
    <tr>
            <th>Team</th>
            <th>Match</th>
            <th>Time</th>
            <th>Scout</th>
            <th>Exit</th>
            <th>SSHatch</th>
            <th>SSCargo</th>
            <th>TotHatch</th>
            <th>TotCargo</th>
            <th>Defense</th>
            <th>Return</th>       
    </tr>

<?php
$team = "$_GET[TeamId]";
$tsql = "select TeamNumber
              , matchNumber
              , matchTime
              , scoutName
              , leaveHab
              , ssHatchCnt
              , ssCargoCnt
              , totHatchCnt
              , totCargoCnt
              , playedDefense
              , returnToHab
              , TeamId
              , matchId
              , scoutId
		   from v_TeamReport
          where TeamId = $team
		order by matchTime, matchNumber";
    $getResults = sqlsrv_query($conn, $tsql);
    if ($getResults == FALSE)
        echo (sqlsrv_errors());
    while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
?>
	<tr>
        <td><?php echo ($row['TeamNumber']);?></td>
        <td><?php echo ($row['matchNumber']);?></td>
        <td><?php echo xyz;?></td>
        <td><?php echo ($row['scoutName']);?></td>
        <td><?php echo ($row['leaveHab']);?></td>
        <td><?php echo ($row['ssHatchCnt']);?></td>
        <td><?php echo ($row['ssCargoCnt']);?></td>
        <td><?php echo ($row['totHatchCnt']);?></td>
        <td><?php echo ($row['totCargoCnt']);?></td>
        <td><?php echo ($row['playedDefense']);?></td>
        <td><?php echo ($row['returnToHab']);?></td>
	</tr>
    <?php
    }
    sqlsrv_free_stmt($getResults);
    ?>
    </center>
    </table>
</html>