CREATE view v_RankButtons6217 as
select distinct
       '<div id="reportsby"><a class="clickme danger" href="Reports/rankReport6217.php?sortOrder=' + r.queryString + '&rankName=' + r.name + '">Rank by ' + r.name + ' </a></div>' buttonHtml
	 , r.name
	 , r.queryString
     , r.sortOrder
     , ge.loginGUID
  from Rank r
       inner join RankObjective ro
	   on ro.rankId = r.id
	   inner join Objective o
	   on o.id = ro.objectiveId
	   inner join Game g
	   on g.id = o.gameId
	   inner join v_GameEvent ge
	   on ge.gameId = g.id
