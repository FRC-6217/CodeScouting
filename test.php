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
        <meta name="google-signin-client_id" content="521347466058-vnmcclmps4a1galclba7jq6rpkj813ca.apps.googleusercontent.com">
		<script>
			function start() {
			gapi.load('auth2', function() {
				auth2 = gapi.auth2.init({
				client_id: '521347466058-vnmcclmps4a1galclba7jq6rpkj813ca.apps.googleusercontent.com',
				});
			});
			}
		</script>
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

	<button id="signinButton">Sign in with Google</button>
	<script>
	$('#signinButton').click(function() {
		// signInCallback defined in step 6.
		auth2.grantOfflineAccess().then(signInCallback);
	});
	</script>

<div>
        <?php
            $email = $_SERVER['HTTP_X_MS_CLIENT_PRINCIPAL_NAME'] ?? null;
            $user = $_SERVER['HTTP_X_MS_CLIENT_PRINCIPAL'] ?? null;

            echo "Hello " . $user . "<br>";
            echo "Your email is " . $email . "<br>";
        ?>
    </div>

	<script>
		function signInCallback(authResult) {
			if (authResult['code']) {

				// Hide the sign-in button now that the user is authorized, for example:
				$('#signinButton').attr('style', 'display: none');
				// Send the code to the server
				$.ajax({
				type: 'POST',
				url: 'http://example.com/storeauthcode',
				// Always include an `X-Requested-With` header in every AJAX request,
				// to protect against CSRF attacks.
				headers: {
					'X-Requested-With': 'XMLHttpRequest'
				},
				contentType: 'application/octet-stream; charset=utf-8',
				success: function(result) {
					// Handle or verify the server response.
				},
				processData: false,
				data: authResult['code']
				});
			}
			else {
				// There was an error.
			}
		}
	</script>
</html>  




