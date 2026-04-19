CREATE view v_ScoutList as
select '<a href="scout.php?scoutId=' + convert(varchar, s2.id) + '">' + s2.lastName + ', ' + s2.firstName + '</a>' scoutUrl
     , s2.id scoutId
	 , s2.lastName
	 , s2.firstName
     , s2.lastName + ', ' + s2.firstName fullName
     , s2.emailAddress
     , s2.isActive
     , s2.isAdmin
	 , ge.loginGUID
  from v_GameEvent ge
       inner join Scout s
       on s.scoutGUID = ge.loginGUID
       inner join Team t
       on t.id = s.teamId
       inner join Scout s2
       on s2.teamId = t.id
 where s2.lastName not in ('TBA', '(Choose Scout)', 'xOnly');