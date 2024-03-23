select m.number, t.teamNumber, tm.alliance, tm.alliancePosition
  from game g
       inner join gameEvent ge
	   on ge.gameId = g.id
	   inner join event e
	   on e.id = ge.eventId
	   inner join match m
	   on m.gameEventId = ge.id
	   inner join TeamMatch tm
	   on tm.matchId = m.id
	   inner join team t
	   on t.id = tm.teamId
 where g.name = 'Crescendo'
  and e.name = 'Iowa Regional'
  and m.type = 'QM'
--  and t.teamNumber= 6217
  and tm.alliance = 'B'
  and tm.alliancePosition = 3
order by convert(integer, m.number)