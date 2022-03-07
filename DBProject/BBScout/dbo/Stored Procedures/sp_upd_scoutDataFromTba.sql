CREATE PROCEDURE sp_upd_scoutDataFromTba (@pv_loginGUID varchar(128))
as
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
	update ScoutObjectiveRecord
	   set integerValue = 0
	 where id in (
			select sor.id
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
			   and coalesce(sor.integerValue, -999) <> 0);
	insert into ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue)
	select sr.id scoutRecordId
		 , mo.objectiveId
		 , mo.integerValue
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
	update ScoutObjectiveRecord
	   set integerValue =
		  (select mo.integerValue
			  from MatchObjective mo
				   inner join Match m
				   on m.id = mo.matchId
				   inner join GameEvent ge
				   on ge.id = m.gameEventId
				   inner join TeamMatch tm
				   on tm.matchId = mo.matchId
				   and tm.alliance = mo.alliance
				   inner join ScoutRecord sr
				   on sr.matchId = tm.matchId
				   and sr.teamId = tm.teamId
			 where sr.id = ScoutObjectiveRecord.scoutRecordId
			   and mo.objectiveId = ScoutObjectiveRecord.objectiveId)
     where id in (
			select sor.id
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
			   and coalesce(sor.integerValue, -999) > mo.integerValue);
end
