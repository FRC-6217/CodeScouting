CREATE PROCEDURE sp_upd_scoutDataAutoAudit (@pv_matchId integer
                                         , @pv_alliance char(1)
										 , @pv_toleranceToAutoAudit decimal(10,2)
									     , @pv_LoginGUID uniqueidentifier)
as
DECLARE @lv_gameYear int;
DECLARE @lv_autoAuditFunction char(1);
DECLARE @lv_cntScoutedAlliance int;
DECLARE @lv_sumTBA int;
DECLARE @lv_sumAdjustedTBA int;
DECLARE @lv_sumScouted1 int;
DECLARE @lv_sumScouted2 int;
DECLARE @lv_Scouted1 int;
DECLARE @lv_Scouted2 int;
DECLARE @lv_Scouted3 int;
DECLARE @lv_UpdatedScouted1 int;
DECLARE @lv_UpdatedScouted2 int;
DECLARE @lv_UpdatedScouted3 int;
DECLARE @lv_deltaScoutedToTBA decimal(10,2)

begin
    -- Get Game Year and setting to plan for Auto Audit
	select @lv_GameYear = g.GameYear
	     , @lv_autoAuditFunction = g.autoAuditFunction
	  from Match m
	       inner join GameEvent ge
		   on ge.id = m.gameEventId
	       inner join Game g
		   on g.id = ge.gameId
	 where m.id = @pv_MatchId;

    -- Count number of alliance robots scouted (not by TBA)
	select @lv_cntScoutedAlliance = count(*)
	  from (select distinct sr.teamId
              from ScoutRecord sr
	               inner join Scout s
		           on s.id = sr.scoutId
		           inner join TeamMatch tm
		           on tm.matchId = sr.matchId
		           and tm.teamId = sr.teamId
	         where tm.matchId = @pv_matchId
	           and tm.alliance = @pv_alliance
	           and s.lastName <> 'TBA') as subquery;
-- Debug
--    select @lv_cntScoutedAlliance cntScoutedAlliance;

	-- 2026 Adjustments
	if (@lv_autoAuditFunction = 'Y' AND
	    @lv_GameYear = 2026 AND
		@lv_cntScoutedAlliance = 3)
	begin
	    -- Get TBA total for Auto Fuel made
		select @lv_sumTBA = sum(mo.integerValue)
		  from MatchObjective mo
		       inner join Objective o
			   on o.id = mo.objectiveId
		 where mo.matchId = @pv_matchId
		   and mo.alliance = @pv_alliance
		   and o.name = 'aFuel';

	    -- Get Scouted total for Auto Fuel made
		select @lv_sumScouted1 = sum(asor.avgIntegerValue)
		  from TeamMatch tm
		       inner join v_AvgScoutObjectiveRecord asor
			   on asor.teamId = tm.teamId
			   and asor.matchId = tm.matchId
		 where tm.matchId = @pv_matchId
		   and tm.alliance = @pv_alliance
		   and asor.objectiveName = 'aFuel'
		   and asor.loginGUID = @pv_LoginGUID;

	    -- Get Scouted total for Auto Human Player Fuel made
		select @lv_sumScouted2 = sum(asor.avgIntegerValue)
		  from TeamMatch tm
		       inner join v_AvgScoutObjectiveRecord asor
			   on asor.teamId = tm.teamId
			   and asor.matchId = tm.matchId
		 where tm.matchId = @pv_matchId
		   and tm.alliance = @pv_alliance
		   and asor.objectiveName = 'aHpM'
		   and asor.loginGUID = @pv_LoginGUID;

		-- Decide if auto auditing is performed on Auto Fuel made
		if (@lv_sumScouted2 > @lv_sumTBA) set @lv_sumAdjustedTBA = 0
		else set @lv_sumAdjustedTBA = @lv_sumTBA - @lv_sumScouted2;

-- Debug
--        select @lv_sumTBA sumTBA, @lv_sumAdjustedTBA sumAdjustedTBA, @lv_sumScouted1 sumScouted1, @lv_sumScouted2 sumScouted2;

		if (@lv_sumAdjustedTBA = 0) set @lv_deltaScoutedToTBA = 1.0
		else set @lv_deltaScoutedToTBA = abs((convert(decimal(10,4), @lv_sumScouted1) /  convert(decimal(10,4), @lv_sumAdjustedTBA)) - 1.0);

-- Debug
--        select @lv_deltaScoutedToTBA deltaScoutedToTBA;

		-- Audit Auto Fuel
		if ((@pv_toleranceToAutoAudit = 0.0 OR -- Indicator of always performing Auto Audit
		     @lv_deltaScoutedToTBA <= @pv_toleranceToAutoAudit) AND
			 @lv_deltaScoutedToTBA > 0 AND
			 @lv_sumTBA IS NOT NULL AND
			 @lv_sumScouted1 IS NOT NULL AND
			 @lv_sumScouted2 IS NOT NULL)
		begin
		    -- Get individual robot records for this alliance
			-- Alliance Position 1
			select @lv_Scouted1 = max(coalesce(asor.avgIntegerValue, 0))
			  from TeamMatch tm
				   inner join v_AvgScoutObjectiveRecord asor
				   on asor.teamId = tm.teamId
				   and asor.matchId = tm.matchId
			 where tm.matchId = @pv_matchId
			   and tm.alliance = @pv_alliance
			   and tm.alliancePosition = 1
			   and asor.objectiveName = 'aFuel'
			   and asor.loginGUID = @pv_LoginGUID;
			-- Alliance Position 2
			select @lv_Scouted2 = max(coalesce(asor.avgIntegerValue, 0))
			  from TeamMatch tm
				   inner join v_AvgScoutObjectiveRecord asor
				   on asor.teamId = tm.teamId
				   and asor.matchId = tm.matchId
			 where tm.matchId = @pv_matchId
			   and tm.alliance = @pv_alliance
			   and tm.alliancePosition = 2
			   and asor.objectiveName = 'aFuel'
			   and asor.loginGUID = @pv_LoginGUID;
			-- Alliance Position 3
			select @lv_Scouted3 = max(coalesce(asor.avgIntegerValue, 0))
			  from TeamMatch tm
				   inner join v_AvgScoutObjectiveRecord asor
				   on asor.teamId = tm.teamId
				   and asor.matchId = tm.matchId
			 where tm.matchId = @pv_matchId
			   and tm.alliance = @pv_alliance
			   and tm.alliancePosition = 3
			   and asor.objectiveName = 'aFuel'
			   and asor.loginGUID = @pv_LoginGUID;

          set @lv_UpdatedScouted1 = convert(int, round(convert(decimal(10,3), @lv_Scouted1) / convert(decimal(10,3), @lv_sumScouted1) * convert(decimal(10,3), @lv_sumAdjustedTBA), 0))
          set @lv_UpdatedScouted2 = convert(int, round(convert(decimal(10,3), @lv_Scouted2) / convert(decimal(10,3), @lv_sumScouted1) * convert(decimal(10,3), @lv_sumAdjustedTBA), 0))
          set @lv_UpdatedScouted3 = convert(int, round(convert(decimal(10,3), @lv_Scouted3) / convert(decimal(10,3), @lv_sumScouted1) * convert(decimal(10,3), @lv_sumAdjustedTBA), 0))
-- Debug
--			select 'Ready to Audit Auto'
--          select @lv_Scouted1, @lv_Scouted2, @lv_Scouted3; 
--          select @lv_UpdatedScouted1, @lv_UpdatedScouted2, @lv_UpdatedScouted3; 
			-- Update Alliance Position 1
			update sor
			   set integerValue = @lv_UpdatedScouted1
			     , decimalValue = convert(decimal(10,3), @lv_UpdatedScouted1)
				 , scoreValue = @lv_UpdatedScouted1 * o.scoreMultiplier
			  from scoutRecord sr
				   inner join TeamMatch tm
				   on tm.matchId = sr.matchId
				   and tm.teamId = sr.teamId
				   inner join scoutObjectiveRecord sor
				   on sor.scoutRecordId = sr.id
				   inner join Objective o
				   on o.id = sor.objectiveId
			 where sr.matchId = @pv_matchId
			   and tm.alliance = @pv_alliance
			   and tm.alliancePosition = 1
			   and o.name = 'aFuel'
			-- Update Alliance Position 2
			update sor
			   set integerValue = @lv_UpdatedScouted2
			     , decimalValue = convert(decimal(10,3), @lv_UpdatedScouted2)
				 , scoreValue = @lv_UpdatedScouted2 * o.scoreMultiplier
			  from scoutRecord sr
				   inner join TeamMatch tm
				   on tm.matchId = sr.matchId
				   and tm.teamId = sr.teamId
				   inner join scoutObjectiveRecord sor
				   on sor.scoutRecordId = sr.id
				   inner join Objective o
				   on o.id = sor.objectiveId
			 where sr.matchId = @pv_matchId
			   and tm.alliance = @pv_alliance
			   and tm.alliancePosition = 2
			   and o.name = 'aFuel'
			-- Update Alliance Position 3
			update sor
			   set integerValue = @lv_UpdatedScouted3
			     , decimalValue = convert(decimal(10,3), @lv_UpdatedScouted3)
				 , scoreValue = @lv_UpdatedScouted3 * o.scoreMultiplier
			  from scoutRecord sr
				   inner join TeamMatch tm
				   on tm.matchId = sr.matchId
				   and tm.teamId = sr.teamId
				   inner join scoutObjectiveRecord sor
				   on sor.scoutRecordId = sr.id
				   inner join Objective o
				   on o.id = sor.objectiveId
			 where sr.matchId = @pv_matchId
			   and tm.alliance = @pv_alliance
			   and tm.alliancePosition = 3
			   and o.name = 'aFuel'
		end

	    -- Get TBA total for TeleOp Fuel made
		select @lv_sumTBA = sum(mo.integerValue)
		  from MatchObjective mo
		       inner join Objective o
			   on o.id = mo.objectiveId
		 where mo.matchId = @pv_matchId
		   and mo.alliance = @pv_alliance
		   and o.name = 'toFuel';

	    -- Get Scouted total for TeleOp Fuel made
		select @lv_sumScouted1 = sum(asor.avgIntegerValue)
		  from TeamMatch tm
		       inner join v_AvgScoutObjectiveRecord asor
			   on asor.teamId = tm.teamId
			   and asor.matchId = tm.matchId
		 where tm.matchId = @pv_matchId
		   and tm.alliance = @pv_alliance
		   and asor.objectiveName = 'toFuel'
		   and asor.loginGUID = @pv_LoginGUID;

	    -- Get Scouted total for TeleOp Human Player Fuel made
		select @lv_sumScouted2 = sum(asor.avgIntegerValue)
		  from TeamMatch tm
		       inner join v_AvgScoutObjectiveRecord asor
			   on asor.teamId = tm.teamId
			   and asor.matchId = tm.matchId
		 where tm.matchId = @pv_matchId
		   and tm.alliance = @pv_alliance
		   and asor.objectiveName = 'toHpM'
		   and asor.loginGUID = @pv_LoginGUID;

		-- Decide if auto auditing is performed on TeleOp Fuel made
		if (@lv_sumScouted2 > @lv_sumTBA) set @lv_sumAdjustedTBA = 0
		else set @lv_sumAdjustedTBA = @lv_sumTBA - @lv_sumScouted2;

-- Debug
--        select @lv_sumTBA sumTBA, @lv_sumAdjustedTBA sumAdjustedTBA, @lv_sumScouted1 sumScouted1, @lv_sumScouted2 sumScouted2;

		if (@lv_sumAdjustedTBA = 0) set @lv_deltaScoutedToTBA = 1.0
		else set @lv_deltaScoutedToTBA = abs((convert(decimal(10,4), @lv_sumScouted1) /  convert(decimal(10,4), @lv_sumAdjustedTBA)) - 1.0);

 -- Debug
--       select @lv_deltaScoutedToTBA deltaScoutedToTBA;

		-- Audit TeleOp Fuel
		if ((@pv_toleranceToAutoAudit = 0.0 OR -- Indicator of always performing Auto Audit
		     @lv_deltaScoutedToTBA <= @pv_toleranceToAutoAudit) AND
			 @lv_deltaScoutedToTBA > 0 AND
			 @lv_sumTBA IS NOT NULL AND
			 @lv_sumScouted1 IS NOT NULL AND
			 @lv_sumScouted2 IS NOT NULL)
		begin
		    -- Get individual robot records for this alliance
			-- Alliance Position 1
			select @lv_Scouted1 = max(coalesce(asor.avgIntegerValue, 0))
			  from TeamMatch tm
				   inner join v_AvgScoutObjectiveRecord asor
				   on asor.teamId = tm.teamId
				   and asor.matchId = tm.matchId
			 where tm.matchId = @pv_matchId
			   and tm.alliance = @pv_alliance
			   and tm.alliancePosition = 1
			   and asor.objectiveName = 'toFuel'
			   and asor.loginGUID = @pv_LoginGUID;
			-- Alliance Position 2
			select @lv_Scouted2 = max(coalesce(asor.avgIntegerValue, 0))
			  from TeamMatch tm
				   inner join v_AvgScoutObjectiveRecord asor
				   on asor.teamId = tm.teamId
				   and asor.matchId = tm.matchId
			 where tm.matchId = @pv_matchId
			   and tm.alliance = @pv_alliance
			   and tm.alliancePosition = 2
			   and asor.objectiveName = 'toFuel'
			   and asor.loginGUID = @pv_LoginGUID;
			-- Alliance Position 3
			select @lv_Scouted3 = max(coalesce(asor.avgIntegerValue, 0))
			  from TeamMatch tm
				   inner join v_AvgScoutObjectiveRecord asor
				   on asor.teamId = tm.teamId
				   and asor.matchId = tm.matchId
			 where tm.matchId = @pv_matchId
			   and tm.alliance = @pv_alliance
			   and tm.alliancePosition = 3
			   and asor.objectiveName = 'toFuel'
			   and asor.loginGUID = @pv_LoginGUID;

          set @lv_UpdatedScouted1 = convert(int, round(convert(decimal(10,3), @lv_Scouted1) / convert(decimal(10,3), @lv_sumScouted1) * convert(decimal(10,3), @lv_sumAdjustedTBA), 0))
          set @lv_UpdatedScouted2 = convert(int, round(convert(decimal(10,3), @lv_Scouted2) / convert(decimal(10,3), @lv_sumScouted1) * convert(decimal(10,3), @lv_sumAdjustedTBA), 0))
          set @lv_UpdatedScouted3 = convert(int, round(convert(decimal(10,3), @lv_Scouted3) / convert(decimal(10,3), @lv_sumScouted1) * convert(decimal(10,3), @lv_sumAdjustedTBA), 0))
-- Debug
--			select 'Ready to Audit Auto'
--          select @lv_Scouted1, @lv_Scouted2, @lv_Scouted3; 
--          select @lv_UpdatedScouted1, @lv_UpdatedScouted2, @lv_UpdatedScouted3; 
			-- Update Alliance Position 1
			update sor
			   set integerValue = @lv_UpdatedScouted1
			     , decimalValue = convert(decimal(10,3), @lv_UpdatedScouted1)
				 , scoreValue = @lv_UpdatedScouted1 * o.scoreMultiplier
			  from scoutRecord sr
				   inner join TeamMatch tm
				   on tm.matchId = sr.matchId
				   and tm.teamId = sr.teamId
				   inner join scoutObjectiveRecord sor
				   on sor.scoutRecordId = sr.id
				   inner join Objective o
				   on o.id = sor.objectiveId
			 where sr.matchId = @pv_matchId
			   and tm.alliance = @pv_alliance
			   and tm.alliancePosition = 1
			   and o.name = 'toFuel'
			-- Update Alliance Position 2
			update sor
			   set integerValue = @lv_UpdatedScouted2
			     , decimalValue = convert(decimal(10,3), @lv_UpdatedScouted2)
				 , scoreValue = @lv_UpdatedScouted2 * o.scoreMultiplier
			  from scoutRecord sr
				   inner join TeamMatch tm
				   on tm.matchId = sr.matchId
				   and tm.teamId = sr.teamId
				   inner join scoutObjectiveRecord sor
				   on sor.scoutRecordId = sr.id
				   inner join Objective o
				   on o.id = sor.objectiveId
			 where sr.matchId = @pv_matchId
			   and tm.alliance = @pv_alliance
			   and tm.alliancePosition = 2
			   and o.name = 'toFuel'
			-- Update Alliance Position 3
			update sor
			   set integerValue = @lv_UpdatedScouted3
			     , decimalValue = convert(decimal(10,3), @lv_UpdatedScouted3)
				 , scoreValue = @lv_UpdatedScouted3 * o.scoreMultiplier
			  from scoutRecord sr
				   inner join TeamMatch tm
				   on tm.matchId = sr.matchId
				   and tm.teamId = sr.teamId
				   inner join scoutObjectiveRecord sor
				   on sor.scoutRecordId = sr.id
				   inner join Objective o
				   on o.id = sor.objectiveId
			 where sr.matchId = @pv_matchId
			   and tm.alliance = @pv_alliance
			   and tm.alliancePosition = 3
			   and o.name = 'toFuel'
		end
    end
end