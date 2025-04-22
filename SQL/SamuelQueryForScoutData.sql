-- Reefscape TBA Data
select g.name game
     , e.name Event
	 , ge.eventDate
	 , m.type MatchTyp
	 , m.number MatchNbr
	 , m.dateTime MatchDate
	 , t.teamNumber
	 , t.teamName
     , tm.alliance
     , tm.alliancePosition
	 , tmo_Leave.scoreValue teamAutoLeave
	 , tmo_End.scoreValue teamClimb
	 , m.redScore
	 , m.blueScore
	 , coalesce(m.blueCoop, 0) blueCoop
	 , coalesce(m.blueFoulPoints, 0) blueFoulPoints
	 , coalesce(m.blueRP1, 0) blueAutoRP
	 , coalesce(m.blueRP2, 0) blueCoralRP
	 , coalesce(m.blueRP3, 0) blueBargeRP
	 , coalesce(m.redCoop, 0) redCoop
	 , coalesce(m.redFoulPoints, 0) redFoulPoints
	 , coalesce(m.redRP1, 0) redAutoRP
	 , coalesce(m.redRP2, 0) redCoralRP
	 , coalesce(m.redRP3, 0) redBargeRP
	 , mo.blue_aL1
	 , mo.blue_aL2
	 , mo.blue_aL3
	 , mo.blue_aL4
	 , mo.blue_toL1
	 , mo.blue_toL2
	 , mo.blue_toL3
	 , mo.blue_toL4
	 , mo.blue_toNet
	 , mo.blue_toProc
	 , mo.red_aL1
	 , mo.red_aL2
	 , mo.red_aL3
	 , mo.red_aL4
	 , mo.red_toL1
	 , mo.red_toL2
	 , mo.red_toL3
	 , mo.red_toL4
	 , mo.red_toNet
	 , mo.red_toProc
  from game g
       inner join gameEvent ge
	   on ge.gameId = g.id
       inner join event e
	   on e.id = ge.eventId
	   inner join Match m
	   on m.gameEventId = ge.id
	   inner join TeamMatch tm
	   on tm.matchId = m.id
	   inner join Team t
	   on t.id = tm.teamId
       inner join (
			select tmo.teamMatchId
				 , o.name objectiveName
				 , tmo.scoreValue
			  from game g
				   inner join gameEvent ge
				   on ge.gameId = g.id
				   inner join Match m
				   on m.gameEventId = ge.id
				   inner join TeamMatch tm
				   on tm.matchId = m.id
				   inner join TeamMatchObjective tmo
				   on tmo.teamMatchId = tm.id
				   inner join Objective o
				   on o.id = tmo.objectiveId
			 where g.name = 'Reefscape'
			   and o.name = 'aLeave') tmo_Leave
	   on tmo_Leave.teamMatchId = tm.id
       inner join (
			select tmo.teamMatchId
				 , o.name objectiveName
				 , tmo.scoreValue
			  from game g
				   inner join gameEvent ge
				   on ge.gameId = g.id
				   inner join Match m
				   on m.gameEventId = ge.id
				   inner join TeamMatch tm
				   on tm.matchId = m.id
				   inner join TeamMatchObjective tmo
				   on tmo.teamMatchId = tm.id
				   inner join Objective o
				   on o.id = tmo.objectiveId
			 where g.name = 'Reefscape'
			   and o.name = 'toEnd') tmo_End
	   on tmo_End.teamMatchId = tm.id
	   inner join (
			select matchId
				 , [BaL1] as blue_aL1
				 , [BaL2] as blue_aL2
				 , [BaL3] as blue_aL3
				 , [BaL4] as blue_aL4
				 , [BtoL1] as blue_toL1
				 , [BtoL2] as blue_toL2
				 , [BtoL3] as blue_toL3
				 , [BtoL4] as blue_toL4
				 , [BtoNet] as blue_toNet
				 , [BtoProc] as blue_toProc
				 , [RaL1] as red_aL1
				 , [RaL2] as red_aL2
				 , [RaL3] as red_aL3
				 , [RaL4] as red_aL4
				 , [RtoL1] as red_toL1
				 , [RtoL2] as red_toL2
				 , [RtoL3] as red_toL3
				 , [RtoL4] as red_toL4
				 , [RtoNet] as red_toNet
				 , [RtoProc] as red_toProc
			from (
			select mo.matchId, mo.alliance + o.name allianceObject, case when o.name = 'toProc' then mo.scoreValue * 3 else mo.scoreValue end scoreValue
			  from game g
				   inner join gameEvent ge
				   on ge.gameId = g.id
				   inner join Match m
				   on m.gameEventId = ge.id
				   inner join MatchObjective mo
				   on mo.matchId = m.id
				   inner join Objective o
				   on o.id = mo.objectiveId
			 where g.name = 'Reefscape'
			) mo
			PIVOT
			  (sum(scoreValue)
				for allianceObject IN ([BaL1], [RaL1], [BaL2], [RaL2], [BaL3], [RaL3], [BaL4], [RaL4],
									   [BtoL1], [RtoL1], [BtoL2], [RtoL2], [BtoL3], [RtoL3], [BtoL4], [RtoL4],
									   [BtoNet], [RtoNet], [BtoProc], [RtoProc])
			  ) as pvt) mo
	   on mo.matchId = m.id
 where g.name = 'Reefscape'
   and m.type <> 'PR'


-- Reefscape Scouted Data
select g.name game
     , e.name Event
	 , ge.eventDate
	 , m.type MatchTyp
	 , m.number MatchNbr
	 , m.dateTime MatchDate
	 , t.teamNumber
	 , t.teamName
     , tm.alliance
     , tm.alliancePosition
	 , sro.aLeave autoLeave
	 , sro.toEnd climb
	 , sro.aL1
	 , sro.aL2
	 , sro.aL3
	 , sro.aL4
	 , sro.toL1
	 , sro.toL2
	 , sro.toL3
	 , sro.toL4
	 , sro.toNet
	 , sro.toProc
  from game g
       inner join gameEvent ge
	   on ge.gameId = g.id
       inner join event e
	   on e.id = ge.eventId
	   inner join Match m
	   on m.gameEventId = ge.id
	   inner join TeamMatch tm
	   on tm.matchId = m.id
	   inner join Team t
	   on t.id = tm.teamId
	   inner join (
			select matchId
			     , teamId
				 , [aLeave] as aLeave
				 , [aL1] as aL1
				 , [aL2] as aL2
				 , [aL3] as aL3
				 , [aL4] as aL4
				 , [toL1] as toL1
				 , [toL2] as toL2
				 , [toL3] as toL3
				 , [toL4] as toL4
				 , [toNet] as toNet
				 , [toProc] as toProc
				 , [toEnd] as toEnd
			from (
			select sr.matchId
			     , sr.teamId
				 , o.name objectiveName
				 , case when o.name = 'toProc' then sro.scoreValue * 3 else sro.scoreValue end scoreValue
			  from game g
				   inner join gameEvent ge
				   on ge.gameId = g.id
				   inner join Match m
				   on m.gameEventId = ge.id
				   inner join TeamMatch tm
				   on tm.matchId = m.id
				   inner join ScoutRecord sr
				   on sr.matchId = tm.matchId
				   and sr.teamId = tm.teamId
				   inner join ScoutObjectiveRecord sro
				   on sro.scoutRecordId = sr.id
				   inner join Objective o
				   on o.id = sro.objectiveId
			 where g.name = 'Reefscape'
			   and sr.scoutId <> (select id from Scout where lastName = 'TBA')
			) sro
			PIVOT
			  (sum(scoreValue)
				for objectiveName IN ([aLeave],
				                      [aL1], [aL2], [aL3], [aL4],
									  [toL1], [toL2], [toL3], [toL4], 
									  [toNet], [toProc], [toEnd])
			  ) as pvt) sro
	   on sro.matchId = tm.matchId
	   and sro.teamId = tm.teamId
 where g.name = 'Reefscape'
   and m.type <> 'PR'
   and e.name in ('Lake Superior Regional', 'Minnesota 10,000 Lakes Regional', 'Northern Lights Regional') -- North Star Data was not entered well
order by 2, 4 desc, 5, 7

/*
-- Rapid React
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
*/