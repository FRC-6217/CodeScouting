

CREATE PROCEDURE sp_ins_NM_scoutRecord (@pv_ScoutName varchar(128)
                                   , @pv_MatchNumber varchar(8)
                                   , @pv_TeamNumber integer
								   , @pv_AlliancePosition varchar(2)
                                   , @pv_ScoutComment varchar(4000)
								   , @pv_loginGUID varchar(128)
                                   , @pv_TextValue01 varchar(4000)
                                   , @pv_TextValue02 varchar(4000) = '0'
                                   , @pv_TextValue03 varchar(4000) = '0'
                                   , @pv_TextValue04 varchar(4000) = '0'
                                   , @pv_TextValue05 varchar(4000) = '0'
                                   , @pv_TextValue06 varchar(4000) = '0'
                                   , @pv_TextValue07 varchar(4000) = '0'
                                   , @pv_TextValue08 varchar(4000) = '0'
                                   , @pv_TextValue09 varchar(4000) = '0'
                                   , @pv_TextValue10 varchar(4000) = '0'
                                   , @pv_TextValue11 varchar(4000) = '0'
                                   , @pv_TextValue12 varchar(4000) = '0'
                                   , @pv_TextValue13 varchar(4000) = '0'
                                   , @pv_TextValue14 varchar(4000) = '0'
                                   , @pv_TextValue15 varchar(4000) = '0'
                                   , @pv_TextValue16 varchar(4000) = '0'
                                   , @pv_TextValue17 varchar(4000) = '0'
                                   , @pv_TextValue18 varchar(4000) = '0'
                                   , @pv_TextValue19 varchar(4000) = '0'
                                   , @pv_TextValue20 varchar(4000) = '0')
AS
declare @lv_ScoutId integer;
declare @lv_MatchId integer;
declare @lv_TeamId integer;
declare @lv_aLeaveId integer;
declare @lv_toEndId integer;
declare @lv_toDefenseId integer;
declare @lv_RatingId integer;
declare @lv_Count integer;

BEGIN
	SET NOCOUNT ON
    -- Lookup Ids for Scout, Match, and Team
	SELECT @lv_ScoutId = max(id)
	  FROM Scout
	 WHERE lastName = @pv_ScoutName;
	IF @lv_ScoutId is null
	BEGIN
		RAISERROR('Scout needs to be selected from the dropdown list.', 16, 1)
		RETURN
	END
	SELECT @lv_MatchId = max(m.id)
	  FROM Match m
	       INNER JOIN v_GameEvent ge
		   ON ge.id = m.gameEventId
	 WHERE ge.loginGUID = @pv_loginGUID
	   AND m.number = @pv_MatchNumber;
	IF @lv_MatchId is null
	BEGIN
		RAISERROR('Match Number needs to be selected from the dropdown list.', 16, 1)
		RETURN
	END
	SELECT @lv_TeamId = max(t.id)
	  FROM Team t
	       INNER JOIN TeamGameEvent tge
		   ON tge.teamId = t.id
	       INNER JOIN v_GameEvent ge
		   ON ge.id = tge.gameEventId
	 WHERE ge.loginGUID = @pv_loginGUID
	   AND t.teamNumber = @pv_TeamNumber;
	IF @lv_TeamId is null
	BEGIN
		RAISERROR('Team Number needs to be selected from the dropdown list.', 16, 1)
		RETURN
	END
	IF @pv_AlliancePosition is null
	   OR substring(@pv_AlliancePosition, 1, 1) NOT IN ('B', 'R')
	   OR substring(@pv_AlliancePosition, 2, 1) NOT IN ('1', '2', '3')
	BEGIN
		RAISERROR('Alliance Position needs to be selected from the dropdown list.', 16, 1)
		RETURN
	END

    -- Verify correct robot/match/alliance position
	select @lv_Count = count(*)
      from TeamMatch tm
           inner join Match m
	       on m.id = tm.matchId
	       inner join v_GameEvent ge
	       on ge.id = m.gameEventId
     where ge.loginGUID = 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3'
	   and tm.teamId = @lv_TeamId
	   and tm.matchId = @lv_MatchId
	   and tm.alliance = substring(@pv_AlliancePosition, 1, 1)
	   and tm.alliancePosition = substring(@pv_AlliancePosition, 2, 1);
	IF @lv_Count = 0
	BEGIN
		RAISERROR('Team/Match/Alliance Position Mismatch.', 16, 1)
		RETURN
	END

	-- Lookup Objective Value Ids
	SELECT @lv_aLeaveId = max(ov.integerValue)
	  FROM Objective o
	       INNER JOIN ObjectiveValue ov
		   ON ov.objectiveId = o.id
		   INNER JOIN game g
		   on g.id = o.gameId
	       INNER JOIN v_GameEvent ge
		   ON ge.gameId = g.id
	 WHERE ge.loginGUID = @pv_loginGUID
	   AND o.name = 'aLeave'
	   AND ov.displayValue = @pv_TextValue01;

	SELECT @lv_toEndId = max(ov.integerValue)
	  FROM Objective o
	       INNER JOIN ObjectiveValue ov
		   ON ov.objectiveId = o.id
		   INNER JOIN game g
		   on g.id = o.gameId
	       INNER JOIN v_GameEvent ge
		   ON ge.gameId = g.id
	 WHERE ge.loginGUID = @pv_loginGUID
	   AND o.name = 'toEnd'
	   AND ov.displayValue = @pv_TextValue12;

	SELECT @lv_toDefenseId = max(ov.integerValue)
	  FROM Objective o
	       INNER JOIN ObjectiveValue ov
		   ON ov.objectiveId = o.id
		   INNER JOIN game g
		   on g.id = o.gameId
	       INNER JOIN v_GameEvent ge
		   ON ge.gameId = g.id
	 WHERE ge.loginGUID = @pv_loginGUID
	   AND o.name = 'toDefense'
	   AND ov.displayValue = @pv_TextValue14;

	SELECT @lv_RatingId = max(ov.integerValue)
	  FROM Objective o
	       INNER JOIN ObjectiveValue ov
		   ON ov.objectiveId = o.id
		   INNER JOIN game g
		   on g.id = o.gameId
	       INNER JOIN v_GameEvent ge
		   ON ge.gameId = g.id
	 WHERE ge.loginGUID = @pv_loginGUID
	   AND o.name = 'Rating'
	   AND ov.displayValue = @pv_TextValue15;

    -- Call native stored procedure
	exec sp_ins_scoutRecord 0, @lv_ScoutId, @lv_MatchId, @lv_TeamId, @pv_AlliancePosition, @pv_ScoutComment, @pv_loginGUID
	                      , @lv_aLeaveId, @pv_TextValue02, @pv_TextValue03, @pv_TextValue04, @pv_TextValue05
	                      , @pv_TextValue06, @pv_TextValue07, @pv_TextValue08, @pv_TextValue09, @pv_TextValue10
	                      , @pv_TextValue11, @lv_toEndId, @pv_TextValue13, @lv_toDefenseId, @lv_RatingId
	                      , @pv_TextValue16, @pv_TextValue17, @pv_TextValue18, @pv_TextValue19, @pv_TextValue20
						  , 0;
END