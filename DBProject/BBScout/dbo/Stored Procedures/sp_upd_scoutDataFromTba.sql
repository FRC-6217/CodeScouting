CREATE PROCEDURE sp_upd_scoutDataFromTba (@pv_loginGUID varchar(128))
as
DECLARE @lv_GameYear int;
begin
	-- Update scout record objectives for data specific to a team from TBA
	update ScoutObjectiveRecord
	   set integerValue =
		   (select tmo.integervalue
			  from TeamMatchObjective tmo
				   inner join TeamMatch tm
				   on tm.id = tmo.teamMatchId
				   inner join ScoutRecord sr
				   on sr.teamId = tm.teamId
				   and sr.matchId = tm.matchId
			 where ScoutObjectiveRecord.scoutRecordId = sr.id
			   and ScoutObjectiveRecord.objectiveId = tmo.objectiveId
			   and tmo.integervalue is not null)
	 where exists
		   (select 1
			  from TeamMatchObjective tmo
				   inner join TeamMatch tm
				   on tm.id = tmo.teamMatchId
				   inner join ScoutRecord sr
				   on sr.teamId = tm.teamId
				   and sr.matchId = tm.matchId
				   inner join Match m
				   on m.id = tm.matchId
				   inner join v_GameEvent ge
				   on ge.id = m.gameEventId
			 where ge.loginGUID = @pv_loginGUID
			   and ScoutObjectiveRecord.scoutRecordId = sr.id
			   and ScoutObjectiveRecord.objectiveId = tmo.objectiveId
			   and coalesce(ScoutObjectiveRecord.integerValue, -1) <> tmo.integerValue);

	-- If match has been scouted after TBA data added, then remove the TBA scout record
	delete from scoutObjectiveRecord
	 where scoutRecordId in (
		select sr.id
		  from scoutRecord sr
			   inner join Scout s
			   on s.id = sr.scoutId
			   inner join Match m
			   on m.id = sr.matchId
			   inner join v_GameEvent ge
			   on ge.id = m.gameEventId
		 where s.lastName = 'TBA'
		   and ge.loginGUID = @pv_loginGUID
		   and exists
			   (select 1
				  from ScoutRecord sr2
				 where sr2.matchId = sr.matchId
				   and sr2.teamId = sr.teamId
				   and sr2.scoutId <> sr.scoutId));
	delete from scoutRecord
	 where id in (
		select sr.id
		  from scoutRecord sr
			   inner join Scout s
			   on s.id = sr.scoutId
			   inner join Match m
			   on m.id = sr.matchId
			   inner join v_GameEvent ge
			   on ge.id = m.gameEventId
		 where s.lastName = 'TBA'
		   and ge.loginGUID = @pv_loginGUID
		   and exists
			   (select 1
				  from ScoutRecord sr2
				 where sr2.matchId = sr.matchId
				   and sr2.teamId = sr.teamId
				   and sr2.scoutId <> sr.scoutId));

	-- Add partial scout records for data which comes from TBA
	insert into ScoutRecord (scoutId, matchId, teamId)
	select distinct
		   s.id scoutId
		 , tm.matchId
		 , tm.teamId
	  from Scout s
		 , TeamMatch tm
		   inner join TeamMatchObjective tmo
		   on tmo.teamMatchId = tm.id
		   inner join Match m
		   on m.id = tm.matchId
		   inner join v_GameEvent ge
		   on ge.id = m.gameEventId
	 where s.lastName = 'TBA'
	   and ge.loginGUID = @pv_loginGUID
	   and tmo.integerValue is not null
	   and not exists
		   (select 1
			  from ScoutRecord sr
			 where sr.matchId = tm.matchId
			   and sr.teamId = tm.teamId);
	insert into ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue)
	select sr.id scoutRecordId
		 , tmo.objectiveId
		 , tmo.integerValue
	  from ScoutRecord sr
		   inner join Scout s
		   on s.id = sr.scoutId
		   inner join TeamMatch tm
		   on tm.matchId = sr.matchId
		   and tm.teamId = sr.teamId
		   inner join TeamMatchObjective tmo
		   on tmo.teamMatchId = tm.id
		   inner join Match m
		   on m.id = tm.matchId
		   inner join v_GameEvent ge
		   on ge.id = m.gameEventId
	 where s.lastName = 'TBA'
	   and ge.loginGUID = @pv_loginGUID
	   and tmo.integerValue is not null
	   and not exists
		   (select 1
			  from ScoutObjectiveRecord sor
			 where sor.scoutRecordId = sr.id
			   and sor.objectiveId = tmo.objectiveId);

	-- If alliance objective data from TBA is zero, then set all teams in alliance objective to zero
	update sor
	   set integerValue = mo.integerValue
	     , decimalValue = coalesce(mo.decimalValue, mo.integerValue, 0.0)
	     , scoreValue = mo.scoreValue
	  from MatchObjective mo
		   inner join Match m
		   on m.id = mo.matchId
		   inner join v_GameEvent ge
		   on ge.id = m.gameEventId
		   inner join TeamMatch tm
		   on tm.matchId = mo.matchId
		   and tm.alliance = mo.alliance
		   inner join ScoutRecord sr
		   on sr.matchId = tm.matchId
		   and sr.teamId = tm.teamId
		   inner join ScoutObjectiveRecord sor
		   on sor.scoutRecordId = sr.id
		   and sor.objectiveId = mo.objectiveId
	 where ge.loginGUID = @pv_loginGUID
	   and mo.integerValue = 0
	   and coalesce(sor.integerValue, -999) <> 0;
	insert into ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue, decimalValue, scoreValue)
	select sr.id scoutRecordId
		 , mo.objectiveId
		 , mo.integerValue
		 , coalesce(mo.decimalValue, 0.0)
		 , mo.scoreValue
	  from ScoutRecord sr
		   inner join Match m
		   on m.id = sr.matchId
		   inner join MatchObjective mo
		   on mo.matchId = m.id
		   inner join v_GameEvent ge
		   on ge.id = m.gameEventId
		   inner join TeamMatch tm
		   on tm.matchId = sr.matchId
		   and tm.teamId = sr.teamId
		   and tm.alliance = mo.alliance
	 where ge.loginGUID = @pv_loginGUID
	   and mo.integerValue = 0
	   and not exists
		   (select 1
			  from ScoutObjectiveRecord sor
			 where sor.scoutRecordId = sr.id
			   and sor.objectiveId = mo.objectiveId);

	-- If alliance objective data from TBA is lower than any one team's objective value, then lower the team's objective value to TBA
	update sor
	   set integerValue = mo.integerValue
	     , decimalValue = coalesce(mo.decimalValue, mo.integerValue, 0.0)
	     , scoreValue = coalesce(mo.scoreValue, 0.0)
	  from ScoutObjectiveRecord sor
	       inner join MatchObjective mo
		   on mo.objectiveId = sor.objectiveId
           inner join Match m
           on m.id = mo.matchId
           inner join v_GameEvent ge
           on ge.id = m.gameEventId
           inner join TeamMatch tm
           on tm.matchId = mo.matchId
           and tm.alliance = mo.alliance
           inner join ScoutRecord sr
           on sr.matchId = tm.matchId
           and sr.teamId = tm.teamId
		   and sr.id = sor.scoutRecordId
	 where ge.loginGUID = @pv_loginGUID
	   and coalesce(sor.integerValue, -999) > mo.integerValue;

    -- Update any Game Year specific cross-objective values 
	select @lv_GameYear = g.GameYear
	  from Game g
	       inner join v_GameEvent ge
		   on ge.gameId = g.id
	 where ge.loginGUID = @pv_loginGUID;

	-- 2026 Adjustments
	if (@lv_GameYear = 2026)
	begin
		-- 2026 - Reduce Auto Human Player shots attempted based on Alliance Shots Made/Team Shots Made
		update sor3
		   set integerValue = sor3.integerValue - sor2.integerValue + mo.integerValue
			 , decimalValue = sor3.decimalValue - sor2.decimalValue + coalesce(mo.decimalValue, mo.integerValue, 0.0)
			 , scoreValue = sor3.scoreValue - sor2.scoreValue + mo.scoreValue
		  from v_GameEvent ge
			   inner join Game g
			   on g.id = ge.gameId
			   inner join Match m
			   on m.gameEventId = ge.id
			   inner join matchObjective mo
			   on mo.matchId = m.id
			   inner join Objective o
			   on o.id = mo.objectiveId
			   inner join TeamMatch tm
			   on tm.matchId = mo.matchid
			   and tm.alliance = mo.alliance
			   inner join ScoutRecord sr
			   on sr.matchId = mo.matchId
			   and sr.teamId = tm.teamId
			   inner join ScoutObjectiveRecord sor2
			   on sor2.scoutRecordId = sr.id
			   inner join Objective o2
			   on o2.id = sor2.objectiveId
			   inner join ScoutObjectiveRecord sor3
			   on sor3.scoutRecordId = sr.id
			   inner join Objective o3
			   on o3.id = sor3.objectiveId
		 where g.gameYear = 2026
		   and ge.loginGUID = @pv_loginGUID
		   and o.name = 'aFuel'
		   and o2.name = 'aHpM'
		   and o3.name = 'aHpS'
		   and mo.integerValue < sor2.integerValue;

		-- 2026 - Auto Human Player shots made can't be higher than Alliance Shots Made
		update sor2
		   set integerValue = mo.integerValue
			 , decimalValue = coalesce(mo.decimalValue, mo.integerValue, 0.0)
			 , scoreValue = mo.scoreValue
		  from v_GameEvent ge
			   inner join Game g
			   on g.id = ge.gameId
			   inner join Match m
			   on m.gameEventId = ge.id
			   inner join matchObjective mo
			   on mo.matchId = m.id
			   inner join Objective o
			   on o.id = mo.objectiveId
			   inner join TeamMatch tm
			   on tm.matchId = mo.matchid
			   and tm.alliance = mo.alliance
			   inner join ScoutRecord sr
			   on sr.matchId = mo.matchId
			   and sr.teamId = tm.teamId
			   inner join ScoutObjectiveRecord sor2
			   on sor2.scoutRecordId = sr.id
			   inner join Objective o2
			   on o2.id = sor2.objectiveId
		 where g.gameYear = 2026
		   and ge.loginGUID = @pv_loginGUID
		   and o.name = 'aFuel'
		   and o2.name = 'aHpM'
		   and mo.integerValue < sor2.integerValue;

		-- 2026 - Reduce TeleOp Human Player shots attempted based on Alliance Shots Made/Team Shots Made
		update sor3
		   set integerValue = sor3.integerValue - sor2.integerValue + mo.integerValue
			 , decimalValue = sor3.decimalValue - sor2.decimalValue + coalesce(mo.decimalValue, mo.integerValue, 0.0)
			 , scoreValue = sor3.scoreValue - sor2.scoreValue + mo.scoreValue
		  from v_GameEvent ge
			   inner join Game g
			   on g.id = ge.gameId
			   inner join Match m
			   on m.gameEventId = ge.id
			   inner join matchObjective mo
			   on mo.matchId = m.id
			   inner join Objective o
			   on o.id = mo.objectiveId
			   inner join TeamMatch tm
			   on tm.matchId = mo.matchid
			   and tm.alliance = mo.alliance
			   inner join ScoutRecord sr
			   on sr.matchId = mo.matchId
			   and sr.teamId = tm.teamId
			   inner join ScoutObjectiveRecord sor2
			   on sor2.scoutRecordId = sr.id
			   inner join Objective o2
			   on o2.id = sor2.objectiveId
			   inner join ScoutObjectiveRecord sor3
			   on sor3.scoutRecordId = sr.id
			   inner join Objective o3
			   on o3.id = sor3.objectiveId
		 where g.gameYear = 2026
		   and ge.loginGUID = @pv_loginGUID
		   and o.name = 'toFuel'
		   and o2.name = 'toHpM'
		   and o3.name = 'toHpS'
		   and mo.integerValue < sor2.integerValue;

		-- 2026 - TeleOp Human Player shots made can't be higher than Alliance Shots Made
		update sor2
		   set integerValue = mo.integerValue
			 , decimalValue = coalesce(mo.decimalValue, mo.integerValue, 0.0)
			 , scoreValue = mo.scoreValue
		  from v_GameEvent ge
			   inner join Game g
			   on g.id = ge.gameId
			   inner join Match m
			   on m.gameEventId = ge.id
			   inner join matchObjective mo
			   on mo.matchId = m.id
			   inner join Objective o
			   on o.id = mo.objectiveId
			   inner join TeamMatch tm
			   on tm.matchId = mo.matchid
			   and tm.alliance = mo.alliance
			   inner join ScoutRecord sr
			   on sr.matchId = mo.matchId
			   and sr.teamId = tm.teamId
			   inner join ScoutObjectiveRecord sor2
			   on sor2.scoutRecordId = sr.id
			   inner join Objective o2
			   on o2.id = sor2.objectiveId
		 where g.gameYear = 2026
		   and ge.loginGUID = @pv_loginGUID
		   and o.name = 'toFuel'
		   and o2.name = 'toHpM'
		   and mo.integerValue < sor2.integerValue;
   end
end