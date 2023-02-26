-- View for Scout Record
CREATE view [dbo].[v_ScoutRecord] as
select sr.id scoutRecordId
     , sr.matchId
     , sr.teamId
	 , sr.scoutId
	 , sr.scoutComment
	 , m.gameEventId
	 , sum(case when o.sortOrder = 1 and o.reportDisplay = 'S'
	            then sor.scoreValue
	            when o.sortOrder = 1 and o.reportDisplay = 'I'
				then sor.integerValue
	            else null end) value1
	 , sum(case when o.sortOrder = 2 and o.reportDisplay = 'S'
	            then sor.scoreValue
	            when o.sortOrder = 2 and o.reportDisplay = 'I'
				then sor.integerValue
	            else null end) value2
	 , sum(case when o.sortOrder = 3 and o.reportDisplay = 'S'
	            then sor.scoreValue
	            when o.sortOrder = 3 and o.reportDisplay = 'I'
				then sor.integerValue
	            else null end) value3
	 , sum(case when o.sortOrder = 4 and o.reportDisplay = 'S'
	            then sor.scoreValue
	            when o.sortOrder = 4 and o.reportDisplay = 'I'
				then sor.integerValue
	            else null end) value4
	 , sum(case when o.sortOrder = 5 and o.reportDisplay = 'S'
	            then sor.scoreValue
	            when o.sortOrder = 5 and o.reportDisplay = 'I'
				then sor.integerValue
	            else null end) value5
	 , sum(case when o.sortOrder = 6 and o.reportDisplay = 'S'
	            then sor.scoreValue
	            when o.sortOrder = 6 and o.reportDisplay = 'I'
				then sor.integerValue
	            else null end) value6
	 , sum(case when o.sortOrder = 7 and o.reportDisplay = 'S'
	            then sor.scoreValue
	            when o.sortOrder = 7 and o.reportDisplay = 'I'
				then sor.integerValue
	            else null end) value7
	 , sum(case when o.sortOrder = 8 and o.reportDisplay = 'S'
	            then sor.scoreValue
	            when o.sortOrder = 8 and o.reportDisplay = 'I'
				then sor.integerValue
	            else null end) value8
	 , sum(case when o.sortOrder = 9 and o.reportDisplay = 'S'
	            then sor.scoreValue
	            when o.sortOrder = 9 and o.reportDisplay = 'I'
				then sor.integerValue
	            else null end) value9
	 , sum(case when o.sortOrder = 10 and o.reportDisplay = 'S'
	            then sor.scoreValue
	            when o.sortOrder = 10 and o.reportDisplay = 'I'
				then sor.integerValue
	            else null end) value10
	 , sum(case when o.sortOrder = 11 and o.reportDisplay = 'S'
	            then sor.scoreValue
	            when o.sortOrder = 11 and o.reportDisplay = 'I'
				then sor.integerValue
	            else null end) value11
	 , sum(case when o.sortOrder = 12 and o.reportDisplay = 'S'
	            then sor.scoreValue
	            when o.sortOrder = 12 and o.reportDisplay = 'I'
				then sor.integerValue
	            else null end) value12
	 , sum(case when o.sortOrder = 13 and o.reportDisplay = 'S'
	            then sor.scoreValue
	            when o.sortOrder = 13 and o.reportDisplay = 'I'
				then sor.integerValue
	            else null end) value13
	 , sum(case when o.sortOrder = 14 and o.reportDisplay = 'S'
	            then sor.scoreValue
	            when o.sortOrder = 14 and o.reportDisplay = 'I'
				then sor.integerValue
	            else null end) value14
	 , sum(case when o.sortOrder = 15 and o.reportDisplay = 'S'
	            then sor.scoreValue
	            when o.sortOrder = 15 and o.reportDisplay = 'I'
				then sor.integerValue
	            else null end) value15
	 , sum(case when o.sortOrder = 16 and o.reportDisplay = 'S'
	            then sor.scoreValue
	            when o.sortOrder = 16 and o.reportDisplay = 'I'
				then sor.integerValue
	            else null end) value16
	 , sum(case when o.sortOrder = 17 and o.reportDisplay = 'S'
	            then sor.scoreValue
	            when o.sortOrder = 17 and o.reportDisplay = 'I'
				then sor.integerValue
	            else null end) value17
	 , sum(case when o.sortOrder = 18 and o.reportDisplay = 'S'
	            then sor.scoreValue
	            when o.sortOrder = 18 and o.reportDisplay = 'I'
				then sor.integerValue
	            else null end) value18
	 , sum(case when o.sortOrder = 19 and o.reportDisplay = 'S'
	            then sor.scoreValue
	            when o.sortOrder = 19 and o.reportDisplay = 'I'
				then sor.integerValue
	            else null end) value19
	 , sum(case when o.sortOrder = 20 and o.reportDisplay = 'S'
	            then sor.scoreValue
	            when o.sortOrder = 20 and o.reportDisplay = 'I'
				then sor.integerValue
	            else null end) value20
	 , sum(case when o.sortOrder = 1 then sor.integerValue else null end) integerValue1
	 , sum(case when o.sortOrder = 2 then sor.integerValue else null end) integerValue2
	 , sum(case when o.sortOrder = 3 then sor.integerValue else null end) integerValue3
	 , sum(case when o.sortOrder = 4 then sor.integerValue else null end) integerValue4
	 , sum(case when o.sortOrder = 5 then sor.integerValue else null end) integerValue5
	 , sum(case when o.sortOrder = 6 then sor.integerValue else null end) integerValue6
	 , sum(case when o.sortOrder = 7 then sor.integerValue else null end) integerValue7
	 , sum(case when o.sortOrder = 8 then sor.integerValue else null end) integerValue8
	 , sum(case when o.sortOrder = 9 then sor.integerValue else null end) integerValue9
	 , sum(case when o.sortOrder = 10 then sor.integerValue else null end) integerValue10
	 , sum(case when o.sortOrder = 11 then sor.integerValue else null end) integerValue11
	 , sum(case when o.sortOrder = 12 then sor.integerValue else null end) integerValue12
	 , sum(case when o.sortOrder = 13 then sor.integerValue else null end) integerValue13
	 , sum(case when o.sortOrder = 14 then sor.integerValue else null end) integerValue14
	 , sum(case when o.sortOrder = 15 then sor.integerValue else null end) integerValue15
	 , sum(case when o.sortOrder = 16 then sor.integerValue else null end) integerValue16
	 , sum(case when o.sortOrder = 17 then sor.integerValue else null end) integerValue17
	 , sum(case when o.sortOrder = 18 then sor.integerValue else null end) integerValue18
	 , sum(case when o.sortOrder = 19 then sor.integerValue else null end) integerValue19
	 , sum(case when o.sortOrder = 20 then sor.integerValue else null end) integerValue20
	 , sum(case when o.sortOrder = 1
	            then sor.scoreValue
				else null end) scoreValue1
	 , sum(case when o.sortOrder = 2  
	            then sor.scoreValue
				else null end) scoreValue2
	 , sum(case when o.sortOrder = 3 
	            then sor.scoreValue
				else null end) scoreValue3
	 , sum(case when o.sortOrder = 4 
	            then sor.scoreValue
				else null end) scoreValue4
	 , sum(case when o.sortOrder = 5 
	            then sor.scoreValue
				else null end) scoreValue5
	 , sum(case when o.sortOrder = 6 
	            then sor.scoreValue
				else null end) scoreValue6
	 , sum(case when o.sortOrder = 7 
	            then sor.scoreValue
				else null end) scoreValue7
	 , sum(case when o.sortOrder = 8 
	            then sor.scoreValue
				else null end) scoreValue8
	 , sum(case when o.sortOrder = 9 
	            then sor.scoreValue
				else null end) scoreValue9
	 , sum(case when o.sortOrder = 10 
	            then sor.scoreValue
				else null end) scoreValue10
	 , sum(case when o.sortOrder = 11 
	            then sor.scoreValue
				else null end) scoreValue11
	 , sum(case when o.sortOrder = 12 
	            then sor.scoreValue
				else null end) scoreValue12
	 , sum(case when o.sortOrder = 13 
	            then sor.scoreValue
				else null end) scoreValue13
	 , sum(case when o.sortOrder = 14 
	            then sor.scoreValue
				else null end) scoreValue14
	 , sum(case when o.sortOrder = 15 
	            then sor.scoreValue
				else null end) scoreValue15
	 , sum(case when o.sortOrder = 16 
	            then sor.scoreValue
				else null end) scoreValue16
	 , sum(case when o.sortOrder = 17 
	            then sor.scoreValue
				else null end) scoreValue17
	 , sum(case when o.sortOrder = 18 
	            then sor.scoreValue
				else null end) scoreValue18
	 , sum(case when o.sortOrder = 19 
	            then sor.scoreValue
				else null end) scoreValue19
	 , sum(case when o.sortOrder = 20 
	            then sor.scoreValue
				else null end) scoreValue20
	 , max(case when o.sortOrder = 1 then sor.textValue else null end) textValue1
	 , max(case when o.sortOrder = 2 then sor.textValue else null end) textValue2
	 , max(case when o.sortOrder = 3 then sor.textValue else null end) textValue3
	 , max(case when o.sortOrder = 4 then sor.textValue else null end) textValue4
	 , max(case when o.sortOrder = 5 then sor.textValue else null end) textValue5
	 , max(case when o.sortOrder = 6 then sor.textValue else null end) textValue6
	 , max(case when o.sortOrder = 7 then sor.textValue else null end) textValue7
	 , max(case when o.sortOrder = 8 then sor.textValue else null end) textValue8
	 , max(case when o.sortOrder = 9 then sor.textValue else null end) textValue9
	 , max(case when o.sortOrder = 10 then sor.textValue else null end) textValue10
	 , max(case when o.sortOrder = 11 then sor.textValue else null end) textValue11
	 , max(case when o.sortOrder = 12 then sor.textValue else null end) textValue12
	 , max(case when o.sortOrder = 13 then sor.textValue else null end) textValue13
	 , max(case when o.sortOrder = 14 then sor.textValue else null end) textValue14
	 , max(case when o.sortOrder = 15 then sor.textValue else null end) textValue15
	 , max(case when o.sortOrder = 16 then sor.textValue else null end) textValue16
	 , max(case when o.sortOrder = 17 then sor.textValue else null end) textValue17
	 , max(case when o.sortOrder = 18 then sor.textValue else null end) textValue18
	 , max(case when o.sortOrder = 19 then sor.textValue else null end) textValue19
	 , max(case when o.sortOrder = 20 then sor.textValue else null end) textValue20
	 , sum(case when o.sortOrder = 1 then o.id else null end) objectiveId1
	 , sum(case when o.sortOrder = 2 then o.id else null end) objectiveId2
	 , sum(case when o.sortOrder = 3 then o.id else null end) objectiveId3
	 , sum(case when o.sortOrder = 4 then o.id else null end) objectiveId4
	 , sum(case when o.sortOrder = 5 then o.id else null end) objectiveId5
	 , sum(case when o.sortOrder = 6 then o.id else null end) objectiveId6
	 , sum(case when o.sortOrder = 7 then o.id else null end) objectiveId7
	 , sum(case when o.sortOrder = 8 then o.id else null end) objectiveId8
	 , sum(case when o.sortOrder = 9 then o.id else null end) objectiveId9
	 , sum(case when o.sortOrder = 10 then o.id else null end) objectiveId10
	 , sum(case when o.sortOrder = 11 then o.id else null end) objectiveId11
	 , sum(case when o.sortOrder = 12 then o.id else null end) objectiveId12
	 , sum(case when o.sortOrder = 13 then o.id else null end) objectiveId13
	 , sum(case when o.sortOrder = 14 then o.id else null end) objectiveId14
	 , sum(case when o.sortOrder = 15 then o.id else null end) objectiveId15
	 , sum(case when o.sortOrder = 16 then o.id else null end) objectiveId16
	 , sum(case when o.sortOrder = 17 then o.id else null end) objectiveId17
	 , sum(case when o.sortOrder = 18 then o.id else null end) objectiveId18
	 , sum(case when o.sortOrder = 19 then o.id else null end) objectiveId19
	 , sum(case when o.sortOrder = 20 then o.id else null end) objectiveId20
	 , max(case when o.sortOrder = 1 then st.name else null end) scoringTypeName1
	 , max(case when o.sortOrder = 2 then st.name else null end) scoringTypeName2
	 , max(case when o.sortOrder = 3 then st.name else null end) scoringTypeName3
	 , max(case when o.sortOrder = 4 then st.name else null end) scoringTypeName4
	 , max(case when o.sortOrder = 5 then st.name else null end) scoringTypeName5
	 , max(case when o.sortOrder = 6 then st.name else null end) scoringTypeName6
	 , max(case when o.sortOrder = 7 then st.name else null end) scoringTypeName7
	 , max(case when o.sortOrder = 8 then st.name else null end) scoringTypeName8
	 , max(case when o.sortOrder = 9 then st.name else null end) scoringTypeName9
	 , max(case when o.sortOrder = 10 then st.name else null end) scoringTypeName10
	 , max(case when o.sortOrder = 11 then st.name else null end) scoringTypeName11
	 , max(case when o.sortOrder = 12 then st.name else null end) scoringTypeName12
	 , max(case when o.sortOrder = 13 then st.name else null end) scoringTypeName13
	 , max(case when o.sortOrder = 14 then st.name else null end) scoringTypeName14
	 , max(case when o.sortOrder = 15 then st.name else null end) scoringTypeName15
	 , max(case when o.sortOrder = 16 then st.name else null end) scoringTypeName16
	 , max(case when o.sortOrder = 17 then st.name else null end) scoringTypeName17
	 , max(case when o.sortOrder = 18 then st.name else null end) scoringTypeName18
	 , max(case when o.sortOrder = 19 then st.name else null end) scoringTypeName19
	 , max(case when o.sortOrder = 20 then st.name else null end) scoringTypeName20
	 , tm.portionOfAlliancePoints
	 , ge.loginGUID
  from ScoutRecord sr
       inner join Match m
	   on m.id = sr.matchId
	   inner join v_GameEvent ge
	   on ge.id = m.gameEventId
	   inner join Objective o
	   on o.gameId = ge.gameId
	   inner join ScoringType st
	   on st.id = o.scoringTypeId
	   inner join TeamMatch tm
	   on tm.matchId = sr.matchId
	   and tm.teamId = sr.teamId
	   left outer join ScoutObjectiveRecord sor
	   on sor.scoutRecordId = sr.id
	   and sor.objectiveId = o.id
 where m.isActive = 'Y'
group by sr.id
       , sr.matchId
       , sr.teamId
	   , sr.scoutId
	   , sr.scoutComment
	   , m.gameEventId
	   , tm.portionOfAlliancePoints
	   , ge.loginGUID
