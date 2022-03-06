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
	<center><h1>Match Audit Report</h1></center>

<center><table cellspacing="0" cellpadding="5">
    <tr>
            <th>Match</th>
            <th>Alliance</th>
            <th>Scout Score</th>
            <th>TBA Adj Score</th>
            <th>Delta Score</th>
            <th>Nbr Scout Recs</th>
    </tr>
<?php
$tsql = "select m.id matchId
		    , m.number matchNumber
			, case tm.alliance when 'R' then 'Red' else 'Blue' end alliance
			, sum(asor.avgScoreValue) scoutScoreValue
			, case when tm.alliance = 'R' then m.redScore - m.redFoulPoints - m.redAlliancePoints
					else m.blueScore - m.blueFoulPoints - m.blueAlliancePoints end tbaMatchAdjustedScore
			, sum(asor.avgScoreValue) -
			case when tm.alliance = 'R' then m.redScore - m.redFoulPoints - m.redAlliancePoints
					else m.blueScore - m.blueFoulPoints - m.blueAlliancePoints end matchScoreDelta
			, (select count(*)
				from scoutRecord sr
					inner join teamMatch tm2
					on tm2.matchId = sr.matchId
					and tm2.teamId = sr.teamId
					inner join scout s
					on s.id = sr.scoutId
				where sr.matchId = m.id
				and tm2.alliance = tm.alliance
				and s.lastName <> 'TBA') nbrSRs
		 from v_AvgScoutObjectiveRecord asor
			inner join TeamMatch tm
			on tm.matchId = asor.matchId
			and tm.teamId = asor.teamId
			inner join Match m
			on m.id = asor.matchId
			inner join v_GameEvent ge
			on ge.id = m.gameEventId
		where ge.loginGUID = '$loginGUID'
		  and m.isActive = 'Y'
		  and exists
			(select 1
				from ScoutRecord sr
					inner join Scout s
					on s.id = sr.scoutId
				where sr.matchId = tm.matchId
				and sr.teamId = tm.teamId
				and s.lastName <> 'TBA')
		group by m.id
			, m.dateTime
			, m.number
			, tm.alliance
			, case when tm.alliance = 'R' then m.redScore - m.redFoulPoints - m.redAlliancePoints
					else m.blueScore - m.blueFoulPoints - m.blueAlliancePoints end
		having sum(asor.avgScoreValue) <>
			case when tm.alliance = 'R' then m.redScore - m.redFoulPoints - m.redAlliancePoints
					else m.blueScore - m.blueFoulPoints - m.blueAlliancePoints end
		order by 6, m.datetime, tm.alliance;";
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
			echo "<td><a href='/Reports/matchReport6217.php?matchId=" . $row['matchId'] . "'>" . $row['matchNumber'] . "</a></td>";
			echo "<td>" . $row['alliance'] . "</td>";
			echo "<td>" . $row['scoutScoreValue'] . "</td>";
			echo "<td>" . $row['tbaMatchAdjustedScore'] . "</td>";
			echo "<td>" . $row['matchScoreDelta'] . "</td>";
			echo "<td>" . $row['nbrSRs'] . "</td>";
		echo "</tr>";
    }
    sqlsrv_free_stmt($getResults);
	sqlsrv_close($conn);
    ?>
  </body>
</html>