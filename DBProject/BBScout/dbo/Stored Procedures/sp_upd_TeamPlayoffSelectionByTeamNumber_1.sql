-- Toggle Team Playoff Selection
CREATE PROCEDURE sp_upd_TeamPlayoffSelectionByTeamNumber (@pv_LoginGUID uniqueidentifier, @pv_teamNumber1 int, @pv_teamNumber2 int, @pv_teamNumber3 int, @pv_teamNumber4 int, @pv_playoffAlliance int)
AS
declare @lv_teamGameEventId int;
BEGIN

-- Get the TeamGameEvent Id for the Team 1
if coalesce(@pv_teamNumber1, -1) <> -1
begin
	select @lv_teamGameEventId = max(tge.id)
	  from v_GameEvent ge
		   inner join TeamGameEvent tge
		   on tge.gameEventId = ge.id
		   inner join Team t
		   on t.id = tge.teamId
	 where ge.loginGUID = @pv_LoginGUID
	   and t.teamNumber = @pv_teamNumber1;

	-- Use other Stored Procedure to update alliance selection
	if @lv_teamGameEventId is not null
	begin
		exec sp_upd_TeamPlayoffSelection @lv_teamGameEventId, @pv_playoffAlliance;
	end
end

-- Get the TeamGameEvent Id for the Team 2
if coalesce(@pv_teamNumber2, -1) <> -1
begin
	select @lv_teamGameEventId = max(tge.id)
	  from v_GameEvent ge
		   inner join TeamGameEvent tge
		   on tge.gameEventId = ge.id
		   inner join Team t
		   on t.id = tge.teamId
	 where ge.loginGUID = @pv_LoginGUID
	   and t.teamNumber = @pv_teamNumber2;

	-- Use other Stored Procedure to update alliance selection
	if @lv_teamGameEventId is not null
	begin
		exec sp_upd_TeamPlayoffSelection @lv_teamGameEventId, @pv_playoffAlliance;
	end
end

-- Get the TeamGameEvent Id for the Team 3
if coalesce(@pv_teamNumber3, -1) <> -1
begin
	select @lv_teamGameEventId = max(tge.id)
	  from v_GameEvent ge
		   inner join TeamGameEvent tge
		   on tge.gameEventId = ge.id
		   inner join Team t
		   on t.id = tge.teamId
	 where ge.loginGUID = @pv_LoginGUID
	   and t.teamNumber = @pv_teamNumber3;

	-- Use other Stored Procedure to update alliance selection
	if @lv_teamGameEventId is not null
	begin
		exec sp_upd_TeamPlayoffSelection @lv_teamGameEventId, @pv_playoffAlliance;
	end
end

-- Get the TeamGameEvent Id for the Team 4
if coalesce(@pv_teamNumber4, -1) <> -1
begin
	select @lv_teamGameEventId = max(tge.id)
	  from v_GameEvent ge
		   inner join TeamGameEvent tge
		   on tge.gameEventId = ge.id
		   inner join Team t
		   on t.id = tge.teamId
	 where ge.loginGUID = @pv_LoginGUID
	   and t.teamNumber = @pv_teamNumber4;

	-- Use other Stored Procedure to update alliance selection
	if @lv_teamGameEventId is not null
	begin
		exec sp_upd_TeamPlayoffSelection @lv_teamGameEventId, @pv_playoffAlliance;
	end
end

END