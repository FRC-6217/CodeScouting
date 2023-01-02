-- Update Team Scoring Impact
CREATE PROCEDURE sp_upd_TeamScoringImpact (@pv_loginGUID varchar(128))
AS
BEGIN
	create table #AvgTeamRecord(teamId int
	                          , gameId int
	                          , rankName varchar(64)
	                          , sortOrder int
							  , cntMatches int
	                          , value numeric(38, 6)
							  , rank integer
							  , rankingPointAverage numeric(10, 3)
							  , teamGameEventId int);
	SET NOCOUNT ON

	-- Populate local temporary table of team average scores.  This improves overall query performance
	INSERT INTO #AvgTeamRecord
	select atr.teamId
		 , r.gameId
		 , r.name rankName
		 , r.sortOrder
		 , atr.cntMatches
		 , sum(case when r.type = 'V' then case when o.sortOrder = 1 then atr.integerValue1
						                        when o.sortOrder = 2 then atr.integerValue2
												when o.sortOrder = 3 then atr.integerValue3
												when o.sortOrder = 4 then atr.integerValue4
												when o.sortOrder = 5 then atr.integerValue5
												when o.sortOrder = 6 then atr.integerValue6
												when o.sortOrder = 7 then atr.integerValue7
												when o.sortOrder = 8 then atr.integerValue8
												when o.sortOrder = 9 then atr.integerValue9
												when o.sortOrder = 10 then atr.integerValue10
												when o.sortOrder = 11 then atr.integerValue11
						                        when o.sortOrder = 12 then atr.integerValue12
												when o.sortOrder = 13 then atr.integerValue13
												when o.sortOrder = 14 then atr.integerValue14
												when o.sortOrder = 15 then atr.integerValue15
 						                        else null end
				    when r.type = 'S' then case when o.sortOrder = 1 then atr.scoreValue1
					                            when o.sortOrder = 2 then atr.scoreValue2
					                            when o.sortOrder = 3 then atr.scoreValue3
					                            when o.sortOrder = 4 then atr.scoreValue4
					                            when o.sortOrder = 5 then atr.scoreValue5
					                            when o.sortOrder = 6 then atr.scoreValue6
					                            when o.sortOrder = 7 then atr.scoreValue7
					                            when o.sortOrder = 8 then atr.scoreValue8
					                            when o.sortOrder = 9 then atr.scoreValue9
					                            when o.sortOrder = 10 then atr.scoreValue10
												when o.sortOrder = 11 then atr.scoreValue11
					                            when o.sortOrder = 12 then atr.scoreValue12
					                            when o.sortOrder = 13 then atr.scoreValue13
					                            when o.sortOrder = 14 then atr.scoreValue14
					                            when o.sortOrder = 15 then atr.scoreValue15
 						                        else null end
					else null end) value
		 , tge.rank
		 , tge.rankingPointAverage
		 , tge.id teamGameEventId
	  from rank r
		   inner join RankObjective ro
		   on ro.rankId = r.id
		   inner join Objective o
		   on o.id = ro.objectiveId
		   inner join v_GameEvent ge
		   on ge.gameId = o.gameId
		   inner join TeamGameEvent tge
		   on ge.id = tge.gameEventId
		   inner join v_AvgTeamRecord atr
		   on atr.teamId = tge.teamId
		   and atr.loginGUID = ge.loginGUID
	 where ge.loginGUID = @pv_loginGUID
	   and r.name = 'Scr Imp'
	group by atr.teamId
		   , r.gameId
		   , r.name
		   , r.sortOrder
		   , atr.cntMatches
		   , tge.rank
		   , tge.rankingPointAverage
		   , tge.id;

	-- Add teams that do not have a scout record yet
	INSERT INTO #AvgTeamRecord
	select tge.teamId
		 , r.gameId
		 , r.name rankName
		 , r.sortOrder
		 , 0 cntMatches
		 , 0 value
		 , tge.rank
		 , tge.rankingPointAverage
		 , tge.id teamGameEventId
      from rank r
		   inner join v_GameEvent ge
		   on ge.gameId = r.gameId
		   inner join TeamGameEvent tge
		   on tge.gameEventId = ge.id
	 where ge.loginGUID = @pv_loginGUID
	   and r.name = 'Scr Imp'
	   and not exists
	       (select 1
		      from #AvgTeamRecord atr
			 where atr.TeamId = tge.teamId);

    -- Update Scoring Impact for Teams
	update tge
	   set scoringRank = subquery.rank
	     , scoringAverage = subquery.value
	  from TeamGameEvent tge
	       inner join
	       (select atr.teamGameEventId
                 , atr.value
                 , (select count(*)
                      from #AvgTeamRecord atr2
                     where atr2.gameId = atr.gameId
                       and atr2.rankName = atr.rankName
                       and atr2.sortOrder = atr.sortOrder
                       and atr2.value > atr.value) + 1 rank
              from #AvgTeamRecord atr
             where atr.rankName = 'Scr Imp') subquery
		   on subquery.teamGameEventId = tge.id;

END