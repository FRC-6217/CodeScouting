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
Delete From ObjectiveValue where objectiveId in (select o.id from objective o inner join game g on g.id = o.gameId where g.name = 'Infinite Recharge')
Delete From Objective where gameid = (select g.id from game g where g.name = 'Infinite Recharge')

-- Autonomous 
insert into Objective select g.id, 'aPcLower', 'Auto PC Lower Count', st.id, 0, 8, 2, 1 from ScoringType st, game g  where st.name = 'integer' and g.name = 'Infinite Recharge'
insert into Objective select g.id, 'aPcOuter', 'Auto PC Outer Count', st.id, 0, 8, 4, 2 from ScoringType st, game g  where st.name = 'integer' and g.name = 'Infinite Recharge'
insert into Objective select g.id, 'aPcInner', 'Auto PC Inner Count', st.id, 0, 8, 6, 3 from ScoringType st, game g  where st.name = 'integer' and g.name = 'Infinite Recharge'
insert into Objective select g.id, 'aMove', 'Auto Move Off Line', st.id, null, null, null, 4 from ScoringType st, game g  where st.name = 'Radio Button' and g.name = 'Infinite Recharge'

-- TeleOp
insert into Objective select g.id, 'toPcLower', 'TeleOp PC Lower Count', st.id, 0, 50, 1, 5 from ScoringType st, game g  where st.name = 'integer' and g.name = 'Infinite Recharge'
insert into Objective select g.id, 'toPcOuter', 'TeleOp PC Outer Count', st.id, 0, 50, 2, 6 from ScoringType st, game g  where st.name = 'integer' and g.name = 'Infinite Recharge'
insert into Objective select g.id, 'toPcInner', 'TeleOp PC Inner Count', st.id, 0, 50, 3, 7 from ScoringType st, game g  where st.name = 'integer' and g.name = 'Infinite Recharge'
insert into Objective select g.id, 'toCpRotation', 'TeleOp Ctrl Pnl Rotation', st.id, null, null, null, 8 from ScoringType st, game g  where st.name = 'Radio Button' and g.name = 'Infinite Recharge'
insert into Objective select g.id, 'toCpRotationTime', 'TeleOp Ctrl Pnl Rotation Time', st.id, 0, 60, null, 9 from ScoringType st, game g where st.name = 'integer' and g.name = 'Infinite Recharge'
insert into Objective select g.id, 'toCpPosition', 'TeleOp Ctrl Pnl Position', st.id, null, null, null, 10 from ScoringType st, game g  where st.name = 'Radio Button' and g.name = 'Infinite Recharge'
insert into Objective select g.id, 'toCpPositionTime', 'TeleOp Ctrl Pnl Position Time', st.id, 0, 60, null, 11 from ScoringType st, game g where st.name = 'integer' and g.name = 'Infinite Recharge' 
insert into Objective select g.id, 'toDefense', 'TeleOp Defense', st.id, null, null, null, 12 from ScoringType st, game g  where st.name = 'Radio Button' and g.name = 'Infinite Recharge'

-- End Game
insert into Objective select g.id, 'toFinalPosition', 'TeleOp Final Position', st.id, null, null, null, 13 from ScoringType st, game g  where st.name = 'Radio Button' and g.name = 'Infinite Recharge'

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
