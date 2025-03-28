-- List of duplicates
select m.type, m.number, t.teamNumber, sr.matchId, sr.teamId, count(*) cnt
  from v_GameEvent ge
       inner join Match m
	   on m.gameEventId = ge.id
	   inner join ScoutRecord sr
	   on sr.matchId = m.id
	   inner join Scout s
	   on s.id = sr.scoutId
       inner join TeamMatch tm
	   on tm.matchId = sr.matchId
	   and tm.teamId = sr.teamId
	   inner join team t
	   on t.id = tm.teamId
 where ge.loginGUID = 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3'
   and s.lastName <> 'TBA'
group by m.type, m.number, t.teamNumber, sr.matchId, sr.teamId
having count(*) > 1
order by m.type, m.number

-- Details of duplicates
select sr.id, m.type, m.number, t.teamNumber, s.lastName, s.firstName, sr.id, sr.lastUpdated
  from v_GameEvent ge
       inner join Match m
	   on m.gameEventId = ge.id
	   inner join ScoutRecord sr
	   on sr.matchId = m.id
	   inner join Scout s
	   on s.id = sr.scoutId
       inner join TeamMatch tm
	   on tm.matchId = sr.matchId
	   and tm.teamId = sr.teamId
	   inner join team t
	   on t.id = tm.teamId
	   inner join (
			select tm.matchId, tm.teamId, ge.loginGUID
			  from v_GameEvent ge
				   inner join Match m
				   on m.gameEventId = ge.id
				   inner join ScoutRecord sr
				   on sr.matchId = m.id
				   inner join Scout s
				   on s.id = sr.scoutId
				   inner join TeamMatch tm
				   on tm.matchId = sr.matchId
				   and tm.teamId = sr.teamId
			 where ge.loginGUID = 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3'
			   and s.lastName <> 'TBA'
			group by tm.matchId, tm.teamId, ge.loginGUID
			having count(*) > 1
	   ) dups
       on dups.matchId = sr.matchId
	   and dups.teamId = sr.teamId
	   and dups.loginGUID = ge.loginGUID
order by m.type, m.number, t.teamNumber, sr.lastUpdated

-- Remove appropriate duplicates
delete from ScoutRecord where id in (42583, 42654, 42663, 42672, 42675)