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
		
		<body>
			<h1><center>Bomb Botz Scouting App</center></h1>
		</body>
		<h2>
			<center><a id="buttons" class="clickme danger" href="index6217.php">Home</a>
			<a id="buttons" class="clickme danger" href="robotAttrList6217.php">Pit Scout</a></center>
		</h2>
		
		<form enctype="multipart/form-data" action='robotAttrConf6217.php' method='post'>
<?php
	# Reference autoload (assuming you're using Composer)
	require_once('vendor/autoload.php');

	use MicrosoftAzure\Storage\Blob\Models\CreateBlockBlobOptions;
	use MicrosoftAzure\Storage\Blob\Models\ListBlobsOptions;
	use MicrosoftAzure\Storage\Blob\BlobRestProxy;
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

    // Get Query String Parameters
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

	$teamId = "$_GET[teamId]";
	$teamNumber = "$_GET[teamNumber]";
	$teamName = "$_GET[teamName]";
	$location = "$_GET[location]";
?>
			<center>				
				<div class="container" id="scout">
					<?php
					echo "<p><u><b>Team " . $teamNumber . " - " . $teamName . "</b></u></p>";
					echo "<p>From " . $location . "</p>";
					echo '<input type="hidden" id="teamNumber" name="teamNumber" value="' . $teamNumber . '">'; 
					echo '<input type="hidden" id="teamId" name="teamId" value="' . $teamId . '">'; 
					$tsql = "select attributeName
								  , attributeLabel
								  , displayValue
								  , integerValue
								  , attributeSort
								  , attributeValueSort
								  , scoutTeamHtml
							   from v_EnterScoutTeamHTML
							  where loginGUID = '$loginGUID'
							    and teamId = $teamId
							 order by attributeSort, attributeValueSort";
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
						echo $row['scoutTeamHtml'];
					}
					sqlsrv_free_stmt($getResults);
					sqlsrv_close($conn);
					?>
					<p></p>
					<center>
						<input type="submit" value="Submit" name="submitToDatabase">
					</center>
				</div>
		<?php
			// Display current photo
			$storageAccountName = getenv("StorageAccountName");
			$containerName = getenv("StorageContainer");
			$accessKey = getenv("StorageAccessKey");
			# Setup Azure Storage connection
			$connectionString = "DefaultEndpointsProtocol=https;AccountName=$storageAccountName;AccountKey=$accessKey";
			try {
				$blobClient = BlobRestProxy::createBlobService($connectionString);
			}
			catch (Exception $e) {
				echo "Failed create Blob Service: " . $e . "<br />";
			}
			$key = '2025/' . $teamNumber . '/';
			$blobListOptions = new ListBlobsOptions();
			$blobListOptions->setPrefix($key);
			$blobList = $blobClient->listBlobs($containerName, $blobListOptions);
			foreach($blobList->getBlobs() as $key => $blob) {
				//echo "Blob ".$key.": \t".$blob->getName()."\t(".$blob->getUrl().")<br />";
				echo '<img class="image'.$key.'" src="'.$blob->getUrl().'" style="max-width: 75%;transform:rotate(90deg);padding : 20px;"><br />';
			}
		?>
            </center>
        </form>
	</head>
</html>
