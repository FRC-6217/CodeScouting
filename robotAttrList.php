<html>
     <meta name="viewport" content="width=device-width, initial-scale=1">
	 <script src="https://apis.google.com/js/platform.js" async defer></script>
     <title>Scouting App</title>
     <link rel="stylesheet" type="text/css" href="Style/scoutingStyle.css">
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
?>
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
    </head>

    <h2>
          <center><a class="clickme danger" href="index.php">Home</a></center>
          <p></p>
     </h2>
	 
<center><h1>Robot Attributes</h1></center>
<center>

    <br>
	<center><div class="g-signin2" data-onsuccess="onSignIn"></div></center>
	<br>
	<center><table cellspacing="0" cellpadding="5">
    <tr>
        <th>Team</th>
      	<?php
			// Display table headers for robot attributes
			$tsql = "select a.tableheader
					   from Attribute a
							inner join gameEvent ge
							on ge.gameId = a.gameId
					  where ge.isActive = 'Y'
					 order by a.sortOrder";
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
				echo "<th>" . $row['tableheader'] . "</th>";
			}
			sqlsrv_free_stmt($getResults);
			?>
     </tr>

    <?php
    $tsql = "select t.teamNumber, t.id teamId
     , coalesce(
	   (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue))
	      from TeamAttribute ta
		       inner join Attribute a
			   on a.id = ta.attributeId
			   and a.gameId = ge.gameId
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 1
		   and ta.teamId = t.id), 'N/A') attrValue1
     , coalesce(
	   (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue))
	      from TeamAttribute ta
		       inner join Attribute a
			   on a.id = ta.attributeId
			   and a.gameId = ge.gameId
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 2
		   and ta.teamId = t.id), 'N/A') attrValue2
     , coalesce(
	   (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue))
	      from TeamAttribute ta
		       inner join Attribute a
			   on a.id = ta.attributeId
			   and a.gameId = ge.gameId
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 3
		   and ta.teamId = t.id), 'N/A') attrValue3
     , coalesce(
	   (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue))
	      from TeamAttribute ta
		       inner join Attribute a
			   on a.id = ta.attributeId
			   and a.gameId = ge.gameId
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 4
		   and ta.teamId = t.id), 'N/A') attrValue4
     , coalesce(
	   (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue))
	      from TeamAttribute ta
		       inner join Attribute a
			   on a.id = ta.attributeId
			   and a.gameId = ge.gameId
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 5
		   and ta.teamId = t.id), 'N/A') attrValue5
  from Team t 
       inner join TeamGameEvent tge 
       on tge.teamId = t.id
       inner join GameEvent ge 
       on ge.id = tge.gameEventId
 where ge.isActive = 'Y'
order by teamNumber";
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
        ?>
       <tr>
			<?php
			echo "<td><a href='robotAttrSetup.php?teamId=" . $row['teamId']  "<a/><td/>"
			echo "<td>" . ($row['teamNumber']) . "</td>";
			echo "<td>" . ($row['attrValue1']) . "</td>";
			echo "<td>" . ($row['attrValue2']) . "</td>";
			echo "<td>" . ($row['attrValue3']) . "</td>";
			echo "<td>" . ($row['attrValue4']) . "</td>";
			echo "<td>" . ($row['attrValue5']) . "</td>";
		   ?>
        </tr>
    <?php
    }
    sqlsrv_free_stmt($getResults);
	sqlsrv_close($conn);
    ?>
    </table>
	</center>
</html> 
