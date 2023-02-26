CREATE view [dbo].[v_AvgTeamRecord] as
select asr.TeamId
     , count(*) cntMatches
     , avg(asr.value1) value1
     , avg(asr.value2) value2
     , avg(asr.value3) value3
     , avg(asr.value4) value4
     , avg(asr.value5) value5
     , avg(asr.value6) value6
     , avg(asr.value7) value7
     , avg(asr.value8) value8
     , avg(asr.value9) value9
     , avg(asr.value10) value10
     , avg(asr.value11) value11
     , avg(asr.value12) value12
     , avg(asr.value13) value13
     , avg(asr.value14) value14
     , avg(asr.value15) value15
     , avg(asr.value16) value16
     , avg(asr.value17) value17
     , avg(asr.value18) value18
     , avg(asr.value19) value19
     , avg(asr.value20) value20
     , avg(asr.integerValue1) integerValue1
     , avg(asr.integerValue2) integerValue2
     , avg(asr.integerValue3) integerValue3
     , avg(asr.integerValue4) integerValue4
     , avg(asr.integerValue5) integerValue5
     , avg(asr.integerValue6) integerValue6
     , avg(asr.integerValue7) integerValue7
     , avg(asr.integerValue8) integerValue8
     , avg(asr.integerValue9) integerValue9
     , avg(asr.integerValue10) integerValue10
     , avg(asr.integerValue11) integerValue11
     , avg(asr.integerValue12) integerValue12
     , avg(asr.integerValue13) integerValue13
     , avg(asr.integerValue14) integerValue14
     , avg(asr.integerValue15) integerValue15
     , avg(asr.integerValue16) integerValue16
     , avg(asr.integerValue17) integerValue17
     , avg(asr.integerValue18) integerValue18
     , avg(asr.integerValue19) integerValue19
     , avg(asr.integerValue20) integerValue20
     , avg(asr.scoreValue1) scoreValue1
     , avg(asr.scoreValue2) scoreValue2
     , avg(asr.scoreValue3) scoreValue3
     , avg(asr.scoreValue4) scoreValue4
     , avg(asr.scoreValue5) scoreValue5
     , avg(asr.scoreValue6) scoreValue6
     , avg(asr.scoreValue7) scoreValue7
     , avg(asr.scoreValue8) scoreValue8
     , avg(asr.scoreValue9) scoreValue9
     , avg(asr.scoreValue10) scoreValue10
     , avg(asr.scoreValue11) scoreValue11
     , avg(asr.scoreValue12) scoreValue12
     , avg(asr.scoreValue13) scoreValue13
     , avg(asr.scoreValue14) scoreValue14
     , avg(asr.scoreValue15) scoreValue15
     , avg(asr.scoreValue16) scoreValue16
     , avg(asr.scoreValue17) scoreValue17
     , avg(asr.scoreValue18) scoreValue18
     , avg(asr.scoreValue19) scoreValue19
     , avg(asr.scoreValue20) scoreValue20
	 , round(avg(asr.portionOfAlliancePoints), 2) portionOfAlliancePoints
	 , asr.loginGUID
  from v_AvgScoutRecord asr
       inner join Match m
	   on m.id = asr.matchId
 where m.isActive = 'Y'
   and m.type in ('QM','PR')
group by asr.TeamId
	   , asr.loginGUID;
