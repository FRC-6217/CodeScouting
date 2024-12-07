<html>
     <meta name="viewport" content="width=device-width, initial-scale=1">
     <title>Scouting App</title>
     <link rel="stylesheet" type="text/css" href="Style/scoutingStyle.css">
	 <body>
		<h1><center>Bomb Botz Scouting App</center></h1>
	</body>
	<p></p>
<?php
# Reference autoload (assuming you're using Composer)
require_once('vendor/autoload.php');

use MicrosoftAzure\Storage\Blob\Models\CreateBlockBlobOptions;
use MicrosoftAzure\Storage\Blob\BlobRestProxy;

#phpinfo(); 

$file = $_FILES["fileToUpload"]["name"];
$tmpFile = $_FILES["fileToUpload"]["tmp_name"];
$targetFile = basename($file);
$uploadOk = 1;
$imageFileType = strtolower(pathinfo($targetFile,PATHINFO_EXTENSION));
echo "File: $file, Temp File: $tmpFile, Target File: $targetFile.<p></p>";

// Check if image file is a actual image or fake image
if(isset($_POST["submit"])) {
    $check = getimagesize($_FILES["fileToUpload"]["tmp_name"]);
    $mime = $check["mime"];
    if($check !== false) {
        echo "File is an image - $mime.<p></p>";
    }
    else {
        echo "File is not an image.<p></p>";
        $uploadOk = 0;
    }

    // Check file size
    $fileSize = $_FILES["fileToUpload"]["size"];
    if ($fileSize > 500000) {
        echo "Sorry, your file is too large.<p></p>";
        $uploadOk = 0;
    }

    // Allow certain file formats
    if($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg" && $imageFileType != "gif" ) {
        echo "Sorry, only JPG, JPEG, PNG & GIF files are allowed.<p></p>";
        $uploadOk = 0;
    }

    // Check if $uploadOk is set to 0 by an error
    if ($uploadOk == 0) {
        echo "Sorry, your file was not uploaded.<p></p>";
    }
    // if everything is ok, try to upload file
    else {
        $storageAccountName = getenv("StorageAccountName");
        $containerName = getenv("StorageContainer");
        $accessKey = getenv("StorageAccessKey");
        echo "Account Name: $storageAccountName, Container Name: $containerName.<p></p>";
        
        # Use functions to upload file
        $fileNameOnStorage = "1234/" . $file;
        
        echo "Calling Function storageAddFile.<p></p>";
        storageAddFile($containerName, $tmpFile, $fileNameOnStorage, $mime, $storageAccountName, $accessKey);
    }
}

# Function to add a file to storage
function storageAddFile($containerName, $tmpFile, $fileNameOnStorage, $mime, $storageAccountName, $accessKey) {
    echo "In Function storageAddFile.<p></p>";
    # Setup Azure Storage connection
    $connectionString = "DefaultEndpointsProtocol=https;AccountName=$storageAccountName;AccountKey=$accessKey";
    echo "Connection String: $connectionString.<p></p>";
    try {
        $blobClient = BlobRestProxy::createBlobService($connectionString);
    }
    catch (Exception $e) {
        echo "Failed create Blob Service: " . $e . "<p></p>";
    }

    # Open the file
    $handle = fopen($tmpFile, "r");
    if ($handle) {
        echo "Opened file '" . $tmpFile . "' for upload to storage." . "<p></p>";
        $options = new CreateBlockBlobOptions();

        # Identify MIME type
        try {
            $options->setContentType($mime);
        } catch (Exception $e) {
            echo "Failed to read MIME from '" . $tmpFile . "': " . $e . "<p></p>";
        }

        # Upload the blob
        try {
            if ($mime) {
                $cacheTime = getCacheTimeByMimeType($mime);
                if ($cacheTime) {
                    $options->setCacheControl("public, max-age=" . $cacheTime);
                }
            }
            $blobClient->createBlockBlob($containerName, $fileNameOnStorage, $handle, $options);
        } catch (Exception $e) {
            echo "Failed to upload file '" . $tmpFile . "' to storage: " . $e . "<p></p>";
        }

        /*
        # Remove the fClose because it returns an error. Filestream must be closed in createBlockBlob call
        echo "Closing file '" . $tmpFile . "'." . "<p></p>";
        fclose($handle);
        */

        return true;
    } else {
        echo "Failed to open file '" . $tmpFile . "' for upload to storage." . "<p></p>";
        return false;
    }
}

# Get cache time by MIME type
function getCacheTimeByMimeType($mime) {
    $mime = strtolower($mime);
    $types = array(
        "application/json" => 604800, // 7 days
        // Add more MIME types and cache times as needed
    );
    return $types[$mime] ?? null;
}
?>
</html>
