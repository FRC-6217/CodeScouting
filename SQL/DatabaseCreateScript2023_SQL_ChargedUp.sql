/* Clear data
delete from AttributeValue where attributeId in (select a.id from Attribute a inner join Game g on g.id = a.gameId where g.name = 'Charged Up');
delete from Attribute where gameId in (select g.id from Game g where g.name = 'Charged Up');

delete from RankObjective where rankId in (select r.id from Rank r inner join Game g on g.id = r.gameId where g.name = 'Charged Up');
delete from Rank where gameId in (select g.id from Game g where g.name = 'Charged Up');

delete from ObjectiveGroupObjective where objectiveId in (select o.id from Objective o inner join Game g on g.id = o.gameId where g.name = 'Charged Up');
delete from ObjectiveValue where objectiveId in (select o.id from Objective o inner join Game g on g.id = o.gameId where g.name = 'Charged Up');
delete from Objective where gameId in (select g.id from Game g where g.name = 'Charged Up');

delete from game where name = 'Charged Up';
*/

-- Game
insert into Game (name, gameYear, alliancePtsHeader) values ('Charged Up', 2023, 'Amped');

-- Attributes
insert into Attribute select g.id, 'name', 'What''s your name?', st.id, null, null, 1, getdate(), 'Name', 'N', '<Enter Name Here>' from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Free Form'
insert into Attribute select g.id, 'role', 'What''s your role on the team?', st.id, null, null, 2, getdate(), 'Role', 'N', 'Drive Team' from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Free Form'
insert into Attribute select g.id, 'driveTrain', 'What drivetrain is robot using?', st.id, null, null, 3, getdate(), 'Drive Train', 'N', null from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Radio Button'
insert into Attribute select g.id, 'robotWidth', 'Width of robot with bumpers (inches)?', st.id, null, null, 4, getdate(), 'Width', 'N', null from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Integer'
insert into Attribute select g.id, 'autoChargeStation', 'Do you have an auto charge station program?', st.id, null, null, 5, getdate(), 'Charge Stat', 'N', null from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Radio Button'
insert into Attribute select g.id, 'preferredStart', 'What is preferred start location?', st.id, null, null, 6, getdate(), 'Pref Start', 'N', null from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Radio Button'
insert into Attribute select g.id, 'flexibleStart', 'Does autonomous program allow for flexible start location?', st.id, null, null, 7, getdate(), 'Flex Start', 'N', null from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Radio Button'
insert into Attribute select g.id, 'autoNow', 'Describe current autonomous program movment?', st.id, null, null, 8, getdate(), 'Auto Now', 'N', 'Drive out of Community' from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Free Form'
insert into Attribute select g.id, 'AutoPlan', 'Describe any plans for changes to autonomous movement?', st.id, null, null, 9, getdate(), 'Auto Plan', 'N', 'Pick up second game piece' from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Free Form'
insert into Attribute select g.id, 'gamePiecePickup', 'How does robot attain game pieces?', st.id, null, null, 10, getdate(), 'Pickup', 'N', null from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Radio Button'
insert into Attribute select g.id, 'gamePieces', 'Which game pieces does robot work with?', st.id, null, null, 11, getdate(), 'Game Pieces', 'N', null from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Radio Button'
insert into Attribute select g.id, 'gamePieceLevel', 'Which levels can robot place game pieces?', st.id, null, null, 12, getdate(), 'Game Piece Levels', 'N', null from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Radio Button'
insert into Attribute select g.id, 'chargeStationDescription', 'Describe the charge station end game plan?', st.id, null, null, 13, getdate(), 'Chg Stat', 'N', 'Share Charge Station with another robot' from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Free Form'

-- Attribute Values
insert into AttributeValue select a.id, 'Tank', 0, 1, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'driveTrain';
insert into AttributeValue select a.id, 'Tank with Omni', 1, 2, getdate(), 'Y', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'driveTrain';
insert into AttributeValue select a.id, 'Swerve', 2, 3, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'driveTrain';
insert into AttributeValue select a.id, 'Mecanum', 3, 4, getdate(), 'Y', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'driveTrain';
insert into AttributeValue select a.id, 'Kiwi', 4, 5, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'driveTrain';
insert into AttributeValue select a.id, 'Other', 5, 6, getdate(), 'Y', 'Y' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'driveTrain';
insert into AttributeValue select a.id, 'No', 0, 1, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'autoChargeStation';
insert into AttributeValue select a.id, 'Yes - Docked', 1, 2, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'autoChargeStation';
insert into AttributeValue select a.id, 'Yes - Engaged', 2, 3, getdate(), 'Y', 'Y' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'autoChargeStation';
insert into AttributeValue select a.id, 'No Preference', 0, 1, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'preferredStart';
insert into AttributeValue select a.id, 'Above Chg Stat', 1, 2, getdate(), 'Y', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'preferredStart';
insert into AttributeValue select a.id, 'Behind Chg Stat', 2, 3, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'preferredStart';
insert into AttributeValue select a.id, 'Below Chg Stat', 3, 4, getdate(), 'Y', 'Y' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'preferredStart';
insert into AttributeValue select a.id, 'No', 0, 1, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'flexibleStart';
insert into AttributeValue select a.id, 'Yes', 1, 2, getdate(), 'Y', 'Y' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'flexibleStart';
insert into AttributeValue select a.id, 'Off Floor', 0, 1, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'gamePiecePickup';
insert into AttributeValue select a.id, 'Sub Shelf', 1, 2, getdate(), 'Y', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'gamePiecePickup';
insert into AttributeValue select a.id, 'Both', 2, 3, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'gamePiecePickup';
insert into AttributeValue select a.id, 'Neither', 3, 4, getdate(), 'Y', 'Y' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'gamePiecePickup';
insert into AttributeValue select a.id, 'Cubes', 0, 1, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'gamePieces';
insert into AttributeValue select a.id, 'Cones', 1, 2, getdate(), 'Y', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'gamePieces';
insert into AttributeValue select a.id, 'Both', 2, 3, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'gamePieces';
insert into AttributeValue select a.id, 'Neither', 3, 4, getdate(), 'Y', 'Y' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'gamePieces';
insert into AttributeValue select a.id, 'None', 0, 1, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'gamePieceLevel';
insert into AttributeValue select a.id, 'Floor Only', 1, 2, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'gamePieceLevel';
insert into AttributeValue select a.id, 'Floor & Mid', 2, 3, getdate(), 'Y', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'gamePieceLevel';
insert into AttributeValue select a.id, 'Mid Only', 3, 4, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'gamePieceLevel';
insert into AttributeValue select a.id, 'Mid & Hi', 4, 5, getdate(), 'Y', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'gamePieceLevel';
insert into AttributeValue select a.id, 'Hi Only', 5, 6, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'gamePieceLevel';
insert into AttributeValue select a.id, 'Floor, Mid & Hi', 6, 7, getdate(), 'Y', 'Y' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'gamePieceLevel';

-- Objectives
insert into Objective select g.id, 'aAtmptCS', 'Attempt Chg Stat:', st.id, null, null, null, 1, getdate(), 'aAtmptCS', 'I', 'Y', 'N', 2 from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Radio Button'
insert into Objective select g.id, 'aCoLow', 'Cone Low:', st.id, 0, 3, 3, 2, getdate(), 'aCoLow', 'I', 'N', 'Y', 4 from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Integer'
insert into Objective select g.id, 'aCoMid', 'Mid:', st.id, 0, 3, 4, 3, getdate(), 'aCoMid', 'I', 'Y', 'Y', 5 from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Integer'
insert into Objective select g.id, 'aCoHi', 'Hi:', st.id, 0, 3, 6, 4, getdate(), 'aCoHi', 'I', 'Y', 'Y', 6 from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Integer'
insert into Objective select g.id, 'aCuLow', 'Cube Low:', st.id, 0, 3, 3, 5, getdate(), 'aCuLow', 'I', 'N', 'Y', 7 from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Integer'
insert into Objective select g.id, 'aCuMid', 'Mid:', st.id, 0, 2, 4, 6, getdate(), 'aCuMid', 'I', 'Y', 'Y', 8 from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Integer'
insert into Objective select g.id, 'aCuHi', 'Hi:', st.id, 0, 2, 6, 7, getdate(), 'aCuHi', 'I', 'Y', 'Y', 9 from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Integer'
insert into Objective select g.id, 'toCoLow', 'Cone Low:', st.id, 0, 9, 2, 8, getdate(), 'toCoLow', 'I', 'N', 'Y', 10 from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Integer'
insert into Objective select g.id, 'toCoMid', 'Mid:', st.id, 0, 6, 3, 9, getdate(), 'toCoMid', 'I', 'Y', 'Y', 11 from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Integer'
insert into Objective select g.id, 'toCoHi', 'Hi:', st.id, 0, 6, 5, 10, getdate(), 'toCoHi', 'I', 'Y', 'Y', 12 from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Integer'
insert into Objective select g.id, 'toCuLow', 'Cube Low:', st.id, 0, 9, 2, 11, getdate(), 'toCuLow', 'I', 'N', 'Y', 13 from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Integer'
insert into Objective select g.id, 'toCuMid', 'Mid:', st.id, 0, 3, 3, 12, getdate(), 'toCuMid', 'I', 'Y', 'Y', 14 from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Integer'
insert into Objective select g.id, 'toCuHi', 'Hi:', st.id, 0, 3, 5, 13, getdate(), 'toCuHi', 'I', 'Y', 'Y', 15 from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Integer'
insert into Objective select g.id, 'toDefense', 'Defense:', st.id, null, null, null, 14, getdate(), 'Def', 'I', 'N', 'N', 17 from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Radio Button'
insert into Objective select g.id, 'toHP', 'Human Player Perf:', st.id, null, null, null, 15, getdate(), 'HP', 'I', 'N', 'N', 18 from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Radio Button'
insert into Objective select g.id, 'aMove', 'Move out of Community:', st.id, null, null, null, 16, getdate(), 'aMove', 'S', 'N', 'N', 1 from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Radio Button'
insert into Objective select g.id, 'aCS', 'Charge Station:', st.id, null, null, null, 17, getdate(), 'aCS', 'S', 'N', 'N', 3 from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Radio Button'
insert into Objective select g.id, 'toEnd', 'End Game:', st.id, null, null, null, 18, getdate(), 'End', 'S', 'N', 'N', 16 from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Radio Button'

-- Objective Value
insert into ObjectiveValue select o.id, 'No', 0, 1, 0, getdate(), 'Y', 'No', null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Charged Up' and o.name = 'aAtmptCS'
insert into ObjectiveValue select o.id, 'Yes', 1, 2, 0, getdate(), 'Y', 'Yes', null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Charged Up' and o.name = 'aAtmptCS'
insert into ObjectiveValue select o.id, 'No', 0, 1, 0, getdate(), 'N', 'No', null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Charged Up' and o.name = 'aMove'
insert into ObjectiveValue select o.id, 'Yes', 1, 2, 3, getdate(), 'Y', 'Yes', null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Charged Up' and o.name = 'aMove'
insert into ObjectiveValue select o.id, 'None', 0, 1, 0, getdate(), 'N', 'None', null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Charged Up' and o.name = 'aCS'
insert into ObjectiveValue select o.id, 'Docked', 1, 2, 8, getdate(), 'Y', 'Docked', null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Charged Up' and o.name = 'aCS'
insert into ObjectiveValue select o.id, 'Engaged', 2, 3, 12, getdate(), 'Y', 'Engaged', null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Charged Up' and o.name = 'aCS'
insert into ObjectiveValue select o.id, 'No Defense', 0, 1, 0, getdate(), 'N', null, null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Charged Up' and o.name = 'toDefense'
insert into ObjectiveValue select o.id, 'Poor Defense', -1, 2, 0, getdate(), 'Y', null, null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Charged Up' and o.name = 'toDefense'
insert into ObjectiveValue select o.id, 'Good Defense', 1, 3, 0, getdate(), 'N', null, null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Charged Up' and o.name = 'toDefense'
insert into ObjectiveValue select o.id, 'Excellent Defense', 2, 4, 0, getdate(), 'Y', null, null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Charged Up' and o.name = 'toDefense'
insert into ObjectiveValue select o.id, 'None', 0, 1, 0, getdate(), 'N', null, null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Charged Up' and o.name = 'toHP'
insert into ObjectiveValue select o.id, 'Poor HP', -1, 2, 0, getdate(), 'Y', null, null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Charged Up' and o.name = 'toHP'
insert into ObjectiveValue select o.id, 'Good HP', 1, 3, 0, getdate(), 'N', null, null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Charged Up' and o.name = 'toHP'
insert into ObjectiveValue select o.id, 'Excellent HP', 2, 4, 0, getdate(), 'Y', null, null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Charged Up' and o.name = 'toHP'
insert into ObjectiveValue select o.id, 'None', 0, 1, 0, getdate(), 'N', 'None', null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Charged Up' and o.name = 'toEnd'
insert into ObjectiveValue select o.id, 'Park', 1, 2, 2, getdate(), 'Y', 'Park', null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Charged Up' and o.name = 'toEnd'
insert into ObjectiveValue select o.id, 'Docked', 2, 3, 6, getdate(), 'N', 'Docked', null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Charged Up' and o.name = 'toEnd'
insert into ObjectiveValue select o.id, 'Engaged', 3, 4, 10, getdate(), 'Y', 'Engaged', null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Charged Up' and o.name = 'toEnd'

-- Objective Group Objectives
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'aAtmptCS' and og.name = 'Autonomous' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'aCoLow' and og.name = 'Autonomous' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'aCoMid' and og.name = 'Autonomous' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'aCoHi' and og.name = 'Autonomous' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'aCuLow' and og.name = 'Autonomous' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'aCuMid' and og.name = 'Autonomous' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'aCuHi' and og.name = 'Autonomous' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'toCoLow' and og.name = 'Tele Op' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'toCoMid' and og.name = 'Tele Op' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'toCoHi' and og.name = 'Tele Op' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'toCuLow' and og.name = 'Tele Op' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'toCuMid' and og.name = 'Tele Op' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'toCuHi' and og.name = 'Tele Op' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'toDefense' and og.name = 'Tele Op' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'toHP' and og.name = 'Tele Op' and og.groupCode = 'Scout Match'

insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'aMove' and og.name = 'Autonomous' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'aCoLow' and og.name = 'Autonomous' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'aCoMid' and og.name = 'Autonomous' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'aCoHi' and og.name = 'Autonomous' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'aCuLow' and og.name = 'Autonomous' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'aCuMid' and og.name = 'Autonomous' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'aCuHi' and og.name = 'Autonomous' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'aCS' and og.name = 'Autonomous' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'toCoLow' and og.name = 'TeleOp' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'toCoMid' and og.name = 'TeleOp' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'toCoHi' and og.name = 'TeleOp' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'toCuLow' and og.name = 'TeleOp' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'toCuMid' and og.name = 'TeleOp' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'toCuHi' and og.name = 'TeleOp' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'toEnd' and og.name = 'End Game' and og.groupCode = 'Report Pie Chart'

insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'aMove' and og.name = 'Autonomous' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'aCoLow' and og.name = 'Autonomous' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'aCoMid' and og.name = 'Autonomous' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'aCoHi' and og.name = 'Autonomous' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'aCuLow' and og.name = 'Autonomous' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'aCuMid' and og.name = 'Autonomous' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'aCuHi' and og.name = 'Autonomous' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'aCS' and og.name = 'Autonomous' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'toCoLow' and og.name = 'TeleOp' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'toCoMid' and og.name = 'TeleOp' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'toCoHi' and og.name = 'TeleOp' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'toCuLow' and og.name = 'TeleOp' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'toCuMid' and og.name = 'TeleOp' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'toCuHi' and og.name = 'TeleOp' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'toEnd' and og.name = 'End Game' and og.groupCode = 'Report Line Graph'

-- Ranks
insert into Rank select 'Auto', 'rankAuto', 'S', 1, getdate(), g.id, 'N' from Game g where g.name = 'Charged Up'
insert into Rank select 'Cone', 'rankCone', 'S', 2, getdate(), g.id, 'N' from Game g where g.name = 'Charged Up'
insert into Rank select 'Cube', 'rankCube', 'S', 3, getdate(), g.id, 'N' from Game g where g.name = 'Charged Up'
insert into Rank select 'Driving', 'rankDr', 'S', 4, getdate(), g.id, 'N' from Game g where g.name = 'Charged Up'
insert into Rank select 'Scr Imp', 'rankScoreImpact', 'S', 5, getdate(), g.id, 'Y' from Game g where g.name = 'Charged Up'
--insert into Rank select 'Defense', 'rankPlayedDefense', 'V', 5, getdate(), g.id from Game g where g.name = 'Charged Up'
--insert into Rank select 'HP', 'rankHP', 'V', 6, getdate(), g.id from Game g where g.name = 'Charged Up'

-- Rank Objective
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'aMove' and r.name = 'Auto'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'aCoLow' and r.name = 'Auto'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'aCoMid' and r.name = 'Auto'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'aCoHi' and r.name = 'Auto'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'aCuLow' and r.name = 'Auto'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'aCuMid' and r.name = 'Auto'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'aCuHi' and r.name = 'Auto'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'aCS' and r.name = 'Auto'

insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'aCoLow' and r.name = 'Cone'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'aCoMid' and r.name = 'Cone'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'aCoHi' and r.name = 'Cone'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'toCoLow' and r.name = 'Cone'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'toCoMid' and r.name = 'Cone'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'toCoHi' and r.name = 'Cone'

insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'aCuLow' and r.name = 'Cube'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'aCuMid' and r.name = 'Cube'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'aCuHi' and r.name = 'Cube'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'toCuLow' and r.name = 'Cube'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'toCuMid' and r.name = 'Cube'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'toCuHi' and r.name = 'Cube'

insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'aMove' and r.name = 'Driving'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'aCS' and r.name = 'Driving'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'toEnd' and r.name = 'Driving'

insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'aMove' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'aCoLow' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'aCoMid' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'aCoHi' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'aCuLow' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'aCuMid' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'aCuHi' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'aCS' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'toCoLow' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'toCoMid' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'toCoHi' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'toCuLow' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'toCuMid' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'toCuHi' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'toEnd' and r.name = 'Scr Imp'

--insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'toDefense' and r.name = 'Defense'

--insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'toHP' and r.name = 'HP'

-- Scout
update Scout set isActive = 'N' where teamId in (select id from Team where teamNumber = 6217) and lastname + firstname not in ('CoyleJoe', 'EngebretsenDave', 'HernkeKyle (Lead Scout)','TBA');
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Auger', 'Sara', t.id, 'Y', '24sa01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Auger' and s.firstName = 'Sara' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Banitt', 'Brody', t.id, 'Y', '26bb02@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Banitt' and s.firstName = 'Brody' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Broenen', 'Jon', t.id, 'Y', '23jb01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Broenen' and s.firstName = 'Jon' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Brokate', 'Max', t.id, 'Y', '25mb02@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Brokate' and s.firstName = 'Max' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Coyle', 'Thomas', t.id, 'Y', '25tc01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Coyle' and s.firstName = 'Thomas' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Dettmann', 'Madison', t.id, 'Y', '26md01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Dettmann' and s.firstName = 'Madison' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Ehlers', 'Thomas', t.id, 'Y', '24te01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Ehlers' and s.firstName = 'Thomas' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Gustafson', 'Aubrey', t.id, 'Y', '27ag02@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Gustafson' and s.firstName = 'Aubrey' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Hernke', 'Luke', t.id, 'Y', 'hernkelm@gmail.com', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Hernke' and s.firstName = 'Luke' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Lochner', 'Brighton', t.id, 'Y', '23bl01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Lochner' and s.firstName = 'Brighton' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Lopez', 'Emma', t.id, 'Y', '23el02@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Lopez' and s.firstName = 'Emma' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Maki', 'Gunnar', t.id, 'Y', '27gm01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Maki' and s.firstName = 'Gunnar' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'McGeough', 'Andrew', t.id, 'Y', '26am01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'McGeough' and s.firstName = 'Andrew' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'McGeough', 'Riley', t.id, 'Y', 'riley.mcgeough@icloud.com', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'McGeough' and s.firstName = 'Riley' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'McGuire', 'Tyler', t.id, 'Y', '24tm01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'McGuire' and s.firstName = 'Tyler' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Olson', 'Maddie', t.id, 'Y', '27mo01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Olson' and s.firstName = 'Maddie' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Rapp', 'Axel', t.id, 'Y', '26ar01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Rapp' and s.firstName = 'Axel' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Rapp', 'Isaac', t.id, 'Y', '25ir01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Rapp' and s.firstName = 'Isaac' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Rapp', 'Tyler', t.id, 'Y', '23tr01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Rapp' and s.firstName = 'Tyler' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Strecker', 'Teagan', t.id, 'Y', '23ts01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Strecker' and s.firstName = 'Teagan' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Strecker', 'Torin', t.id, 'Y', '26ts01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Strecker' and s.firstName = 'Torin' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Sullivan', 'Danny', t.id, 'Y', '24ds01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Sullivan' and s.firstName = 'Danny' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Swenson', 'Brandon', t.id, 'Y', '24bs01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Swenson' and s.firstName = 'Brandon' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'White', 'Brandon', t.id, 'Y', '25bw01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'White' and s.firstName = 'Brandon' and s.teamId = t.id);
update Scout set isActive = 'Y' where lastName = 'Auger' and firstName = 'Sara' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Banitt' and firstName = 'Brody' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Broenen' and firstName = 'Jon' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Brokate' and firstName = 'Max' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Coyle' and firstName = 'Thomas' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Dettmann' and firstName = 'Madison' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Ehlers' and firstName = 'Thomas' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Gustafson' and firstName = 'Aubrey' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Hernke' and firstName = 'Luke' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Lochner' and firstName = 'Brighton' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Lopez' and firstName = 'Emma' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Maki' and firstName = 'Gunnar' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'McGeough' and firstName = 'Andrew' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'McGeough' and firstName = 'Riley' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'McGuire' and firstName = 'Tyler' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Olson' and firstName = 'Maddie' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Rapp' and firstName = 'Axel' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Rapp' and firstName = 'Isaac' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Rapp' and firstName = 'Tyler' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Strecker' and firstName = 'Teagan' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Strecker' and firstName = 'Torin' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Sullivan' and firstName = 'Danny' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Swenson' and firstName = 'Brandon' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'White' and firstName = 'Brandon' and teamId = (select id from Team where teamNumber = 6217);

update Scout set isAdmin = 'N' where isActive = 'N' and isAdmin = 'Y';

