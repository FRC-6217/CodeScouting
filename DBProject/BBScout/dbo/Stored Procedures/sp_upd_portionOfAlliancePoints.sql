CREATE PROCEDURE [dbo].[sp_upd_portionOfAlliancePoints]
    (@pv_GameYear integer
    ,@pv_GameEventId integer)
as
begin
	SET NOCOUNT ON
	-- If year is 2020, allocate balanced hang points
	if @pv_GameYear = 2020
	begin
		-- Clear all portioning of points
		update TeamMatch
		   set portionOfAlliancePoints = null
		 where portionOfAlliancePoints is not null
		   and id in
			   (select tm.id
				  from TeamMatch tm
					   inner join Match m
					   on m.id = tm.matchId
				 where m.gameEventId = @pv_GameEventId);

		-- Set portion to zero if team did not hang
		update TeamMatch
		   set portionOfAlliancePoints = 0
		 where coalesce(portionOfAlliancePoints, -1) <> 0
		   and id in
			   (select tm.id
				  from TeamMatch tm
					   inner join Match m
					   on m.id = tm.matchId
				 where m.gameEventId = @pv_GameEventId)
		   and not exists
			   (select 1
				  from TeamMatchObjective tmo
				       inner join Objective o
					   on o.id = tmo.objectiveId
					   inner join Match m
					   on m.id = TeamMatch.matchId
				 where m.gameEventId = @pv_GameEventId
				   and tmo.teamMatchId = TeamMatch.id
				   and o.addTeamScorePortion = 'Y'
				   and tmo.scoreValue = 25); -- Indicates hang at end

		-- Set portion to alliance score divide by teams hanging
		update TeamMatch
		   set portionOfAlliancePoints =
			   convert(numeric(10,3),
			   (select case when TeamMatch.alliance = 'R'
							then m.redAlliancePoints
							when TeamMatch.alliance = 'B'
							then m.blueAlliancePoints
							else 0 end
				  from Match m
				 where m.id = TeamMatch.matchId)) /
			   convert(numeric(10,3),
			   (select count(*)
				  from TeamMatch tm
				 where tm.matchId = TeamMatch.matchId
				   and tm.alliance = TeamMatch.alliance
				   and tm.portionOfAlliancePoints is null))
		 where coalesce(portionOfAlliancePoints, -1) <> 0
		   and id in
			   (select tm.id
				  from TeamMatch tm
					   inner join Match m
					   on m.id = tm.matchId
				 where m.gameEventId = @pv_GameEventId);
	end
	-- If year is 2023, allocate link points
	if @pv_GameYear = 2023
	begin
		-- Clear all portioning of points
		update tm
		   set portionOfAlliancePoints = null
		     , lastUpdated = getdate()
		  from TeamMatch tm
			   inner join Match m
			   on m.id = tm.matchId
		 where m.gameEventId = @pv_GameEventId
		   and portionOfAlliancePoints is not null;

		-- Set portion to zero if alliance didn't have any links
		update tm
		   set portionOfAlliancePoints = 0
		     , lastUpdated = getdate()
		  from TeamMatch tm
		       inner join Match m
			   on m.id = tm.matchId
		 where m.gameEventId = @pv_GameEventId
		   and portionOfAlliancePoints is null
		   and case when tm.alliance = 'R'
					then m.redAlliancePoints
					when tm.alliance = 'B'
					then m.blueAlliancePoints
					else 0 end = 0;

		-- Set portion to zero if team didn't place any game pieces
		update tm
		   set portionOfAlliancePoints = 0
		     , lastUpdated = getdate()
		  from TeamMatch tm
			   inner join Match m
			   on m.id = tm.matchId
			   inner join v_TeamScorePortion tsp
			   on tsp.gameEventId = m.gameEventId
			   and tsp.matchId = tm.matchid
			   and tsp.teamId = tm.teamId
		 where m.gameEventId = @pv_GameEventId
		   and portionOfAlliancePoints is null
		   and tsp.intTeamScorePortion = 0; -- Indicates no game piece placed

        -- Set portion to alliance score to ratio of team game pieces to alliance game peices
		update tm
		   set portionOfAlliancePoints =
   		          convert(numeric,
				  case when tm.alliance = 'R'
					   then m.redAlliancePoints
					   when tm.alliance = 'B'
					   then m.blueAlliancePoints
					   else 0 end)
			   *  convert(numeric,
			      tsp.intTeamScorePortion)
			   /  convert(numeric,
			      (select sum(tsp2.intTeamScorePortion)
				     from v_TeamScorePortion tsp2
					where tsp2.gameEventId = tsp.gameEventId
					  and tsp2.matchId = tsp.matchid
					  and tsp2.alliance = tsp.alliance))
		     , lastUpdated = getdate()
		  from TeamMatch tm
			   inner join Match m
			   on m.id = tm.matchId
			   inner join v_TeamScorePortion tsp
			   on tsp.gameEventId = m.gameEventId
			   and tsp.matchId = tm.matchid
			   and tsp.teamId = tm.teamId
		 where m.gameEventId = @pv_GameEventId
		   and portionOfAlliancePoints is null
		   and tsp.intTeamScorePortion > 0; -- Indicates at least one game piece placed

        -- Set portion to alliance score to ratio of teams if no scout data shows game peices
		update tm
		   set portionOfAlliancePoints =
   		          convert(numeric,
				  case when tm.alliance = 'R'
					   then m.redAlliancePoints
					   when tm.alliance = 'B'
					   then m.blueAlliancePoints
					   else 0 end)
			   *  1.0
			   /  convert(numeric,
			      (select count(*)
				     from TeamMatch tm2
					where tm2.matchId = tm.matchId
					  and tm2.alliance = tm.alliance))
		     , lastUpdated = getdate()
		  from TeamMatch tm
			   inner join Match m
			   on m.id = tm.matchId
		 where m.gameEventId = @pv_GameEventId
		   and case when tm.alliance = 'R'
					then m.redAlliancePoints
					when tm.alliance = 'B'
					then m.blueAlliancePoints
					else 0 end > 0
		   and (select sum(tsp.intTeamScorePortion)
		          from v_TeamScorePortion tsp
				 where tsp.gameEventId = m.gameEventId
			       and tsp.matchId = tm.matchid) = 0;
   end
	-- If year is 2024, allocate amplification points
	if @pv_GameYear = 2024
	begin
		-- Clear all portioning of points
		update tm
		   set portionOfAlliancePoints = null
		     , lastUpdated = getdate()
		  from TeamMatch tm
			   inner join Match m
			   on m.id = tm.matchId
		 where m.gameEventId = @pv_GameEventId
		   and portionOfAlliancePoints is not null;

		-- Set portion to zero if alliance didn't have any amplification points
		update tm
		   set portionOfAlliancePoints = 0
		     , lastUpdated = getdate()
		  from TeamMatch tm
		       inner join Match m
			   on m.id = tm.matchId
		 where m.gameEventId = @pv_GameEventId
		   and portionOfAlliancePoints is null
		   and case when tm.alliance = 'R'
					then m.redAlliancePoints
					when tm.alliance = 'B'
					then m.blueAlliancePoints
					else 0 end = 0;

		-- Set portion to zero if team didn't score any TeleOp Speaker or Amp
		update tm
		   set portionOfAlliancePoints = 0
		     , lastUpdated = getdate()
		  from TeamMatch tm
			   inner join Match m
			   on m.id = tm.matchId
			   inner join v_TeamScorePortion tsp
			   on tsp.gameEventId = m.gameEventId
			   and tsp.matchId = tm.matchid
			   and tsp.teamId = tm.teamId
		 where m.gameEventId = @pv_GameEventId
		   and portionOfAlliancePoints is null
		   and tsp.intTeamScorePortion = 0; -- Indicates no game piece placed

        -- Set portion to alliance score to ratio of team game pieces to alliance game peices
		update tm
		   set portionOfAlliancePoints =
   		          convert(numeric,
				  case when tm.alliance = 'R'
					   then m.redAlliancePoints
					   when tm.alliance = 'B'
					   then m.blueAlliancePoints
					   else 0 end)
			   *  convert(numeric,
			      tsp.intTeamScorePortion)
			   /  convert(numeric,
			      (select sum(tsp2.intTeamScorePortion)
				     from v_TeamScorePortion tsp2
					where tsp2.gameEventId = tsp.gameEventId
					  and tsp2.matchId = tsp.matchid
					  and tsp2.alliance = tsp.alliance))
		     , lastUpdated = getdate()
		  from TeamMatch tm
			   inner join Match m
			   on m.id = tm.matchId
			   inner join v_TeamScorePortion tsp
			   on tsp.gameEventId = m.gameEventId
			   and tsp.matchId = tm.matchid
			   and tsp.teamId = tm.teamId
		 where m.gameEventId = @pv_GameEventId
		   and portionOfAlliancePoints is null
		   and tsp.intTeamScorePortion > 0; -- Indicates at least one game piece placed

        -- Set portion to alliance score to ratio of teams if no scout data shows game peices
		update tm
		   set portionOfAlliancePoints =
   		          convert(numeric,
				  case when tm.alliance = 'R'
					   then m.redAlliancePoints
					   when tm.alliance = 'B'
					   then m.blueAlliancePoints
					   else 0 end)
			   *  1.0
			   /  convert(numeric,
			      (select count(*)
				     from TeamMatch tm2
					where tm2.matchId = tm.matchId
					  and tm2.alliance = tm.alliance))
		     , lastUpdated = getdate()
		  from TeamMatch tm
			   inner join Match m
			   on m.id = tm.matchId
		 where m.gameEventId = @pv_GameEventId
		   and case when tm.alliance = 'R'
					then m.redAlliancePoints
					when tm.alliance = 'B'
					then m.blueAlliancePoints
					else 0 end > 0
		   and (select coalesce(sum(tsp.intTeamScorePortion), 0)
		          from v_TeamScorePortion tsp
				 where tsp.gameEventId = m.gameEventId
			       and tsp.matchId = tm.matchid) = 0;
   end
end
