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
    </head>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <h1><center>BOMB BOTZ SCOUTING APP</center></h1>
    <img class="image1" src="Flag/USA.png" style="max-width: 10%; float: left; border-radius: 100%;">
    <img class="image2" src="Flag/Brazil.png" style="max-width: 10%; float: right; border-radius: 100%;">
    <p></p>
    <h2>
          <center><a id="mainpage" class="clickme danger" href="scoutRecord.php">Scout Record</a></center>
          <p></p>
          <center><a id="mainpage" class="clickme danger" href="reportMenu.php">Reports</a></center>
          <p></p>
     </h2>
    <center><h3>
          <div id="reportsby"><a class="clickme danger" href="Reports/rankReport.php?sortorder=rankLeaveHab">Rank by Exit </a></div>
          <div id="reportsby"><a class="clickme danger" href="Reports/rankReport.php?sortorder=rankTotHatch">Rank by Hatches </a></div>
          <div id="reportsby"><a class="clickme danger" href="Reports/rankReport.php?sortorder=rankTotCargo">Rank by Cargo </a></div>
          <div id="reportsby"><a class="clickme danger" href="Reports/rankReport.php?sortorder=rankPlayedDefense">Rank by Defense </a></div>
          <div id="reportsby"><a class="clickme danger" href="Reports/rankReport.php?sortorder=rankReturnToHab">Rank by Return </a></div>
     </center> </h3>
    <br>

    <center><table cellspacing="0" cellpadding="5">
    <tr>
        <th>Match </th>
        <th>Red1</th>
        <th>R</th>
        <th>S</th>
        <th>Red2</th>
        <th>R</th>
        <th>S</th>
        <th>Red3</th>
        <th>R</th>
        <th>S</th>
        <th>Blue1</th>
        <th>R</th>
        <th>S</th>
        <th>Blue2</th>
        <th>R</th>
        <th>S</th>
        <th>Blue3</th>
        <th>R</th>
        <th>S</th>
     </tr>

    <?php
    $tsql = "select matchReportUrl, r1TeamNumber, r1TeamReportUrl, r1TeamScoutUrl, r2TeamNumber, r2TeamReportUrl, r2TeamScoutUrl, r3TeamNumber, r3TeamReportUrl, r3TeamScoutUrl, b1TeamNumber, b1TeamReportUrl, b1TeamScoutUrl, b2TeamNumber, b2TeamReportUrl, b2TeamScoutUrl, b3TeamNumber, b3TeamReportUrl, b3TeamScoutUrl, sortOrder, matchNumber, matchId, r1TeamId, r2TeamId, r3TeamId, b1TeamId, b2TeamId, b3TeamId from v_MatchHyperlinks order by sortOrder, matchNumber";
    $getResults = sqlsrv_query($conn, $tsql);
    if ($getResults == FALSE)
        echo (sqlsrv_errors());
    while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
        ?>
       <tr>
           <td><?php echo ($row['matchReportUrl']);?></td>
           <td><?php echo ($row['r1TeamNumber']);?></td>
           <td><?php echo ($row['r1TeamReportUrl']);?></td>
           <td><?php echo ($row['r1TeamScoutUrl']);?></td>
           <td><?php echo ($row['r2TeamNumber']);?></td>
           <td><?php echo ($row['r2TeamReportUrl']);?></td>
           <td><?php echo ($row['r2TeamScoutUrl']);?></td>
           <td><?php echo ($row['r3TeamNumber']);?></td>
           <td><?php echo ($row['r3TeamReportUrl']);?></td>
           <td><?php echo ($row['r3TeamScoutUrl']);?></td>
           <td><?php echo ($row['b1TeamNumber']);?></td>
           <td><?php echo ($row['b1TeamReportUrl']);?></td>
           <td><?php echo ($row['b1TeamScoutUrl']);?></td>
           <td><?php echo ($row['b2TeamNumber']);?></td>
           <td><?php echo ($row['b2TeamReportUrl']);?></td>
           <td><?php echo ($row['b2TeamScoutUrl']);?></td>
           <td><?php echo ($row['b3TeamNumber']);?></td>
           <td><?php echo ($row['b3TeamReportUrl']);?></td>
           <td><?php echo ($row['b3TeamScoutUrl']);?></td>
        </tr>
    <?php
    }
    sqlsrv_free_stmt($getResults);
    ?>
    </table>
	</center>
</html> 
