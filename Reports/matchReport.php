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
		$tsql = "select matchNumber
                      , matchId
				 	  , teamId
				 	  , TeamNumber
					  , alliance
					  , alliancePosition
					  , teamReportUrl
					  , matchCnt
					  , leaveHabAvg
					  , ssHatchCnt
					  , ssCargoCnt
					  , totHatchCnt
					  , totCargoCnt
					  , playedDefense
					  , returnToHab
                   from v_MatchReport
				  where matchId = $match
				 order by alliance desc, alliancePosition";
    $getResults = sqlsrv_query($conn, $tsql);
    if ($getResults == FALSE)
        echo (sqlsrv_errors());
    while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
        ?>
		<tr>
           <td><?php echo ($row['alliance']);?></td>
           <td><?php echo ($row['alliancePosition']);?></td>
           <td><?php echo ($row['teamReportUrl']);?></td>
           <td><?php echo ($row['matchCnt']);?></td>
           <td><?php echo ($row['leaveHabAvg']);?></td>
           <td><?php echo ($row['ssHatchCnt']);?></td>
           <td><?php echo ($row['ssCargoCnt']);?></td>
           <td><?php echo ($row['totHatchCnt']);?></td>
           <td><?php echo ($row['totCargoCnt']);?></td>
        </tr>
    <?php
    }
    sqlsrv_free_stmt($getResults);
    ?>
    </center>
    </table>
</html>