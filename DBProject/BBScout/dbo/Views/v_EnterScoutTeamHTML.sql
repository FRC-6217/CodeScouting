CREATE view [dbo].[v_EnterScoutTeamHTML] as
select a.name attributeName
	 , a.label attributeLabel
	 , av.displayValue
	 , av.integerValue
     , a.sortOrder attributeSort
	 , av.sortOrder attributeValueSort
     , case when st.hasValueList = 'N' and st.name = 'Free Form'
	        then '<br>' + a.label + '<br><input type="text" name ="value' + convert(varchar, a.sortOrder) +
			case when (select ta.textValue from teamAttribute ta where ta.teamId = t.id and ta.attributeId = a.id) is not null
			     then '" value="' + (select ta.textValue from teamAttribute ta where ta.teamId = t.id and ta.attributeId = a.id)
				 else '" placeholder="' + a.defaultText end +
			'" style="width: 320px"><br>'
			when st.hasValueList = 'N'
	        then case when a.sameLineAsPrevious = 'Y' then '' else '<br>' end + a.label + '<input type="number" name ="value' + convert(varchar, a.sortOrder) + '" value=' +
			coalesce((select convert(varchar, ta.integerValue) from teamAttribute ta where ta.teamId = t.id and ta.attributeId = a.id), '0') +
			' style="width: 50px;">' + case when a.sameLineAsPrevious = 'Y' then '' else '<br>' end
			when av.sortOrder = 1
	        then '<br>' + a.label + '<br>&nbsp;&nbsp;&nbsp;&nbsp;' + av.displayValue + '<input type="radio" ' +
			coalesce((select case when ta.integerValue = av.integerValue then 'checked="checked"' else '' end from teamAttribute ta where ta.teamId = t.id and ta.attributeId = a.id), 'checked="checked"') +
			' name ="value' + convert(varchar, a.sortOrder) + '" value=' + convert(varchar, av.integerValue) + '>'
			else case when av.sameLineAsPrevious = 'Y' then '' else '<br>' end + '&nbsp;&nbsp;&nbsp;&nbsp;' + av.displayValue + '<input type="radio" ' +
			coalesce((select case when ta.integerValue = av.integerValue then 'checked="checked"' else '' end from teamAttribute ta where ta.teamId = t.id and ta.attributeId = a.id), '') +
			' name ="value' + convert(varchar, a.sortOrder) + '" value=' + convert(varchar, av.integerValue) + '>' + case when av.lastValue = 'Y' then '<br>' else '' end end scoutTeamHtml
	 , t.id teamId
	 , t.teamNumber
	 , ge.loginGUID
  from attribute a
	   inner join scoringType st
	   on st.id = a.scoringTypeId
	   left outer join attributeValue av
	   on av.attributeId = a.id,
	   team t
	   inner join TeamGameEvent tge
	   on tge.teamId = t.id
	   inner join v_GameEvent ge
	   on ge.id = tge.gameEventId
 where a.gameId = ge.gameId
--order by attributeSort, attributeValueSort
