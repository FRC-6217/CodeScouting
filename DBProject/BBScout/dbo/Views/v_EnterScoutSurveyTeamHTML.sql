
CREATE view [dbo].[v_EnterScoutSurveyTeamHTML] as
select questions.qName
     , questions.qLabel
	 , questions.qSort
	 , '<br>' + questions.qLabel + '<br>' +
	   case when questions.qSort = 1
	        then '&nbsp;&nbsp;&nbsp;&nbsp;' +
			     'Yes<input type="radio" ' +
			     case when tss.scoutMatch = 'Y' then 'checked="checked"' else '' end +
				 ' name ="' + questions.qName + '" value="Y">&nbsp;&nbsp;&nbsp;&nbsp;' +
				 'No<input type="radio" ' +
				 case when coalesce(tss.scoutMatch, 'N') <> 'Y' then 'checked="checked"' else '' end +
				 ' name ="' + questions.qName + '" value="N">'
			when questions.qSort = 2
	        then '&nbsp;&nbsp;&nbsp;&nbsp;' +
			     'Yes<input type="radio" ' +
			     case when tss.scoutRobot = 'Y' then 'checked="checked"' else '' end +
				 ' name ="' + questions.qName + '" value="Y">&nbsp;&nbsp;&nbsp;&nbsp;' +
				 'No<input type="radio" ' +
				 case when coalesce(tss.scoutRobot, 'N') <> 'Y' then 'checked="checked"' else '' end +
				 ' name ="' + questions.qName + '" value="N">'
			when questions.qSort = 3
			then '<input type="text" name ="' + questions.qName + '" ' +
			     case when tss.scoutingDesc is not null
				      then 'value="' + tss.scoutingDesc + '"'
					  else '' end +
				 ' style="width: 320px">'
			when questions.qSort = 4
			then '<input type="text" name ="' + questions.qName + '" ' +
			     case when tss.scoutingDataStored is not null
				      then 'value="' + tss.scoutingDataStored + '"'
					  else '' end +
				 ' style="width: 320px">'
			when questions.qSort = 5
	        then '&nbsp;&nbsp;&nbsp;&nbsp;' +
			     'Yes<input type="radio" ' +
			     case when tss.colaborate = 'Y' then 'checked="checked"' else '' end +
				 ' name ="' + questions.qName + '" value="Y">&nbsp;&nbsp;&nbsp;&nbsp;' +
				 'No<input type="radio" ' +
				 case when coalesce(tss.colaborate, 'N') <> 'Y' then 'checked="checked"' else '' end +
				 ' name ="' + questions.qName + '" value="N">'
			when questions.qSort = 6
	        then '&nbsp;&nbsp;&nbsp;&nbsp;' +
			     'Yes<input type="radio" ' +
			     case when tss.tbaForMatches = 'Y' then 'checked="checked"' else '' end +
				 ' name ="' + questions.qName + '" value="Y">&nbsp;&nbsp;&nbsp;&nbsp;' +
				 'No<input type="radio" ' +
				 case when coalesce(tss.tbaForMatches, 'N') <> 'Y' then 'checked="checked"' else '' end +
				 ' name ="' + questions.qName + '" value="N">'
			when questions.qSort = 7
	        then '&nbsp;&nbsp;&nbsp;&nbsp;' +
			     'Yes<input type="radio" ' +
			     case when tss.tbaForAllianceSelection = 'Y' then 'checked="checked"' else '' end +
				 ' name ="' + questions.qName + '" value="Y">&nbsp;&nbsp;&nbsp;&nbsp;' +
				 'No<input type="radio" ' +
				 case when coalesce(tss.tbaForAllianceSelection, 'N') <> 'Y' then 'checked="checked"' else '' end +
				 ' name ="' + questions.qName + '" value="N">'
			when questions.qSort = 8
	        then '&nbsp;&nbsp;&nbsp;&nbsp;' +
			     'Yes<input type="radio" ' +
			     case when tss.wantBBScout = 'Y' then 'checked="checked"' else '' end +
				 ' name ="' + questions.qName + '" value="Y">&nbsp;&nbsp;&nbsp;&nbsp;' +
				 'No<input type="radio" ' +
				 case when coalesce(tss.wantBBScout, 'N') <> 'Y' then 'checked="checked"' else '' end +
				 ' name ="' + questions.qName + '" value="N">'
			when questions.qSort = 9
	        then '&nbsp;&nbsp;&nbsp;&nbsp;' +
			     'Yes<input type="radio" ' +
			     case when tss.overviewOfBBScout = 'Y' then 'checked="checked"' else '' end +
				 ' name ="' + questions.qName + '" value="Y">&nbsp;&nbsp;&nbsp;&nbsp;' +
				 'No<input type="radio" ' +
				 case when coalesce(tss.overviewOfBBScout, 'N') <> 'Y' then 'checked="checked"' else '' end +
				 ' name ="' + questions.qName + '" value="N">'
			else '' end +
	   '<br>' qTeamHtml
     , t.id teamId
     , t.teamNumber
	 , ge.loginGUID
  from team t
	   inner join TeamGameEvent tge
	   on tge.teamId = t.id
	   inner join v_GameEvent ge
	   on ge.id = tge.gameEventId
       left outer join TeamScoutSurvey tss
	   on tss.teamId = t.id
	   and tss.gameId = ge.gameId,
	   (select 'scoutMatch' qName, 'Does your team scout matches?' qLabel, 1 qSort union
        select 'scoutRobot' qName, 'Does your team scout robots in the pit area?' qLabel, 2 qSort union
        select 'scoutingDesc' qName, 'Describe your scouting process/program?' qLabel, 3 qSort union
        select 'scoutingDataStored' qName, 'How is your scouting data stored?' qLabel, 4 qSort union
        select 'collaborate' qName, 'Do you work with other teams in scouting?' qLabel, 5 qSort union
        select 'tbaForMatches' qName, 'Do you use the Blue Alliance data (Event Rank, oPR and other analytics) for match planning?' qLabel, 6 qSort union
        select 'tbaForAllianceSelection' qName, 'Do you use the Blue Alliance data (Event Rank, oPR and other analytics) for alliance selection?' qLabel, 7 qSort union
        select 'wantBBScout' qName, 'Do you want access to our scouting application and data?' qLabel, 8 qSort union
        select 'overviewOfBBScout' qName, 'Do you want an overview of its features?' qLabel, 9 qSort
		) questions
--order by questions.qSort