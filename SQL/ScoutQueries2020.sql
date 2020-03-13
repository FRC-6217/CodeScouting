-- Rank by End Game, then Total Score
select tr.teamNumber
     , tr.totalScoreValue
	 , tr.value8 endGame
	 , case when (select count(*)
	                from TeamMatch tm
					     inner join Match m
						 on m.id = tm.matchId
						 inner join GameEvent ge
						 on ge.id = m.gameEventId
				   where ge.isActive = 'Y'
				     and m.isActive = 'Y'
					 and m.type <> 'QM'
					 and tm.teamId = tr.TeamId) > 0 then 'Y'
			else null end inPlayoff
  from v_TeamReport tr
 where tr.matchNumber = 'N/A'
order by 3 desc, 2 desc
