-- Toggle Team Playoff Selection
CREATE PROCEDURE sp_upd_TeamPlayoffSelection (@pv_teamGameEventId int)
AS
BEGIN
	-- Update Scoring Impact for Teams
	update TeamGameEvent
	   set selectedForPlayoff = case when coalesce(selectedForPlayoff, 'N') = 'N'
	                                 then 'Y'
									 else 'N' end
		 , lastUpdated = getdate()
     where id = @pv_teamGameEventId;
END