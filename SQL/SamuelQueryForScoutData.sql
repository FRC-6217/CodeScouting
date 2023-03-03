select m.dateTime
     , m.matchCode
	 , m.redScore
	 , m.redFoulPoints
	 , m.blueScore
	 , m.blueFoulPoints
	 , t_r1.teamNumber r1_teamNumber
	 , t_r2.teamNumber r2_teamNumber
	 , t_r3.teamNumber r3_teamNumber
	 , t_b1.teamNumber b1_teamNumber
	 , t_b2.teamNumber b2_teamNumber
	 , t_b3.teamNumber b3_teamNumber
	 , o.name objectiveName
	 , replace(o.label, ':', '') labelName
	 , mo_r.scoreValue r_objectiveScore
	 , mo_b.scoreValue b_objectiveScore
  from game g
       inner join gameEvent ge
	   on ge.gameId = g.id
	   inner join Match m
	   on m.gameEventId = ge.id
	   inner join TeamMatch tm_r1
	   on tm_r1.matchId = m.id
	   and tm_r1.alliance = 'r'
	   and tm_r1.alliancePosition = 1
	   inner join Team t_r1
	   on t_r1.id = tm_r1.teamId
	   inner join TeamMatch tm_r2
	   on tm_r2.matchId = m.id
	   and tm_r2.alliance = 'r'
	   and tm_r2.alliancePosition = 2
	   inner join Team t_r2
	   on t_r2.id = tm_r2.teamId
	   inner join TeamMatch tm_r3
	   on tm_r3.matchId = m.id
	   and tm_r3.alliance = 'r'
	   and tm_r3.alliancePosition = 3
	   inner join Team t_r3
	   on t_r3.id = tm_r3.teamId
	   inner join TeamMatch tm_b1
	   on tm_b1.matchId = m.id
	   and tm_b1.alliance = 'b'
	   and tm_b1.alliancePosition = 1
	   inner join Team t_b1
	   on t_b1.id = tm_b1.teamId
	   inner join TeamMatch tm_b2
	   on tm_b2.matchId = m.id
	   and tm_b2.alliance = 'b'
	   and tm_b2.alliancePosition = 2
	   inner join Team t_b2
	   on t_b2.id = tm_b2.teamId
	   inner join TeamMatch tm_b3
	   on tm_b3.matchId = m.id
	   and tm_b3.alliance = 'b'
	   and tm_b3.alliancePosition = 3
	   inner join Team t_b3
	   on t_b3.id = tm_b3.teamId
	   inner join MatchObjective mo_r
	   on mo_r.matchId = m.id
	   and mo_r.alliance = 'r'
	   inner join Objective o
	   on o.id = mo_r.objectiveId
	   inner join MatchObjective mo_b
	   on mo_b.matchId = m.id
	   and mo_b.alliance = 'b'
	   and mo_b.objectiveId = o.id
 where g.name = 'Rapid React'
   and m.type <> 'PR'
   and m.redScore is not null
union
select m.dateTime
     , m.matchCode
	 , m.redScore
	 , m.redFoulPoints
	 , m.blueScore
	 , m.blueFoulPoints
	 , t_r1.teamNumber r1_teamNumber
	 , t_r2.teamNumber r2_teamNumber
	 , t_r3.teamNumber r3_teamNumber
	 , t_b1.teamNumber b1_teamNumber
	 , t_b2.teamNumber b2_teamNumber
	 , t_b3.teamNumber b3_teamNumber
	 , o.name objectiveName
	 , replace(o.label, ':', '') labelName
	 , (select sum(tmo_r.scoreValue)
	      from TeamMatchObjective tmo_r
		 where tmo_r.objectiveId = o.id
		   and tmo_r.teamMatchId in (tm_r1.id, tm_r2.id, tm_r3.id)) r_objectiveScore
	 , (select sum(tmo_b.scoreValue)
	      from TeamMatchObjective tmo_b
		 where tmo_b.objectiveId = o.id
		   and tmo_b.teamMatchId in (tm_b1.id, tm_b2.id, tm_b3.id)) b_objectiveScore
  from game g
       inner join gameEvent ge
	   on ge.gameId = g.id
	   inner join Match m
	   on m.gameEventId = ge.id
	   inner join TeamMatch tm_r1
	   on tm_r1.matchId = m.id
	   and tm_r1.alliance = 'r'
	   and tm_r1.alliancePosition = 1
	   inner join Team t_r1
	   on t_r1.id = tm_r1.teamId
	   inner join TeamMatch tm_r2
	   on tm_r2.matchId = m.id
	   and tm_r2.alliance = 'r'
	   and tm_r2.alliancePosition = 2
	   inner join Team t_r2
	   on t_r2.id = tm_r2.teamId
	   inner join TeamMatch tm_r3
	   on tm_r3.matchId = m.id
	   and tm_r3.alliance = 'r'
	   and tm_r3.alliancePosition = 3
	   inner join Team t_r3
	   on t_r3.id = tm_r3.teamId
	   inner join TeamMatch tm_b1
	   on tm_b1.matchId = m.id
	   and tm_b1.alliance = 'b'
	   and tm_b1.alliancePosition = 1
	   inner join Team t_b1
	   on t_b1.id = tm_b1.teamId
	   inner join TeamMatch tm_b2
	   on tm_b2.matchId = m.id
	   and tm_b2.alliance = 'b'
	   and tm_b2.alliancePosition = 2
	   inner join Team t_b2
	   on t_b2.id = tm_b2.teamId
	   inner join TeamMatch tm_b3
	   on tm_b3.matchId = m.id
	   and tm_b3.alliance = 'b'
	   and tm_b3.alliancePosition = 3
	   inner join Team t_b3
	   on t_b3.id = tm_b3.teamId
	   inner join Objective o
	   on o.gameId = g.id
	   and o.id in (select tmo_r.objectiveId
	                  from TeamMatchObjective tmo_r
					 where tmo_r.teamMatchId in (tm_r1.id, tm_r2.id, tm_r3.id))
 where g.name = 'Rapid React'
   and m.type <> 'PR'
   and m.redScore is not null
order by m.matchCode
       , o.name
