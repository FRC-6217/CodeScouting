CREATE PROCEDURE sp_ins_teamMatches (@pv_ScoutGUID uniqueidentifier
                                   , @pv_MatchNumber varchar(8)
                                   , @pv_R1_TeamNumber integer
                                   , @pv_R2_TeamNumber integer
                                   , @pv_R3_TeamNumber integer
                                   , @pv_B1_TeamNumber integer
                                   , @pv_B2_TeamNumber integer
                                   , @pv_B3_TeamNumber integer
								   , @pv_MatchType varchar(8)
                                   , @pv_MatchDateTime datetime
)
AS
declare @lv_GameEventId integer;
declare @lv_MatchId integer;
declare @lv_GameYear integer;
declare @lv_EventCode varchar(16);
declare @lv_TeamNumber integer;

BEGIN
	SET NOCOUNT ON
	-- Lookup Game Event Record
	SELECT @lv_GameEventId = max(t.gameEventId)
	     , @lv_GameYear = max(g.gameYear)
		 , @lv_EventCode = max(e.eventCode)
	  FROM Scout s
	       inner join Team t
		      on t.id = s.teamId
		   inner join GameEvent ge
		      on ge.id = t.gameEventId
		   inner join Game g
		      on g.id = ge.gameId
		   inner join Event e
		      on e.id = ge.eventId
	 WHERE s.scoutGUID = @pv_ScoutGUID;
	 
	-- If Game Event not found, then skip rest of logic
	IF @lv_GameEventId is not null
	BEGIN
		-- Lookup Match Record, default type to QM
		SELECT @lv_MatchId = max(m.id)
		  FROM Match m
		 WHERE m.gameEventId = @lv_GameEventId
		   AND m.type = coalesce(@pv_MatchType, 'QM')
		   AND m.number = @pv_MatchNumber;
		-- Add/update Match Record
		IF @lv_MatchId is null
		BEGIN
			INSERT INTO Match (gameEventId, number, dateTime, type, isActive, matchCode)
			VALUES (@lv_GameEventId, @pv_MatchNumber, @pv_MatchDateTime, @pv_MatchType, 'Y', convert(varchar, @lv_GameYear) + @lv_EventCode + @pv_MatchType + @pv_MatchNumber);
			SET @lv_MatchId = @@IDENTITY;
		END
		ELSE
		BEGIN
			UPDATE Match
			   SET dateTime = @pv_MatchDateTime
			     , matchCode = convert(varchar, @lv_GameYear) + @lv_EventCode + @pv_MatchType + @pv_MatchNumber
			 WHERE id = @lv_MatchId;
		END

		-- Add Team matches for R1 team
        IF @pv_R1_TeamNumber is not null
		BEGIN
			-- If not already done, add team to game event
			INSERT INTO TeamGameEvent (teamId, gameEventId)
			SELECT t.id, @lv_GameEventId
			  FROM Team t
			 WHERE t.teamNumber = @pv_R1_TeamNumber
			   AND not exists
			       (SELECT 1
				      FROM TeamGameEvent tge
					 WHERE tge.teamId = t.id
					   AND tge.gameEventId = @lv_GameEventId)

			-- Replace any other teams in this slot
			SELECT @lv_TeamNumber = max(t.teamNumber)
			  FROM TeamMatch tm
			       inner join Team t
				      on t.id = tm.teamId
			 WHERE matchId = @lv_MatchId
			   AND alliance = 'R'
			   AND alliancePosition = 1;
			IF coalesce(@lv_TeamNumber, -1) <> @pv_R1_TeamNumber
			BEGIN
				DELETE FROM TeamMatch
				 WHERE matchId = @lv_MatchId
				   AND alliance = 'R'
				   AND alliancePosition = 1;
				INSERT INTO TeamMatch (matchId, teamId, alliance, alliancePosition)
				SELECT @lv_MatchId, t.id, 'R', 1
				  FROM Team t
				 WHERE t.teamNumber = @pv_R1_TeamNumber;
			END
		END

		-- Add Team matches for R2 team
        IF @pv_R2_TeamNumber is not null
		BEGIN
			-- If not already done, add team to game event
			INSERT INTO TeamGameEvent (teamId, gameEventId)
			SELECT t.id, @lv_GameEventId
			  FROM Team t
			 WHERE t.teamNumber = @pv_R2_TeamNumber
			   AND not exists
			       (SELECT 1
				      FROM TeamGameEvent tge
					 WHERE tge.teamId = t.id
					   AND tge.gameEventId = @lv_GameEventId)

			-- Replace any other teams in this slot
			SELECT @lv_TeamNumber = max(t.teamNumber)
			  FROM TeamMatch tm
			       inner join Team t
				      on t.id = tm.teamId
			 WHERE matchId = @lv_MatchId
			   AND alliance = 'R'
			   AND alliancePosition = 2;
			IF coalesce(@lv_TeamNumber, -1) <> @pv_R2_TeamNumber
			BEGIN
				DELETE FROM TeamMatch
				 WHERE matchId = @lv_MatchId
				   AND alliance = 'R'
				   AND alliancePosition = 2;
				INSERT INTO TeamMatch (matchId, teamId, alliance, alliancePosition)
				SELECT @lv_MatchId, t.id, 'R', 2
				  FROM Team t
				 WHERE t.teamNumber = @pv_R2_TeamNumber;
			END
		END

		-- Add Team matches for R3 team
        IF @pv_R3_TeamNumber is not null
		BEGIN
			-- If not already done, add team to game event
			INSERT INTO TeamGameEvent (teamId, gameEventId)
			SELECT t.id, @lv_GameEventId
			  FROM Team t
			 WHERE t.teamNumber = @pv_R3_TeamNumber
			   AND not exists
			       (SELECT 1
				      FROM TeamGameEvent tge
					 WHERE tge.teamId = t.id
					   AND tge.gameEventId = @lv_GameEventId)

			-- Replace any other teams in this slot
			SELECT @lv_TeamNumber = max(t.teamNumber)
			  FROM TeamMatch tm
			       inner join Team t
				      on t.id = tm.teamId
			 WHERE matchId = @lv_MatchId
			   AND alliance = 'R'
			   AND alliancePosition = 3;
			IF coalesce(@lv_TeamNumber, -1) <> @pv_R3_TeamNumber
			BEGIN
				DELETE FROM TeamMatch
				 WHERE matchId = @lv_MatchId
				   AND alliance = 'R'
				   AND alliancePosition = 3;
				INSERT INTO TeamMatch (matchId, teamId, alliance, alliancePosition)
				SELECT @lv_MatchId, t.id, 'R', 3
				  FROM Team t
				 WHERE t.teamNumber = @pv_R3_TeamNumber;
			END
		END

		-- Add Team matches for B1 team
        IF @pv_B1_TeamNumber is not null
		BEGIN
			-- If not already done, add team to game event
			INSERT INTO TeamGameEvent (teamId, gameEventId)
			SELECT t.id, @lv_GameEventId
			  FROM Team t
			 WHERE t.teamNumber = @pv_B1_TeamNumber
			   AND not exists
			       (SELECT 1
				      FROM TeamGameEvent tge
					 WHERE tge.teamId = t.id
					   AND tge.gameEventId = @lv_GameEventId)

			-- Replace any other teams in this slot
			SELECT @lv_TeamNumber = max(t.teamNumber)
			  FROM TeamMatch tm
			       inner join Team t
				      on t.id = tm.teamId
			 WHERE matchId = @lv_MatchId
			   AND alliance = 'B'
			   AND alliancePosition = 1;
			IF coalesce(@lv_TeamNumber, -1) <> @pv_B1_TeamNumber
			BEGIN
				DELETE FROM TeamMatch
				 WHERE matchId = @lv_MatchId
				   AND alliance = 'B'
				   AND alliancePosition = 1;
				INSERT INTO TeamMatch (matchId, teamId, alliance, alliancePosition)
				SELECT @lv_MatchId, t.id, 'B', 1
				  FROM Team t
				 WHERE t.teamNumber = @pv_B1_TeamNumber;
			END
		END

		-- Add Team matches for B2 team
        IF @pv_B2_TeamNumber is not null
		BEGIN
			-- If not already done, add team to game event
			INSERT INTO TeamGameEvent (teamId, gameEventId)
			SELECT t.id, @lv_GameEventId
			  FROM Team t
			 WHERE t.teamNumber = @pv_B2_TeamNumber
			   AND not exists
			       (SELECT 1
				      FROM TeamGameEvent tge
					 WHERE tge.teamId = t.id
					   AND tge.gameEventId = @lv_GameEventId)

			-- Replace any other teams in this slot
			SELECT @lv_TeamNumber = max(t.teamNumber)
			  FROM TeamMatch tm
			       inner join Team t
				      on t.id = tm.teamId
			 WHERE matchId = @lv_MatchId
			   AND alliance = 'B'
			   AND alliancePosition = 2;
			IF coalesce(@lv_TeamNumber, -1) <> @pv_B2_TeamNumber
			BEGIN
				DELETE FROM TeamMatch
				 WHERE matchId = @lv_MatchId
				   AND alliance = 'B'
				   AND alliancePosition = 2;
				INSERT INTO TeamMatch (matchId, teamId, alliance, alliancePosition)
				SELECT @lv_MatchId, t.id, 'B', 2
				  FROM Team t
				 WHERE t.teamNumber = @pv_B2_TeamNumber;
			END
		END

		-- Add Team matches for B3 team
        IF @pv_B3_TeamNumber is not null
		BEGIN
			-- If not already done, add team to game event
			INSERT INTO TeamGameEvent (teamId, gameEventId)
			SELECT t.id, @lv_GameEventId
			  FROM Team t
			 WHERE t.teamNumber = @pv_B3_TeamNumber
			   AND not exists
			       (SELECT 1
				      FROM TeamGameEvent tge
					 WHERE tge.teamId = t.id
					   AND tge.gameEventId = @lv_GameEventId)

			-- Replace any other teams in this slot
			SELECT @lv_TeamNumber = max(t.teamNumber)
			  FROM TeamMatch tm
			       inner join Team t
				      on t.id = tm.teamId
			 WHERE matchId = @lv_MatchId
			   AND alliance = 'B'
			   AND alliancePosition = 3;
			IF coalesce(@lv_TeamNumber, -1) <> @pv_B3_TeamNumber
			BEGIN
				DELETE FROM TeamMatch
				 WHERE matchId = @lv_MatchId
				   AND alliance = 'B'
				   AND alliancePosition = 3;
				INSERT INTO TeamMatch (matchId, teamId, alliance, alliancePosition)
				SELECT @lv_MatchId, t.id, 'B', 3
				  FROM Team t
				 WHERE t.teamNumber = @pv_B3_TeamNumber;
			END
		END
	END
END
