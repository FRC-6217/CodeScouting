CREATE PROCEDURE sp_ins_scout  (@pv_ScoutId integer
							  , @pv_lastName varchar(128)
							  , @pv_firstName varchar(128)
							  , @pv_teamId int
							  , @pv_isActive char(1)
							  , @pv_emailAddress varchar(128)
                              , @pv_isAdmin char(1))
AS
declare @lv_Count integer;

BEGIN
	SET NOCOUNT ON
	-- Lookup Team Scout
    SELECT @lv_Count = count(*)
	  FROM Scout
	 WHERE id = @pv_ScoutId;

	-- Add or Update Team Scout Record
	IF @lv_Count = 0
	BEGIN
		INSERT INTO Scout (lastName, firstName, teamId, isActive, lastUpdated, emailAddress, isAdmin)
		VALUES (@pv_lastName, @pv_firstName, @pv_teamId, @pv_isActive, getdate(), @pv_emailAddress, @pv_isAdmin);
	END
	ELSE
	BEGIN
		UPDATE Scout
           SET lastName = @pv_lastName
		     , firstName = @pv_firstName
			 , teamId = @pv_teamId
			 , isActive = @pv_isActive
			 , emailAddress = @pv_emailAddress
			 , isAdmin = @pv_isAdmin
			 , lastUpdated = getdate()
		 WHERE id = @pv_ScoutId;
	END
END