-- View for average Team report on a match
CREATE view [dbo].[v_Report_AvgScoutRecord] as
select sr.matchId
     , sr.teamId
	 , sr.gameEventId
     , count(*) cnt
     , avg(convert(numeric(11,3), sr.value1)) value1
     , avg(convert(numeric(11,3), sr.value2)) value2
     , avg(convert(numeric(11,3), sr.value3)) value3
     , avg(convert(numeric(11,3), sr.value4)) value4
     , avg(convert(numeric(11,3), sr.value5)) value5 
     , avg(convert(numeric(11,3), sr.value6)) value6
     , avg(convert(numeric(11,3), sr.value7)) value7
     , avg(convert(numeric(11,3), sr.value8)) value8
     , avg(convert(numeric(11,3), sr.value9)) value9
     , avg(convert(numeric(11,3), sr.value10)) value10
     , avg(convert(numeric(11,3), sr.value11)) value11
     , avg(convert(numeric(11,3), sr.value12)) value12
     , avg(convert(numeric(11,3), sr.value13)) value13
     , avg(convert(numeric(11,3), sr.value14)) value14
     , avg(convert(numeric(11,3), sr.value15)) value15 
     , avg(convert(numeric(11,3), sr.value16)) value16 
     , avg(convert(numeric(11,3), sr.value17)) value17 
     , avg(convert(numeric(11,3), sr.value18)) value18 
     , avg(convert(numeric(11,3), sr.value19)) value19 
     , avg(convert(numeric(11,3), sr.value20)) value20 
     , avg(convert(numeric, sr.integerValue1)) integerValue1
     , avg(convert(numeric, sr.integerValue2)) integerValue2
     , avg(convert(numeric, sr.integerValue3)) integerValue3
     , avg(convert(numeric, sr.integerValue4)) integerValue4
     , avg(convert(numeric, sr.integerValue5)) integerValue5 
     , avg(convert(numeric, sr.integerValue6)) integerValue6
     , avg(convert(numeric, sr.integerValue7)) integerValue7
     , avg(convert(numeric, sr.integerValue8)) integerValue8
     , avg(convert(numeric, sr.integerValue9)) integerValue9
     , avg(convert(numeric, sr.integerValue10)) integerValue10
     , avg(convert(numeric, sr.integerValue11)) integerValue11
     , avg(convert(numeric, sr.integerValue12)) integerValue12
     , avg(convert(numeric, sr.integerValue13)) integerValue13
     , avg(convert(numeric, sr.integerValue14)) integerValue14
     , avg(convert(numeric, sr.integerValue15)) integerValue15 
     , avg(convert(numeric, sr.integerValue16)) integerValue16 
     , avg(convert(numeric, sr.integerValue17)) integerValue17 
     , avg(convert(numeric, sr.integerValue18)) integerValue18 
     , avg(convert(numeric, sr.integerValue19)) integerValue19 
     , avg(convert(numeric, sr.integerValue20)) integerValue20 
     , avg(convert(numeric(11,3), sr.scoreValue1)) scoreValue1
     , avg(convert(numeric(11,3), sr.scoreValue2)) scoreValue2
     , avg(convert(numeric(11,3), sr.scoreValue3)) scoreValue3
     , avg(convert(numeric(11,3), sr.scoreValue4)) scoreValue4
     , avg(convert(numeric(11,3), sr.scoreValue5)) scoreValue5 
     , avg(convert(numeric(11,3), sr.scoreValue6)) scoreValue6
     , avg(convert(numeric(11,3), sr.scoreValue7)) scoreValue7
     , avg(convert(numeric(11,3), sr.scoreValue8)) scoreValue8
     , avg(convert(numeric(11,3), sr.scoreValue9)) scoreValue9
     , avg(convert(numeric(11,3), sr.scoreValue10)) scoreValue10
     , avg(convert(numeric(11,3), sr.scoreValue11)) scoreValue11
     , avg(convert(numeric(11,3), sr.scoreValue12)) scoreValue12
     , avg(convert(numeric(11,3), sr.scoreValue13)) scoreValue13
     , avg(convert(numeric(11,3), sr.scoreValue14)) scoreValue14
     , avg(convert(numeric(11,3), sr.scoreValue15)) scoreValue15 
     , avg(convert(numeric(11,3), sr.scoreValue16)) scoreValue16 
     , avg(convert(numeric(11,3), sr.scoreValue17)) scoreValue17 
     , avg(convert(numeric(11,3), sr.scoreValue18)) scoreValue18 
     , avg(convert(numeric(11,3), sr.scoreValue19)) scoreValue19 
     , avg(convert(numeric(11,3), sr.scoreValue20)) scoreValue20 
     , avg(convert(integer, objectiveId1)) objectiveId1
     , avg(convert(integer, objectiveId2)) objectiveId2
     , avg(convert(integer, objectiveId3)) objectiveId3
     , avg(convert(integer, objectiveId4)) objectiveId4
     , avg(convert(integer, objectiveId5)) objectiveId5 
     , avg(convert(integer, objectiveId6)) objectiveId6
     , avg(convert(integer, objectiveId7)) objectiveId7
     , avg(convert(integer, objectiveId8)) objectiveId8
     , avg(convert(integer, objectiveId9)) objectiveId9
     , avg(convert(integer, objectiveId10)) objectiveId10
     , avg(convert(integer, objectiveId11)) objectiveId11
     , avg(convert(integer, objectiveId12)) objectiveId12
     , avg(convert(integer, objectiveId13)) objectiveId13
     , avg(convert(integer, objectiveId14)) objectiveId14
     , avg(convert(integer, objectiveId15)) objectiveId15
     , avg(convert(integer, objectiveId16)) objectiveId16
     , avg(convert(integer, objectiveId17)) objectiveId17
     , avg(convert(integer, objectiveId18)) objectiveId18
     , avg(convert(integer, objectiveId19)) objectiveId19
     , avg(convert(integer, objectiveId20)) objectiveId20
	 , max(scoringTypeName1) scoringTypeName1
	 , max(scoringTypeName2) scoringTypeName2
	 , max(scoringTypeName3) scoringTypeName3
	 , max(scoringTypeName4) scoringTypeName4
	 , max(scoringTypeName5) scoringTypeName5
	 , max(scoringTypeName6) scoringTypeName6
	 , max(scoringTypeName7) scoringTypeName7
	 , max(scoringTypeName8) scoringTypeName8
	 , max(scoringTypeName9) scoringTypeName9
	 , max(scoringTypeName10) scoringTypeName10
	 , max(scoringTypeName11) scoringTypeName11
	 , max(scoringTypeName12) scoringTypeName12
	 , max(scoringTypeName13) scoringTypeName13
	 , max(scoringTypeName14) scoringTypeName14
	 , max(scoringTypeName15) scoringTypeName15
	 , max(scoringTypeName16) scoringTypeName16
	 , max(scoringTypeName17) scoringTypeName17
	 , max(scoringTypeName18) scoringTypeName18
	 , max(scoringTypeName19) scoringTypeName19
	 , max(scoringTypeName20) scoringTypeName20
	 , round(avg(sr.portionOfAlliancePoints), 2) portionOfAlliancePoints
	 , sr.loginGUID
	 , max(sr.tbaScout) tbaScout
  from v_Report_ScoutRecord sr
group by sr.matchId
       , sr.TeamId
	   , sr.gameEventId
	   , sr.loginGUID;