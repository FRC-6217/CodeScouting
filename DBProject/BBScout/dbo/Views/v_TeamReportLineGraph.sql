-- View for Team Trend Line Chart
CREATE view v_TeamReportLineGraph as
select objectiveScoutRecordAverages.teamNumber
     , objectiveScoutRecordAverages.matchNumber
     , objectiveScoutRecordAverages.matchDateTime
     , objectiveScoutRecordAverages.objectiveGroupName
	 , objectiveScoutRecordAverages.objectiveGroupSortOrder
     , objectiveScoutRecordAverages.teamId
	 , objectiveScoutRecordAverages.matchId
	 , objectiveScoutRecordAverages.loginGUID
	 , round(sum(objectiveScoutRecordAverages.avgScoreValue), 2) objectiveGroupScoreValue
	 , (select avg(tr.totalScoreValue)
	      from v_TeamReport tr
		 where tr.teamId = objectiveScoutRecordAverages.teamId
		   and tr.matchId = objectiveScoutRecordAverages.matchId
		   and tr.loginGUID = objectiveScoutRecordAverages.loginGUID) totalScoreValue
 from (
select matchScoutRecordAverages.teamNumber
     , matchScoutRecordAverages.matchNumber
     , matchScoutRecordAverages.matchDateTime
     , matchScoutRecordAverages.objectiveGroupName
	 , matchScoutRecordAverages.objectiveGroupSortOrder
     , matchScoutRecordAverages.objectiveName
	 , matchScoutRecordAverages.teamId
	 , matchScoutRecordAverages.matchId
	 , matchScoutRecordAverages.loginGUID
	 , avg(matchScoutRecordAverages.scoreValue) avgScoreValue 
  from (
select t.teamNumber
     , m.type + ' ' + convert(varchar, m.number) matchNumber
	 , m.dateTime matchDateTime
     , og.name objectiveGroupName
	 , og.sortOrder objectiveGroupSortOrder
	 , o.name objectiveName
	 , sr.matchId
     , sr.teamId
	 , avg(convert(numeric, sor.scoreValue) +
	       case when o.addTeamScorePortion = 'Y'
		        then tm.portionOfAlliancePoints
				else 0 end) scoreValue
	 , ge.loginGUID
  from ScoutRecord sr
       inner join Match m
	   on m.id = sr.matchId
	   inner join v_GameEvent ge
	   on ge.id = m.gameEventId
	   inner join ScoutObjectiveRecord sor
	   on sor.scoutRecordId = sr.id
	   inner join Objective o
	   on o.id = sor.objectiveId
	   inner join ObjectiveGroupObjective ogo
	   on ogo.objectiveId = o.id
	   inner join ObjectiveGroup og
	   on og.id = ogo.objectiveGroupId
	   inner join Team t
	   on t.id = sr.teamId
	   inner join TeamMatch tm
	   on tm.matchId = sr.matchId
	   and tm.teamId = sr.teamId
 where m.isActive = 'Y'
   and og.groupCode = 'Report Line Graph'
group by t.teamNumber
       , m.type + ' ' + convert(varchar, m.number)
	   , m.dateTime
       , og.name
	   , og.sortOrder
	   , o.name
       , sr.matchId
       , sr.teamId
	   , ge.loginGUID
) matchScoutRecordAverages
group by matchScoutRecordAverages.teamNumber
       , matchScoutRecordAverages.matchNumber
       , matchScoutRecordAverages.matchDateTime
       , matchScoutRecordAverages.objectiveGroupName
	   , matchScoutRecordAverages.objectiveGroupSortOrder
       , matchScoutRecordAverages.objectiveName
	   , matchScoutRecordAverages.teamId
	   , matchScoutRecordAverages.matchId
	   , matchScoutRecordAverages.loginGUID
) objectiveScoutRecordAverages
group by objectiveScoutRecordAverages.teamNumber
       , objectiveScoutRecordAverages.matchNumber
       , objectiveScoutRecordAverages.matchDateTime
       , objectiveScoutRecordAverages.objectiveGroupName
	   , objectiveScoutRecordAverages.objectiveGroupSortOrder
	   , objectiveScoutRecordAverages.teamId
	   , objectiveScoutRecordAverages.matchId
	   , objectiveScoutRecordAverages.loginGUID;
