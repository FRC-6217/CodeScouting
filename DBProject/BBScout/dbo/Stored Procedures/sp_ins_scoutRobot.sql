CREATE PROCEDURE [dbo].[sp_ins_scoutRobot]  (@pv_TeamId integer
								   , @pv_loginGUID varchar(128)
                                   , @pv_TextValue01 varchar(4000) = null
                                   , @pv_TextValue02 varchar(4000) = null
                                   , @pv_TextValue03 varchar(4000) = null
                                   , @pv_TextValue04 varchar(4000) = null
                                   , @pv_TextValue05 varchar(4000) = null
                                   , @pv_TextValue06 varchar(4000) = null
                                   , @pv_TextValue07 varchar(4000) = null
                                   , @pv_TextValue08 varchar(4000) = null
                                   , @pv_TextValue09 varchar(4000) = null
                                   , @pv_TextValue10 varchar(4000) = null
                                   , @pv_TextValue11 varchar(4000) = null
                                   , @pv_TextValue12 varchar(4000) = null
                                   , @pv_TextValue13 varchar(4000) = null
                                   , @pv_TextValue14 varchar(4000) = null
                                   , @pv_TextValue15 varchar(4000) = null)
AS
declare @lv_AtributeId integer;
declare @lv_TeamAtributeId integer;
declare @lv_ScoringTypeName varchar(64);
declare @lv_IntegerValue integer;

BEGIN
	SET NOCOUNT ON
	-- Lookup Team Attribute Record
	if @pv_TextValue01 is not null
		BEGIN
		SELECT @lv_AtributeId = max(a.id)
		     , @lv_TeamAtributeId = max(ta.id)
			 , @lv_ScoringTypeName = max(st.name)
		  FROM Attribute a
		       INNER JOIN scoringType st
			   ON st.id = a.scoringTypeId
			   INNER JOIN v_GameEvent ge
			   ON ge.gameId = a.gameId
			   LEFT OUTER JOIN TeamAttribute ta
			   ON ta.attributeId = a.id
			   AND ta.teamId = @pv_TeamId
		 WHERE a.sortOrder = 1
		   AND ge.loginGUID = @pv_loginGUID;
		-- Decide if integer or text submitted
		IF @lv_ScoringTypeName = 'Free Form'
			BEGIN
			SET @lv_IntegerValue = NULL;
			END
		ELSE
			BEGIN
			SET @lv_IntegerValue = convert(integer, @pv_TextValue01);
			SET @pv_TextValue01 = NULL;
			END
		-- Add Team Attribute Record
		IF @lv_TeamAtributeId is null
			BEGIN
			INSERT INTO TeamAttribute (teamId, attributeId, integerValue, textValue)
			SELECT @pv_TeamId, @lv_AtributeId, @lv_IntegerValue, @pv_TextValue01;
			END
		ELSE
			BEGIN
			UPDATE TeamAttribute
               SET integerValue = @lv_IntegerValue
    			 , textValue = case when @pv_TextValue01 is null or @pv_TextValue01 = '' then textValue else @pv_TextValue01 end
             WHERE teamId = @pv_TeamId
			   AND attributeId = @lv_AtributeId;
			END
		END

	-- Lookup Team Attribute Record
	if @pv_TextValue02 is not null
		BEGIN
		SELECT @lv_AtributeId = max(a.id)
		     , @lv_TeamAtributeId = max(ta.id)
			 , @lv_ScoringTypeName = max(st.name)
		  FROM Attribute a
		       INNER JOIN scoringType st
			   ON st.id = a.scoringTypeId
			   INNER JOIN v_GameEvent ge
			   ON ge.gameId = a.gameId
			   LEFT OUTER JOIN TeamAttribute ta
			   ON ta.attributeId = a.id
			   AND ta.teamId = @pv_TeamId
		 WHERE a.sortOrder = 2
		   AND ge.loginGUID = @pv_loginGUID;
		-- Decide if integer or text submitted
		IF @lv_ScoringTypeName = 'Free Form'
			BEGIN
			SET @lv_IntegerValue = NULL;
			END
		ELSE
			BEGIN
			SET @lv_IntegerValue = convert(integer, @pv_TextValue02);
			SET @pv_TextValue02 = NULL;
			END
		-- Add Team Attribute Record
		IF @lv_TeamAtributeId is null
			BEGIN
			INSERT INTO TeamAttribute (teamId, attributeId, integerValue, textValue)
			SELECT @pv_TeamId, @lv_AtributeId, @lv_IntegerValue, @pv_TextValue02;
			END
		ELSE
			BEGIN
			UPDATE TeamAttribute
               SET integerValue = @lv_IntegerValue
    			 , textValue = case when @pv_TextValue02 is null or @pv_TextValue02 = '' then textValue else @pv_TextValue02 end
             WHERE teamId = @pv_TeamId
			   AND attributeId = @lv_AtributeId;
			END
		END

	-- Lookup Team Attribute Record
	if @pv_TextValue03 is not null
		BEGIN
		SELECT @lv_AtributeId = max(a.id)
		     , @lv_TeamAtributeId = max(ta.id)
			 , @lv_ScoringTypeName = max(st.name)
		  FROM Attribute a
		       INNER JOIN scoringType st
			   ON st.id = a.scoringTypeId
			   INNER JOIN v_GameEvent ge
			   ON ge.gameId = a.gameId
			   LEFT OUTER JOIN TeamAttribute ta
			   ON ta.attributeId = a.id
			   AND ta.teamId = @pv_TeamId
		 WHERE a.sortOrder = 3
		   AND ge.loginGUID = @pv_loginGUID;
		-- Decide if integer or text submitted
		IF @lv_ScoringTypeName = 'Free Form'
			BEGIN
			SET @lv_IntegerValue = NULL;
			END
		ELSE
			BEGIN
			SET @lv_IntegerValue = convert(integer, @pv_TextValue03);
			SET @pv_TextValue03 = NULL;
			END
		-- Add Team Attribute Record
		IF @lv_TeamAtributeId is null
			BEGIN
			INSERT INTO TeamAttribute (teamId, attributeId, integerValue, textValue)
			SELECT @pv_TeamId, @lv_AtributeId, @lv_IntegerValue, @pv_TextValue03;
			END
		ELSE
			BEGIN
			UPDATE TeamAttribute
               SET integerValue = @lv_IntegerValue
    			 , textValue = case when @pv_TextValue03 is null or @pv_TextValue03 = '' then textValue else @pv_TextValue03 end
             WHERE teamId = @pv_TeamId
			   AND attributeId = @lv_AtributeId;
			END
		END

	-- Lookup Team Attribute Record
	if @pv_TextValue04 is not null
		BEGIN
		SELECT @lv_AtributeId = max(a.id)
		     , @lv_TeamAtributeId = max(ta.id)
			 , @lv_ScoringTypeName = max(st.name)
		  FROM Attribute a
		       INNER JOIN scoringType st
			   ON st.id = a.scoringTypeId
			   INNER JOIN v_GameEvent ge
			   ON ge.gameId = a.gameId
			   LEFT OUTER JOIN TeamAttribute ta
			   ON ta.attributeId = a.id
			   AND ta.teamId = @pv_TeamId
		 WHERE a.sortOrder = 4
		   AND ge.loginGUID = @pv_loginGUID;
		-- Decide if integer or text submitted
		IF @lv_ScoringTypeName = 'Free Form'
			BEGIN
			SET @lv_IntegerValue = NULL;
			END
		ELSE
			BEGIN
			SET @lv_IntegerValue = convert(integer, @pv_TextValue04);
			SET @pv_TextValue04 = NULL;
			END
		-- Add Team Attribute Record
		IF @lv_TeamAtributeId is null
			BEGIN
			INSERT INTO TeamAttribute (teamId, attributeId, integerValue, textValue)
			SELECT @pv_TeamId, @lv_AtributeId, @lv_IntegerValue, @pv_TextValue04;
			END
		ELSE
			BEGIN
			UPDATE TeamAttribute
               SET integerValue = @lv_IntegerValue
    			 , textValue = case when @pv_TextValue04 is null or @pv_TextValue04 = '' then textValue else @pv_TextValue04 end
             WHERE teamId = @pv_TeamId
			   AND attributeId = @lv_AtributeId;
			END
		END

	-- Lookup Team Attribute Record
	if @pv_TextValue05 is not null
		BEGIN
		SELECT @lv_AtributeId = max(a.id)
		     , @lv_TeamAtributeId = max(ta.id)
			 , @lv_ScoringTypeName = max(st.name)
		  FROM Attribute a
		       INNER JOIN scoringType st
			   ON st.id = a.scoringTypeId
			   INNER JOIN v_GameEvent ge
			   ON ge.gameId = a.gameId
			   LEFT OUTER JOIN TeamAttribute ta
			   ON ta.attributeId = a.id
			   AND ta.teamId = @pv_TeamId
		 WHERE a.sortOrder = 5
		   AND ge.loginGUID = @pv_loginGUID;
		-- Decide if integer or text submitted
		IF @lv_ScoringTypeName = 'Free Form'
			BEGIN
			SET @lv_IntegerValue = NULL;
			END
		ELSE
			BEGIN
			SET @lv_IntegerValue = convert(integer, @pv_TextValue05);
			SET @pv_TextValue05 = NULL;
			END
		-- Add Team Attribute Record
		IF @lv_TeamAtributeId is null
			BEGIN
			INSERT INTO TeamAttribute (teamId, attributeId, integerValue, textValue)
			SELECT @pv_TeamId, @lv_AtributeId, @lv_IntegerValue, @pv_TextValue05;
			END
		ELSE
			BEGIN
			UPDATE TeamAttribute
               SET integerValue = @lv_IntegerValue
    			 , textValue = case when @pv_TextValue05 is null or @pv_TextValue05 = '' then textValue else @pv_TextValue05 end
             WHERE teamId = @pv_TeamId
			   AND attributeId = @lv_AtributeId;
			END
		END

	-- Lookup Team Attribute Record
	if @pv_TextValue06 is not null
		BEGIN
		SELECT @lv_AtributeId = max(a.id)
		     , @lv_TeamAtributeId = max(ta.id)
			 , @lv_ScoringTypeName = max(st.name)
		  FROM Attribute a
		       INNER JOIN scoringType st
			   ON st.id = a.scoringTypeId
			   INNER JOIN v_GameEvent ge
			   ON ge.gameId = a.gameId
			   LEFT OUTER JOIN TeamAttribute ta
			   ON ta.attributeId = a.id
			   AND ta.teamId = @pv_TeamId
		 WHERE a.sortOrder = 6
		   AND ge.loginGUID = @pv_loginGUID;
		-- Decide if integer or text submitted
		IF @lv_ScoringTypeName = 'Free Form'
			BEGIN
			SET @lv_IntegerValue = NULL;
			END
		ELSE
			BEGIN
			SET @lv_IntegerValue = convert(integer, @pv_TextValue06);
			SET @pv_TextValue06 = NULL;
			END
		-- Add Team Attribute Record
		IF @lv_TeamAtributeId is null
			BEGIN
			INSERT INTO TeamAttribute (teamId, attributeId, integerValue, textValue)
			SELECT @pv_TeamId, @lv_AtributeId, @lv_IntegerValue, @pv_TextValue06;
			END
		ELSE
			BEGIN
			UPDATE TeamAttribute
               SET integerValue = @lv_IntegerValue
    			 , textValue = case when @pv_TextValue06 is null or @pv_TextValue06 = '' then textValue else @pv_TextValue06 end
             WHERE teamId = @pv_TeamId
			   AND attributeId = @lv_AtributeId;
			END
		END

	-- Lookup Team Attribute Record
	if @pv_TextValue07 is not null
		BEGIN
		SELECT @lv_AtributeId = max(a.id)
		     , @lv_TeamAtributeId = max(ta.id)
			 , @lv_ScoringTypeName = max(st.name)
		  FROM Attribute a
		       INNER JOIN scoringType st
			   ON st.id = a.scoringTypeId
			   INNER JOIN v_GameEvent ge
			   ON ge.gameId = a.gameId
			   LEFT OUTER JOIN TeamAttribute ta
			   ON ta.attributeId = a.id
			   AND ta.teamId = @pv_TeamId
		 WHERE a.sortOrder = 7
		   AND ge.loginGUID = @pv_loginGUID;
		-- Decide if integer or text submitted
		IF @lv_ScoringTypeName = 'Free Form'
			BEGIN
			SET @lv_IntegerValue = NULL;
			END
		ELSE
			BEGIN
			SET @lv_IntegerValue = convert(integer, @pv_TextValue07);
			SET @pv_TextValue07 = NULL;
			END
		-- Add Team Attribute Record
		IF @lv_TeamAtributeId is null
			BEGIN
			INSERT INTO TeamAttribute (teamId, attributeId, integerValue, textValue)
			SELECT @pv_TeamId, @lv_AtributeId, @lv_IntegerValue, @pv_TextValue07;
			END
		ELSE
			BEGIN
			UPDATE TeamAttribute
               SET integerValue = @lv_IntegerValue
    			 , textValue = case when @pv_TextValue07 is null or @pv_TextValue07 = '' then textValue else @pv_TextValue07 end
             WHERE teamId = @pv_TeamId
			   AND attributeId = @lv_AtributeId;
			END
		END

	-- Lookup Team Attribute Record
	if @pv_TextValue08 is not null
		BEGIN
		SELECT @lv_AtributeId = max(a.id)
		     , @lv_TeamAtributeId = max(ta.id)
			 , @lv_ScoringTypeName = max(st.name)
		  FROM Attribute a
		       INNER JOIN scoringType st
			   ON st.id = a.scoringTypeId
			   INNER JOIN v_GameEvent ge
			   ON ge.gameId = a.gameId
			   LEFT OUTER JOIN TeamAttribute ta
			   ON ta.attributeId = a.id
			   AND ta.teamId = @pv_TeamId
		 WHERE a.sortOrder = 8
		   AND ge.loginGUID = @pv_loginGUID;
		-- Decide if integer or text submitted
		IF @lv_ScoringTypeName = 'Free Form'
			BEGIN
			SET @lv_IntegerValue = NULL;
			END
		ELSE
			BEGIN
			SET @lv_IntegerValue = convert(integer, @pv_TextValue08);
			SET @pv_TextValue08 = NULL;
			END
		-- Add Team Attribute Record
		IF @lv_TeamAtributeId is null
			BEGIN
			INSERT INTO TeamAttribute (teamId, attributeId, integerValue, textValue)
			SELECT @pv_TeamId, @lv_AtributeId, @lv_IntegerValue, @pv_TextValue08;
			END
		ELSE
			BEGIN
			UPDATE TeamAttribute
               SET integerValue = @lv_IntegerValue
    			 , textValue = case when @pv_TextValue08 is null or @pv_TextValue08 = '' then textValue else @pv_TextValue08 end
             WHERE teamId = @pv_TeamId
			   AND attributeId = @lv_AtributeId;
			END
		END

	-- Lookup Team Attribute Record
	if @pv_TextValue09 is not null
		BEGIN
		SELECT @lv_AtributeId = max(a.id)
		     , @lv_TeamAtributeId = max(ta.id)
			 , @lv_ScoringTypeName = max(st.name)
		  FROM Attribute a
		       INNER JOIN scoringType st
			   ON st.id = a.scoringTypeId
			   INNER JOIN v_GameEvent ge
			   ON ge.gameId = a.gameId
			   LEFT OUTER JOIN TeamAttribute ta
			   ON ta.attributeId = a.id
			   AND ta.teamId = @pv_TeamId
		 WHERE a.sortOrder = 9
		   AND ge.loginGUID = @pv_loginGUID;
		-- Decide if integer or text submitted
		IF @lv_ScoringTypeName = 'Free Form'
			BEGIN
			SET @lv_IntegerValue = NULL;
			END
		ELSE
			BEGIN
			SET @lv_IntegerValue = convert(integer, @pv_TextValue09);
			SET @pv_TextValue09 = NULL;
			END
		-- Add Team Attribute Record
		IF @lv_TeamAtributeId is null
			BEGIN
			INSERT INTO TeamAttribute (teamId, attributeId, integerValue, textValue)
			SELECT @pv_TeamId, @lv_AtributeId, @lv_IntegerValue, @pv_TextValue09;
			END
		ELSE
			BEGIN
			UPDATE TeamAttribute
               SET integerValue = @lv_IntegerValue
    			 , textValue = case when @pv_TextValue09 is null or @pv_TextValue09 = '' then textValue else @pv_TextValue09 end
             WHERE teamId = @pv_TeamId
			   AND attributeId = @lv_AtributeId;
			END
		END

	-- Lookup Team Attribute Record
	if @pv_TextValue10 is not null
		BEGIN
		SELECT @lv_AtributeId = max(a.id)
		     , @lv_TeamAtributeId = max(ta.id)
			 , @lv_ScoringTypeName = max(st.name)
		  FROM Attribute a
		       INNER JOIN scoringType st
			   ON st.id = a.scoringTypeId
			   INNER JOIN v_GameEvent ge
			   ON ge.gameId = a.gameId
			   LEFT OUTER JOIN TeamAttribute ta
			   ON ta.attributeId = a.id
			   AND ta.teamId = @pv_TeamId
		 WHERE a.sortOrder = 10
		   AND ge.loginGUID = @pv_loginGUID;
		-- Decide if integer or text submitted
		IF @lv_ScoringTypeName = 'Free Form'
			BEGIN
			SET @lv_IntegerValue = NULL;
			END
		ELSE
			BEGIN
			SET @lv_IntegerValue = convert(integer, @pv_TextValue10);
			SET @pv_TextValue10 = NULL;
			END
		-- Add Team Attribute Record
		IF @lv_TeamAtributeId is null
			BEGIN
			INSERT INTO TeamAttribute (teamId, attributeId, integerValue, textValue)
			SELECT @pv_TeamId, @lv_AtributeId, @lv_IntegerValue, @pv_TextValue10;
			END
		ELSE
			BEGIN
			UPDATE TeamAttribute
               SET integerValue = @lv_IntegerValue
    			 , textValue = case when @pv_TextValue10 is null or @pv_TextValue10 = '' then textValue else @pv_TextValue10 end
             WHERE teamId = @pv_TeamId
			   AND attributeId = @lv_AtributeId;
			END
		END

	-- Lookup Team Attribute Record
	if @pv_TextValue11 is not null
		BEGIN
		SELECT @lv_AtributeId = max(a.id)
		     , @lv_TeamAtributeId = max(ta.id)
			 , @lv_ScoringTypeName = max(st.name)
		  FROM Attribute a
		       INNER JOIN scoringType st
			   ON st.id = a.scoringTypeId
			   INNER JOIN v_GameEvent ge
			   ON ge.gameId = a.gameId
			   LEFT OUTER JOIN TeamAttribute ta
			   ON ta.attributeId = a.id
			   AND ta.teamId = @pv_TeamId
		 WHERE a.sortOrder = 11
		   AND ge.loginGUID = @pv_loginGUID;
		-- Decide if integer or text submitted
		IF @lv_ScoringTypeName = 'Free Form'
			BEGIN
			SET @lv_IntegerValue = NULL;
			END
		ELSE
			BEGIN
			SET @lv_IntegerValue = convert(integer, @pv_TextValue11);
			SET @pv_TextValue11 = NULL;
			END
		-- Add Team Attribute Record
		IF @lv_TeamAtributeId is null
			BEGIN
			INSERT INTO TeamAttribute (teamId, attributeId, integerValue, textValue)
			SELECT @pv_TeamId, @lv_AtributeId, @lv_IntegerValue, @pv_TextValue11;
			END
		ELSE
			BEGIN
			UPDATE TeamAttribute
               SET integerValue = @lv_IntegerValue
    			 , textValue = case when @pv_TextValue11 is null or @pv_TextValue11 = '' then textValue else @pv_TextValue11 end
             WHERE teamId = @pv_TeamId
			   AND attributeId = @lv_AtributeId;
			END
		END

	-- Lookup Team Attribute Record
	if @pv_TextValue12 is not null
		BEGIN
		SELECT @lv_AtributeId = max(a.id)
		     , @lv_TeamAtributeId = max(ta.id)
			 , @lv_ScoringTypeName = max(st.name)
		  FROM Attribute a
		       INNER JOIN scoringType st
			   ON st.id = a.scoringTypeId
			   INNER JOIN v_GameEvent ge
			   ON ge.gameId = a.gameId
			   LEFT OUTER JOIN TeamAttribute ta
			   ON ta.attributeId = a.id
			   AND ta.teamId = @pv_TeamId
		 WHERE a.sortOrder = 12
		   AND ge.loginGUID = @pv_loginGUID;
		-- Decide if integer or text submitted
		IF @lv_ScoringTypeName = 'Free Form'
			BEGIN
			SET @lv_IntegerValue = NULL;
			END
		ELSE
			BEGIN
			SET @lv_IntegerValue = convert(integer, @pv_TextValue12);
			SET @pv_TextValue12 = NULL;
			END
		-- Add Team Attribute Record
		IF @lv_TeamAtributeId is null
			BEGIN
			INSERT INTO TeamAttribute (teamId, attributeId, integerValue, textValue)
			SELECT @pv_TeamId, @lv_AtributeId, @lv_IntegerValue, @pv_TextValue12;
			END
		ELSE
			BEGIN
			UPDATE TeamAttribute
               SET integerValue = @lv_IntegerValue
    			 , textValue = case when @pv_TextValue12 is null or @pv_TextValue12 = '' then textValue else @pv_TextValue12 end
             WHERE teamId = @pv_TeamId
			   AND attributeId = @lv_AtributeId;
			END
		END

	-- Lookup Team Attribute Record
	if @pv_TextValue13 is not null
		BEGIN
		SELECT @lv_AtributeId = max(a.id)
		     , @lv_TeamAtributeId = max(ta.id)
			 , @lv_ScoringTypeName = max(st.name)
		  FROM Attribute a
		       INNER JOIN scoringType st
			   ON st.id = a.scoringTypeId
			   INNER JOIN v_GameEvent ge
			   ON ge.gameId = a.gameId
			   LEFT OUTER JOIN TeamAttribute ta
			   ON ta.attributeId = a.id
			   AND ta.teamId = @pv_TeamId
		 WHERE a.sortOrder = 13
		   AND ge.loginGUID = @pv_loginGUID;
		-- Decide if integer or text submitted
		IF @lv_ScoringTypeName = 'Free Form'
			BEGIN
			SET @lv_IntegerValue = NULL;
			END
		ELSE
			BEGIN
			SET @lv_IntegerValue = convert(integer, @pv_TextValue13);
			SET @pv_TextValue13 = NULL;
			END
		-- Add Team Attribute Record
		IF @lv_TeamAtributeId is null
			BEGIN
			INSERT INTO TeamAttribute (teamId, attributeId, integerValue, textValue)
			SELECT @pv_TeamId, @lv_AtributeId, @lv_IntegerValue, @pv_TextValue13;
			END
		ELSE
			BEGIN
			UPDATE TeamAttribute
               SET integerValue = @lv_IntegerValue
    			 , textValue = case when @pv_TextValue13 is null or @pv_TextValue13 = '' then textValue else @pv_TextValue13 end
             WHERE teamId = @pv_TeamId
			   AND attributeId = @lv_AtributeId;
			END
		END

	-- Lookup Team Attribute Record
	if @pv_TextValue14 is not null
		BEGIN
		SELECT @lv_AtributeId = max(a.id)
		     , @lv_TeamAtributeId = max(ta.id)
			 , @lv_ScoringTypeName = max(st.name)
		  FROM Attribute a
		       INNER JOIN scoringType st
			   ON st.id = a.scoringTypeId
			   INNER JOIN v_GameEvent ge
			   ON ge.gameId = a.gameId
			   LEFT OUTER JOIN TeamAttribute ta
			   ON ta.attributeId = a.id
			   AND ta.teamId = @pv_TeamId
		 WHERE a.sortOrder = 14
		   AND ge.loginGUID = @pv_loginGUID;
		-- Decide if integer or text submitted
		IF @lv_ScoringTypeName = 'Free Form'
			BEGIN
			SET @lv_IntegerValue = NULL;
			END
		ELSE
			BEGIN
			SET @lv_IntegerValue = convert(integer, @pv_TextValue14);
			SET @pv_TextValue14 = NULL;
			END
		-- Add Team Attribute Record
		IF @lv_TeamAtributeId is null
			BEGIN
			INSERT INTO TeamAttribute (teamId, attributeId, integerValue, textValue)
			SELECT @pv_TeamId, @lv_AtributeId, @lv_IntegerValue, @pv_TextValue14;
			END
		ELSE
			BEGIN
			UPDATE TeamAttribute
               SET integerValue = @lv_IntegerValue
    			 , textValue = case when @pv_TextValue14 is null or @pv_TextValue14 = '' then textValue else @pv_TextValue14 end
             WHERE teamId = @pv_TeamId
			   AND attributeId = @lv_AtributeId;
			END
		END

	-- Lookup Team Attribute Record
	if @pv_TextValue15 is not null
		BEGIN
		SELECT @lv_AtributeId = max(a.id)
		     , @lv_TeamAtributeId = max(ta.id)
			 , @lv_ScoringTypeName = max(st.name)
		  FROM Attribute a
		       INNER JOIN scoringType st
			   ON st.id = a.scoringTypeId
			   INNER JOIN v_GameEvent ge
			   ON ge.gameId = a.gameId
			   LEFT OUTER JOIN TeamAttribute ta
			   ON ta.attributeId = a.id
			   AND ta.teamId = @pv_TeamId
		 WHERE a.sortOrder = 15
		   AND ge.loginGUID = @pv_loginGUID;
		-- Decide if integer or text submitted
		IF @lv_ScoringTypeName = 'Free Form'
			BEGIN
			SET @lv_IntegerValue = NULL;
			END
		ELSE
			BEGIN
			SET @lv_IntegerValue = convert(integer, @pv_TextValue15);
			SET @pv_TextValue15 = NULL;
			END
		-- Add Team Attribute Record
		IF @lv_TeamAtributeId is null
			BEGIN
			INSERT INTO TeamAttribute (teamId, attributeId, integerValue, textValue)
			SELECT @pv_TeamId, @lv_AtributeId, @lv_IntegerValue, @pv_TextValue15;
			END
		ELSE
			BEGIN
			UPDATE TeamAttribute
               SET integerValue = @lv_IntegerValue
    			 , textValue = case when @pv_TextValue15 is null or @pv_TextValue15 = '' then textValue else @pv_TextValue15 end
             WHERE teamId = @pv_TeamId
			   AND attributeId = @lv_AtributeId;
			END
		END
END
