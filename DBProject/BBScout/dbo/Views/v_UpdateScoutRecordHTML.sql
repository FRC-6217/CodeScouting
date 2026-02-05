



-- View to get HTML for update of Scout Record
CREATE view [dbo].[v_UpdateScoutRecordHTML] as
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
	 , sr.id scoutRecordId
	 , ge.loginGUID
  from objectiveGroup og
       inner join objectiveGroupObjective ogo
	   on ogo.objectiveGroupId = og.id
       inner join objective o
	   on o.id = ogo.objectiveId
	   inner join game g
	   on g.id = o.gameId
	   inner join v_GameEvent ge
	   on ge.gameId = g.id,
	   ScoutRecord sr
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
	        then '<br><br>' + o.label + '<br><input type="text" name ="value' + convert(varchar, o.sortOrder) + '" placeholder="' +
			     coalesce(sor.textValue, '') + '" style="width: 320px"><br>'
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
								else '<br><br>' end end +
				 o.label + '<input id="spinner' + convert(varchar, o.sortOrder) + '"' +
				 ' name ="value' + convert(varchar, o.sortOrder) + '"' +
				 ' min="' + convert(varchar, coalesce(o.lowRangeValue, 0)) + '"' +
				 ' max="' + convert(varchar, coalesce(o.highRangeValue, 999)) + '" step="1" ' +
				 ' value="' + case when sor.integerValue is null then '-99' else convert(varchar, coalesce(sor.integerValue, 0)) end + '"' +
				 ' style="width: 30px;">' +
				 ' <script>$( "#spinner' + convert(varchar, o.sortOrder) + '" ).spinner();</script>'
/* commented out to test jQuery Spinner buttons
                 o.label + '<input type="number" name ="value' + convert(varchar, o.sortOrder) + '"' +
				 ' min="' + convert(varchar, coalesce(o.lowRangeValue, 0)) + '"' +
				 ' max="' + convert(varchar, coalesce(o.highRangeValue, 999)) + '" step="1" ' +
				 ' value="' + case when sor.integerValue is null then '-99' else convert(varchar, coalesce(sor.integerValue, 0)) end + '"' +
				 ' style="width: 40px;">'
*/
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
						else '<br><br>' end +
				 o.label + '<br>&nbsp;&nbsp;&nbsp;&nbsp;' + ov.displayValue +
				 '<input type="radio" ' +
				 case when coalesce(sor.integerValue, -99) = coalesce(ov.integerValue, -99)
				      then 'checked="checked" '
					  else '' end +
				 'name ="value' + convert(varchar, o.sortOrder) +
				 '" value=' + case when ov.integerValue is null then '-99' else convert(varchar, ov.integerValue) end + '>'
			else case when ov.sameLineAsPrevious = 'Y'
			          then '&nbsp;&nbsp;&nbsp;'
					  else '<br>&nbsp;&nbsp;&nbsp;&nbsp;' end + ov.displayValue +
				 '<input type="radio" ' +
				 case when coalesce(sor.integerValue, -99) = coalesce(ov.integerValue, -99)
				      then 'checked="checked" '
					  else '' end +
				 'name ="value' + convert(varchar, o.sortOrder) +
				 '" value=' + case when ov.integerValue is null then '-99' else convert(varchar, ov.integerValue) end + '>' end scoutRecordHtml
	 , sor.scoutRecordId
	 , ge.loginGUID
  from objectiveGroup og
       inner join objectiveGroupObjective ogo
	   on ogo.objectiveGroupId = og.id
       inner join objective o
	   on o.id = ogo.objectiveId
	   inner join scoringType st
	   on st.id = o.scoringTypeId
	   inner join ScoutObjectiveRecord sor
	   on sor.objectiveId = o.id
	   inner join game g
	   on g.id = o.gameId
	   inner join v_GameEvent ge
	   on ge.gameId = g.id
	   left outer join objectiveValue ov
	   on ov.objectiveId = o.id
 where og.groupCode = 'Scout Match'
--order by groupSort, objectiveSort, objectiveValueSort