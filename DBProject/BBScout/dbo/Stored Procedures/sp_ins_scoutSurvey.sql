CREATE PROCEDURE sp_ins_scoutSurvey  (@pv_TeamId integer
								   , @pv_loginGUID varchar(128)
                                   , @pv_scoutMatch char(1) = null
                                   , @pv_scoutRobot char(1) = null
								   , @pv_scoutingDesc varchar(4000) = null
                                   , @pv_scoutingDataStored varchar(4000) = null
                                   , @pv_colaborate char(1) = null
                                   , @pv_tbaForMatches char(1) = null
                                   , @pv_tbaForAllianceSelection char(1) = null
                                   , @pv_wantBBScout char(1) = null
                                   , @pv_overviewOfBBScout char(1) = null)
AS
declare @lv_GameId integer;
declare @lv_Count integer;

BEGIN
	SET NOCOUNT ON
	-- Lookup Game Id
	SELECT @lv_GameId = ge.gameId
      FROM v_GameEvent ge
	 WHERE ge.loginGUID = @pv_loginGUID;

	-- Lookup Team Scout Survey
    SELECT @lv_Count = count(*)
	  FROM TeamScoutSurvey
	 WHERE teamId = @pv_TeamId
	   AND gameId = @lv_GameId;

	-- Add or Update Team Scout Survey Record
	IF @lv_Count = 0
	BEGIN
		INSERT INTO TeamScoutSurvey
		VALUES (@pv_TeamId, @lv_GameId, @pv_scoutMatch, @pv_scoutRobot, @pv_scoutingDesc, @pv_scoutingDataStored, @pv_colaborate
		      , @pv_tbaForMatches, @pv_tbaForAllianceSelection, @pv_wantBBScout, @pv_overviewOfBBScout, getdate());
	END
	ELSE
	BEGIN
		UPDATE TeamScoutSurvey
           SET scoutMatch = @pv_scoutMatch
		     , scoutRobot = @pv_scoutRobot
			 , scoutingDesc = @pv_scoutingDesc
			 , scoutingDataStored = @pv_scoutingDataStored
			 , colaborate = @pv_colaborate
		     , tbaForMatches = @pv_tbaForMatches
			 , tbaForAllianceSelection = @pv_tbaForAllianceSelection
			 , wantBBScout = @pv_wantBBScout
			 , overviewOfBBScout = @pv_overviewOfBBScout
			 , lastUpdated = getdate()
		 WHERE teamId = @pv_TeamId
		   AND gameId = @lv_GameId;
	END
END