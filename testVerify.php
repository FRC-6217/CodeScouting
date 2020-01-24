<?php
 
echo "Result from server<br>";
 
if (isset ( $_REQUEST['token'] ) && $_REQUEST['token'] != '') {
    
    $response = file_get_contents ( 'https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=' . $_REQUEST['token'] );
    
    $response = json_decode ( $response );
    
    echo "<pre>";
    print_r ( $response );
    echo "</pre>";
}
?>
