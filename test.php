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
        <meta name="msapplication-TileColor" content="#ffffff">
        <meta name="msapplication-TileImage" content="/Logo/ms-icon-144x144.png">
        <meta name="theme-color" content="#ffffff">
		<meta name="viewport" content="width=device-width, initial-scale=1">
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
        <link rel="stylesheet" type="text/css" href="Style/jquery.countdown.css"> 
        <script type="text/javascript" src="js/jquery.plugin.js"></script> 
        <script type="text/javascript" src="js/jquery.countdown.js"></script>
        <style type="text/css">
            body > iframe { display: none; }
            #defaultCountdown { width: 180px; height: 45px; }
        </style>
        <script>
            $(function () {
                var austDay = new Date('2025-03-14 17:00:00');
                $('#defaultCountdown').countdown({until: austDay, format: 'HMS'});
            });
        </script>
        <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/smoothness/jquery-ui.css">
        <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
        <script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script>
</head>
    </head>
    <body>
        <h1><center>Bomb Botz Scouting App</center></h1>
    </body>
    <center><a class="clickme danger" href="index6217.php">Home</a></center>
    
    <div id="defaultCountdown"></div>
    <input id="spinner1" name ="value1" min="0" max="6" value="1" style="width: 30px;"><script>$( "#spinner1" ).spinner();</script>
    <input id="spinner2" name ="value2" min="0" max="12" value="2" style="width: 30px;"><script>$( "#spinner2" ).spinner();</script>

    <a href="/.auth/login/google?post_login_redirect_uri=/index6217.php">Log in with Google</a>

<?php
    $loginURL = '/.auth/me';
    $data = json_decode(file_get_contents($loginURL), true);

    if ($data != null && json_last_error() !== JSON_ERROR_NONE) {
        echo "Error decoding JSON: " . json_last_error_msg();
    } else {
        echo "Hello " . $data[0]["user_claims"][7]["val"];
        echo "<br>Your email is " . $data[0]["user_claims"][4]["val"];
    }
?>

</html>  




