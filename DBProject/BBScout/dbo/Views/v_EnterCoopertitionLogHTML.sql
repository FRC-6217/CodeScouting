CREATE view [dbo].[v_EnterCoopertitionLogHTML] as
select fields.fName
     , fields.fLabel
	 , fields.fSort
	 , '<p>' + fields.fLabel + 
	   '&nbsp;&nbsp;' +
	   case when fields.fSort = 1
	        then '<select style="width: 161px;" name="' + fields.fName + '" required>' +
				 dbo.fn_ScoutDropdownOptions(s.id, slg.scoutGUID) + '</select>'
            when fields.fSort = 2
	        then '<input type="date" name="' + fields.fName + '"' +
			     case when cl.logLocation is not null
				      then 'value="' + format(cl.logDate, 'yyyy-MM-dd') + '"'
					  else '' end +
				 '" required>'
			when fields.fSort = 3
	        then '<select style="width: 161px;" name="' + fields.fName + '" required>' +
				 dbo.fn_TeamDropdownOptions(t.id, slg.scoutGUID, null) + '</select>'
			when fields.fSort = 4
			then '<textarea id="' + fields.fName + '" name="' + fields.fName + '" rows="4" cols="40" wrap="soft">' +
			     case when cl.logNotes is not null
				      then cl.logNotes
					  else '' end +
				 '</textarea>'
			when fields.fSort = 5
	        then '<select style="width: 160px" name="' + fields.fName + '" required>' +
			     '<option value="G"' + case when cl.logType = 'G' then ' selected' else '' end + '>Given</option>' + 
			     '<option value="R"' + case when cl.logType = 'R' then ' selected' else '' end + '>Received</option>' + 
			     '<option value="C"' + case when cl.logType = 'C' then ' selected' else '' end + '>Collaborated</option>' + '</select>'
			when fields.fSort = 6
	        then '<select style="width: 161px;" name="' + fields.fName + '">' +
				 dbo.fn_EventDropdownOptions(e.id, slg.scoutGUID) + '</select>'
			when fields.fSort = 7
			then '<input type="text" name ="' + fields.fName + '" ' +
			     case when cl.logLocation is not null
				      then 'value="' + cl.logLocation + '"'
					  else '' end +
				 ' style="width: 320px">'
            else '' end +
	   '</p>' fLogHtml
     , cl.id coopertitionLogId
	 , slg.emailAddress
	 , slg.scoutGUID loginGUID
  from (select id, scoutId, logDate, teamId, logNotes, logType, eventId, logLocation, lastUpdated 
          from CoopertitionLog
		union
		select 0 id, null scoutId, null logDate, null teamId, null logNotes, null logType, null eventId, null logLocation, null lastUpdated) cl
       left outer join Scout s
	   on s.id = cl.scoutId
       left outer join Team t
	   on t.id = cl.teamId
       left outer join Event e
	   on e.id = cl.eventId,
	   (select 'scoutId' fName, 'Entered By:' fLabel, 1 fSort union
        select 'logDate' fName, 'Date:' fLabel, 2 fSort union
        select 'teamId' fName, 'Team:' fLabel, 3 fSort union
        select 'logNotes' fName, 'Coopertition Desc:' fLabel, 4 fSort union
        select 'logType' fName, 'Type:' fLabel, 5 fSort union
        select 'eventId' fName, 'Event:' qLabel, 6 fSort union
        select 'logLocation' fName, 'Location:' fLabel, 7 fSort
		) fields,
	   scout slg