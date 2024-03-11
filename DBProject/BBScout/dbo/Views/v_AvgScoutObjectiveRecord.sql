
CREATE view [dbo].[v_AvgScoutObjectiveRecord] as
select sr.teamId
	 , sr.matchId
     , m.isActive matchIsActive
	 , m.gameEventId
	 , ge.isActive gameEventIsActive
	 , sor.objectiveId
	 , o.name objectiveName
	 , o.addTeamScorePortion
	 , avg(sor.integerValue) avgIntegerValue
	 , min(sor.integerValue) minIntegerValue
	 , max(sor.integerValue) maxIntegerValue
	 , avg(sor.scoreValue) avgScoreValue
	 , min(sor.scoreValue) minScoreValue
	 , max(sor.scoreValue) maxScoreValue
	 , count(*) cntScoutRecord
	 , ge.loginGUID
  from ScoutRecord sr
       inner join ScoutObjectiveRecord sor
	   on sor.scoutRecordId = sr.id
	   inner join Objective o
	   on o.id = sor.objectiveId
	   inner join Match m
	   on m.id = sr.matchId
	   inner join v_GameEvent ge
	   on ge.id = m.gameEventId
group by sr.teamId
	   , sr.matchId
       , m.isActive
	   , m.gameEventId
	   , ge.isActive
	   , sor.objectiveId
	   , o.name
	   , o.addTeamScorePortion
       , ge.loginGUID;
