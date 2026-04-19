-- Function to return JSON file
CREATE function fn_JsonSetupFile ( @pv_LoginGUID uniqueidentifier )
returns varchar(max)
as
begin
	declare @lv_Return varchar(max);

-- Get the Team Options
select @lv_Return = 
(select g.id gameId
     , g.gameYear
     , g.name gameName
	 , e.name eventName
	 , t.teamNumber
	 , t.teamName
     , (select ts.id scoutId
             , ts.lastName
             , ts.firstName
	      from Scout ts
	     where ts.teamId = t.id
           and ts.isActive = 'Y'
           and ts.isAdmin = 'Y'
        order by ts.lastName, ts.firstName
		for json path) as Scouts
     , (select o.id objectiveId
             , o.name
             , o.label
             , st.name scoringType
             , o.lowRangeValue
             , o.highRangeValue
             , o.sortOrder
             , o.sameLineAsPrevious
             , (select ov.id objectiveValueId
	                 , ov.integerValue
	                 , ov.displayValue
	                 , ov.sortOrder sortOrder
	                 , ov.sameLineAsPrevious
        	      from ObjectiveValue ov
	             where ov.objectiveId = o.id
                order by ov.sortOrder
		        for json path) as ObjectivesValues
	      from Objective o
               inner join ScoringType st
	           on st.id = o.scoringTypeId
	     where o.gameId = g.id
        order by o.sortOrder
		for json path) as Objectives
     , (select t2.id teamId
	         , t2.teamNumber
	         , t2.teamName
          from TeamGameEvent tge
		       inner join Team t2
			   on t2.id = tge.teamId
		 where tge.gameEventId = ge.id
        order by t2.teamNumber
		for json path) as Teams
     , (select m.id matchId
	         , m.number matchNumber
	         , m.type
			 , m.dateTime
             , (select tm.teamId
	                 , tm.alliance
	                 , tm.alliancePosition
        	      from TeamMatch tm
	             where tm.matchId = m.id
                order by tm.alliance, tm.alliancePosition
		        for json path) as Teams
          from Match m
		 where m.gameEventId = ge.id
        order by m.dateTime, m.type, case when isnumeric(m.number) = 1 then format(convert(integer, m.number),'0000') else m.number end
		for json path) as Matches
  from Scout s
       inner join v_GameEvent ge
	   on ge.loginGUID = s.scoutGUID
	   inner join Game g
	   on g.id = ge.gameId
	   inner join Event e
	   on e.id = ge.eventId
	   inner join Team t
	   on t.id = s.teamId
 where ge.loginGUID = @pv_LoginGUID
order by g.id
for json path);

return @lv_Return;
end;