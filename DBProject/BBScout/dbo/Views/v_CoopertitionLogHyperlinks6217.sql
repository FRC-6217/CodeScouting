
CREATE view [dbo].[v_CoopertitionLogHyperlinks6217] as
select '<a href="coopertitionLog6217.php?coopertitionLogId=' + convert(varchar, cl.id) + '">' + format(cl.logDate, 'MM/dd/yy') + '</a>' logUrl
     , s.firstName + ' ' + s.lastName scoutName
	 , t.teamNumber
	 , cl.logNotes
	 , case when cl.logType = 'G' then 'Given'
	        when cl.logType = 'R' then 'Received'
	        when cl.logType = 'C' then 'Collaborated'
			else cl.logType end logType
     , e.name eventName
	 , cl.logLocation
	 , cl.id
	 , cl.logDate
  from CoopertitionLog cl
       inner join Scout s
	   on s.id = cl.scoutId
	   inner join team t
	   on t.id = cl.teamId
	   left outer join Event e
	   on e.id = cl.eventId