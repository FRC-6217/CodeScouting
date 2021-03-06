-- Fix Scout Data that can be directly updated based on Blue Alliance Data - this is for currently active Game Event
exec sp_upd_scoutDataFromTba 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3'

-- Compare Total Score Scout Data to Blue Alliance Score
select m.id matchId
     , m.number matchNumber
	 , tm.alliance
	 , sum(asor.avgScoreValue) scoutScoreValue
	 , case when tm.alliance = 'R' then m.redScore - m.redFoulPoints - m.redAlliancePoints
	        else m.blueScore - m.blueFoulPoints - m.blueAlliancePoints end tbaMatchAdjustedScore
	 , sum(asor.avgScoreValue) -
	   case when tm.alliance = 'R' then m.redScore - m.redFoulPoints - m.redAlliancePoints
	        else m.blueScore - m.blueFoulPoints - m.blueAlliancePoints end matchScoreDelta
  from v_AvgScoutObjectiveRecord asor
       inner join TeamMatch tm
	   on tm.matchId = asor.matchId
	   and tm.teamId = asor.teamId
	   inner join Match m
	   on m.id = asor.matchId
	   inner join v_GameEvent ge
	   on ge.id = m.gameEventId
 where ge.loginGUID = 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3'
   and m.isActive = 'Y'
   and exists
       (select 1
	     from ScoutRecord sr
		      inner join Scout s
			  on s.id = sr.scoutId
		where sr.matchId = tm.matchId
		  and sr.teamId = tm.teamId
		  and s.lastName <> 'TBA')
group by m.id
	   , m.dateTime
 	   , m.number
	   , tm.alliance
 	   , case when tm.alliance = 'R' then m.redScore - m.redFoulPoints - m.redAlliancePoints
	          else m.blueScore - m.blueFoulPoints - m.blueAlliancePoints end
having sum(asor.avgScoreValue) <>
       case when tm.alliance = 'R' then m.redScore - m.redFoulPoints - m.redAlliancePoints
	        else m.blueScore - m.blueFoulPoints - m.blueAlliancePoints end
order by m.datetime, tm.alliance;

-- Compare Total Score Scout Data to Blue Alliance Score
select m.id matchId
	 , m.number matchNumber
	 , tm.alliance
     , asor.objectiveName
	 , sum(asor.avgScoreValue) scoutScoreValue
	 , mo.scoreValue tbaObjectiveScore
	 , sum(asor.avgScoreValue) -
	   mo.scoreValue objectiveScoreDelta
  from v_AvgScoutObjectiveRecord asor
       inner join TeamMatch tm
	   on tm.matchId = asor.matchId
	   and tm.teamId = asor.teamId
       inner join MatchObjective mo
	   on mo.matchId = asor.matchId
	   and mo.objectiveId = asor.objectiveId
	   and mo.alliance = tm.alliance
	   inner join Team t
	   on t.id = asor.teamId
	   inner join Match m
	   on m.id = asor.matchId
	   inner join v_GameEvent ge
	   on ge.id = m.gameEventId
 where ge.loginGUID = 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3'
group by m.id
       , m.number
	   , m.dateTime
       , asor.objectiveName
	   , tm.alliance
	   , mo.scoreValue
having mo.scoreValue <> sum(asor.avgScoreValue)
order by m.datetime, tm.alliance, asor.objectiveName;

-- Scouted Data Accuracy - scout records needing correction
select subquery.allianceScore
     , subquery.teamScore + subquery.partnerScore + subquery.allianceFoulPoints calcAllianceScore
     , subquery.allianceScore - (subquery.teamScore + subquery.partnerScore + subquery.allianceFoulPoints) deltaScore
     , subquery.*
  from (
select m.type
     , m.number
	 , t.teamNumber
	 , tge.rank
	 , tm.alliance
	 , count(*) partnersScouted
	 , case when tm.alliance = 'R' then m.redScore
	        when tm.alliance = 'B' then m.blueScore
	        else 0 end allianceScore
	 , tm.portionOfAlliancePoints
	 , asr.scoreValue1 + asr.scoreValue2 + asr.scoreValue3 + asr.scoreValue4 + asr.scoreValue5 +
	   asr.scoreValue6 + asr.scoreValue7 + asr.scoreValue8 + asr.scoreValue9 + asr.scoreValue10 +
	   asr.scoreValue11 teamScore
	 , sum(asr2.scoreValue1 + asr2.scoreValue2 + asr2.scoreValue3 + asr2.scoreValue4 + asr2.scoreValue5 +
	       asr2.scoreValue6 + asr2.scoreValue7 + asr2.scoreValue8 + asr2.scoreValue9 + asr2.scoreValue10 +
	       asr2.scoreValue11) partnerScore
	 , case when tm.alliance = 'R' then coalesce(m.redAlliancePoints, 0)
	        when tm.alliance = 'B' then coalesce(m.blueAlliancePoints, 0)
	        else 0 end allianceTeamPoints
	 , case when tm.alliance = 'R' then coalesce(m.redFoulPoints, 0)
	        when tm.alliance = 'B' then coalesce(m.blueFoulPoints, 0)
	        else 0 end allianceFoulPoints
	 , asr.integerValue1 + sum(asr2.integerValue1) aMove
	 , asr.integerValue2 + sum(asr2.integerValue2) aLower
	 , asr.integerValue3 + sum(asr2.integerValue3) aOuter
	 , asr.integerValue4 + sum(asr2.integerValue4) aInner
	 , asr.integerValue5 + sum(asr2.integerValue5) toLower
	 , asr.integerValue6 + sum(asr2.integerValue6) toOuter
	 , asr.integerValue7 + sum(asr2.integerValue7) toInner
	 , asr.scoreValue8 + sum(asr2.scoreValue8) endGame
	 , asr.matchId
  from v_AvgScoutRecord asr
       inner join Team t
	   on t.id = asr.teamId
       inner join TeamMatch tm
	   on tm.matchId = asr.matchId
	   and tm.teamId = asr.teamId
	   inner join Match m
	   on m.id = asr.matchId
	   inner join v_GameEvent ge
	   on ge.id = m.gameEventId
	   inner join TeamGameEvent tge
	   on tge.gameEventId = ge.id
	   and tge.teamId = asr.teamId
	   inner join v_AvgScoutRecord asr2
	   on asr2.matchId = asr.matchId
       inner join TeamMatch tm2
	   on tm2.matchId = asr2.matchId
	   and tm2.teamId = asr2.teamId
	   and tm2.alliance = tm.alliance
 where ge.loginGUID = 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3'
   and asr.loginGUID = 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3'
   and asr2.loginGUID = 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3'
   and asr2.teamId <> asr.teamId
--   and asr.teamId = 101
group by m.type
       , m.number
	   , t.teamNumber
	   , tge.rank
	   , tm.alliance
	   , case when tm.alliance = 'R' then m.redScore
	          when tm.alliance = 'B' then m.blueScore
	          else 0 end
	   , tm.portionOfAlliancePoints
	   , asr.scoreValue1 + asr.scoreValue2 + asr.scoreValue3 + asr.scoreValue4 + asr.scoreValue5 +
	     asr.scoreValue6 + asr.scoreValue7 + asr.scoreValue8 + asr.scoreValue9 + asr.scoreValue10 +
	     asr.scoreValue11
  	   , case when tm.alliance = 'R' then coalesce(m.redAlliancePoints, 0)
	          when tm.alliance = 'B' then coalesce(m.blueAlliancePoints, 0)
	          else 0 end
	   , case when tm.alliance = 'R' then coalesce(m.redFoulPoints, 0)
	          when tm.alliance = 'B' then coalesce(m.blueFoulPoints, 0)
	          else 0 end
	   , asr.integerValue1
	   , asr.integerValue2
	   , asr.integerValue3
	   , asr.integerValue4
	   , asr.integerValue5
	   , asr.integerValue6
	   , asr.integerValue7
	   , asr.scoreValue8
	   , asr.matchId) subquery
 where subquery.allianceScore <> subquery.teamScore + subquery.partnerScore + subquery.allianceFoulPoints
--and subquery.number = 50
order by abs(subquery.allianceScore - (subquery.teamScore + subquery.partnerScore + subquery.allianceFoulPoints)) desc, subquery.alliance

/*
-- Set objective to counts versus score to make cleanup easier
update Objective set reportDisplay = 'I' where gameid = 2 --and id <> 113
-- Reset objective to back to score for online reports
update Objective set reportDisplay = 'S' where gameid = 2 --and id <> 113

-- Match reports to cleanup
select tr.matchNumber
     , tm.alliance + convert(varchar, tm.alliancePosition) alliancePos
	 , tr.TeamNumber
	 , tr.totalScoreValue teamScore
	 , case when tm.alliance = 'R' then m.redScore else m.blueScore end allianceScore
	 , case when tm.alliance = 'R' then m.redAlliancePoints else m.blueAlliancePoints end allianceTeamPoints
	 , case when tm.alliance = 'R' then m.redFoulPoints else m.blueFoulPoints end allianceFoulPoints
	 , 'exec sp_ins_scoutRecord ' + convert(varchar, tr.scoutId) +
	                         ', ' + convert(varchar, tr.matchId) +
	                         ', ' + convert(varchar, tr.teamId) +
	                         ', ''' + tm.alliance + convert(varchar, tm.alliancePosition) + '''' + 
	                         ', ' + convert(varchar, tr.value1) +
	                         ', ' + convert(varchar, tr.value2) +
	                         ', ' + convert(varchar, tr.value3) +
	                         ', ' + convert(varchar, tr.value4) +
	                         ', ' + convert(varchar, tr.value5) +
	                         ', ' + convert(varchar, tr.value6) +
	                         ', ' + convert(varchar, tr.value7) +
	                         ', ' + convert(varchar, tr.value8) +
	                         ', ' + convert(varchar, tr.value9) +
	                         ', ' + convert(varchar, tr.value10) +
	                         ', ' + convert(varchar, tr.value11) +
							 ' -- ' + convert(varchar, tr.teamNumber) stmt
     , tr.scoutId
     , tr.matchId
	 , tr.TeamId
	 , tr.value1
	 , tr.value2
	 , tr.value3
	 , tr.value4
	 , tr.value5
	 , tr.value6
	 , tr.value7
	 , tr.value8
	 , tr.value9
	 , tr.value10
	 , tr.value11
  from v_TeamReport tr
       inner join TeamMatch tm
	   on tm.teamId = tr.TeamId
	   and tm.matchId = tr.matchId
	   inner join Match m
	   on m.id = tm.matchId
 where tr.matchNumber in ('QM 54','QM 70') order by tr.matchNumber, tm.alliance desc, convert(varchar, tm.alliancePosition)
-- where tr.value1 not in (0, 1) or tr.value2 > 3 or tr.value3 > 3 or tr.value4 > 3 order by 1
-- where tr.value5 > 0 and (tr.value3 > 0 or tr.value4 > 0 or tr.value6 > 0 or tr.value7 > 0)

-- SQL used to cleanup data after viewing video of match
exec sp_ins_scoutRecord 15, 1159, 85, 'B1', 1.000000, 0.000000, 2.000000, 0.000000, 0.000000, 4.000000, 1.000000, 1.000000, 0.000000, 0.000000, 0.000000 -- 5653
exec sp_ins_scoutRecord 1, 1159, 1, 'B2', 1.000000, 0.000000, 0.000000, 0.000000, 0.000000, 3.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000 -- 93
exec sp_ins_scoutRecord 30, 1159, 44, 'B3', 1.000000, 0.000000, 0.000000, 0.000000, 1.000000, 0.000000, 0.000000, 1.000000, -1.000000, 0.000000, 0.000000 -- 3291

*/

