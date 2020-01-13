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
	echo ini_set('display_errors', '1');
	echo ini_get('display_errors');

$sURL = "https://www.thebluealliance.com/api/v3/event/2020mndu/teams/simple"; // The POST URL

$aHTTP['http']['method']  = 'GET';
$aHTTP['http']['header']  = "X-TBA-Auth-Key: N4Z1bSR1oaDFECjDNV3wp1zAqUY0LCI4OZyL1nVCg2K5yfsV3JAy9OBuJgEKYQ7M\r\n";
$aHTTP['http']['header'] .= "Accept: application/json\r\n";

$context = stream_context_create($aHTTP);
$contents = file_get_contents($sURL, false, $context);

echo $contents;

    $response = http_get('https://www.thebluealliance.com/api/v3/event/2020mndu/teams'
	                   , array('headers' =>
					           array('X-TBA-Auth-Key' => 'N4Z1bSR1oaDFECjDNV3wp1zAqUY0LCI4OZyL1nVCg2K5yfsV3JAy9OBuJgEKYQ7M'
							        ,'Accept' => 'application/json')), $info);
	print_r($response);
	print_r($info);
	echo($info);
	echo($response);
	var_dump(json_decode($info));
	var_dump(json_decode($info, true));
?>
</html> 
