
-- View to get HTML for entry of Scout Record
CREATE view [dbo].[v_EnterScoutRecordHTML] as
select distinct
       og.name groupName
     , null objectiveName      
	 , null objectiveLabel
	 , null displayValue
	 , null integerValue
     , og.sortOrder groupSort
	 , null objectiveSort
	 , null objectiveValueSort
	 , case when og.sortOrder = 1 then '' else '<br><br>' end + '<b><u>' + og.name + '</u>' scoutRecordHtml
	 , ge.loginGUID
  from objectiveGroup og
       inner join objectiveGroupObjective ogo
	   on ogo.objectiveGroupId = og.id
       inner join objective o
	   on o.id = ogo.objectiveId
	   inner join game g
	   on g.id = o.gameId
	   inner join v_GameEvent ge
	   on ge.gameId = g.id
 where og.groupCode = 'Scout Match'
union
select distinct
       og.name groupName
     , o.name objectiveName
	 , o.label objectiveLabel
	 , ov.displayValue
	 , ov.integerValue
     , og.sortOrder groupSort
	 , o.sortOrder objectiveSort
	 , ov.sortOrder objectiveValueSort
	 , case when st.hasValueList = 'N' and st.name = 'Free Form'
	        then '<br><br>' + o.label + '<br><input type="text" name ="value' + convert(varchar, o.sortOrder) + '" style="width: 320px"><br>'
			when st.hasValueList = 'N'
	        then case when o.sameLineAsPrevious = 'Y'
			          then '&nbsp;&nbsp;'
					  else case when o.sortOrder = 
					                (select min(o2.sortOrder)
                                       from Objective o2
		                                    inner join ObjectiveGroupObjective ogo2
			                                on ogo2.objectiveId = o2.id
			                                inner join ObjectiveGroup og2
			                                on og2.id = ogo2.objectiveGroupId
		                              where og2.groupCode = 'Scout Match'
									    and o2.gameId = o.gameId
		                                and og2.id = og.id)
								then '<br>'
								else '<br><br>' end end + o.label + '<input type="number" name ="value' + convert(varchar, o.sortOrder) + '" value=0 style="width: 40px;">'
			when ov.sortOrder = 1
	        then case when o.sortOrder = 
					      (select min(o2.sortOrder)
                             from Objective o2
		                          inner join ObjectiveGroupObjective ogo2
			                      on ogo2.objectiveId = o2.id
			                      inner join ObjectiveGroup og2
			                      on og2.id = ogo2.objectiveGroupId
		                    where og2.groupCode = 'Scout Match'
							  and o2.gameId = o.gameId
		                      and og2.id = og.id)
						then '<br>'
						else '<br><br>' end + o.label + '<br>&nbsp;&nbsp;&nbsp;&nbsp;' + ov.displayValue + '<input type="radio" checked="checked" name ="value' + convert(varchar, o.sortOrder) + '" value=' + case when ov.integerValue is null then '-99' else convert(varchar, ov.integerValue) end + '>'
			else case when ov.sameLineAsPrevious = 'Y' then '&nbsp;&nbsp;&nbsp;' else '<br>&nbsp;&nbsp;&nbsp;&nbsp;' end + ov.displayValue + '<input type="radio" name ="value' + convert(varchar, o.sortOrder) + '" value=' + case when ov.integerValue is null then '-99' else convert(varchar, ov.integerValue) end + '>' end scoutRecordHtml
     , ge.loginGUID
  from objectiveGroup og
       inner join objectiveGroupObjective ogo
	   on ogo.objectiveGroupId = og.id
       inner join objective o
	   on o.id = ogo.objectiveId
	   inner join scoringType st
	   on st.id = o.scoringTypeId
	   inner join game g
	   on g.id = o.gameId
	   inner join v_GameEvent ge
	   on ge.gameId = g.id
	   left outer join objectiveValue ov
	   on ov.objectiveId = o.id
 where og.groupCode = 'Scout Match'
--order by groupSort, objectiveSort, objectiveValueSort
