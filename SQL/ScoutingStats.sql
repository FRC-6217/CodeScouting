-- Count of Scouted Records
select s.id, s.lastName, s.firstName, s.firstName + ' ' + s.lastName fullName, count(*) cnt, min(m.dateTime) earliest, max(m.dateTime) latest
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
order by count(*) desc, s.lastName, s.firstName

-- Count for Pit Scouting
select s.id, s.lastName, s.firstName, s.firstName + ' ' + s.lastName fullName, count(*) cnt, min(tas.lastUpdated) earliest, max(tas.lastUpdated) latest
  from v_GameEvent ge
       inner join TeamAttributeScouts tas
	   on tas.gameId = ge.gameId
	   inner join Scout s
	   on s.id in (tas.scoutId1, tas.scoutId2, tas.scoutId3)
	   inner join TeamGameEvent tge
	   on tge.teamId = tas.teamId
	   and tge.gameEventId = ge.id
 where ge.loginGUID = 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3'
   and s.lastName not in ('TBA', '(Choose Scout)')
group by s.id, s.lastName, s.firstName, s.lastName, s.firstName
order by count(*) desc

-- Report Query for both Scout Data records
select coalesce(m_s.id, p_s.id) id
     , coalesce(m_s.lastName, p_s.lastName) lastName
     , coalesce(m_s.firstName, p_s.firstName) firstName
     , coalesce(m_s.cnt, 0) matchesScouted
     , coalesce(p_s.cnt, 0) pitScouted
  from (
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
group by s.id, s.lastName, s.firstName) m_s
full outer join (
select s.id, s.lastName, s.firstName, count(*) cnt, min(tas.lastUpdated) earliest, max(tas.lastUpdated) latest
  from v_GameEvent ge
       inner join TeamAttributeScouts tas
	   on tas.gameId = ge.gameId
	   inner join Scout s
	   on s.id in (tas.scoutId1, tas.scoutId2, tas.scoutId3)
	   inner join TeamGameEvent tge
	   on tge.teamId = tas.teamId
	   and tge.gameEventId = ge.id
 where ge.loginGUID = 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3'
   and s.lastName not in ('TBA', '(Choose Scout)')
group by s.id, s.lastName, s.firstName) p_s
on m_s.id = p_s.id
order by coalesce(m_s.cnt, 0) desc
       , coalesce(p_s.cnt, 0) desc
	   , coalesce(m_s.lastName, p_s.lastName)
       , coalesce(m_s.firstName, p_s.firstName)

-- Match Scouted Details
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

     