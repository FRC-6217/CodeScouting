-- Game Objectives
-- Autonomous
--  1 Power Cell Lower Count (x2)
--  2 Power Cell Outer Count (x4)
--  3 Power Cell Inner Count (x6)
--  4 Move Off Line (Y/N) - 5 pts
-- TeleOp
--  5 Power Cell Lower Count (x1)
--  6 Power Cell Outer Count (x2)
--  7 Power Cell Inner Count (x3)
--  8 Control Panel Rotation (Y/N) - 10 pts
--  9 Control Panel Rotation Time
-- 10 Control Panel Position (Y/N) - 20 pts
-- 11 Control Panel Position Time
-- 12 Defense - No Defense (0), Poor Defense (-1), Good Defense (1), Excellent Defense (2)
-- End Game
-- 13 Final Position - None (0), Park (5), Hang Unassisted (25), Hang Assisted (10), Hang Assist 1 (40), Hang Assist 2 (55)
--
-- Team Attributes
-- 1 Where do you prefer to start match? Inline with Target, Right of Target, Left of Target, Out of the way.
-- 2 Can your autonomous software be flexible for position? Y/N
-- 3 Can your autonomous software allow for a time delay to help with robot flow? Y/N
-- 4 Draw your preferred robot path for autonomous? Upload an Image
-- 5 What does your robot weigh?

-- Clear any previous setup
Delete from RankObjective where objectiveId in (select o.id from objective o inner join game g on g.id = o.gameId where g.name = 'Infinite Recharge')
Delete from ObjectiveGroupObjective where objectiveId in (select o.id from objective o inner join game g on g.id = o.gameId where g.name = 'Infinite Recharge')
Delete From ObjectiveValue where objectiveId in (select o.id from objective o inner join game g on g.id = o.gameId where g.name = 'Infinite Recharge')
Delete From Objective where gameid = (select g.id from game g where g.name = 'Infinite Recharge')

-- Autonomous 
insert into Objective (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue, scoreMultiplier, sortOrder, tableHeader, reportDisplay, sameLineAsPrevious) select g.id, 'aPcLower', 'Lower: ', st.id, 0, 8, 2, 1, 'aLower', 'I', 'N' from ScoringType st, game g  where st.name = 'integer' and g.name = 'Infinite Recharge'
insert into Objective (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue, scoreMultiplier, sortOrder, tableHeader, reportDisplay, sameLineAsPrevious) select g.id, 'aPcOuter', 'Outer: ', st.id, 0, 8, 4, 2, 'aOuter', 'I', 'Y' from ScoringType st, game g  where st.name = 'integer' and g.name = 'Infinite Recharge'
insert into Objective (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue, scoreMultiplier, sortOrder, tableHeader, reportDisplay, sameLineAsPrevious) select g.id, 'aPcInner', 'Inner: ', st.id, 0, 8, 6, 3, 'aInner', 'I', 'Y' from ScoringType st, game g  where st.name = 'integer' and g.name = 'Infinite Recharge'
insert into Objective (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue, scoreMultiplier, sortOrder, tableHeader, reportDisplay, sameLineAsPrevious) select g.id, 'aMove', 'Move Off Line:', st.id, null, null, null, 4, 'aMove', 'I', 'N' from ScoringType st, game g  where st.name = 'Radio Button' and g.name = 'Infinite Recharge'

-- TeleOp
insert into Objective (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue, scoreMultiplier, sortOrder, tableHeader, reportDisplay, sameLineAsPrevious) select g.id, 'toPcLower', 'Lower: ', st.id, 0, 50, 1, 5, 'toLower', 'I', 'N' from ScoringType st, game g  where st.name = 'integer' and g.name = 'Infinite Recharge'
insert into Objective (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue, scoreMultiplier, sortOrder, tableHeader, reportDisplay, sameLineAsPrevious) select g.id, 'toPcOuter', 'Outer: ', st.id, 0, 50, 2, 6, 'toOuter', 'I', 'Y' from ScoringType st, game g  where st.name = 'integer' and g.name = 'Infinite Recharge'
insert into Objective (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue, scoreMultiplier, sortOrder, tableHeader, reportDisplay, sameLineAsPrevious) select g.id, 'toPcInner', 'Inner: ', st.id, 0, 50, 3, 7, 'toInner', 'I', 'Y' from ScoringType st, game g  where st.name = 'integer' and g.name = 'Infinite Recharge'
insert into Objective (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue, scoreMultiplier, sortOrder, tableHeader, reportDisplay, sameLineAsPrevious) select g.id, 'toCpRotation', 'Ctrl Pnl Rotation:', st.id, null, null, null, 8, 'cpRot', 'I', 'N' from ScoringType st, game g  where st.name = 'Radio Button' and g.name = 'Infinite Recharge'
insert into Objective (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue, scoreMultiplier, sortOrder, tableHeader, reportDisplay, sameLineAsPrevious) select g.id, 'toCpRotationTime', 'Rotation Time: ', st.id, 0, 60, null, 9, 'cpRotTime', 'I', 'N' from ScoringType st, game g where st.name = 'integer' and g.name = 'Infinite Recharge'
insert into Objective (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue, scoreMultiplier, sortOrder, tableHeader, reportDisplay, sameLineAsPrevious) select g.id, 'toCpPosition', 'Ctrl Pnl Position:', st.id, null, null, null, 10, 'cpPos', 'I', 'N' from ScoringType st, game g  where st.name = 'Radio Button' and g.name = 'Infinite Recharge'
insert into Objective (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue, scoreMultiplier, sortOrder, tableHeader, reportDisplay, sameLineAsPrevious) select g.id, 'toCpPositionTime', 'Position Time: ', st.id, 0, 60, null, 11, 'cpPosTime', 'I', 'N' from ScoringType st, game g where st.name = 'integer' and g.name = 'Infinite Recharge' 
insert into Objective (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue, scoreMultiplier, sortOrder, tableHeader, reportDisplay, sameLineAsPrevious) select g.id, 'toDefense', 'Defense:', st.id, null, null, null, 12, 'Defense', 'I', 'N' from ScoringType st, game g  where st.name = 'Radio Button' and g.name = 'Infinite Recharge'

-- End Game
insert into Objective (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue, scoreMultiplier, sortOrder, tableHeader, reportDisplay) select g.id, 'toFinalPosition', 'Final Position:', st.id, null, null, null, 13, 'Finish', 'S' from ScoringType st, game g  where st.name = 'Radio Button' and g.name = 'Infinite Recharge'

-- Objective Values
insert into ObjectiveValue select o.id, 'No', 0, 1, 0 from game g inner join objective o on o.gameId = g.id where g.name = 'Infinite Recharge' and o.name = 'aMove'
insert into ObjectiveValue select o.id, 'Yes', 1, 2, 5 from game g inner join objective o on o.gameId = g.id where g.name = 'Infinite Recharge' and o.name = 'aMove'

insert into ObjectiveValue select o.id, 'No', 0, 1, 0 from game g inner join objective o on o.gameId = g.id where g.name = 'Infinite Recharge' and o.name = 'toCpRotation'
insert into ObjectiveValue select o.id, 'Yes', 1, 2, 10 from game g inner join objective o on o.gameId = g.id where g.name = 'Infinite Recharge' and o.name = 'toCpRotation'

insert into ObjectiveValue select o.id, 'No', 0, 1, 0 from game g inner join objective o on o.gameId = g.id where g.name = 'Infinite Recharge' and o.name = 'toCpPosition'
insert into ObjectiveValue select o.id, 'Yes', 1, 2, 20 from game g inner join objective o on o.gameId = g.id where g.name = 'Infinite Recharge' and o.name = 'toCpPosition'

insert into ObjectiveValue select o.id, 'No Defense', 0, 1, 0 from game g inner join objective o on o.gameId = g.id where g.name = 'Infinite Recharge' and o.name = 'toDefense'
insert into ObjectiveValue select o.id, 'Poor Defense', -1, 2, 0 from game g inner join objective o on o.gameId = g.id where g.name = 'Infinite Recharge' and o.name = 'toDefense'
insert into ObjectiveValue select o.id, 'Good Defense', 1, 3, 0 from game g inner join objective o on o.gameId = g.id where g.name = 'Infinite Recharge' and o.name = 'toDefense'
insert into ObjectiveValue select o.id, 'Excellent Defense', 2, 4, 0 from game g inner join objective o on o.gameId = g.id where g.name = 'Infinite Recharge' and o.name = 'toDefense'

insert into ObjectiveValue select o.id, 'None', 0, 1, 0 from game g inner join objective o on o.gameId = g.id where g.name = 'Infinite Recharge' and o.name = 'toFinalPosition'
insert into ObjectiveValue select o.id, 'Park', 1, 2, 5 from game g inner join objective o on o.gameId = g.id where g.name = 'Infinite Recharge' and o.name = 'toFinalPosition'
insert into ObjectiveValue select o.id, 'Hang Unassisted', 2, 3, 25 from game g inner join objective o on o.gameId = g.id where g.name = 'Infinite Recharge' and o.name = 'toFinalPosition'
insert into ObjectiveValue select o.id, 'Hang Assisted', 1, 4, 10 from game g inner join objective o on o.gameId = g.id where g.name = 'Infinite Recharge' and o.name = 'toFinalPosition'
insert into ObjectiveValue select o.id, 'Hang Assist 1', 3, 5, 40 from game g inner join objective o on o.gameId = g.id where g.name = 'Infinite Recharge' and o.name = 'toFinalPosition'
insert into ObjectiveValue select o.id, 'Hang Assist 2', 4, 6, 55 from game g inner join objective o on o.gameId = g.id where g.name = 'Infinite Recharge' and o.name = 'toFinalPosition'

-- Objective Groupings
insert into ObjectiveGroupObjective (objectiveGroupId, objectiveId) select og.id, o.id from ObjectiveGroup og, Objective o where og.name = 'Autonomous' and o.name = 'aPcLower';
insert into ObjectiveGroupObjective (objectiveGroupId, objectiveId) select og.id, o.id from ObjectiveGroup og, Objective o where og.name = 'Autonomous' and o.name = 'aPcOuter';
insert into ObjectiveGroupObjective (objectiveGroupId, objectiveId) select og.id, o.id from ObjectiveGroup og, Objective o where og.name = 'Autonomous' and o.name = 'aPcInner';
insert into ObjectiveGroupObjective (objectiveGroupId, objectiveId) select og.id, o.id from ObjectiveGroup og, Objective o where og.name = 'Autonomous' and o.name = 'aMove';
insert into ObjectiveGroupObjective (objectiveGroupId, objectiveId) select og.id, o.id from ObjectiveGroup og, Objective o where og.name = 'Tele Op' and o.name = 'toPcLower';
insert into ObjectiveGroupObjective (objectiveGroupId, objectiveId) select og.id, o.id from ObjectiveGroup og, Objective o where og.name = 'Tele Op' and o.name = 'toPcOuter';
insert into ObjectiveGroupObjective (objectiveGroupId, objectiveId) select og.id, o.id from ObjectiveGroup og, Objective o where og.name = 'Tele Op' and o.name = 'toPcInner';
insert into ObjectiveGroupObjective (objectiveGroupId, objectiveId) select og.id, o.id from ObjectiveGroup og, Objective o where og.name = 'Tele Op' and o.name = 'toCpRotation';
insert into ObjectiveGroupObjective (objectiveGroupId, objectiveId) select og.id, o.id from ObjectiveGroup og, Objective o where og.name = 'Tele Op' and o.name = 'toCpRotationTime';
insert into ObjectiveGroupObjective (objectiveGroupId, objectiveId) select og.id, o.id from ObjectiveGroup og, Objective o where og.name = 'Tele Op' and o.name = 'toCpPosition';
insert into ObjectiveGroupObjective (objectiveGroupId, objectiveId) select og.id, o.id from ObjectiveGroup og, Objective o where og.name = 'Tele Op' and o.name = 'toCpPositionTime';
insert into ObjectiveGroupObjective (objectiveGroupId, objectiveId) select og.id, o.id from ObjectiveGroup og, Objective o where og.name = 'Tele Op' and o.name = 'toDefense';
insert into ObjectiveGroupObjective (objectiveGroupId, objectiveId) select og.id, o.id from ObjectiveGroup og, Objective o where og.name = 'End Game' and o.name = 'toFinalPosition';

-- Rank Setup
insert into Rank (gameId, name, queryString, type, sortOrder) select g.id, 'Auto', 'rankAuto', 'S', 1 from game g where g.name = 'Infinite Recharge';
insert into Rank (gameId, name, queryString, type, sortOrder) select g.id, 'Power Cell', 'rankPC', 'S', 2 from game g where g.name = 'Infinite Recharge';
insert into Rank (gameId, name, queryString, type, sortOrder) select g.id, 'Ctrl Pnl', 'rankCP', 'S', 3 from game g where g.name = 'Infinite Recharge';
insert into Rank (gameId, name, queryString, type, sortOrder) select g.id, 'Defense', 'rankPlayedDefense', 'V', 4 from game g where g.name = 'Infinite Recharge';
insert into Rank (gameId, name, queryString, type, sortOrder) select g.id, 'Finish', 'rankFinish', 'S', 5 from game g where g.name = 'Infinite Recharge';

insert into RankObjective (rankId, objectiveId) select r.id, o.id from Rank r inner join Game g on g.id = r.gameId, Objective o where r.name = 'Auto' and o.name = 'aMove' and g.name = 'Infinite Recharge';
insert into RankObjective (rankId, objectiveId) select r.id, o.id from Rank r inner join Game g on g.id = r.gameId, Objective o where r.name = 'Auto' and o.name = 'aPcLower' and g.name = 'Infinite Recharge';
insert into RankObjective (rankId, objectiveId) select r.id, o.id from Rank r inner join Game g on g.id = r.gameId, Objective o where r.name = 'Auto' and o.name = 'aPcOuter' and g.name = 'Infinite Recharge';
insert into RankObjective (rankId, objectiveId) select r.id, o.id from Rank r inner join Game g on g.id = r.gameId, Objective o where r.name = 'Auto' and o.name = 'aPcInner' and g.name = 'Infinite Recharge';
insert into RankObjective (rankId, objectiveId) select r.id, o.id from Rank r inner join Game g on g.id = r.gameId, Objective o where r.name = 'Power Cell' and o.name = 'aPcLower' and g.name = 'Infinite Recharge';
insert into RankObjective (rankId, objectiveId) select r.id, o.id from Rank r inner join Game g on g.id = r.gameId, Objective o where r.name = 'Power Cell' and o.name = 'aPcOuter' and g.name = 'Infinite Recharge';
insert into RankObjective (rankId, objectiveId) select r.id, o.id from Rank r inner join Game g on g.id = r.gameId, Objective o where r.name = 'Power Cell' and o.name = 'aPcInner' and g.name = 'Infinite Recharge';
insert into RankObjective (rankId, objectiveId) select r.id, o.id from Rank r inner join Game g on g.id = r.gameId, Objective o where r.name = 'Power Cell' and o.name = 'toPcLower' and g.name = 'Infinite Recharge';
insert into RankObjective (rankId, objectiveId) select r.id, o.id from Rank r inner join Game g on g.id = r.gameId, Objective o where r.name = 'Power Cell' and o.name = 'toPcOuter' and g.name = 'Infinite Recharge';
insert into RankObjective (rankId, objectiveId) select r.id, o.id from Rank r inner join Game g on g.id = r.gameId, Objective o where r.name = 'Power Cell' and o.name = 'toPcInner' and g.name = 'Infinite Recharge';
insert into RankObjective (rankId, objectiveId) select r.id, o.id from Rank r inner join Game g on g.id = r.gameId, Objective o where r.name = 'Ctrl Pnl' and o.name = 'toCpRotation' and g.name = 'Infinite Recharge';
insert into RankObjective (rankId, objectiveId) select r.id, o.id from Rank r inner join Game g on g.id = r.gameId, Objective o where r.name = 'Ctrl Pnl' and o.name = 'toCpPosition' and g.name = 'Infinite Recharge';
insert into RankObjective (rankId, objectiveId) select r.id, o.id from Rank r inner join Game g on g.id = r.gameId, Objective o where r.name = 'Defense' and o.name = 'toDefense' and g.name = 'Infinite Recharge';
insert into RankObjective (rankId, objectiveId) select r.id, o.id from Rank r inner join Game g on g.id = r.gameId, Objective o where r.name = 'Finish' and o.name = 'toFinalPosition' and g.name = 'Infinite Recharge';

-- Attribute Setup
insert into Attribute (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue, sortOrder, tableHeader) select g.id, 'weight', 'What does the robot weigh (include battery and bumpers)?', st.id, 100, 150, 1, 'Weight' from game g, scoringType st where g.name = 'Infinite Recharge' and st.name = 'Integer';
insert into Attribute (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue, sortOrder, tableHeader) select g.id, 'preferredStart', 'What is preferred start location?', st.id, null, null, 2, 'Pref Start' from game g, scoringType st where g.name = 'Infinite Recharge' and st.name = 'Radio Button';
insert into Attribute (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue, sortOrder, tableHeader) select g.id, 'flexibleStart', 'Does your autonomous allow for flexible start location?', st.id, null, null, 3, 'Flex Start' from game g, scoringType st where g.name = 'Infinite Recharge' and st.name = 'Radio Button';
insert into Attribute (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue, sortOrder, tableHeader) select g.id, 'movementDelay', 'Does your autonomous allow for delaying movement start?', st.id, null, null, 4, 'Move Delay' from game g, scoringType st where g.name = 'Infinite Recharge' and st.name = 'Radio Button';
insert into Attribute (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue, sortOrder, tableHeader) select g.id, 'movementDescription', 'Describe autonomous movement?', st.id, null, null, 5, 'Move Desc' from game g, scoringType st where g.name = 'Infinite Recharge' and st.name = 'Free Form';
insert into AttributeValue (attributeId, displayValue, integerValue, sortOrder) select a.id, 'Out of way, non-shooting', -2, 2 from Attribute a inner join Game g on g.id = a.gameId where g.name = 'Infinite Recharge' and a.name = 'preferredStart';
insert into AttributeValue (attributeId, displayValue, integerValue, sortOrder) select a.id, 'In Front of Target', 0, 2 from Attribute a inner join Game g on g.id = a.gameId where g.name = 'Infinite Recharge' and a.name = 'preferredStart';
insert into AttributeValue (attributeId, displayValue, integerValue, sortOrder) select a.id, 'Right of Target', 1, 3 from Attribute a inner join Game g on g.id = a.gameId where g.name = 'Infinite Recharge' and a.name = 'preferredStart';
insert into AttributeValue (attributeId, displayValue, integerValue, sortOrder) select a.id, 'Left of Target', -1, 4 from Attribute a inner join Game g on g.id = a.gameId where g.name = 'Infinite Recharge' and a.name = 'preferredStart';
insert into AttributeValue (attributeId, displayValue, integerValue, sortOrder) select a.id, 'No', 0, 1 from Attribute a inner join Game g on g.id = a.gameId where g.name = 'Infinite Recharge' and a.name = 'flexibleStart';
insert into AttributeValue (attributeId, displayValue, integerValue, sortOrder) select a.id, 'Yes', 1, 2 from Attribute a inner join Game g on g.id = a.gameId where g.name = 'Infinite Recharge' and a.name = 'flexibleStart';
insert into AttributeValue (attributeId, displayValue, integerValue, sortOrder) select a.id, 'No', 0, 1 from Attribute a inner join Game g on g.id = a.gameId where g.name = 'Infinite Recharge' and a.name = 'movementDelay';
insert into AttributeValue (attributeId, displayValue, integerValue, sortOrder) select a.id, 'Yes', 1, 2 from Attribute a inner join Game g on g.id = a.gameId where g.name = 'Infinite Recharge' and a.name = 'movementDelay';

update GameEvent set isActive = 'N' where isActive = 'Y'
update GameEvent set isActive = 'Y' where eventId = (select id from Event where name = 'Lake Superior Regional') and gameId = (select id from game where name = 'Infinite Recharge')

-- Add matches and teams to the matches for a test event
Delete From TeamMatch where matchId in
      (select m.id from match m inner join gameEvent ge on ge.id = m.gameEventId
                        inner join game g on g.id = ge.gameId inner join Event e on e.id = ge.eventId
        where g.name = 'Infinite Recharge' and e.name = 'Lake Superior Regional')
Delete From Match where gameEventId in
      (select ge.id from gameEvent ge
                        inner join game g on g.id = ge.gameId inner join Event e on e.id = ge.eventId
        where g.name = 'Infinite Recharge' and e.name = 'Lake Superior Regional')

insert into Match
select ge.id, '01', '02-29-2020 03:34', 'T', 'Y'
  from GameEvent ge inner join Event e on e.id = ge.eventId inner join Game g on g.id = ge.gameId
where g.name = 'Infinite Recharge' and e.name = 'Lake Superior Regional'
insert into Match
select ge.id, '02', '02-29-2020 03:47', 'T', 'Y'
from GameEvent ge inner join Event e on e.id = ge.eventId inner join Game g on g.id = ge.gameId
where g.name = 'Infinite Recharge' and e.name = 'Lake Superior Regional'

insert into TeamMatch select m.id, t.id, 'R', 1 from Team t, Match m inner join gameEvent ge on ge.id = m.gameEventId inner join Event e on e.id = ge.eventId inner join Game g on g.id = ge.gameId
 where g.name = 'Infinite Recharge' and e.name = 'Lake Superior Regional' and m.number = '01' and t.teamNumber = 5653
insert into TeamMatch select m.id, t.id, 'R', 2 from Team t, Match m inner join gameEvent ge on ge.id = m.gameEventId inner join Event e on e.id = ge.eventId inner join Game g on g.id = ge.gameId
 where g.name = 'Infinite Recharge' and e.name = 'Lake Superior Regional' and m.number = '01' and t.teamNumber = 5690
insert into TeamMatch select m.id, t.id, 'R', 3 from Team t, Match m inner join gameEvent ge on ge.id = m.gameEventId inner join Event e on e.id = ge.eventId inner join Game g on g.id = ge.gameId
 where g.name = 'Infinite Recharge' and e.name = 'Lake Superior Regional' and m.number = '01' and t.teamNumber = 5991
insert into TeamMatch select m.id, t.id, 'B', 1 from Team t, Match m inner join gameEvent ge on ge.id = m.gameEventId inner join Event e on e.id = ge.eventId inner join Game g on g.id = ge.gameId
 where g.name = 'Infinite Recharge' and e.name = 'Lake Superior Regional' and m.number = '01' and t.teamNumber = 5999
insert into TeamMatch select m.id, t.id, 'B', 2 from Team t, Match m inner join gameEvent ge on ge.id = m.gameEventId inner join Event e on e.id = ge.eventId inner join Game g on g.id = ge.gameId
 where g.name = 'Infinite Recharge' and e.name = 'Lake Superior Regional' and m.number = '01' and t.teamNumber = 6022
insert into TeamMatch select m.id, t.id, 'B', 3 from Team t, Match m inner join gameEvent ge on ge.id = m.gameEventId inner join Event e on e.id = ge.eventId inner join Game g on g.id = ge.gameId
 where g.name = 'Infinite Recharge' and e.name = 'Lake Superior Regional' and m.number = '01' and t.teamNumber = 6045

insert into TeamMatch select m.id, t.id, 'R', 1 from Team t, Match m inner join gameEvent ge on ge.id = m.gameEventId inner join Event e on e.id = ge.eventId inner join Game g on g.id = ge.gameId
 where g.name = 'Infinite Recharge' and e.name = 'Lake Superior Regional' and m.number = '02' and t.teamNumber = 6047
insert into TeamMatch select m.id, t.id, 'R', 2 from Team t, Match m inner join gameEvent ge on ge.id = m.gameEventId inner join Event e on e.id = ge.eventId inner join Game g on g.id = ge.gameId
 where g.name = 'Infinite Recharge' and e.name = 'Lake Superior Regional' and m.number = '02' and t.teamNumber = 6146
insert into TeamMatch select m.id, t.id, 'R', 3 from Team t, Match m inner join gameEvent ge on ge.id = m.gameEventId inner join Event e on e.id = ge.eventId inner join Game g on g.id = ge.gameId
 where g.name = 'Infinite Recharge' and e.name = 'Lake Superior Regional' and m.number = '02' and t.teamNumber = 6160
insert into TeamMatch select m.id, t.id, 'B', 1 from Team t, Match m inner join gameEvent ge on ge.id = m.gameEventId inner join Event e on e.id = ge.eventId inner join Game g on g.id = ge.gameId
 where g.name = 'Infinite Recharge' and e.name = 'Lake Superior Regional' and m.number = '02' and t.teamNumber = 6217
insert into TeamMatch select m.id, t.id, 'B', 2 from Team t, Match m inner join gameEvent ge on ge.id = m.gameEventId inner join Event e on e.id = ge.eventId inner join Game g on g.id = ge.gameId
 where g.name = 'Infinite Recharge' and e.name = 'Lake Superior Regional' and m.number = '02' and t.teamNumber = 6318
insert into TeamMatch select m.id, t.id, 'B', 3 from Team t, Match m inner join gameEvent ge on ge.id = m.gameEventId inner join Event e on e.id = ge.eventId inner join Game g on g.id = ge.gameId
 where g.name = 'Infinite Recharge' and e.name = 'Lake Superior Regional' and m.number = '02' and t.teamNumber = 6453
