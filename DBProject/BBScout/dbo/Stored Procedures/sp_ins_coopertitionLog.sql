

CREATE PROCEDURE [dbo].[sp_ins_coopertitionLog]  (@pv_Id int
                                   , @pv_ScoutId integer
								   , @pv_LogDate date
                                   , @pv_TeamId int
                                   , @pv_LogNotes varchar(4000)
								   , @pv_LogType char(1)
                                   , @pv_EventId int
                                   , @pv_LogLocation varchar(512))
AS
declare @lv_Count integer;
declare @lv_EventId integer;
declare @lv_LogLocation varchar(512);

BEGIN
	SET NOCOUNT ON
	-- Lookup Coopertition Log
    SELECT @lv_Count = count(*)
	  FROM CoopertitionLog
	 WHERE id = @pv_Id;

	-- Allow Event to be empty if not selected
	IF (@pv_EventId = 0)
	BEGIN
		SET @lv_EventId = null;
	END
	ELSE
	BEGIN
		SET @lv_EventId = @pv_EventId;
	END

	-- Default Location to the Event Location
	IF (coalesce(@pv_LogLocation, '') = '')
	BEGIN
		SELECT @lv_LogLocation = max(location)
		  FROM Event
		 WHERE id = @lv_EventId;
	END
	ELSE
	BEGIN
		SET @lv_LogLocation = @pv_LogLocation;
	END

	-- Add or Update Team Scout Survey Record
	IF @lv_Count = 0
	BEGIN
		INSERT INTO CoopertitionLog
		VALUES (@pv_ScoutId, @pv_LogDate, @pv_TeamId, @pv_LogNotes, @pv_LogType, @lv_EventId, @lv_LogLocation, getdate());
	END
	ELSE
	BEGIN
		UPDATE CoopertitionLog
           SET scoutId = @pv_ScoutId
		     , logDate = @pv_LogDate
		     , teamId = @pv_TeamId
		     , logNotes = @pv_LogNotes
		     , logType = @pv_LogType
		     , eventId = @lv_EventId
		     , logLocation = @lv_LogLocation
			 , lastUpdated = getdate()
		 WHERE id = @pv_Id;
	END
END