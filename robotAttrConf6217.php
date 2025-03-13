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
		<p></p>
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

    // Get posted variables
	$teamId = $_POST['teamId'];
	$teamNumber = $_POST['teamNumber'];
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
	$scoutId1 = $_POST['scoutId1'];
	$scoutId2 = $_POST['scoutId2'];
	$scoutId3 = $_POST['scoutId3'];
	$value1 = $_POST['value1'];
	$value2 = $_POST['value2'];
	$value3 = $_POST['value3'];
	$value4 = $_POST['value4'];
	$value5 = $_POST['value5'];
	$value6 = $_POST['value6'];
	$value7 = $_POST['value7'];
	$value8 = $_POST['value8'];
	$value9 = $_POST['value9'];
	$value10 = $_POST['value10'];
	$value11 = $_POST['value11'];
	$value12 = $_POST['value12'];
	$value13 = $_POST['value13'];
	$value14 = $_POST['value14'];
	$value15 = $_POST['value15'];
	$value16 = $_POST['value16'];
	$value17 = $_POST['value17'];
	$value18 = $_POST['value18'];
	$value19 = $_POST['value19'];
	$value20 = $_POST['value20'];
?>
	<p></p>
	<h2>
		<center><a id="buttons" class="clickme danger" href="index6217.php">Home</a>
			    <a id="buttons" class="clickme danger" href="robotAttrList6217.php">Pit Scout</a></center>
	</h2>
<?php
    $tsql = "sp_ins_scoutRobot $teamId, '$loginGUID', $scoutId1, $scoutId2, $scoutId3, '$value1'";
	if (isset($value2))
		$tsql .= ", '$value2'";
	if (isset($value3))
		$tsql .= ", '$value3'";
	if (isset($value4))
		$tsql .= ", '$value4'";
	if (isset($value5))
		$tsql .= ", '$value5'";
	if (isset($value6))
		$tsql .= ", '$value6'";
	if (isset($value7))
		$tsql .= ", '$value7'";
	if (isset($value8))
		$tsql .= ", '$value8'";
	if (isset($value9))
		$tsql .= ", '$value9'";
	if (isset($value10))
		$tsql .= ", '$value10'";
	if (isset($value11))
		$tsql .= ", '$value11'";
	if (isset($value12))
		$tsql .= ", '$value12'";
	if (isset($value13))
		$tsql .= ", '$value13'";
	if (isset($value14))
		$tsql .= ", '$value14'";
	if (isset($value15))
		$tsql .= ", '$value15'";
	if (isset($value16))
		$tsql .= ", '$value16'";
	if (isset($value17))
		$tsql .= ", '$value17'";
	if (isset($value18))
		$tsql .= ", '$value18'";
	if (isset($value19))
		$tsql .= ", '$value19'";
	if (isset($value20))
		$tsql .= ", '$value20'";
	$results = sqlsrv_query($conn, $tsql);
	if($results) 
		echo "<p></p><center>Submission Succeeded!</center>";
	
	if(!$results) 
	{
		echo "It is not working!<br />";
		if( ($errors = sqlsrv_errors() ) != null) {
			foreach( $errors as $error ) {
				echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
				echo "code: ".$error[ 'code']."<br />";
				echo "message: ".$error[ 'message']."<br />";
			}
		}
	}		
	?>
	<p></p>
	<form enctype="multipart/form-data" action='./photoUpload.php' method='post'>
		Select image to upload:
		<input type="file" name="fileToUpload" id="fileToUpload">
		<input type="submit" value="Upload Image" name="submit">
<?php
		echo '<input type="hidden" id="teamNumber" name="teamNumber" value="' . $teamNumber . '">'; 
		echo '<input type="hidden" id="teamId" name="teamId" value="' . $teamId . '">'; 
?>
	</form>
	<p></p>

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
		echo '<img class="image'.$key.'" src="'.$blob->getUrl().'" style="max-width: 75%;"><br />';
	}

	// Close SQL
	sqlsrv_free_stmt($getResults);
	sqlsrv_close($conn);
?>
    </head>
</html>