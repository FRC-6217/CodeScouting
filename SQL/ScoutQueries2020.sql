/*
-- Rank by End Game, then Total Score
select tr.teamNumber
     , tr.totalScoreValue
	 , tr.value8 endGame
	 , case when (select count(*)
	                from TeamMatch tm
					     inner join Match m
						 on m.id = tm.matchId
                         inner join v_GameEvent ge
	                     on ge.id = m.gameEventId
						 inner join GameEvent ge
						 on ge.id = m.gameEventId
				   where ge.loginGUID = 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3'
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
						 inner join v_GameEvent ge
						 on ge.id = m.gameEventId
				   where ge.loginGUID = 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3'
				     and m.isActive = 'Y'
					 and m.type <> 'QM'
					 and tm.teamId = asr.TeamId) > 0 then 'Y'
			else null end inPlayoff
  from v_AvgScoutRecord asr
       inner join Match m
	   on m.id = asr.matchId
	   inner join v_GameEvent ge
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

-- Best team individual matches
select tr.teamNumber
     , m.type + convert(varchar, m.number) matchNumber
	 , tm.alliance + convert(varchar, tm.alliancePosition) alliancePosition
	 , tr.totalScoreValue teamScore
	 , tr.value1 aMove
	 , tr.value2 aLower
	 , tr.value3 aOuter
	 , tr.value4 aInner
	 , tr.value5 toLower
	 , tr.value6 toOuter
	 , tr.value7 toInner
	 , tr.value8 endGame
     , tge.rank eventRank
  from v_TeamReport tr
	   inner join Match m
	   on m.id = tr.matchId
	   inner join TeamGameEvent tge
	   on tge.gameEventId = m.gameEventId
	   and tge.teamId = tr.TeamId
	   inner join TeamMatch tm
	   on tm.matchId = tr.matchId
	   and tm.teamId = tr.teamId
order by tr.totalScoreValue desc

-- Allocate Team and Foul Points to Robots
select subquery.teamNumber
     , avg(subquery.totalScoreValue) avgScoreValue
	 , avg(subquery.robotPortionOfAlliancePoints) avgPortionOfAlliancePoints 
	 , avg(subquery.robotPortionOfFoulPoints) avgPortionOfFoulPoints
     , avg(subquery.totalScoreValue) + 
	   avg(subquery.robotPortionOfAlliancePoints) avgScoreWithAlliancePoints
     , avg(subquery.totalScoreValue) + 
	   avg(subquery.robotPortionOfAlliancePoints) -
	   avg(subquery.robotPortionOfFoulPoints) avgScoreWithTeamAndFoulPoints
  from (
select m.type
     , m.number
	 , t.teamNumber
	 , tm.alliance
	 , tm.alliancePosition
	 , tr.value1 aMove
	 , tr.value2 aLower
	 , tr.value3 aOuter
	 , tr.value4 aInner
	 , tr.value5 toLower
	 , tr.value6 toOuter
	 , tr.value7 toInner
	 , tr.value8 endGame
	 , tr.totalScoreValue
	 , case when alliance = 'R' then redAlliancePoints else blueAlliancePoints end AlliancePoints
	 , case when alliance = 'R' then redFoulPoints else blueFoulPoints end foulPoints
	 , coalesce(tm.portionOfAlliancePoints, 0) robotPortionOfAlliancePoints
	 , case when tm.alliance = 'R' then convert(decimal(18,3), m.redFoulPoints) else convert(decimal(18,3), m.blueFoulPoints) end / 3.0 robotPortionOfFoulPoints
  from v_GameEvent ge
       inner join Match m
	   on m.gameEventId = ge.id
	   inner join TeamMatch tm
	   on tm.matchId = m.id
	   inner join Team t
	   on t.id = tm.teamId
	   inner join v_TeamReport tr
	   on tr.gameEventId = ge.id
	   and tr.matchId = m.id
	   and tr.teamId = t.id
 where ge.loginGUID = 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3'
--order by m.type, convert(integer, m.number), tm.alliance, tm.alliancePosition, t.teamNumber
) subquery
group by subquery.teamNumber
order by 6 desc
*/

-- Matches won/lost on fouls?
select m.type + ' ' + m.number matchNumber
	 , m.redScore
	 , m.blueScore
	 , m.redFoulPoints
	 , m.blueFoulPoints
	 , m.redScore - m.redFoulPoints redWithoutFouls
	 , m.blueScore - m.blueFoulPoints blueWithoutFouls
	 , case when m.redScore > m.blueScore then 'Red'
	        when m.redScore < m.blueScore then 'Blue'
	        else 'Tie' end winningAlliance
	 , convert(varchar,
	   (select t.teamNumber
	      from TeamMatch tm
	           inner join Team t
	           on t.id = tm.teamId
         where tm.matchId = m.id
		   and tm.alliance = 'R'
		   and tm.alliancePosition = 1)) + ', ' +
	   convert(varchar,
	   (select t.teamNumber
	      from TeamMatch tm
	           inner join Team t
	           on t.id = tm.teamId
         where tm.matchId = m.id
		   and tm.alliance = 'R'
		   and tm.alliancePosition = 2)) + ', ' +
	   convert(varchar,
	   (select t.teamNumber
	      from TeamMatch tm
	           inner join Team t
	           on t.id = tm.teamId
         where tm.matchId = m.id
		   and tm.alliance = 'R'
		   and tm.alliancePosition = 3)) redAlliance
	 , convert(varchar,
	   (select t.teamNumber
	      from TeamMatch tm
	           inner join Team t
	           on t.id = tm.teamId
         where tm.matchId = m.id
		   and tm.alliance = 'B'
		   and tm.alliancePosition = 1)) + ', ' +
	   convert(varchar,
	   (select t.teamNumber
	      from TeamMatch tm
	           inner join Team t
	           on t.id = tm.teamId
         where tm.matchId = m.id
		   and tm.alliance = 'B'
		   and tm.alliancePosition = 2)) + ', ' +
	   convert(varchar,
	   (select t.teamNumber
	      from TeamMatch tm
	           inner join Team t
	           on t.id = tm.teamId
         where tm.matchId = m.id
		   and tm.alliance = 'B'
		   and tm.alliancePosition = 3)) blueAlliance
	 , abs(m.redScore - m.blueScore) scoreDiff
	 , case when m.redScore > m.blueScore
              then m.redScore - m.blueScore - m.redFoulPoints + m.blueFoulPoints
	          when m.redScore < m.blueScore
			  then m.blueScore - m.redScore - m.blueFoulPoints + m.redFoulPoints
              else 0 end scoreDiffWithoutFouls
     , case when m.redScore > m.blueScore and
                 (m.redScore - m.redFoulPoints) <= (m.blueScore - m.blueFoulPoints)
			then 'Y'
	        when m.redScore < m.blueScore and
                 (m.redScore - m.redFoulPoints) >= (m.blueScore - m.blueFoulPoints)
			then 'Y'
            else 'N' end foulsAffectedWinner
  from Match m
       inner join v_GameEvent ge
	   on ge.id = m.gameEventId
 where ge.loginGUID = 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3'
   and m.isActive = 'Y'
--order by case when redFoulPoints > blueFoulPoints then redFoulPoints else blueFoulPoints end desc, m.dateTime
order by case when m.redScore > m.blueScore
              then m.redScore - m.blueScore - m.redFoulPoints + m.blueFoulPoints
	          when m.redScore < m.blueScore
			  then m.blueScore - m.redScore - m.blueFoulPoints + m.redFoulPoints
              else 0 end
	   , m.dateTime
