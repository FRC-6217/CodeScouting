-- Count of Scouted Records
select s.id, s.lastName, s.firstName, count(*) cnt, min(m.dateTime) earliest, max(m.dateTime) latest
  from v_GameEvent ge
       inner join Match m
	   on m.gameEventId = ge.id
	   inner join ScoutRecord sr
	   on sr.matchId = m.id
	   inner join Scout s
	   on s.id = sr.scoutId
 where ge.loginGUID = 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3'
   and s.lastName <> 'TBA'
group by s.id, s.lastName, s.firstName
order by count(*) desc

-- Scouted Details
select s.id, s.lastName, s.firstName, m.number, m.dateTime, tm.alliance, tm.alliancePosition, sr.lastUpdated
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
   and s.lastName in ('Beck', 'Stark', 'Rezac')
order by m.dateTime, s.lastName, s.firstName

