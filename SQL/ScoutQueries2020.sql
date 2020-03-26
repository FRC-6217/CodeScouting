/*
-- Rank by End Game, then Total Score
select tr.teamNumber
     , tr.totalScoreValue
	 , tr.value8 endGame
	 , case when (select count(*)
	                from TeamMatch tm
					     inner join Match m
						 on m.id = tm.matchId
						 inner join GameEvent ge
						 on ge.id = m.gameEventId
				   where ge.isActive = 'Y'
				     and m.isActive = 'Y'
					 and m.type <> 'QM'
					 and tm.teamId = tr.TeamId) > 0 then 'Y'
			else null end inPlayoff
  from v_TeamReport tr
 where tr.matchNumber = 'N/A'
order by 3 desc, 2 desc

-- Rank by Defense
select t.teamNumber
     , avg(asr.integerValue9) defAvg
	 , case when (select count(*)
	                from TeamMatch tm
					     inner join Match m
						 on m.id = tm.matchId
						 inner join GameEvent ge
						 on ge.id = m.gameEventId
				   where ge.isActive = 'Y'
				     and m.isActive = 'Y'
					 and m.type <> 'QM'
					 and tm.teamId = asr.TeamId) > 0 then 'Y'
			else null end inPlayoff
  from v_AvgScoutRecord asr
       inner join Match m
	   on m.id = asr.matchId
	   inner join GameEvent ge
	   on ge.id = m.gameEventId
	   inner join game g
	   on g.id = ge.gameId
	   inner join Event e
	   on e.id = ge.eventId
	   inner join Team t
	   on t.id = asr.teamId
 where g.name = 'Infinite Recharge'
   and e.name = 'Lake Superior Regional'
group by t.teamNumber, asr.teamId
--having avg(asr.integerValue9) <> 0
order by 2 desc

-- Statistics Based Defense Percentage
select subquery.teamNumber
     , subquery.scoutedPlayingDefense
     , sum(subquery.oppToPCScore) oppToPCScore
     , sum(subquery.oppAvgToPCScore) oppAvgToPCScore
     , sum(subquery.oppToPCScore) / sum(subquery.oppAvgToPCScore) defPercentage
  from (
select m.type
     , m.number
	 , tm.matchId
	 , tm.alliance
	 , tm.alliancePosition
	 , t.teamNumber
	 , t2.teamNumber oppTeamNumber
	 , tm2.alliance oppAlliance
	 , tm2.alliancePosition oppAlliancePosition
	 , asr.scoreValue5 + asr.scoreValue6 + asr.scoreValue7 oppToPCScore
	 , (select avg(asr2.scoreValue5 + asr2.scoreValue6 + asr2.scoreValue7)
	      from v_AvgScoutRecord asr2
	           inner join Match m2
	           on m2.id = asr2.matchId
		 where m2.gameEventId = m.gameEventId
		   and asr2.matchId <> asr.matchId -- include only other matches
		   and asr2.teamId = asr.teamId) oppAvgToPCScore
     , (select sum(case when asr3.integerValue9 <> 0 then 1 else 0 end)
          from v_AvgScoutRecord asr3
	           inner join Match m3
	           on m3.id = asr3.matchId
		 where m3.gameEventId = m.gameEventId
           and asr3.teamId = tm.teamId) scoutedPlayingDefense
  from TeamMatch tm
       inner join Team t
	   on t.id = tm.teamId
	   inner join Match m
	   on m.id = tm.matchId
	   inner join GameEvent ge
	   on ge.id = m.gameEventId
	   inner join game g
	   on g.id = ge.gameId
	   inner join Event e
	   on e.id = ge.eventId
	   inner join v_AvgScoutRecord asr
	   on asr.matchId = tm.matchId
	   inner join TeamMatch tm2
	   on tm2.matchId = asr.matchId
	   and tm2.teamId = asr.teamId
	   inner join Team t2
	   on t2.id = tm2.teamId
 where g.name = 'Infinite Recharge'
   and e.name = 'Lake Superior Regional'
   and m.type = 'QM'
   and tm2.alliance <> tm.alliance
--   and t.teamNumber in (8416, 7041, 2526)
--order by t.teamNumber, m.type, convert(integer, m.number)
   ) subquery
group by subquery.teamNumber
       , subquery.scoutedPlayingDefense
order by sum(subquery.oppToPCScore) / sum(subquery.oppAvgToPCScore)

-- Rank by Strength of Opponent/Partner
select subquery.teamNumber
     , subquery.rank eventRanking
	 , subquery.teamMatchCount
     , subquery.avgScoreValue teamAvgScoreValue
     , sum(case when subquery.allianceSide = 'Partner' then otherRobotAvgScoreValue else 0 end) / subquery.teamMatchCount partnerRobotsAvgScoreValue
     , sum(case when subquery.allianceSide = 'Opponent' then otherRobotAvgScoreValue else 0 end) / subquery.teamMatchCount opponentRobotsAvgScoreValue
     , (sum(case when subquery.allianceSide = 'Opponent' then otherRobotAvgScoreValue else 0 end) / subquery.teamMatchCount) -
       (sum(case when subquery.allianceSide = 'Partner' then otherRobotAvgScoreValue else 0 end) / subquery.teamMatchCount) robotsAvgScoreDifferential
  from (
select tr.teamNumber
     , tge.rank
     , tr.totalScoreValue avgScoreValue
	 , m.type
	 , m.number
	 , (select count(*)
	      from TeamMatch tm2
		       inner join Match m2
			   on m2.id = tm2.matchId
		 where tm2.teamId = tr.TeamId
		   and m2.gameEventId = ge.id
		   and m2.type = 'QM') teamMatchCount
	 , case when tm.alliance = tm2.alliance then 'Partner' else 'Opponent' end allianceSide
	 , tm2.alliance
	 , tm2.alliancePosition
	 , t2.teamNumber otherTeamNumber
	 , tr2.totalScoreValue otherRobotAvgScoreValue
  from v_TeamReport tr
	   inner join GameEvent ge
	   on ge.id = tr.gameEventId
       inner join TeamMatch tm
	   on tm.teamId = tr.TeamId
	   inner join Match m
	   on m.id = tm.matchId
	   and m.gameEventId = ge.id
	   inner join TeamGameEvent tge
	   on tge.teamId = tr.TeamId
	   and tge.gameEventId = ge.id
	   inner join TeamMatch tm2
	   on tm2.matchId = tm.matchId
	   and tm2.teamId <> tm.teamId
	   inner join Team t2
	   on t2.id = tm2.teamId
	   inner join v_TeamReport tr2
	   on tr2.TeamId = tm2.teamId
 where m.type = 'QM'
   and tr.matchNumber = 'N/A' -- Average for all games
   and tr2.matchNumber = 'N/A' -- Average for all games
--   and tr.TeamNumber = 6217
--order by tr.TeamNumber, convert(integer, m.number), tm2.alliance, tm2.alliancePosition
) subquery
group by subquery.TeamNumber
       , subquery.rank
       , subquery.avgScoreValue
	   , subquery.teamMatchCount
order by 7 desc, subquery.TeamNumber

-- Match Point Percentage
select subquery.teamNumber
     , sum(subquery.teamScore) / sum(subquery.teamScore + subquery.partnerScore) teamAlliancePercentage
	 , subquery.rank eventRank
	 , avg(subquery.teamScore) avgTeamScore
	 , avg(subquery.partnerScore) avgPartnerScore
  from (
select m.number
     , t.teamNumber
	 , tge.rank
	 , count(*) partnersScouted
	 , asr.scoreValue1 + asr.scoreValue2 + asr.scoreValue3 + asr.scoreValue4 + asr.scoreValue5 +
	   asr.scoreValue6 + asr.scoreValue7 + asr.scoreValue8 + asr.scoreValue9 + asr.scoreValue10 +
	   asr.scoreValue11 teamScore
	 , sum(asr2.scoreValue1 + asr2.scoreValue2 + asr2.scoreValue3 + asr2.scoreValue4 + asr2.scoreValue5 +
	       asr2.scoreValue6 + asr2.scoreValue7 + asr2.scoreValue8 + asr2.scoreValue9 + asr2.scoreValue10 +
	       asr2.scoreValue11) partnerScore
  from v_AvgScoutRecord asr
       inner join Team t
	   on t.id = asr.teamId
       inner join TeamMatch tm
	   on tm.matchId = asr.matchId
	   and tm.teamId = asr.teamId
	   inner join Match m
	   on m.id = asr.matchId
	   inner join GameEvent ge
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
 where asr2.teamId <> asr.teamId
--   and asr.teamId = 101
group by m.number
       , t.teamNumber
	   , tge.rank
	   , asr.scoreValue1 + asr.scoreValue2 + asr.scoreValue3 + asr.scoreValue4 + asr.scoreValue5 +
	     asr.scoreValue6 + asr.scoreValue7 + asr.scoreValue8 + asr.scoreValue9 + asr.scoreValue10 +
	     asr.scoreValue11
having count(*) = 2
--order by m.type, convert(integer, m.number)
) subquery
group by subquery.teamNumber
  	   , subquery.rank
order by 2 desc
*/

-- Scouted Data Accuracy
select subquery.allianceScore
     , subquery.teamScore + subquery.partnerScore + subquery.allianceTeamPoints + subquery.allianceFoulPoints calcAllianceScore
     , subquery.allianceScore - (subquery.teamScore + subquery.partnerScore + subquery.allianceTeamPoints + subquery.allianceFoulPoints calcAllianceScore) deltaScore
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
	 , asr.scoreValue1 + asr.scoreValue2 + asr.scoreValue3 + asr.scoreValue4 + asr.scoreValue5 +
	   asr.scoreValue6 + asr.scoreValue7 + asr.scoreValue8 + asr.scoreValue9 + asr.scoreValue10 +
	   asr.scoreValue11 teamScore
	 , sum(asr2.scoreValue1 + asr2.scoreValue2 + asr2.scoreValue3 + asr2.scoreValue4 + asr2.scoreValue5 +
	       asr2.scoreValue6 + asr2.scoreValue7 + asr2.scoreValue8 + asr2.scoreValue9 + asr2.scoreValue10 +
	       asr2.scoreValue11) partnerScore
	 , case when tm.alliance = 'R' then coalesce(m.redTeamPoints, 0)
	        when tm.alliance = 'B' then coalesce(m.blueTeamPoints, 0)
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
	   inner join GameEvent ge
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
 where asr2.teamId <> asr.teamId
--   and asr.teamId = 101
group by m.type
       , m.number
	   , t.teamNumber
	   , tge.rank
	   , tm.alliance
	   , case when tm.alliance = 'R' then m.redScore
	          when tm.alliance = 'B' then m.blueScore
	          else 0 end
	   , asr.scoreValue1 + asr.scoreValue2 + asr.scoreValue3 + asr.scoreValue4 + asr.scoreValue5 +
	     asr.scoreValue6 + asr.scoreValue7 + asr.scoreValue8 + asr.scoreValue9 + asr.scoreValue10 +
	     asr.scoreValue11
  	   , case when tm.alliance = 'R' then coalesce(m.redTeamPoints, 0)
	          when tm.alliance = 'B' then coalesce(m.blueTeamPoints, 0)
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
 where subquery.allianceScore <> subquery.teamScore + subquery.partnerScore + subquery.allianceTeamPoints + subquery.allianceFoulPoints
order by subquery.allianceScore - (subquery.teamScore + subquery.partnerScore + subquery.allianceTeamPoints + subquery.allianceFoulPoints)
       , subquery.type, convert(integer, subquery.number), subquery.alliance

--update GameEvent set isActive = 'N' where id = 2; -- Iowa 2019
--update GameEvent set isActive = 'Y' where id = 7; -- Duluth 2020
/*
update Objective set reportDisplay = 'S' where gameid = 2

select tr.TeamNumber
     , tr.scoutId
     , tr.matchId
	 , tr.TeamId
	 , tm.alliance + convert(varchar, tm.alliancePosition) alliancePos
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
	                         ', ' + convert(varchar, tr.value11) stmt
  from v_TeamReport tr
       inner join TeamMatch tm
	   on tm.teamId = tr.TeamId
	   and tm.matchId = tr.matchId
-- where matchNumber = 'QM 17' order by 5
-- where tr.value1 not in (0, 1) or tr.value2 > 3 or tr.value3 > 3 or tr.value4 > 3 order by 1
 where tr.value5 > 0 and (tr.value3 > 0 or tr.value4 > 0 or tr.value6 > 0 or tr.value7 > 0)

exec sp_ins_scoutRecord 18, 1100, 108, 'R2', 1.000000, 0.000000, 0.000000, 0.000000, 3.000000, 0.000000, 0.000000, 2.000000, 0.000000, 0.000000, 0.000000

*/
