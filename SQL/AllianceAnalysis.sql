-- Default to my active event
declare @loginGUID uniqueidentifier;
set @loginGUID = 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3';

-- Update Scoring Ranks and Averages for the event
exec sp_upd_TeamScoringImpact @loginGUID

-- Get the number of teams in the event 
declare @teamCount int;
declare @gameEventId int;

select @teamCount = count(*)
     , @gameEventId = max(t.gameEventId)
  from scout s
       inner join team t
	   on t.id = s.teamId
	   inner join teamGameEvent tge
	   on tge.gameEventId = t.gameEventId
 where s.scoutGUID = @loginGUID

select g.name
     , e.name
	 , t.teamNumber
	 , t.teamName
	 , tge.rank
	 , tge.scoringRank
	 , tge.scoringRank - tge.rank diffRank
	 , (select round(avg(tge2.scoringAverage), 2)
	      from match m
		       inner join teamMatch tm
			   on tm.matchId = m.id
		       and tm.teamId = t.id
			   inner join teamMatch tm2
			   on tm2.matchId = m.id
			   and tm2.teamId <> t.id
			   and tm.alliance = tm2.alliance
			   inner join team t2
			   on t2.id = tm2.teamId
			   inner join teamGameEvent tge2
			   on tge2.gameEventId = ge.id
			   and tge2.teamId = t2.id
		 where 1=1
		   and m.gameEventId = ge.id
		   and m.type = 'QM') -
	   (select round(avg(tge2.scoringAverage), 2)
	      from match m
		       inner join teamMatch tm
			   on tm.matchId = m.id
		       and tm.teamId = t.id
			   inner join teamMatch tm2
			   on tm2.matchId = m.id
			   and tm2.teamId <> t.id
			   and tm.alliance <> tm2.alliance
			   inner join team t2
			   on t2.id = tm2.teamId
			   inner join teamGameEvent tge2
			   on tge2.gameEventId = ge.id
			   and tge2.teamId = t2.id
		 where 1=1
		   and m.gameEventId = ge.id
		   and m.type = 'QM') diffAllianceAverage
	 , (select round(avg(tge2.scoringAverage), 2)
	      from match m
		       inner join teamMatch tm
			   on tm.matchId = m.id
		       and tm.teamId = t.id
			   inner join teamMatch tm2
			   on tm2.matchId = m.id
			   and tm2.teamId <> t.id
			   and tm.alliance = tm2.alliance
			   inner join team t2
			   on t2.id = tm2.teamId
			   inner join teamGameEvent tge2
			   on tge2.gameEventId = ge.id
			   and tge2.teamId = t2.id
		 where 1=1
		   and m.gameEventId = ge.id
		   and m.type = 'QM') avgAllianceAverage
     , (select round(avg(tge2.scoringAverage), 2)
	      from match m
		       inner join teamMatch tm
			   on tm.matchId = m.id
		       and tm.teamId = t.id
			   inner join teamMatch tm2
			   on tm2.matchId = m.id
			   and tm2.teamId <> t.id
			   and tm.alliance <> tm2.alliance
			   inner join team t2
			   on t2.id = tm2.teamId
			   inner join teamGameEvent tge2
			   on tge2.gameEventId = ge.id
			   and tge2.teamId = t2.id
		 where 1=1
		   and m.gameEventId = ge.id
		   and m.type = 'QM') avgOpponentAverage
	 , (select round(avg(convert(decimal, tge2.scoringRank)), 2)
	      from match m
		       inner join teamMatch tm
			   on tm.matchId = m.id
		       and tm.teamId = t.id
			   inner join teamMatch tm2
			   on tm2.matchId = m.id
			   and tm2.teamId <> t.id
			   and tm.alliance = tm2.alliance
			   inner join team t2
			   on t2.id = tm2.teamId
			   inner join teamGameEvent tge2
			   on tge2.gameEventId = ge.id
			   and tge2.teamId = t2.id
		 where 1=1
		   and m.gameEventId = ge.id
		   and m.type = 'QM') -
	   (select round(avg(convert(decimal, tge2.scoringRank)), 2)
	      from match m
		       inner join teamMatch tm
			   on tm.matchId = m.id
		       and tm.teamId = t.id
			   inner join teamMatch tm2
			   on tm2.matchId = m.id
			   and tm2.teamId <> t.id
			   and tm.alliance <> tm2.alliance
			   inner join team t2
			   on t2.id = tm2.teamId
			   inner join teamGameEvent tge2
			   on tge2.gameEventId = ge.id
			   and tge2.teamId = t2.id
		 where 1=1
		   and m.gameEventId = ge.id
		   and m.type = 'QM') diffAllianceRank
	 , (select round(avg(convert(decimal, tge2.scoringRank)), 2)
	      from match m
		       inner join teamMatch tm
			   on tm.matchId = m.id
		       and tm.teamId = t.id
			   inner join teamMatch tm2
			   on tm2.matchId = m.id
			   and tm2.teamId <> t.id
			   and tm.alliance = tm2.alliance
			   inner join team t2
			   on t2.id = tm2.teamId
			   inner join teamGameEvent tge2
			   on tge2.gameEventId = ge.id
			   and tge2.teamId = t2.id
		 where 1=1
		   and m.gameEventId = ge.id
		   and m.type = 'QM') avgAllianceRank
/*
     , (select min(tge2.scoringRank)
	      from match m
		       inner join teamMatch tm
			   on tm.matchId = m.id
		       and tm.teamId = t.id
			   inner join teamMatch tm2
			   on tm2.matchId = m.id
			   and tm2.teamId <> t.id
			   and tm.alliance = tm2.alliance
			   inner join team t2
			   on t2.id = tm2.teamId
			   inner join teamGameEvent tge2
			   on tge2.gameEventId = ge.id
			   and tge2.teamId = t2.id
		 where 1=1
		   and m.gameEventId = ge.id
		   and m.type = 'QM') minAllianceRank
	 , (select max(tge2.scoringRank)
	      from match m
		       inner join teamMatch tm
			   on tm.matchId = m.id
		       and tm.teamId = t.id
			   inner join teamMatch tm2
			   on tm2.matchId = m.id
			   and tm2.teamId <> t.id
			   and tm.alliance = tm2.alliance
			   inner join team t2
			   on t2.id = tm2.teamId
			   inner join teamGameEvent tge2
			   on tge2.gameEventId = ge.id
			   and tge2.teamId = t2.id
		 where 1=1
		   and m.gameEventId = ge.id
		   and m.type = 'QM') maxAllianceRank
*/
     , (select round(avg(convert(decimal, tge2.scoringRank)), 2)
	      from match m
		       inner join teamMatch tm
			   on tm.matchId = m.id
		       and tm.teamId = t.id
			   inner join teamMatch tm2
			   on tm2.matchId = m.id
			   and tm2.teamId <> t.id
			   and tm.alliance <> tm2.alliance
			   inner join team t2
			   on t2.id = tm2.teamId
			   inner join teamGameEvent tge2
			   on tge2.gameEventId = ge.id
			   and tge2.teamId = t2.id
		 where 1=1
		   and m.gameEventId = ge.id
		   and m.type = 'QM') avgOpponentRank
/*
	 , (select min(tge2.scoringRank)
	      from match m
		       inner join teamMatch tm
			   on tm.matchId = m.id
		       and tm.teamId = t.id
			   inner join teamMatch tm2
			   on tm2.matchId = m.id
			   and tm2.teamId <> t.id
			   and tm.alliance <> tm2.alliance
			   inner join team t2
			   on t2.id = tm2.teamId
			   inner join teamGameEvent tge2
			   on tge2.gameEventId = ge.id
			   and tge2.teamId = t2.id
		 where 1=1
		   and m.gameEventId = ge.id
		   and m.type = 'QM') minOpponentRank
	 , (select max(tge2.scoringRank)
	      from match m
		       inner join teamMatch tm
			   on tm.matchId = m.id
		       and tm.teamId = t.id
			   inner join teamMatch tm2
			   on tm2.matchId = m.id
			   and tm2.teamId <> t.id
			   and tm.alliance <> tm2.alliance
			   inner join team t2
			   on t2.id = tm2.teamId
			   inner join teamGameEvent tge2
			   on tge2.gameEventId = ge.id
			   and tge2.teamId = t2.id
		 where 1=1
		   and m.gameEventId = ge.id
		   and m.type = 'QM') maxOpponentRank
*/
     , (select sum(case when tge2.scoringRank <= 10 then 1 else 0 end)
	      from match m
		       inner join teamMatch tm
			   on tm.matchId = m.id
		       and tm.teamId = t.id
			   inner join teamMatch tm2
			   on tm2.matchId = m.id
			   and tm2.teamId <> t.id
			   and tm.alliance = tm2.alliance
			   inner join team t2
			   on t2.id = tm2.teamId
			   inner join teamGameEvent tge2
			   on tge2.gameEventId = ge.id
			   and tge2.teamId = t2.id
		 where 1=1
		   and m.gameEventId = ge.id
		   and m.type = 'QM') top10AlliancePartners
     , (select sum(case when tge2.scoringRank <= 10 then 1 else 0 end)
	      from match m
		       inner join teamMatch tm
			   on tm.matchId = m.id
		       and tm.teamId = t.id
			   inner join teamMatch tm2
			   on tm2.matchId = m.id
			   and tm2.teamId <> t.id
			   and tm.alliance <> tm2.alliance
			   inner join team t2
			   on t2.id = tm2.teamId
			   inner join teamGameEvent tge2
			   on tge2.gameEventId = ge.id
			   and tge2.teamId = t2.id
		 where 1=1
		   and m.gameEventId = ge.id
		   and m.type = 'QM') top10AllianceOpponents
     , (select sum(case when tge2.scoringRank >= @teamCount - 10 then 1 else 0 end)
	      from match m
		       inner join teamMatch tm
			   on tm.matchId = m.id
		       and tm.teamId = t.id
			   inner join teamMatch tm2
			   on tm2.matchId = m.id
			   and tm2.teamId <> t.id
			   and tm.alliance = tm2.alliance
			   inner join team t2
			   on t2.id = tm2.teamId
			   inner join teamGameEvent tge2
			   on tge2.gameEventId = ge.id
			   and tge2.teamId = t2.id
			   inner join gameEvent ge2
			   on ge2.id = tge2.gameEventId 
			   inner join event e2
			   on e2.id = ge2.eventId
		 where 1=1
		   and m.gameEventId = ge.id
		   and m.type = 'QM') bottem10AlliancePartners
     , (select sum(case when tge2.scoringRank >= @teamCount - 10 then 1 else 0 end)
	      from match m
		       inner join teamMatch tm
			   on tm.matchId = m.id
		       and tm.teamId = t.id
			   inner join teamMatch tm2
			   on tm2.matchId = m.id
			   and tm2.teamId <> t.id
			   and tm.alliance <> tm2.alliance
			   inner join team t2
			   on t2.id = tm2.teamId
			   inner join teamGameEvent tge2
			   on tge2.gameEventId = ge.id
			   and tge2.teamId = t2.id
			   inner join gameEvent ge2
			   on ge2.id = tge2.gameEventId 
			   inner join event e2
			   on e2.id = ge2.eventId
		 where 1=1
		   and m.gameEventId = ge.id
		   and m.type = 'QM') bottem10AllianceOpponents
	 , (select count(*)
	      from match m
		       inner join teamMatch tm
			   on tm.matchId = m.id
		       and tm.teamId = t.id
		 where 1=1
		   and m.gameEventId = ge.id
		   and m.type = 'QM') totalMatches
  from game g
       inner join gameEvent ge
	   on ge.gameId = g.id
	   inner join event e
	   on e.id = ge.eventId
	   inner join teamGameEvent tge
	   on tge.gameEventId = ge.id
	   inner join team t
	   on t.id = tge.teamId
 where ge.id = @gameEventId
order by 8, tge.scoringRank
