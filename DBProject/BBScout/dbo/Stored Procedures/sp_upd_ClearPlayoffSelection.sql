-- Clear all Team Playoff Selections
CREATE PROCEDURE sp_upd_ClearPlayoffSelection (@pv_loginGUID varchar(128))
AS
BEGIN
	-- Clear Playoff Selection
	update tge
	   set selectedForPlayoff = 'N'
		 , playoffAlliance = null
		 , lastUpdated = getdate()
	  from TeamGameEvent tge
	       inner join v_GameEvent ge
		   on ge.id = tge.gameEventId
     where ge.loginGUID = @pv_loginGUID;
END