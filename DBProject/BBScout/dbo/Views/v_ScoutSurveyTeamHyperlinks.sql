
CREATE view [dbo].[v_ScoutSurveyTeamHyperlinks] as
select '<a href="scoutSurvey.php?teamId=' + convert(varchar, t.id) +
       '&teamNumber=' + convert(varchar, t.teamNumber) +
	   '&teamName=' + coalesce(t.teamName, ' ') + '">' + convert(varchar, t.teamNumber) + '</a>' teamUrl
     , t.teamNumber
	 , t.teamName
	 , t.location
	 , t.id teamId
	 , tss.scoutMatch
	 , tss.scoutRobot
	 , tss.colaborate
	 , tss.tbaForMatches
	 , tss.tbaForAllianceSelection
	 , tss.wantBBScout
	 , tss.overviewOfBBScout
	 , tss.scoutingDesc
	 , tss.scoutingDataStored
	 , ge.loginGUID
  from team t
	   inner join TeamGameEvent tge
	   on tge.teamId = t.id
	   inner join v_GameEvent ge
	   on ge.id = tge.gameEventId
       left outer join TeamScoutSurvey tss
	   on tss.teamId = t.id
	   and tss.gameId = ge.gameId