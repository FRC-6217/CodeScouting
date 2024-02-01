-- View for Match Final Report
CREATE view [dbo].[v_MatchFinalReport] as
-- Team Scores
select case when tm.alliance = 'R' then 'Red'
	        when tm.alliance = 'B' then 'Blue'
	        else tm.alliance end alliance
	 , tm.alliancePosition
     , convert(varchar, t.TeamNumber) TeamNumber
	 , case when tm.alliance = 'R' then 1
	        when tm.alliance = 'B' then 3
	        else 2 end allianceSort
	 , round(asr.value1,2) value1
     , round(asr.value2,2) value2
     , round(asr.value3,2) value3
     , round(asr.value4,2) value4
     , round(asr.value5,2) value5
     , round(asr.value6,2) value6
     , round(asr.value7,2) value7
     , round(asr.value8,2) value8
     , round(asr.value9,2) value9
     , round(asr.value10,2) value10
     , round(asr.value11,2) value11
     , round(asr.value12,2) value12
     , round(asr.value13,2) value13
     , round(asr.value14,2) value14
     , round(asr.value15,2) value15
     , round(asr.value16,2) value16
     , round(asr.value17,2) value17
     , round(asr.value18,2) value18
     , round(asr.value19,2) value19
     , round(asr.value20,2) value20
     , case when g.alliancePtsHeader is not null
	        then coalesce(round(asr.portionOfAlliancePoints,2),0)
			else null end portionOfAlliancePoints
	 , round(coalesce(asr.scoreValue1,0) +
	         coalesce(asr.scoreValue2,0) +
	         coalesce(asr.scoreValue3,0) +
	         coalesce(asr.scoreValue4,0) +
	         coalesce(asr.scoreValue5,0) +
	         coalesce(asr.scoreValue6,0) +
	         coalesce(asr.scoreValue7,0) +
	         coalesce(asr.scoreValue8,0) +
	         coalesce(asr.scoreValue9,0) +
	         coalesce(asr.scoreValue10,0) +
	         coalesce(asr.scoreValue11,0) +
	         coalesce(asr.scoreValue12,0) +
	         coalesce(asr.scoreValue13,0) +
	         coalesce(asr.scoreValue14,0) +
	         coalesce(asr.scoreValue15,0) +
	         coalesce(asr.scoreValue16,0) +
	         coalesce(asr.scoreValue17,0) +
	         coalesce(asr.scoreValue18,0) +
	         coalesce(asr.scoreValue19,0) +
	         coalesce(asr.scoreValue20,0) +
			 coalesce(asr.portionOfAlliancePoints,0) ,2) totalScoreValue
	 , null matchFoulPoints
	 , null matchScore
     , t.id TeamId
     , asr.matchId
     , asr.gameEventId
	 , m.matchCode
	 , asr.loginGUID
	 , (select max(sr.id) from scoutRecord sr where sr.matchId = tm.matchId and sr.teamId = tm.teamId) scoutRecordId
 from Team t
      inner join v_Report_AvgScoutRecord asr
      on asr.TeamId = t.id
      inner join Match m
      on m.id = asr.matchId
	  inner join TeamMatch tm
	  on tm.matchId = asr.matchId
	  and tm.teamId = asr.teamId
	  inner join GameEvent ge
	  on ge.id = asr.gameEventId
	  inner join Game g
	  on g.id = ge.gameId
 where m.isActive = 'Y'
union
-- Team Scores from  The Blue Alliance if no scout data
select case when tm.alliance = 'R' then 'Red'
	        when tm.alliance = 'B' then 'Blue'
	        else tm.alliance end alliance
	 , tm.alliancePosition
     , convert(varchar, t.TeamNumber) TeamNumber
	 , case when tm.alliance = 'R' then 1
	        when tm.alliance = 'B' then 3
	        else 2 end allianceSort
	 , sum(case when o.reportSortOrder = 1 and o.reportDisplay = 'S'
	            then tmo.scoreValue
	            when o.reportSortOrder = 1 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value1
	 , sum(case when o.reportSortOrder = 2 and o.reportDisplay = 'S'
	            then tmo.scoreValue
	            when o.reportSortOrder = 2 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value2
	 , sum(case when o.reportSortOrder = 3 and o.reportDisplay = 'S'
	            then tmo.scoreValue
	            when o.reportSortOrder = 3 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value3
	 , sum(case when o.reportSortOrder = 4 and o.reportDisplay = 'S'
	            then tmo.scoreValue
	            when o.reportSortOrder = 4 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value4
	 , sum(case when o.reportSortOrder = 5 and o.reportDisplay = 'S'
	            then tmo.scoreValue
	            when o.reportSortOrder = 5 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value5
	 , sum(case when o.reportSortOrder = 6 and o.reportDisplay = 'S'
	            then tmo.scoreValue
	            when o.reportSortOrder = 6 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value6
	 , sum(case when o.reportSortOrder = 7 and o.reportDisplay = 'S'
	            then tmo.scoreValue
	            when o.reportSortOrder = 7 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value7
	 , sum(case when o.reportSortOrder = 8 and o.reportDisplay = 'S'
	            then tmo.scoreValue
	            when o.reportSortOrder = 8 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value8
	 , sum(case when o.reportSortOrder = 9 and o.reportDisplay = 'S'
	            then tmo.scoreValue
	            when o.reportSortOrder = 9 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value9
	 , sum(case when o.reportSortOrder = 10 and o.reportDisplay = 'S'
	            then tmo.scoreValue
	            when o.reportSortOrder = 10 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value10
	 , sum(case when o.reportSortOrder = 11 and o.reportDisplay = 'S'
	            then tmo.scoreValue
	            when o.reportSortOrder = 11 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value11
	 , sum(case when o.reportSortOrder = 12 and o.reportDisplay = 'S'
	            then tmo.scoreValue
	            when o.reportSortOrder = 12 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value12
	 , sum(case when o.reportSortOrder = 13 and o.reportDisplay = 'S'
	            then tmo.scoreValue
	            when o.reportSortOrder = 13 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value13
	 , sum(case when o.reportSortOrder = 14 and o.reportDisplay = 'S'
	            then tmo.scoreValue
	            when o.reportSortOrder = 14 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value14
	 , sum(case when o.reportSortOrder = 15 and o.reportDisplay = 'S'
	            then tmo.scoreValue
	            when o.reportSortOrder = 15 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value15
	 , sum(case when o.reportSortOrder = 16 and o.reportDisplay = 'S'
	            then tmo.scoreValue
	            when o.reportSortOrder = 16 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value16
	 , sum(case when o.reportSortOrder = 17 and o.reportDisplay = 'S'
	            then tmo.scoreValue
	            when o.reportSortOrder = 17 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value17
	 , sum(case when o.reportSortOrder = 18 and o.reportDisplay = 'S'
	            then tmo.scoreValue
	            when o.reportSortOrder = 18 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value18
	 , sum(case when o.reportSortOrder = 19 and o.reportDisplay = 'S'
	            then tmo.scoreValue
	            when o.reportSortOrder = 19 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value19
	 , sum(case when o.reportSortOrder = 20 and o.reportDisplay = 'S'
	            then tmo.scoreValue
	            when o.reportSortOrder = 20 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value20
	 , null portionOfAlliancePoints
	 , null totalScoreValue
	 , null matchFoulPoints
	 , null matchScore
	 , tm.teamId
	 , tm.matchId
	 , m.gameEventId
	 , m.matchCode
	 , ge.loginGUID
	 , null scoutRecordId
  from Match m
	   inner join TeamMatch tm
	   on tm.matchId = m.id
	   inner join TeamMatchObjective tmo
	   on tmo.teamMatchId = tm.id
	   inner join Team t
	   on t.id = tm.teamId
	   inner join v_GameEvent ge
	   on ge.id = m.gameEventId
	   inner join Objective o
	   on o.id = tmo.objectiveId
 where m.isActive = 'Y'
   and not exists
       (select 1
	      from ScoutRecord sr
		 where sr.teamId = tm.teamId
		   and sr.matchId = tm.matchId)
group by tm.alliance
	   , tm.alliancePosition
	   , t.teamNumber
       , tm.teamId
	   , tm.matchId
	   , m.gameEventId
	   , m.matchCode
       , ge.loginGUID
union
-- Total Alliance Scores from Scout Data
select subquery.alliance
     , 98 alliancePosition
	 , 'Scout' teamNumber
	 , subquery.allianceSort
	 , sum(subquery.value1) value1
	 , sum(subquery.value2) value2
	 , sum(subquery.value3) value3
	 , sum(subquery.value4) value4
	 , sum(subquery.value5) value5
	 , sum(subquery.value6) value6
	 , sum(subquery.value7) value7
	 , sum(subquery.value8) value8
	 , sum(subquery.value9) value9
	 , sum(subquery.value10) value10
	 , sum(subquery.value11) value11
	 , sum(subquery.value12) value12
	 , sum(subquery.value13) value13
	 , sum(subquery.value14) value14
	 , sum(subquery.value15) value15
	 , sum(subquery.value16) value16
	 , sum(subquery.value17) value17
	 , sum(subquery.value18) value18
	 , sum(subquery.value19) value19
	 , sum(subquery.value20) value20
	 , sum(subquery.portionOfAlliancePoints) portionOfAlliancePoints
	 , sum(subquery.totalScoreValue) totalScoreValue
	 , subquery.matchFoulPoints
	 , subquery.matchScore
	 , null TeamId
	 , subquery.matchId
	 , subquery.gameEventId
	 , subquery.matchCode
     , subquery.loginGUID
	 , null scoutRecordId
  from (
select case when tm.alliance = 'R' then 'Red'
	        when tm.alliance = 'B' then 'Blue'
	        else tm.alliance end alliance
	 , tm.alliancePosition
     , convert(varchar, t.TeamNumber) TeamNumber
	 , case when tm.alliance = 'R' then 1
	        when tm.alliance = 'B' then 3
	        else 2 end allianceSort
	 , round(asr.value1,2) value1
     , round(asr.value2,2) value2
     , round(asr.value3,2) value3
     , round(asr.value4,2) value4
     , round(asr.value5,2) value5
     , round(asr.value6,2) value6
     , round(asr.value7,2) value7
     , round(asr.value8,2) value8
     , round(asr.value9,2) value9
     , round(asr.value10,2) value10
     , round(asr.value11,2) value11
     , round(asr.value12,2) value12
     , round(asr.value13,2) value13
     , round(asr.value14,2) value14
     , round(asr.value15,2) value15
     , round(asr.value16,2) value16
     , round(asr.value17,2) value17
     , round(asr.value18,2) value18
     , round(asr.value19,2) value19
     , round(asr.value20,2) value20
     , case when g.alliancePtsHeader is not null
	        then coalesce(round(asr.portionOfAlliancePoints,2),0)
			else null end portionOfAlliancePoints
	 , round(coalesce(asr.scoreValue1,0) +
	         coalesce(asr.scoreValue2,0) +
	         coalesce(asr.scoreValue3,0) +
	         coalesce(asr.scoreValue4,0) +
	         coalesce(asr.scoreValue5,0) +
	         coalesce(asr.scoreValue6,0) +
	         coalesce(asr.scoreValue7,0) +
	         coalesce(asr.scoreValue8,0) +
	         coalesce(asr.scoreValue9,0) +
	         coalesce(asr.scoreValue10,0) +
	         coalesce(asr.scoreValue11,0) +
	         coalesce(asr.scoreValue12,0) +
	         coalesce(asr.scoreValue13,0) +
	         coalesce(asr.scoreValue14,0) +
	         coalesce(asr.scoreValue15,0) +
	         coalesce(asr.scoreValue16,0) +
	         coalesce(asr.scoreValue17,0) +
	         coalesce(asr.scoreValue18,0) +
	         coalesce(asr.scoreValue19,0) +
	         coalesce(asr.scoreValue20,0) +
			 coalesce(asr.portionOfAlliancePoints, 0) ,2) totalScoreValue
	 , null matchFoulPoints
	 , null matchScore
     , t.id TeamId
     , asr.matchId
     , asr.gameEventId
	 , m.matchCode
	 , asr.loginGUID
 from Team t
      inner join v_Report_AvgScoutRecord asr
      on asr.TeamId = t.id
      inner join Match m
      on m.id = asr.matchId
	  inner join TeamMatch tm
	  on tm.matchId = asr.matchId
	  and tm.teamId = asr.teamId
	  inner join GameEvent ge
	  on ge.id = asr.gameEventId
	  inner join Game g
	  on g.id = ge.gameId
 where m.isActive = 'Y') subquery
group by subquery.alliance
       , subquery.allianceSort
	   , subquery.matchFoulPoints
	   , subquery.matchScore
	   , subquery.matchId
	   , subquery.gameEventId
	   , subquery.matchCode
	   , subquery.loginGUID
union
-- Divider needed in table between alliances
select '----' alliance
     , null alliancePosition
     , null TeamNumber
     , 2 allianceSort
     , null value1
     , null value2
     , null value3
     , null value4
     , null value5
     , null value6
     , null value7
     , null value8
     , null value9
     , null value10
     , null value11
     , null value12
     , null value13
     , null value14
     , null value15
     , null value16
     , null value17
     , null value18
     , null value19
     , null value20
	 , null portionOfAlliancePoints
	 , null totalScoreValue
	 , null matchFoulPoints
	 , null matchScore
	 , null teamId
	 , m.id matchId
	 , m.gameEventId
	 , m.matchCode
	 , ge.loginGUID
	 , null scoutRecordId
  from Match m
	   inner join v_GameEvent ge
	   on ge.id = m.gameEventId
 where m.isActive = 'Y'
union
-- Total Alliance Scores from The Blue Alliance
select case when mas.alliance = 'R' then 'Red'
	        when mas.alliance = 'B' then 'Blue'
	        else mas.alliance end alliance
     , 99 alliancePosition
	 , 'TBA' teamNumber
	 , case when mas.alliance = 'R' then 1
	        when mas.alliance = 'B' then 3
	        else 2 end allianceSort
     , round(mas.value1,2) value1
     , round(mas.value2,2) value2
     , round(mas.value3,2) value3
     , round(mas.value4,2) value4
     , round(mas.value5,2) value5
     , round(mas.value6,2) value6
     , round(mas.value7,2) value7
     , round(mas.value8,2) value8
     , round(mas.value9,2) value9
     , round(mas.value10,2) value10
     , round(mas.value11,2) value11
     , round(mas.value12,2) value12
     , round(mas.value13,2) value13
     , round(mas.value14,2) value14
     , round(mas.value15,2) value15
     , round(mas.value16,2) value16
     , round(mas.value17,2) value17
     , round(mas.value18,2) value18
     , round(mas.value19,2) value19
     , round(mas.value20,2) value20
/*   Use TBA total for match score pre-fouls
	 , round(coalesce(mas.scoreValue1,0) +
	         coalesce(mas.scoreValue2,0) +
	         coalesce(mas.scoreValue3,0) +
	         coalesce(mas.scoreValue4,0) +
	         coalesce(mas.scoreValue5,0) +
	         coalesce(mas.scoreValue6,0) +
	         coalesce(mas.scoreValue7,0) +
	         coalesce(mas.scoreValue8,0) +
	         coalesce(mas.scoreValue9,0) +
	         coalesce(mas.scoreValue10,0) +
	         coalesce(mas.scoreValue11,0) +
	         coalesce(mas.scoreValue12,0) +
	         coalesce(mas.scoreValue13,0) +
	         coalesce(mas.scoreValue14,0) +
	         coalesce(mas.scoreValue15,0) +
	         coalesce(mas.scoreValue16,0) +
	         coalesce(mas.scoreValue17,0) +
	         coalesce(mas.scoreValue18,0) +
	         coalesce(mas.scoreValue19,0) +
	         coalesce(mas.scoreValue20,0),2) totalScoreValue
*/
     , mas.alliancePoints portionOfAlliancePoints
     , mas.matchScore - mas.matchFoulPoints totalScoreValue
	 , mas.matchFoulPoints
	 , mas.matchScore
	 , null TeamId
     , mas.matchId
	 , mas.gameEventId
	 , m.matchCode
	 , mas.loginGUID
	 , null scoutRecordId
  from v_MatchActualScore mas
       inner join Match m
	   on m.id = mas.matchId;
