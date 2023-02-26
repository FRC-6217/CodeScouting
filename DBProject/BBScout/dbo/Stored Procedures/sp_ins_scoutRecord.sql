CREATE PROCEDURE [dbo].[sp_ins_scoutRecord] (@pv_ScoutId integer
                                   , @pv_MatchId integer
                                   , @pv_TeamId integer
								   , @pv_AlliancePosition varchar(64)
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
declare @lv_Id integer;

BEGIN
	SET NOCOUNT ON
	-- Lookup Scout Header Record
	SELECT @lv_id = max(id)
	  FROM ScoutRecord
	 WHERE scoutId = @pv_ScoutId
	   AND matchId = @pv_MatchId
	   AND teamId = @pv_TeamId;
	   
	-- Add/update Scout Header Record
	IF @lv_Id is null
	BEGIN
		INSERT INTO ScoutRecord (scoutId, matchId, teamId, scoutComment)
		SELECT @pv_ScoutId, @pv_MatchId, @pv_TeamId, @pv_ScoutComment;
		SET @lv_Id = @@IDENTITY;
	END
	ELSE
	BEGIN
		UPDATE ScoutRecord
		   SET scoutComment = COALESCE(@pv_ScoutComment, scoutComment)
		WHERE scoutId = @pv_ScoutId
		  AND matchId = @pv_MatchId
		  AND teamId = @pv_TeamId;
	END

    -- Insert/Update Scout Objective Record data
	MERGE ScoutObjectiveRecord AS TARGET
	USING (
		SELECT @lv_Id scoutRecordId
			 , o.id objectiveId
			 , case when st.name = 'Free Form'
			        then null
					else case when o.sortOrder = 1 then convert(integer, @pv_TextValue01)
					          when o.sortOrder = 2 then convert(integer, @pv_TextValue02)
					          when o.sortOrder = 3 then convert(integer, @pv_TextValue03)
					          when o.sortOrder = 4 then convert(integer, @pv_TextValue04)
					          when o.sortOrder = 5 then convert(integer, @pv_TextValue05)
					          when o.sortOrder = 6 then convert(integer, @pv_TextValue06)
					          when o.sortOrder = 7 then convert(integer, @pv_TextValue07)
					          when o.sortOrder = 8 then convert(integer, @pv_TextValue08)
					          when o.sortOrder = 9 then convert(integer, @pv_TextValue09)
					          when o.sortOrder = 10 then convert(integer, @pv_TextValue10)
					          when o.sortOrder = 11 then convert(integer, @pv_TextValue11)
					          when o.sortOrder = 12 then convert(integer, @pv_TextValue12)
					          when o.sortOrder = 13 then convert(integer, @pv_TextValue13)
					          when o.sortOrder = 14 then convert(integer, @pv_TextValue14)
					          when o.sortOrder = 15 then convert(integer, @pv_TextValue15)
					          when o.sortOrder = 16 then convert(integer, @pv_TextValue16)
					          when o.sortOrder = 17 then convert(integer, @pv_TextValue17)
					          when o.sortOrder = 18 then convert(integer, @pv_TextValue18)
					          when o.sortOrder = 19 then convert(integer, @pv_TextValue19)
					          when o.sortOrder = 20 then convert(integer, @pv_TextValue20)
					          else null end
					end integerValue
			 , case when st.name = 'Free Form'
			        then null
					else case when o.sortOrder = 1 then convert(decimal, @pv_TextValue01)
					          when o.sortOrder = 2 then convert(decimal, @pv_TextValue02)
					          when o.sortOrder = 3 then convert(decimal, @pv_TextValue03)
					          when o.sortOrder = 4 then convert(decimal, @pv_TextValue04)
					          when o.sortOrder = 5 then convert(decimal, @pv_TextValue05)
					          when o.sortOrder = 6 then convert(decimal, @pv_TextValue06)
					          when o.sortOrder = 7 then convert(decimal, @pv_TextValue07)
					          when o.sortOrder = 8 then convert(decimal, @pv_TextValue08)
					          when o.sortOrder = 9 then convert(decimal, @pv_TextValue09)
					          when o.sortOrder = 10 then convert(decimal, @pv_TextValue10)
					          when o.sortOrder = 11 then convert(decimal, @pv_TextValue11)
					          when o.sortOrder = 12 then convert(decimal, @pv_TextValue12)
					          when o.sortOrder = 13 then convert(decimal, @pv_TextValue13)
					          when o.sortOrder = 14 then convert(decimal, @pv_TextValue14)
					          when o.sortOrder = 15 then convert(decimal, @pv_TextValue15)
					          when o.sortOrder = 16 then convert(decimal, @pv_TextValue16)
					          when o.sortOrder = 17 then convert(decimal, @pv_TextValue17)
					          when o.sortOrder = 18 then convert(decimal, @pv_TextValue18)
					          when o.sortOrder = 19 then convert(decimal, @pv_TextValue19)
					          when o.sortOrder = 20 then convert(decimal, @pv_TextValue20)
					          else null end
					end decimalValue
			 , case when st.name = 'Free Form'
			        then case when o.sortOrder = 1 then @pv_TextValue01
					          when o.sortOrder = 2 then @pv_TextValue02
					          when o.sortOrder = 3 then @pv_TextValue03
					          when o.sortOrder = 4 then @pv_TextValue04
					          when o.sortOrder = 5 then @pv_TextValue05
					          when o.sortOrder = 6 then @pv_TextValue06
					          when o.sortOrder = 7 then @pv_TextValue07
					          when o.sortOrder = 8 then @pv_TextValue08
					          when o.sortOrder = 9 then @pv_TextValue09
					          when o.sortOrder = 10 then @pv_TextValue10
					          when o.sortOrder = 11 then @pv_TextValue11
					          when o.sortOrder = 12 then @pv_TextValue12
					          when o.sortOrder = 13 then @pv_TextValue13
					          when o.sortOrder = 14 then @pv_TextValue14
					          when o.sortOrder = 15 then @pv_TextValue15
					          when o.sortOrder = 16 then @pv_TextValue16
					          when o.sortOrder = 17 then @pv_TextValue17
					          when o.sortOrder = 18 then @pv_TextValue18
					          when o.sortOrder = 19 then @pv_TextValue19
					          when o.sortOrder = 20 then @pv_TextValue20
					          else null end
					else null end textValue
		  FROM Match m
			   INNER JOIN GameEvent ge
			   ON ge.id = m.gameEventId
			   INNER JOIN Objective o
			   ON o.gameId = ge.gameId
			   INNER JOIN ScoringType st
			   ON st.id = o.scoringTypeId
		 WHERE m.id = @pv_MatchId ) AS SOURCE
	ON (TARGET.scoutRecordId = SOURCE.scoutRecordId
	AND TARGET.objectiveId = SOURCE.objectiveId)
    WHEN MATCHED AND (COALESCE(TARGET.integerValue, -999) <> COALESCE(SOURCE.integerValue, -999)
	               OR COALESCE(TARGET.decimalValue, -999.0) <> COALESCE(SOURCE.decimalValue, -999.0)
	               OR COALESCE(TARGET.textValue, '<XXXX>') <> COALESCE(SOURCE.textValue, '<XXXX>'))
    THEN UPDATE SET TARGET.integerValue = SOURCE.integerValue, TARGET.decimalValue = SOURCE.decimalValue, TARGET.textValue = SOURCE.textValue
	WHEN NOT MATCHED
	THEN INSERT (scoutRecordId, objectiveId, integerValue, decimalValue, textValue) VALUES (SOURCE.scoutRecordId, SOURCE.objectiveId, SOURCE.integerValue, SOURCE.decimalValue, SOURCE.textValue);

	-- Lookup Team Match Record by Alliance/Position
	SELECT @lv_id = max(id)
	  FROM TeamMatch
	 WHERE matchId = @pv_MatchId
	   AND alliance = substring(@pv_AlliancePosition, 1, 1)
	   AND alliancePosition = convert(int, substring(@pv_AlliancePosition, 2, 1));

	-- Lookup Team Match Record by Team Id
	IF @lv_Id is null
	BEGIN
		SELECT @lv_id = max(id)
		  FROM TeamMatch
		 WHERE matchId = @pv_MatchId
		   AND teamId = @pv_TeamId;

		-- Add Team Match Record
		IF @lv_Id is null
			insert into TeamMatch (matchId, teamId, alliance, alliancePosition)
			values (@pv_MatchId, @pv_TeamId, substring(@pv_AlliancePosition, 1, 1), convert(int, substring(@pv_AlliancePosition, 2, 1)));
		ELSE
			-- Update Team Match Record
			update TeamMatch
			   set alliance = substring(@pv_AlliancePosition, 1, 1)
			     , alliancePosition = convert(int, substring(@pv_AlliancePosition, 2, 1))
			 where matchId = @pv_MatchId
			   and teamId = @pv_TeamId;
	END
	ELSE
		-- Update Team Match Record
		update TeamMatch
		   set teamId = @pv_TeamId
		 where matchId = @pv_MatchId
		   and alliance = substring(@pv_AlliancePosition, 1, 1)
		   and alliancePosition = convert(int, substring(@pv_AlliancePosition, 2, 1));

    -- Resynch TBA data for all scout records
	exec sp_upd_scoutDataFromTba @pv_loginGUID;
END
