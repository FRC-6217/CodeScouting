

-- Toggle Team Playoff Selection
CREATE PROCEDURE [dbo].[sp_upd_TeamPlayoffSelection] (@pv_teamGameEventId int, @pv_playoffAlliance int)
AS
BEGIN
	-- Update Scoring Impact for Teams
	update TeamGameEvent
	   set selectedForPlayoff = case when coalesce(@pv_playoffAlliance, 0) = 0
	                                 then 'N'
									 else 'Y' end
		 , playoffAlliance = case when coalesce(@pv_playoffAlliance, 0) = 0
		                          then null
								  else @pv_playoffAlliance end
		 , lastUpdated = getdate()
     where id = @pv_teamGameEventId;
END