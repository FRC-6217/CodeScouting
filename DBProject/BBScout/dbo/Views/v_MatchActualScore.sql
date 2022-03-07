CREATE view [dbo].[v_MatchActualScore] as
select mo.alliance
     , mo.matchId
	 , mo.gameEventId
	 , coalesce(mo.value1, tmo.value1) value1
	 , coalesce(mo.value2, tmo.value2) value2
	 , coalesce(mo.value3, tmo.value3) value3
	 , coalesce(mo.value4, tmo.value4) value4
	 , coalesce(mo.value5, tmo.value5) value5
	 , coalesce(mo.value6, tmo.value6) value6
	 , coalesce(mo.value7, tmo.value7) value7
	 , coalesce(mo.value8, tmo.value8) value8
	 , coalesce(mo.value9, tmo.value9) value9
	 , coalesce(mo.value10, tmo.value10) value10
	 , coalesce(mo.value11, tmo.value11) value11
	 , coalesce(mo.value12, tmo.value12) value12
	 , coalesce(mo.value13, tmo.value13) value13
	 , coalesce(mo.value14, tmo.value14) value14
	 , coalesce(mo.value15, tmo.value15) value15
	 , coalesce(mo.integerValue1, tmo.integerValue1) integerValue1
	 , coalesce(mo.integerValue2, tmo.integerValue2) integerValue2
	 , coalesce(mo.integerValue3, tmo.integerValue3) integerValue3
	 , coalesce(mo.integerValue4, tmo.integerValue4) integerValue4
	 , coalesce(mo.integerValue5, tmo.integerValue5) integerValue5
	 , coalesce(mo.integerValue6, tmo.integerValue6) integerValue6
	 , coalesce(mo.integerValue7, tmo.integerValue7) integerValue7
	 , coalesce(mo.integerValue8, tmo.integerValue8) integerValue8
	 , coalesce(mo.integerValue9, tmo.integerValue9) integerValue9
	 , coalesce(mo.integerValue10, tmo.integerValue10) integerValue10
	 , coalesce(mo.integerValue11, tmo.integerValue11) integerValue11
	 , coalesce(mo.integerValue12, tmo.integerValue12) integerValue12
	 , coalesce(mo.integerValue13, tmo.integerValue13) integerValue13
	 , coalesce(mo.integerValue14, tmo.integerValue14) integerValue14
	 , coalesce(mo.integerValue15, tmo.integerValue15) integerValue15
	 , coalesce(mo.scoreValue1, tmo.scoreValue1) scoreValue1
	 , coalesce(mo.scoreValue2, tmo.scoreValue2) scoreValue2
	 , coalesce(mo.scoreValue3, tmo.scoreValue3) scoreValue3
	 , coalesce(mo.scoreValue4, tmo.scoreValue4) scoreValue4
	 , coalesce(mo.scoreValue5, tmo.scoreValue5) scoreValue5
	 , coalesce(mo.scoreValue6, tmo.scoreValue6) scoreValue6
	 , coalesce(mo.scoreValue7, tmo.scoreValue7) scoreValue7
	 , coalesce(mo.scoreValue8, tmo.scoreValue8) scoreValue8
	 , coalesce(mo.scoreValue9, tmo.scoreValue9) scoreValue9
	 , coalesce(mo.scoreValue10, tmo.scoreValue10) scoreValue10
	 , coalesce(mo.scoreValue11, tmo.scoreValue11) scoreValue11
	 , coalesce(mo.scoreValue12, tmo.scoreValue12) scoreValue12
	 , coalesce(mo.scoreValue13, tmo.scoreValue13) scoreValue13
	 , coalesce(mo.scoreValue14, tmo.scoreValue14) scoreValue14
	 , coalesce(mo.scoreValue15, tmo.scoreValue15) scoreValue15
	 , coalesce(mo.matchFoulPoints, tmo.matchFoulPoints) matchFoulPoints
	 , coalesce(mo.matchScore, tmo.matchScore) matchScore
	 , coalesce(mo.objectiveId1, tmo.objectiveId1) objectiveId1
	 , coalesce(mo.objectiveId2, tmo.objectiveId2) objectiveId2
	 , coalesce(mo.objectiveId3, tmo.objectiveId3) objectiveId3
	 , coalesce(mo.objectiveId4, tmo.objectiveId4) objectiveId4
	 , coalesce(mo.objectiveId5, tmo.objectiveId5) objectiveId5
	 , coalesce(mo.objectiveId6, tmo.objectiveId6) objectiveId6
	 , coalesce(mo.objectiveId7, tmo.objectiveId7) objectiveId7
	 , coalesce(mo.objectiveId8, tmo.objectiveId8) objectiveId8
	 , coalesce(mo.objectiveId9, tmo.objectiveId9) objectiveId9
	 , coalesce(mo.objectiveId10, tmo.objectiveId10) objectiveId10
	 , coalesce(mo.objectiveId11, tmo.objectiveId11) objectiveId11
	 , coalesce(mo.objectiveId12, tmo.objectiveId12) objectiveId12
	 , coalesce(mo.objectiveId13, tmo.objectiveId13) objectiveId13
	 , coalesce(mo.objectiveId14, tmo.objectiveId14) objectiveId14
	 , coalesce(mo.objectiveId15, tmo.objectiveId15) objectiveId15
	 , mo.loginGUID
  from (
select mo.alliance
     , mo.matchId
     , m.gameEventId
	 , sum(case when o.sortOrder = 1 and o.reportDisplay = 'S'
	            then mo.scoreValue
	            when o.sortOrder = 1 and o.reportDisplay = 'I'
				then mo.integerValue
	            else null end) value1
	 , sum(case when o.sortOrder = 2 and o.reportDisplay = 'S'
	            then mo.scoreValue
	            when o.sortOrder = 2 and o.reportDisplay = 'I'
				then mo.integerValue
	            else null end) value2
	 , sum(case when o.sortOrder = 3 and o.reportDisplay = 'S'
	            then mo.scoreValue
	            when o.sortOrder = 3 and o.reportDisplay = 'I'
				then mo.integerValue
	            else null end) value3
	 , sum(case when o.sortOrder = 4 and o.reportDisplay = 'S'
	            then mo.scoreValue
	            when o.sortOrder = 4 and o.reportDisplay = 'I'
				then mo.integerValue
	            else null end) value4
	 , sum(case when o.sortOrder = 5 and o.reportDisplay = 'S'
	            then mo.scoreValue
	            when o.sortOrder = 5 and o.reportDisplay = 'I'
				then mo.integerValue
	            else null end) value5
	 , sum(case when o.sortOrder = 6 and o.reportDisplay = 'S'
	            then mo.scoreValue
	            when o.sortOrder = 6 and o.reportDisplay = 'I'
				then mo.integerValue
	            else null end) value6
	 , sum(case when o.sortOrder = 7 and o.reportDisplay = 'S'
	            then mo.scoreValue
	            when o.sortOrder = 7 and o.reportDisplay = 'I'
				then mo.integerValue
	            else null end) value7
	 , sum(case when o.sortOrder = 8 and o.reportDisplay = 'S'
	            then mo.scoreValue
	            when o.sortOrder = 8 and o.reportDisplay = 'I'
				then mo.integerValue
	            else null end) value8
	 , sum(case when o.sortOrder = 9 and o.reportDisplay = 'S'
	            then mo.scoreValue
	            when o.sortOrder = 9 and o.reportDisplay = 'I'
				then mo.integerValue
	            else null end) value9
	 , sum(case when o.sortOrder = 10 and o.reportDisplay = 'S'
	            then mo.scoreValue
	            when o.sortOrder = 10 and o.reportDisplay = 'I'
				then mo.integerValue
	            else null end) value10
	 , sum(case when o.sortOrder = 11 and o.reportDisplay = 'S'
	            then mo.scoreValue
	            when o.sortOrder = 11 and o.reportDisplay = 'I'
				then mo.integerValue
	            else null end) value11
	 , sum(case when o.sortOrder = 12 and o.reportDisplay = 'S'
	            then mo.scoreValue
	            when o.sortOrder = 12 and o.reportDisplay = 'I'
				then mo.integerValue
	            else null end) value12
	 , sum(case when o.sortOrder = 13 and o.reportDisplay = 'S'
	            then mo.scoreValue
	            when o.sortOrder = 13 and o.reportDisplay = 'I'
				then mo.integerValue
	            else null end) value13
	 , sum(case when o.sortOrder = 14 and o.reportDisplay = 'S'
	            then mo.scoreValue
	            when o.sortOrder = 14 and o.reportDisplay = 'I'
				then mo.integerValue
	            else null end) value14
	 , sum(case when o.sortOrder = 15 and o.reportDisplay = 'S'
	            then mo.scoreValue
	            when o.sortOrder = 15 and o.reportDisplay = 'I'
				then mo.integerValue
	            else null end) value15
	 , sum(case when o.sortOrder = 1 then mo.integerValue else null end) integerValue1
	 , sum(case when o.sortOrder = 2 then mo.integerValue else null end) integerValue2
	 , sum(case when o.sortOrder = 3 then mo.integerValue else null end) integerValue3
	 , sum(case when o.sortOrder = 4 then mo.integerValue else null end) integerValue4
	 , sum(case when o.sortOrder = 5 then mo.integerValue else null end) integerValue5
	 , sum(case when o.sortOrder = 6 then mo.integerValue else null end) integerValue6
	 , sum(case when o.sortOrder = 7 then mo.integerValue else null end) integerValue7
	 , sum(case when o.sortOrder = 8 then mo.integerValue else null end) integerValue8
	 , sum(case when o.sortOrder = 9 then mo.integerValue else null end) integerValue9
	 , sum(case when o.sortOrder = 10 then mo.integerValue else null end) integerValue10
	 , sum(case when o.sortOrder = 11 then mo.integerValue else null end) integerValue11
	 , sum(case when o.sortOrder = 12 then mo.integerValue else null end) integerValue12
	 , sum(case when o.sortOrder = 13 then mo.integerValue else null end) integerValue13
	 , sum(case when o.sortOrder = 14 then mo.integerValue else null end) integerValue14
	 , sum(case when o.sortOrder = 15 then mo.integerValue else null end) integerValue15
	 , sum(case when o.sortOrder = 1
	            then mo.scoreValue
				else null end) scoreValue1
	 , sum(case when o.sortOrder = 2  
	            then mo.scoreValue
				else null end) scoreValue2
	 , sum(case when o.sortOrder = 3 
	            then mo.scoreValue
				else null end) scoreValue3
	 , sum(case when o.sortOrder = 4 
	            then mo.scoreValue
				else null end) scoreValue4
	 , sum(case when o.sortOrder = 5 
	            then mo.scoreValue
				else null end) scoreValue5
	 , sum(case when o.sortOrder = 6 
	            then mo.scoreValue
				else null end) scoreValue6
	 , sum(case when o.sortOrder = 7 
	            then mo.scoreValue
				else null end) scoreValue7
	 , sum(case when o.sortOrder = 8 
	            then mo.scoreValue
				else null end) scoreValue8
	 , sum(case when o.sortOrder = 9 
	            then mo.scoreValue
				else null end) scoreValue9
	 , sum(case when o.sortOrder = 10 
	            then mo.scoreValue
				else null end) scoreValue10
	 , sum(case when o.sortOrder = 11 
	            then mo.scoreValue
				else null end) scoreValue11
	 , sum(case when o.sortOrder = 12 
	            then mo.scoreValue
				else null end) scoreValue12
	 , sum(case when o.sortOrder = 13 
	            then mo.scoreValue
				else null end) scoreValue13
	 , sum(case when o.sortOrder = 14 
	            then mo.scoreValue
				else null end) scoreValue14
	 , sum(case when o.sortOrder = 15 
	            then mo.scoreValue
				else null end) scoreValue15
	 , case when mo.alliance = 'R' then m.redFoulPoints
	        when mo.alliance = 'B' then m.blueFoulPoints
	        else null end matchFoulPoints
	 , case when mo.alliance = 'R' then m.redScore
	        when mo.alliance = 'B' then m.blueScore
	        else null end matchScore
	 , max(case when o.sortOrder = 1 then mo.objectiveId else null end) objectiveId1
	 , max(case when o.sortOrder = 2 then mo.objectiveId else null end) objectiveId2
	 , max(case when o.sortOrder = 3 then mo.objectiveId else null end) objectiveId3
	 , max(case when o.sortOrder = 4 then mo.objectiveId else null end) objectiveId4
	 , max(case when o.sortOrder = 5 then mo.objectiveId else null end) objectiveId5
	 , max(case when o.sortOrder = 6 then mo.objectiveId else null end) objectiveId6
	 , max(case when o.sortOrder = 7 then mo.objectiveId else null end) objectiveId7
	 , max(case when o.sortOrder = 8 then mo.objectiveId else null end) objectiveId8
	 , max(case when o.sortOrder = 9 then mo.objectiveId else null end) objectiveId9
	 , max(case when o.sortOrder = 10 then mo.objectiveId else null end) objectiveId10
	 , max(case when o.sortOrder = 11 then mo.objectiveId else null end) objectiveId11
	 , max(case when o.sortOrder = 12 then mo.objectiveId else null end) objectiveId12
	 , max(case when o.sortOrder = 13 then mo.objectiveId else null end) objectiveId13
	 , max(case when o.sortOrder = 14 then mo.objectiveId else null end) objectiveId14
	 , max(case when o.sortOrder = 15 then mo.objectiveId else null end) objectiveId15
	 , ge.loginGUID
  from Match m
	   inner join MatchObjective mo
	   on mo.matchId = m.id
	   inner join v_GameEvent ge
	   on ge.id = m.gameEventId
	   inner join Objective o
	   on o.id = mo.objectiveId
 where m.isActive = 'Y'
group by mo.alliance
       , mo.matchId
       , m.gameEventId
	   , m.redFoulPoints
	   , m.blueFoulPoints
	   , m.redScore
	   , m.blueScore
	   , ge.loginGUID) mo
inner join (
select tm.alliance
     , m.id matchId
     , m.gameEventId
	 , sum(case when o.sortOrder = 1 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 1 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value1
	 , sum(case when o.sortOrder = 2 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 2 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value2
	 , sum(case when o.sortOrder = 3 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 3 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value3
	 , sum(case when o.sortOrder = 4 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 4 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value4
	 , sum(case when o.sortOrder = 5 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 5 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value5
	 , sum(case when o.sortOrder = 6 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 6 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value6
	 , sum(case when o.sortOrder = 7 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 7 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value7
	 , sum(case when o.sortOrder = 8 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 8 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value8
	 , sum(case when o.sortOrder = 9 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 9 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value9
	 , sum(case when o.sortOrder = 10 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 10 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value10
	 , sum(case when o.sortOrder = 11 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 11 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value11
	 , sum(case when o.sortOrder = 12 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 12 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value12
	 , sum(case when o.sortOrder = 13 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 13 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value13
	 , sum(case when o.sortOrder = 14 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 14 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value14
	 , sum(case when o.sortOrder = 15 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 15 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value15
	 , sum(case when o.sortOrder = 1 then tmo.integerValue else null end) integerValue1
	 , sum(case when o.sortOrder = 2 then tmo.integerValue else null end) integerValue2
	 , sum(case when o.sortOrder = 3 then tmo.integerValue else null end) integerValue3
	 , sum(case when o.sortOrder = 4 then tmo.integerValue else null end) integerValue4
	 , sum(case when o.sortOrder = 5 then tmo.integerValue else null end) integerValue5
	 , sum(case when o.sortOrder = 6 then tmo.integerValue else null end) integerValue6
	 , sum(case when o.sortOrder = 7 then tmo.integerValue else null end) integerValue7
	 , sum(case when o.sortOrder = 8 then tmo.integerValue else null end) integerValue8
	 , sum(case when o.sortOrder = 9 then tmo.integerValue else null end) integerValue9
	 , sum(case when o.sortOrder = 10 then tmo.integerValue else null end) integerValue10
	 , sum(case when o.sortOrder = 11 then tmo.integerValue else null end) integerValue11
	 , sum(case when o.sortOrder = 12 then tmo.integerValue else null end) integerValue12
	 , sum(case when o.sortOrder = 13 then tmo.integerValue else null end) integerValue13
	 , sum(case when o.sortOrder = 14 then tmo.integerValue else null end) integerValue14
	 , sum(case when o.sortOrder = 15 then tmo.integerValue else null end) integerValue15
	 , sum(case when o.sortOrder = 1
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue1
	 , sum(case when o.sortOrder = 2  
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue2
	 , sum(case when o.sortOrder = 3 
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue3
	 , sum(case when o.sortOrder = 4 
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue4
	 , sum(case when o.sortOrder = 5 
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue5
	 , sum(case when o.sortOrder = 6 
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue6
	 , sum(case when o.sortOrder = 7 
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue7
	 , sum(case when o.sortOrder = 8 
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue8
	 , sum(case when o.sortOrder = 9 
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue9
	 , sum(case when o.sortOrder = 10 
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue10
	 , sum(case when o.sortOrder = 11 
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue11
	 , sum(case when o.sortOrder = 12 
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue12
	 , sum(case when o.sortOrder = 13 
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue13
	 , sum(case when o.sortOrder = 14 
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue14
	 , sum(case when o.sortOrder = 15 
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue15
	 , case when tm.alliance = 'R' then m.redFoulPoints
	        when tm.alliance = 'B' then m.blueFoulPoints
	        else null end matchFoulPoints
	 , case when tm.alliance = 'R' then m.redScore
	        when tm.alliance = 'B' then m.blueScore
	        else null end matchScore
	 , max(case when o.sortOrder = 1 then tmo.objectiveId else null end) objectiveId1
	 , max(case when o.sortOrder = 2 then tmo.objectiveId else null end) objectiveId2
	 , max(case when o.sortOrder = 3 then tmo.objectiveId else null end) objectiveId3
	 , max(case when o.sortOrder = 4 then tmo.objectiveId else null end) objectiveId4
	 , max(case when o.sortOrder = 5 then tmo.objectiveId else null end) objectiveId5
	 , max(case when o.sortOrder = 6 then tmo.objectiveId else null end) objectiveId6
	 , max(case when o.sortOrder = 7 then tmo.objectiveId else null end) objectiveId7
	 , max(case when o.sortOrder = 8 then tmo.objectiveId else null end) objectiveId8
	 , max(case when o.sortOrder = 9 then tmo.objectiveId else null end) objectiveId9
	 , max(case when o.sortOrder = 10 then tmo.objectiveId else null end) objectiveId10
	 , max(case when o.sortOrder = 11 then tmo.objectiveId else null end) objectiveId11
	 , max(case when o.sortOrder = 12 then tmo.objectiveId else null end) objectiveId12
	 , max(case when o.sortOrder = 13 then tmo.objectiveId else null end) objectiveId13
	 , max(case when o.sortOrder = 14 then tmo.objectiveId else null end) objectiveId14
	 , max(case when o.sortOrder = 15 then tmo.objectiveId else null end) objectiveId15
	 , ge.loginGUID
  from Match m
	   inner join TeamMatch tm
	   on tm.matchId = m.id
	   inner join TeamMatchObjective tmo
	   on tmo.teamMatchId = tm.id
	   inner join v_GameEvent ge
	   on ge.id = m.gameEventId
	   inner join Objective o
	   on o.id = tmo.objectiveId
 where m.isActive = 'Y'
group by tm.alliance
       , m.id
       , m.gameEventId
	   , m.redFoulPoints
	   , m.blueFoulPoints
	   , m.redScore
	   , m.blueScore
	   , ge.loginGUID) tmo
on tmo.alliance = mo.alliance
and tmo.matchId = mo.matchId
