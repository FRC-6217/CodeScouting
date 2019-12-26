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
<center><h1>Rank Report</h1></center>
<center>
    <table cellspacing="0" cellpadding="5">
        <tr>
            <th>Team</th>
            <th>AVG</th>
            <th>Exit</th>
            <th>Hatches</th>
            <th>Cargo</th>
            <th>Defense</th>
            <th>Return</th>
            <th>Exit</th>
            <th>Hatches</th>
            <th>Cargo</th>
            <th>Defense</th>
            <th>Return</th>
        </tr>
<?php
$sort = "$_GET[sortOrder]";
$tsql = "select TeamNumber
              , TeamName
              , avgRank
              , rankLeaveHab
              , rankReturnToHab
              , rankSsHatch
              , rankSsCargo
              , rankTotHatch
              , rankTotCargo
              , rankPlayedDefense
              , leaveHab
              , returnToHab
              , ssHatch
              , ssCargo
              , totHatch
              , totCargo
              , playedDefense
           from v_TeamAvgRank
		order by $sort";
    $getResults = sqlsrv_query($conn, $tsql);
    if ($getResults == FALSE)
        echo (sqlsrv_errors());
    while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
?>
        <tr>
            <td><?php echo ($row['TeamNumber']);?></td>
            <td><?php echo ($row['avgRank']);?></td>
            <td><?php echo ($row['rankLeaveHab']);?></td>
            <td><?php echo ($row['rankTotHatch']);?></td>
            <td><?php echo ($row['rankTotCargo']);?></td>
            <td><?php echo ($row['rankPlayedDefense']);?></td>
            <td><?php echo ($row['rankReturnToHab']);?></td>
            <td><?php echo ($row['leaveHab']);?></td>
            <td><?php echo ($row['totHatch']);?></td>
            <td><?php echo ($row['totCargo']);?></td>
            <td><?php echo ($row['playedDefense']);?></td>
            <td><?php echo ($row['returnToHab']);?></td>
        </tr>
        <?php
        }
        db2_close();
        ?>
    </table>
</center>
</html>