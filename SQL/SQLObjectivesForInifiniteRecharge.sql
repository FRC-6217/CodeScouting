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
-- 12 Final Position - Hang Unassisted (25), Hang Assist 1 (40), Hang Assist 2 (55), Hang Assisted (10), Park (5), None (0)
--
-- Team Attributes
-- 1 Where do you prefer to start match? Inline with Target, Right of Target, Left of Target, Out of the way.
-- 2 Can your autonomous software be flexible for position? Y/N
-- 3 Can your autonomous software allow for a time delay to help with robot flow? Y/N
-- 4 Draw your preferred robot path for autonomous? Upload an Image
-- 5 What does your robot weigh?

-- Clear any previous setup
Delete From Objective where gameid = (select g.id from game g where g.name = 'infinite recharge')

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
