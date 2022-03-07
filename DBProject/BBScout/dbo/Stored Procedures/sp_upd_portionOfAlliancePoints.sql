
CREATE PROCEDURE sp_upd_portionOfAlliancePoints
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
end
