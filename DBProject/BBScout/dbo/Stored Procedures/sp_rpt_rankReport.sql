﻿



-- Rank Query (as a stored procedure to improve query performance
CREATE PROCEDURE [dbo].[sp_rpt_rankReport] (@pv_QueryString varchar(64)
                                   ,@pv_loginGUID varchar(128))
AS
DECLARE @lv_SortOrder int;
DECLARE @lv_TeamId int;
BEGIN
	create table #AvgTeamRecord(teamId int
	                          , gameId int
	                          , rankName varchar(64)
	                          , sortOrder int
							  , cntMatches int
	                          , value numeric(38, 6)
							  , portionOfAlliancePoints numeric(38, 6)
							  , rank integer
							  , rankingPointAverage numeric(10, 3)
							  , teamGameEventId int
							  , selectedForPlayoff char(1)
							  , oPR numeric(10, 3)
							  , playoffAlliance int);
	SET NOCOUNT ON
	-- Get current Team
	SELECT @lv_TeamId = coalesce(max(s.teamId), 101)
	  FROM Scout s
	 WHERE s.scoutGUID = @pv_loginGUID;

	-- Get Sort Order
	IF @pv_QueryString = 'Team'
		SET @lv_SortOrder = -98;
	ELSE
		SELECT @lv_SortOrder = coalesce(max(sortOrder), -99)
		  FROM Rank r
			   inner join v_GameEvent ge
			   on ge.gameId = r.gameId
		 WHERE ge.loginGUID = @pv_loginGUID
		   AND r.queryString = @pv_QueryString;

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
												when o.sortOrder = 16 then atr.integerValue16
												when o.sortOrder = 17 then atr.integerValue17
												when o.sortOrder = 18 then atr.integerValue18
												when o.sortOrder = 19 then atr.integerValue19
												when o.sortOrder = 20 then atr.integerValue20
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
					                            when o.sortOrder = 16 then atr.scoreValue16
					                            when o.sortOrder = 17 then atr.scoreValue17
					                            when o.sortOrder = 18 then atr.scoreValue18
					                            when o.sortOrder = 19 then atr.scoreValue19
					                            when o.sortOrder = 20 then atr.scoreValue20
 						                        else null end
					else null end) value
		 , case when r.includeAlliancePts = 'Y'
				then coalesce(atr.portionOfAlliancePoints, 0)
				else 0 end portionOfAlliancePoints
		 , tge.rank
		 , tge.rankingPointAverage
		 , tge.id teamGameEventId
		 , coalesce(tge.selectedForPlayoff, 'N') selectedForPlayoff
		 , tge.oPR
		 , coalesce(tge.playoffAlliance, 0) playoffAlliance
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
	group by atr.teamId
		   , r.gameId
		   , r.name
		   , r.sortOrder
		   , atr.cntMatches
		   , r.includeAlliancePts
		   , atr.portionOfAlliancePoints
		   , tge.rank
		   , tge.rankingPointAverage
		   , tge.id
		   , tge.selectedForPlayoff
		   , tge.oPR
		   , tge.playoffAlliance;

	-- Add teams that do not have a scout record yet
	INSERT INTO #AvgTeamRecord
	select tge.teamId
		 , r.gameId
		 , r.name rankName
		 , r.sortOrder
		 , 0 cntMatches
		 , 0 value
		 , 0 portionOfAlliancePoints
		 , tge.rank
		 , tge.rankingPointAverage
		 , tge.id teamGameEventId
		 , coalesce(tge.selectedForPlayoff, 'N') selectedForPlayoff
		 , tge.oPR
		 , coalesce(tge.playoffAlliance, 0) playoffAlliance
      from rank r
		   inner join v_GameEvent ge
		   on ge.gameId = r.gameId
		   inner join TeamGameEvent tge
		   on tge.gameEventId = ge.id
	 where ge.loginGUID = @pv_loginGUID
	   and not exists
	       (select 1
		      from #AvgTeamRecord atr
			 where atr.TeamId = tge.teamId);

/* Causes data to not display on website?
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
*/

    -- Use temporary table to return rankings and average values
	select subquery.teamId
	     , t.TeamNumber
		 , t.TeamName
		 , subquery.cntMatches
		 , avg(subquery.rank) avgRank
		 , sum(case when subquery.sortOrder = 1 then subquery.rank else null end) rankValue1
		 , sum(case when subquery.sortOrder = 2 then subquery.rank else null end) rankValue2
		 , sum(case when subquery.sortOrder = 3 then subquery.rank else null end) rankValue3
		 , sum(case when subquery.sortOrder = 4 then subquery.rank else null end) rankValue4
		 , sum(case when subquery.sortOrder = 5 then subquery.rank else null end) rankValue5
		 , sum(case when subquery.sortOrder = 6 then subquery.rank else null end) rankValue6
		 , sum(case when subquery.sortOrder = 7 then subquery.rank else null end) rankValue7
		 , sum(case when subquery.sortOrder = 8 then subquery.rank else null end) rankValue8
		 , sum(case when subquery.sortOrder = 9 then subquery.rank else null end) rankValue9
		 , sum(case when subquery.sortOrder = 10 then subquery.rank else null end) rankValue10
		 , sum(case when subquery.sortOrder = 1 then subquery.value else null end) value1
		 , sum(case when subquery.sortOrder = 2 then subquery.value else null end) value2
		 , sum(case when subquery.sortOrder = 3 then subquery.value else null end) value3
		 , sum(case when subquery.sortOrder = 4 then subquery.value else null end) value4
		 , sum(case when subquery.sortOrder = 5 then subquery.value else null end) value5
		 , sum(case when subquery.sortOrder = 6 then subquery.value else null end) value6
		 , sum(case when subquery.sortOrder = 7 then subquery.value else null end) value7
		 , sum(case when subquery.sortOrder = 8 then subquery.value else null end) value8
		 , sum(case when subquery.sortOrder = 9 then subquery.value else null end) value9
		 , sum(case when subquery.sortOrder = 10 then subquery.value else null end) value10
		 , subquery.eventRank
		 , subquery.rankingPointAverage
		 , subquery.teamGameEventId
		 , subquery.selectedForPlayoff
		 , subquery.oPR
		 , subquery.playoffAlliance
		 , rp.rp1TableHeader
		 , rp.rp1Total
		 , rp.rp2TableHeader
		 , rp.rp2Total
		 , rp.rp3TableHeader
		 , rp.rp3Total
		 , rp.coopTableHeader
		 , rp.coopTotal
	  from (
	        select atr.teamId
		         , atr.gameId
		         , atr.rankName
		         , atr.sortOrder
		         , atr.cntMatches
		         , atr.value + atr.portionOfAlliancePoints value
		         , (select count(*)
		              from #AvgTeamRecord atr2
			         where atr2.gameId = atr.gameId
			           and atr2.rankName = atr.rankName
			           and atr2.sortOrder = atr.sortOrder
			           and coalesce(atr2.value + atr2.portionOfAlliancePoints, 0) > coalesce(atr.value + atr.portionOfAlliancePoints, 0)) + 1 rank
		         , atr.rank eventRank
		         , atr.rankingPointAverage
		         , atr.teamGameEventId
		         , atr.selectedForPlayoff
		         , atr.oPR
		         , atr.playoffAlliance
              from #AvgTeamRecord atr) subquery
	               inner join Team t
		           on t.id = subquery.teamId
				   inner join (
					select tm.teamId
						 , (select grp.tableHeader
							  from GameRankingPoint grp
							 where grp.gameId = g.id
							   and grp.sortOrder = 1) rp1TableHeader
						 , coalesce(
						   sum(case when tm.alliance = 'R'
									then m.redRP1
									else m.blueRP1 end)
									, 0) rp1Total
						 , (select grp.tableHeader
							  from GameRankingPoint grp
							 where grp.gameId = g.id
							   and grp.sortOrder = 2) rp2TableHeader
						 , coalesce(
						   sum(case when tm.alliance = 'R'
									then m.redRP2
									else blueRP2 end)
									, 0) rp2Total
						 , (select grp.tableHeader
							  from GameRankingPoint grp
							 where grp.gameId = g.id
							   and grp.sortOrder = 3) rp3TableHeader
						 , coalesce(
						   sum(case when tm.alliance = 'R'
									then m.redRP3
									else m.blueRP3 end)
									, 0) rp3Total
						 , case when g.tbaCoopMet is not null
								then 'Coop'
								else null end coopTableHeader
						 , coalesce(
						   sum(case when tm.alliance = 'R'
									then m.redCoop
									else m.blueCoop end)
									, 0) coopTotal
					  from Game g
						   inner join v_GameEvent ge
						   on ge.gameId = g.id
						   inner join Match m
						   on m.gameEventId = ge.id
						   inner join TeamMatch tm
						   on tm.matchId = m.id
					 where ge.loginGUID = @pv_loginGUID
					group by g.id, g.tbaCoopMet, tm.teamId
					union
					select tge.teamId
						 , (select grp.tableHeader
							  from GameRankingPoint grp
							 where grp.gameId = g.id
							   and grp.sortOrder = 1) rp1TableHeader
						 , 0 rp1Total
						 , (select grp.tableHeader
							  from GameRankingPoint grp
							 where grp.gameId = g.id
							   and grp.sortOrder = 2) rp2TableHeader
						 , 0 rp2Total
						 , (select grp.tableHeader
							  from GameRankingPoint grp
							 where grp.gameId = g.id
							   and grp.sortOrder = 3) rp3TableHeader
						 , 0 rp3Total
						 , case when g.tbaCoopMet is not null
								then 'Coop'
								else null end coopHeader
						 , 0 coopTotal
					  from Game g
						   inner join v_GameEvent ge
						   on ge.gameId = g.id
						   inner join TeamGameEvent tge
						   on tge.gameEventId = ge.id
					 where ge.loginGUID = @pv_loginGUID
					   and not exists
					       (select 1
						      from Match  m
								   inner join TeamMatch tm
								   on tm.matchId = m.id
							 where m.gameEventId = ge.id
							   and tm.teamId = tge.teamId)
					group by g.id, g.tbaCoopMet, tge.teamId, ge.id) rp
           on rp.teamId = t.id
	group by subquery.teamId
	       , t.TeamNumber
		   , t.TeamName
		   , subquery.TeamId
		   , subquery.cntMatches
 		   , subquery.eventRank
		   , subquery.rankingPointAverage
		   , subquery.teamGameEventId
		   , subquery.selectedForPlayoff
		   , subquery.oPR
		   , subquery.playoffAlliance
		   , rp.rp1TableHeader
		   , rp.rp1Total
		   , rp.rp2TableHeader
		   , rp.rp2Total
		   , rp.rp3TableHeader
		   , rp.rp3Total
		   , rp.coopTableHeader
		   , rp.coopTotal
	order by subquery.selectedForPlayoff
	       , subquery.playoffAlliance
	       , case when @lv_SortOrder = -98 and subquery.teamId = @lv_TeamId then 0
	              else 1 end
	       , case when @lv_SortOrder = -98 then t.teamNumber
		          when @lv_SortOrder = -99 then coalesce(subquery.eventRank, 999)
	              else sum(case when subquery.sortOrder = @lv_SortOrder then subquery.rank else null end) end
	       , case when @lv_SortOrder = -98 then 1 else t.teamNumber end;

END
