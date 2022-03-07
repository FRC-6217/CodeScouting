CREATE view v_GameEvent as
select ge.id
     , ge.eventId
	 , ge.gameId
	 , ge.eventDate
	 , (select coalesce(max(case when s2.id is null then 'N' else 'Y' end), 'N')
	      from Team t2
		       inner join Scout s2
			   on s2.teamId = t2.id
		 where s2.emailAddress = s.emailAddress
		   and t2.gameEventId = ge.id) isActive
	 , ge.lastUpdated
	 , s.emailAddress loginEmailAddress
	 , s.scoutGUID loginGUID
  from GameEvent ge
	   left outer join Team t
	   on t.gameEventId = ge.id
	   left outer join Scout s
       on s.teamId = t.id
