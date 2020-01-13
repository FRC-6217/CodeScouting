<html>
     <meta name="viewport" content="width=device-width, initial-scale=1">
     <title>Scouting App</title>
     <link rel="stylesheet" type="text/css" href="Style/scoutingStyle.css">
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
        <meta name="msapplication-TileColor" content="#ffffff"
        <meta name="msapplication-TileImage" content="/Logo/ms-icon-144x144.png">
        <meta name="theme-color" content="#ffffff">
    </head>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <h1><center>Bomb Botz Scouting App</center></h1>
		<center><a href="index.php">Home</a></center>
    <p></p>
    <center><h3>
    </center> </h3>
    <br>
<?php
ini_set('display_errors', '1');

// Setup Blue Alliance API calls
$TBAAuthKey = getenv("TheBlueAllianceAuthKey");
$aHTTP['http']['method']  = 'GET';
$aHTTP['http']['header']  = 'X-TBA-Auth-Key: ' . $TBAAuthKey . '\r\n';
$aHTTP['http']['header'] .= 'Accept: application/json\r\n';
$context = stream_context_create($aHTTP);

// Get Event Matches from Blue Alliance
$sURL = "https://www.thebluealliance.com/api/v3/event/2019mndu/matches/simple";
$matchesJSON = file_get_contents($sURL, false, $context);
// Sort by Time
$matchesArray = json_decode($matchesJSON, true);
usort($matchesArray, function($a, $b) { //Sort the array using a user defined function
    return $a["time"] < $b["time"] ? -1 : 1; //Compare the time of match
});
// Display Match Info
foreach($matchesArray as $key => $value) {
	echo strtoupper($value["comp_level"]) . $value["match_number"] .
	     ", Time:" . gmdate("m/d/Y H:i", $value["time"]) .
	     ", Blue:" . $value["alliances"]["blue"]["score"] .
         ", Red:" . $value["alliances"]["red"]["score"];
    if ($value["alliances"]["blue"]["score"] > $value["alliances"]["red"]["score"]) echo "<strong>";
    echo ", B1:" . substr($value["alliances"]["blue"]["team_keys"][0], 3) .
         ", B2:" . substr($value["alliances"]["blue"]["team_keys"][1], 3) .
         ", B3:" . substr($value["alliances"]["blue"]["team_keys"][2], 3);
    if ($value["alliances"]["blue"]["score"] > $value["alliances"]["red"]["score"]) echo "</strong>";
    if ($value["alliances"]["blue"]["score"] < $value["alliances"]["red"]["score"]) echo "<strong>";
    echo ", R1:" . substr($value["alliances"]["red"]["team_keys"][0], 3) .
         ", R2:" . substr($value["alliances"]["red"]["team_keys"][1], 3) .
         ", R3:" . substr($value["alliances"]["red"]["team_keys"][2], 3);
    if ($value["alliances"]["blue"]["score"] < $value["alliances"]["red"]["score"]) echo "</strong>";
    echo "<br>";
}

// Get Event Teams from Blue Alliance
$sURL = "https://www.thebluealliance.com/api/v3/event/2020mndu/teams/simple";
$teamsJSON = file_get_contents($sURL, false, $context);
// Sort by Team Number
$teamsArray = json_decode($teamsJSON, true);
usort($teamsArray, function($a, $b) { //Sort the array using a user defined function
    return $a["team_number"] < $b["team_number"] ? -1 : 1; //Compare the team numbers
});
// Display Team Number, Name and Location
foreach($teamsArray as $key => $value) {
	echo $value["team_number"] . ", Name: " . $value["nickname"] . ", Location: " . $value["city"] . ", " . $value["state_prov"] . "<br>";
}

?>
</html> 
