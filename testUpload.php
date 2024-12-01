<html>
     <meta name="viewport" content="width=device-width, initial-scale=1">
     <title>Scouting App</title>
     <link rel="stylesheet" type="text/css" href="Style/scoutingStyle.css">
	 <body>
		<h1><center>Bomb Botz Scouting App</center></h1>
	</body>
	<p></p>
<?php
//phpinfo(); 

$file = $_FILES["fileToUpload"]["name"];
$tmp_file = $_FILES["fileToUpload"]["tmp_name"];
$target_file = basename($file);
$uploadOk = 1;
$imageFileType = strtolower(pathinfo($target_file,PATHINFO_EXTENSION));
echo "File: $file, Temp File: $tmp_file, Target File: $target_file.<p></p>";

// Check if image file is a actual image or fake image
if(isset($_POST["submit"])) {
    $check = getimagesize($_FILES["fileToUpload"]["tmp_name"]);
    if($check !== false) {
        echo "File is an image - " . $check["mime"] . ".<p></p>";
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

        $mimeType = $check["mime"];
        $blobName = 'folder/'. hash_name("sha256", _FILES["fileToUpload"]);
        $dateTime = gmdate('D, d M Y H:i:s \G\M\T');
        $headerResource = "x-ms-blob-cache-control:max-age=3600\nx-ms-blob-type:BlockBlob\nx-ms-date:$dateTime\nx-ms-version:2019-12-12";
        echo "File Name: $target_file, Blob Name: $blobName.<p></p>";

        // Generate signature
        $arraysign = [];  // initiate an empty array (don't remove this 🙂)
        $arraysign[] = 'PUT';               //HTTP Verb
        $arraysign[] = '';                  //Content-Encoding
        $arraysign[] = '';                  //Content-Language
        $arraysign[] = $fileSize;           //Content-Length (include value when zero)
        $arraysign[] = '';                  //Content-MD5
        $arraysign[] = $mimeType;           //Content-Type
        $arraysign[] = '';                  //Date
        $arraysign[] = '';                  //If-Modified-Since
        $arraysign[] = '';                  //If-Match
        $arraysign[] = '';                  //If-None-Match
        $arraysign[] = '';                  //If-Unmodified-Since
        $arraysign[] = '';                  //Range
        $arraysign[] = $headerResource;     //CanonicalizedHeaders
        $arraysign[] = $urlResource;        //CanonicalizedResource

        // Converts the array to a string as required by MS 
        $str2sign = implode("\n", $arraysign);
        $sig = base64_encode(hash_hmac('sha256', utf8_encode($str2sign), base64_decode($accessKey), true));
        $url = "https://$storageAccountName.blob.core.windows.net/$containerName/{$blobName}";

        $curl = curl_init($url);
        curl_setopt($curl, CURLOPT_POST, true);
        curl_setopt($curl, CURLOPT_POSTFIELDS, [
          'fileToUpload' => new CURLFile($file)
        ]);
        
        $response = curl_exec($curl);
        curl_close($curl);
        
        echo $response;
    }
}

function uploadToAzureCloud($file)
{
    try { 
        $orignalFileName = $file->getClientOriginalName();

        // use GuzzleHttp\Client;
        $client = new Client();
        $response = $client->request('PUT', $url, [
            'headers' => [
            'Authorization' => "SharedKey $storageAccountName:$sig",
            'x-ms-blob-cache-control' => 'max-age=3600',
            'x-ms-blob-type' => 'BlockBlob',
            'x-ms-date' => $dateTime,
            'x-ms-version' => '2019-12-12',
            'Content-Type' => $mimeType,
            'Content-Length' => $fileSize
            ],
            'body' => fopen($file->path(), 'r'),
        ]);          
        if ($response->getStatusCode() == 201) {
            // image sas token 
//          $urlSasToken = config('services.azure_storage.sas_token');
            return
                [
                'original_name' =>   $orignalFileName,
//             'media_url' => "$url?$urlSasToken",
                'media_url' => "$url"
                ];
        } else {
            echo "Something went wrong, Media URL: $url.<p></p>";
            return response()->json(['message' => 'Something went wrong']);
        }
    }
    catch (RequestException $e) {
        // If there's an error, log the error message
        $errorMessage = $e->getMessage();
        echo "Caught Exception: $errorMessage.<p></p>";
        return response()->json(['error' => $errorMessage], 500);
    }
}
?>
</html>
