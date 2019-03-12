<?php
$submit = $POST[submitToDatabase];
			$scouters = $_POST[scouters];
			$competition = $_POST[competition];
			$match = $_POST[match];
			$robot = $_POST[robot];
			$exitHab = $_POST[exitHab];
			$ssHatchCnt = $_POST[ssHatchCnt];
			$ssCargoCnt = $_POST[ssCargoCnt];
			$toHatchCnt = $_POST[toHatchCnt];
			$toCargoCnt = $_POST[toCargoCnt];
			$defense = $_POST[defense];
			$returnToHab = $_POST[returnToHab];

$insertingData = "INSERT into scoutrecord (matchId, robotId, scoutId, leavehab, sshatchcnt, sscargocnt, tohatchcnt, tocargocnt, playedDefense, returnToHab) values ('$match', '$robot', '$scouters', $exitHab', '$ssHatchCnt', '$ssCargoCnt', '$toHatchCnt', '$toCargoCnt', '$defense', '$returnToaHab')";
$executing = db2_exec($conn, $insertingData);

if($executing) {
    echo "It is working!";
}

else {
    echo "It is not working";
}
?>