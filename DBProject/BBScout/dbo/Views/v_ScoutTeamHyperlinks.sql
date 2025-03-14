﻿


CREATE view [dbo].[v_ScoutTeamHyperlinks] as
select '<a href="robotAttrSetup.php?teamId=' + convert(varchar, t.id) + '&teamNumber=' + convert(varchar, t.teamNumber) + '&teamName=' + coalesce(t.teamName, ' ') + '&location=' + coalesce(t.location, ' ') + '">' + convert(varchar, t.teamNumber) + '</a>' teamUrl
     , t.teamNumber
	 , t.teamName
	 , t.location
	 , t.id teamId
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 1
		   and a.gameId = ge.gameId) attrValue1
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 2
		   and a.gameId = ge.gameId) attrValue2
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 3
		   and a.gameId = ge.gameId) attrValue3
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 4
		   and a.gameId = ge.gameId) attrValue4
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 5
		   and a.gameId = ge.gameId) attrValue5
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 6
		   and a.gameId = ge.gameId) attrValue6
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 7
		   and a.gameId = ge.gameId) attrValue7
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 8
		   and a.gameId = ge.gameId) attrValue8
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 9
		   and a.gameId = ge.gameId) attrValue9
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 10
		   and a.gameId = ge.gameId) attrValue10
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 11
		   and a.gameId = ge.gameId) attrValue11
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 12
		   and a.gameId = ge.gameId) attrValue12
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 13
		   and a.gameId = ge.gameId) attrValue13
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 14
		   and a.gameId = ge.gameId) attrValue14
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 15
		   and a.gameId = ge.gameId) attrValue15
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 16
		   and a.gameId = ge.gameId) attrValue16
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 17
		   and a.gameId = ge.gameId) attrValue17
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 18
		   and a.gameId = ge.gameId) attrValue18
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 19
		   and a.gameId = ge.gameId) attrValue19
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 20
		   and a.gameId = ge.gameId) attrValue20
	 , ge.loginGUID
  from Team t 
       inner join TeamGameEvent tge 
       on tge.teamId = t.id
       inner join v_GameEvent ge 
       on ge.id = tge.gameEventId
