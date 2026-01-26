/* Clear data
delete from teamAttribute where attributeId in (select a.id from Attribute a inner join Game g on g.id = a.gameId where g.name = 'Rebuilt');
delete from teamMatch where matchId in (select m.id from Game g inner join gameEvent ge on g.id = ge.gameId inner join match m on m.gameEventId = ge.id where g.name = 'Rebuilt');
delete from ScoutRecord where matchId in (select m.id from Game g inner join gameEvent ge on g.id = ge.gameId inner join match m on m.gameEventId = ge.id where g.name = 'Rebuilt');

delete from AttributeValue where attributeId in (select a.id from Attribute a inner join Game g on g.id = a.gameId where g.name = 'Rebuilt');
delete from Attribute where gameId in (select g.id from Game g where g.name = 'Rebuilt');

delete from RankObjective where rankId in (select r.id from Rank r inner join Game g on g.id = r.gameId where g.name = 'Rebuilt');
delete from Rank where gameId in (select g.id from Game g where g.name = 'Rebuilt');

delete from ObjectiveGroupObjective where objectiveId in (select o.id from Objective o inner join Game g on g.id = o.gameId where g.name = 'Rebuilt');
delete from ObjectiveValue where objectiveId in (select o.id from Objective o inner join Game g on g.id = o.gameId where g.name = 'Rebuilt');
delete from Objective where gameId in (select g.id from Game g where g.name = 'Rebuilt');

delete from game where name = 'Rebuilt';
*/

-- Game
insert into Game (name, gameYear, alliancePtsHeader, tbaCoopMet, tbaCoopAchieved) values ('Rebuilt', 2026, null, null, null);

-- Game Ranking Points
insert into GameRankingPoint select g.id, 1, 'Energized', 'ERP', 'energizedBonusAchieved', getdate() from Game g where g.name = 'Rebuilt'
insert into GameRankingPoint select g.id, 2, 'Supercharged', 'SRP', 'superchargedBonusAchieved', getdate() from Game g where g.name = 'Rebuilt'
insert into GameRankingPoint select g.id, 3, 'Traversal', 'TRP', 'traversalBonusAchieved', getdate() from Game g where g.name = 'Rebuilt'

-- Attributes
insert into Attribute select g.id, 'name', 'What''s your name?', st.id, null, null, 1, getdate(), 'Name', 'N', '<Enter Name Here>' from Game g, ScoringType st where g.name = 'Rebuilt' and st.name = 'Free Form'
insert into Attribute select g.id, 'role', 'What''s your role on the team?', st.id, null, null, 2, getdate(), 'Role', 'N', 'Drive Team' from Game g, ScoringType st where g.name = 'Rebuilt' and st.name = 'Free Form'
insert into Attribute select g.id, 'driveTrain', 'What drivetrain is robot using?', st.id, null, null, 3, getdate(), 'Drive Train', 'N', null from Game g, ScoringType st where g.name = 'Rebuilt' and st.name = 'Radio Button'
insert into Attribute select g.id, 'robotWidth', 'Width of robot (inches)?', st.id, null, null, 4, getdate(), 'Width', 'N', null from Game g, ScoringType st where g.name = 'Rebuilt' and st.name = 'Integer'
insert into Attribute select g.id, 'robotWeight', 'Weight of robot?', st.id, null, null, 5, getdate(), 'Weight', 'N', null from Game g, ScoringType st where g.name = 'Rebuilt' and st.name = 'Integer'
insert into Attribute select g.id, 'underTrench', 'Does your robot drive through the trench?', st.id, null, null, 6, getdate(), 'Trench', 'N', null from Game g, ScoringType st where g.name = 'Rebuilt' and st.name = 'Radio Button'
insert into Attribute select g.id, 'hopperSize', 'How many fuel can your hopper hold?', st.id, null, null, 7, getdate(), 'Hopper', 'N', null from Game g, ScoringType st where g.name = 'Rebuilt' and st.name = 'Integer'
insert into Attribute select g.id, 'intakeType', 'What type of Intake?', st.id, null, null, 8, getdate(), 'Intake', 'N', null from Game g, ScoringType st where g.name = 'Rebuilt' and st.name = 'Radio Button'
insert into Attribute select g.id, 'passing', 'Does your robot pass fuel?', st.id, null, null, 9, getdate(), 'Pass', 'N', null from Game g, ScoringType st where g.name = 'Rebuilt' and st.name = 'Radio Button'
insert into Attribute select g.id, 'autoNow', 'Describe current autonomous program movement?', st.id, null, null, 10, getdate(), 'Auto Now', 'N', null from Game g, ScoringType st where g.name = 'Rebuilt' and st.name = 'Free Form'
insert into Attribute select g.id, 'preferredStart', 'Do you have a preferred starting location for your robot?', st.id, null, null, 11, getdate(), 'PreffStart', 'N', null from Game g, ScoringType st where g.name = 'Rebuilt' and st.name = 'Radio Button'
insert into Attribute select g.id, 'flexibleStart', 'Does autonomous program allow for flexible start location?', st.id, null, null, 12, getdate(), 'Flex Start', 'N', null from Game g, ScoringType st where g.name = 'Rebuilt' and st.name = 'Radio Button'
insert into Attribute select g.id, 'autoClimb', 'Do you have an autonomous program to climb the tower?', st.id, null, null, 13, getdate(), 'Auto Climb', 'N', null from Game g, ScoringType st where g.name = 'Rebuilt' and st.name = 'Radio Button'
insert into Attribute select g.id, 'endGamePlan', 'What is your end game plan?', st.id, null, null, 14, getdate(), 'End Game', 'N', null from Game g, ScoringType st where g.name = 'Rebuilt' and st.name = 'Radio Button'
insert into Attribute select g.id, 'climbLoc', 'Where can you climb on the Tower?', st.id, null, null, 15, getdate(), 'Climb Loc', 'N', null from Game g, ScoringType st where g.name = 'Rebuilt' and st.name = 'Radio Button'
insert into Attribute select g.id, 'climbTime', 'Expected climb time (seconds)?', st.id, null, null, 16, getdate(), 'Climb Time', 'N', null from Game g, ScoringType st where g.name = 'Rebuilt' and st.name = 'Integer'

-- Attribute Values
insert into AttributeValue select a.id, 'Tank', 0, 1, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Rebuilt' and a.name = 'driveTrain';
insert into AttributeValue select a.id, 'Tank with Omni', 1, 2, getdate(), 'Y', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Rebuilt' and a.name = 'driveTrain';
insert into AttributeValue select a.id, 'Swerve', 2, 3, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Rebuilt' and a.name = 'driveTrain';
insert into AttributeValue select a.id, 'Mecanum', 3, 4, getdate(), 'Y', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Rebuilt' and a.name = 'driveTrain';
insert into AttributeValue select a.id, 'Kiwi', 4, 5, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Rebuilt' and a.name = 'driveTrain';
insert into AttributeValue select a.id, 'Other', 5, 6, getdate(), 'Y', 'Y' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Rebuilt' and a.name = 'driveTrain';
insert into AttributeValue select a.id, 'No', 0, 1, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Rebuilt' and a.name = 'underTrench';
insert into AttributeValue select a.id, 'Yes', 1, 2, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Rebuilt' and a.name = 'underTrench';
insert into AttributeValue select a.id, 'Sometimes', 2, 3, getdate(), 'Y', 'Y' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Rebuilt' and a.name = 'underTrench';
insert into AttributeValue select a.id, 'Bumper Opening', 0, 1, getdate(), 'Y', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Rebuilt' and a.name = 'intakeType';
insert into AttributeValue select a.id, 'Over Bumper', 1, 2, getdate(), 'Y', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Rebuilt' and a.name = 'intakeType';
insert into AttributeValue select a.id, 'Other', 2, 3, getdate(), 'Y', 'Y' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Rebuilt' and a.name = 'intakeType';
insert into AttributeValue select a.id, 'No', 0, 1, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Rebuilt' and a.name = 'passing';
insert into AttributeValue select a.id, 'From Alliance', 1, 2, getdate(), 'Y', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Rebuilt' and a.name = 'passing';
insert into AttributeValue select a.id, 'From Nuetral', 2, 3, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Rebuilt' and a.name = 'passing';
insert into AttributeValue select a.id, 'From Opponents', 3, 4, getdate(), 'Y', 'Y' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Rebuilt' and a.name = 'passing';
insert into AttributeValue select a.id, 'No Preference', 0, 1, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Rebuilt' and a.name = 'preferredStart';
insert into AttributeValue select a.id, 'Mid of Hub', 1, 2, getdate(), 'Y', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Rebuilt' and a.name = 'preferredStart';
insert into AttributeValue select a.id, 'Left of Hub', 2, 3, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Rebuilt' and a.name = 'preferredStart';
insert into AttributeValue select a.id, 'Right of Hub', 3, 4, getdate(), 'Y', 'Y' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Rebuilt' and a.name = 'preferredStart';
insert into AttributeValue select a.id, 'No', 0, 1, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Rebuilt' and a.name = 'flexibleStart';
insert into AttributeValue select a.id, 'Yes', 1, 2, getdate(), 'Y', 'Y' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Rebuilt' and a.name = 'flexibleStart';
insert into AttributeValue select a.id, 'No', 0, 1, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Rebuilt' and a.name = 'autoClimb';
insert into AttributeValue select a.id, 'Yes', 1, 2, getdate(), 'Y', 'Y' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Rebuilt' and a.name = 'autoClimb';
insert into AttributeValue select a.id, 'Continue Scoring', 0, 1, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Rebuilt' and a.name = 'endGamePlan';
insert into AttributeValue select a.id, 'Climb R1', 1, 2, getdate(), 'Y', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Rebuilt' and a.name = 'endGamePlan';
insert into AttributeValue select a.id, 'Climb R2', 2, 3, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Rebuilt' and a.name = 'endGamePlan';
insert into AttributeValue select a.id, 'Climb R3', 3, 4, getdate(), 'Y', 'Y' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Rebuilt' and a.name = 'endGamePlan';
insert into AttributeValue select a.id, 'No Preference', 0, 1, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Rebuilt' and a.name = 'climbLoc';
insert into AttributeValue select a.id, 'Mid of Tower', 1, 2, getdate(), 'Y', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Rebuilt' and a.name = 'climbLoc';
insert into AttributeValue select a.id, 'Left of Tower', 2, 3, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Rebuilt' and a.name = 'climbLoc';
insert into AttributeValue select a.id, 'Right of Tower', 3, 4, getdate(), 'Y', 'Y' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Rebuilt' and a.name = 'climbLoc';

-- Objectives
insert into Objective select g.id, 'aFuel', 'Fuel:', st.id, 0, 100, 1, 1, getdate(), 'aFuel', 'I', 'N', 'N', 1 from Game g, ScoringType st where g.name = 'Rebuilt' and st.name = 'Integer'
insert into Objective select g.id, 'aClimb', 'Climb:', st.id, null, null, null, 2, getdate(), 'aClimb', 'S', 'N', 'N', 2 from Game g, ScoringType st where g.name = 'Rebuilt' and st.name = 'Radio Button'
insert into Objective select g.id, 'aWin', 'Win Auto:', st.id, null, null, null, 3, getdate(), 'aWin', 'I', 'N', 'N', 3 from Game g, ScoringType st where g.name = 'Rebuilt' and st.name = 'Radio Button'
insert into Objective select g.id, 'toFuel', 'Fuel:', st.id, 0, 300, 1, 4, getdate(), 'toFuel', 'I', 'N', 'N', 4 from Game g, ScoringType st where g.name = 'Rebuilt' and st.name = 'Integer'
insert into Objective select g.id, 'toClimb', 'Climb:', st.id, null, null, null, 5, getdate(), 'toClimb', 'S', 'N', 'N', 5 from Game g, ScoringType st where g.name = 'Rebuilt' and st.name = 'Radio Button'
insert into Objective select g.id, 'toEGTime', 'Climb Time:', st.id, 0, 45, null, 6, getdate(), 'EGTime', 'I', 'N', 'N', 6 from Game g, ScoringType st where g.name = 'Rebuilt' and st.name = 'Integer'
insert into Objective select g.id, 'toDefense', 'Defense (0=None, 1=Poor to 4=Great):', st.id, null, null, null, 7, getdate(), 'Def', 'I', 'N', 'N', 7 from Game g, ScoringType st where g.name = 'Rebuilt' and st.name = 'Radio Button'
insert into Objective select g.id, 'Rating', 'How would you rate the robot (0-10)? (Gracious Professionalism):', st.id, null, null, null, 8, getdate(), 'Rate', 'I', 'N', 'N', 8 from Game g, ScoringType st where g.name = 'Rebuilt' and st.name = 'Radio Button'

-- Objective Value
insert into ObjectiveValue select o.id, 'None', 0, 1, 0, getdate(), 'N', 'None', null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Rebuilt' and o.name = 'aClimb'
insert into ObjectiveValue select o.id, 'R1', 1, 2, 15, getdate(), 'Y', 'R1', null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Rebuilt' and o.name = 'aClimb'
insert into ObjectiveValue select o.id, 'No', 0, 1, 0, getdate(), 'N', 'No', null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Rebuilt' and o.name = 'aWin'
insert into ObjectiveValue select o.id, 'Yes', 1, 2, 0, getdate(), 'Y', 'Yes', null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Rebuilt' and o.name = 'aWin'
insert into ObjectiveValue select o.id, 'None', 0, 1, 0, getdate(), 'N', 'None', null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Rebuilt' and o.name = 'toClimb'
insert into ObjectiveValue select o.id, 'R1', 1, 2, 10, getdate(), 'Y', 'R1', null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Rebuilt' and o.name = 'toClimb'
insert into ObjectiveValue select o.id, 'R2', 2, 3, 20, getdate(), 'N', 'R2', null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Rebuilt' and o.name = 'toClimb'
insert into ObjectiveValue select o.id, 'R3', 3, 4, 30, getdate(), 'Y', 'R3', null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Rebuilt' and o.name = 'toClimb'
insert into ObjectiveValue select o.id, '0', null, 1, null, getdate(), 'N', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Rebuilt' and o.name = 'toDefense'
insert into ObjectiveValue select o.id, '1', 1, 2, 0, getdate(), 'Y', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Rebuilt' and o.name = 'toDefense'
insert into ObjectiveValue select o.id, '2', 2, 3, 0, getdate(), 'Y', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Rebuilt' and o.name = 'toDefense'
insert into ObjectiveValue select o.id, '3', 3, 4, 0, getdate(), 'Y', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Rebuilt' and o.name = 'toDefense'
insert into ObjectiveValue select o.id, '4', 4, 5, 0, getdate(), 'Y', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Rebuilt' and o.name = 'toDefense'
insert into ObjectiveValue select o.id, 'Bypassed 0', 0, 1, 0, getdate(), 'N', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Rebuilt' and o.name = 'Rating'
insert into ObjectiveValue select o.id, 'Below...... 1', 1, 2, 0, getdate(), 'N', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Rebuilt' and o.name = 'Rating'
insert into ObjectiveValue select o.id, '2', 2, 3, 0, getdate(), 'Y', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Rebuilt' and o.name = 'Rating'
insert into ObjectiveValue select o.id, '3', 3, 4, 0, getdate(), 'Y', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Rebuilt' and o.name = 'Rating'
insert into ObjectiveValue select o.id, 'Average.. 4', 4, 5, 0, getdate(), 'N', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Rebuilt' and o.name = 'Rating'
insert into ObjectiveValue select o.id, '5', 5, 6, 0, getdate(), 'Y', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Rebuilt' and o.name = 'Rating'
insert into ObjectiveValue select o.id, '6', 6, 7, 0, getdate(), 'Y', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Rebuilt' and o.name = 'Rating'
insert into ObjectiveValue select o.id, 'Above...... 7', 7, 8, 0, getdate(), 'N', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Rebuilt' and o.name = 'Rating'
insert into ObjectiveValue select o.id, '8', 8, 9, 0, getdate(), 'Y', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Rebuilt' and o.name = 'Rating'
insert into ObjectiveValue select o.id, '9', 9, 10, 0, getdate(), 'Y', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Rebuilt' and o.name = 'Rating'
insert into ObjectiveValue select o.id, 'SuperBot 10', 10, 11, 0, getdate(), 'N', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Rebuilt' and o.name = 'Rating'

-- Objective Group Objectives
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Rebuilt' and o.name = 'aFuel' and og.name = 'Autonomous' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Rebuilt' and o.name = 'aClimb' and og.name = 'Autonomous' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Rebuilt' and o.name = 'aWin' and og.name = 'Autonomous' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Rebuilt' and o.name = 'toFuel' and og.name = 'Tele Op' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Rebuilt' and o.name = 'toClimb' and og.name = 'Tele Op' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Rebuilt' and o.name = 'toEGTime' and og.name = 'End Game' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Rebuilt' and o.name = 'toDefense' and og.name = 'End Game' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Rebuilt' and o.name = 'Rating' and og.name = 'End Game' and og.groupCode = 'Scout Match'

insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Rebuilt' and o.name = 'aFuel' and og.name = 'Autonomous' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Rebuilt' and o.name = 'aClimb' and og.name = 'Autonomous' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Rebuilt' and o.name = 'toFuel' and og.name = 'TeleOp' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Rebuilt' and o.name = 'toClimb' and og.name = 'End Game' and og.groupCode = 'Report Pie Chart'

insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Rebuilt' and o.name = 'aFuel' and og.name = 'Autonomous' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Rebuilt' and o.name = 'aClimb' and og.name = 'Autonomous' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Rebuilt' and o.name = 'toFuel' and og.name = 'TeleOp' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Rebuilt' and o.name = 'toClimb' and og.name = 'End Game' and og.groupCode = 'Report Line Graph'

-- Ranks
insert into Rank select 'Auto', 'rankAuto', 'S', 1, getdate(), g.id, 'N' from Game g where g.name = 'Rebuilt'
insert into Rank select 'Fuel', 'rankFuel', 'S', 2, getdate(), g.id, 'N' from Game g where g.name = 'Rebuilt'
insert into Rank select 'Tower', 'rankTower', 'S', 3, getdate(), g.id, 'N' from Game g where g.name = 'Rebuilt'
insert into Rank select 'Defense', 'rankPlayedDefense', 'V', 4, getdate(), g.id, 'N' from Game g where g.name = 'Rebuilt'
insert into Rank select 'Scr Imp', 'rankScoreImpact', 'S', 5, getdate(), g.id, 'Y' from Game g where g.name = 'Rebuilt'

-- Rank Objective
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Rebuilt' and o.name = 'aFuel' and r.name = 'Auto'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Rebuilt' and o.name = 'aClimb' and r.name = 'Auto'

insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Rebuilt' and o.name = 'aFuel' and r.name = 'Fuel'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Rebuilt' and o.name = 'toFuel' and r.name = 'Fuel'

insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Rebuilt' and o.name = 'aClimb' and r.name = 'Tower'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Rebuilt' and o.name = 'toClimb' and r.name = 'Tower'

insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Rebuilt' and o.name = 'toDefense' and r.name = 'Defense'

insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Rebuilt' and o.name = 'aFuel' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Rebuilt' and o.name = 'aClimb' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Rebuilt' and o.name = 'toFuel' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Rebuilt' and o.name = 'toClimb' and r.name = 'Scr Imp'

select * from scout

-- Scout
update Scout set isActive = 'N' where teamId in (select id from Team where teamNumber = 6217) and isActive <> 'N' and lastname + firstname not in ('CoyleJoe', 'EngebretsenDave', 'StarkCharlie','TBA', '(Choose Scout)','zzBomb BotzScout');
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Bray', 'Graham', t.id, 'Y', '26gb01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Bray' and s.firstName = 'Graham' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Conway', 'Mackston', t.id, 'Y', '29mc01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Conway' and s.firstName = 'Mackston' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Dettmann', 'Madison', t.id, 'Y', '26md01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Dettmann' and s.firstName = 'Madison' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Endres', 'Matthew', t.id, 'Y', '29me01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Endres' and s.firstName = 'Matthew' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Flodeen', 'Henry', t.id, 'Y', '29hf01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Flodeen' and s.firstName = 'Henry' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Gibbs', 'Gus', t.id, 'Y', '29ag01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Gibbs' and s.firstName = 'Gus' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Hall', 'Kaidan', t.id, 'Y', '29kh01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Hall' and s.firstName = 'Kaidan' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Hernke', 'Ava', t.id, 'Y', '27ah02@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Hernke' and s.firstName = 'Ava' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Iverson', 'Riley', t.id, 'Y', '27ri01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Iverson' and s.firstName = 'Riley' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Kammerude', 'Hades', t.id, 'Y', '28lk01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Kammerude' and s.firstName = 'Hades' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Lindquist', 'Rylan', t.id, 'Y', '26rl01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Lindquist' and s.firstName = 'Rylan' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Maki', 'Gunnar', t.id, 'Y', '27gm01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Maki' and s.firstName = 'Gunnar' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Medcraft', 'Makenzie', t.id, 'Y', '27mm03@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Medcraft' and s.firstName = 'Makenzie' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Medcraft', 'Sebastian', t.id, 'Y', '29sm01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Medcraft' and s.firstName = 'Sebastian' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Otterness', 'Edmon', t.id, 'Y', '29eo01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Otterness' and s.firstName = 'Edmon' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Propst', 'Addy', t.id, 'Y', '28ap04@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Propst' and s.firstName = 'Addy' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Rezac', 'Kaeda', t.id, 'Y', '27kr01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Rezac' and s.firstName = 'Kaeda' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Stark', 'Avery', t.id, 'Y', '27as02@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Stark' and s.firstName = 'Avery' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Zheng', 'William', t.id, 'Y', '27wz01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Zheng' and s.firstName = 'William' and s.teamId = t.id);

/*
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'zzRobettes', 'Scout', t.id, 'Y', 'xx@xx.com', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'zzRobettes' and s.firstName = 'Scout' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'zzWind Chill', 'Scout', t.id, 'Y', 'xx@xx.com', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'zzWind Chill' and s.firstName = 'Scout' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'zzNoMythic', 'Scout', t.id, 'Y', 'xx@xx.com', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'zzNoMythic' and s.firstName = 'Scout' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'a Robo', 'Raider', t.id, 'Y', 'xx@xx.com', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'a Robo' and s.firstName = 'Raider' and s.teamId = t.id);
*/

update Scout set isActive = 'Y' where isActive <> 'Y' and lastName = 'Bray' and firstName = 'Graham' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where isActive <> 'Y' and lastName = 'Conway' and firstName = 'Mackston' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where isActive <> 'Y' and lastName = 'Dettmann' and firstName = 'Madison' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where isActive <> 'Y' and lastName = 'Endres' and firstName = 'Matthew' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where isActive <> 'Y' and lastName = 'Flodeen' and firstName = 'Henry' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where isActive <> 'Y' and lastName = 'Gibbs' and firstName = 'Gus' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where isActive <> 'Y' and lastName = 'Hall' and firstName = 'Kaidan' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where isActive <> 'Y' and lastName = 'Hernke' and firstName = 'Ava' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where isActive <> 'Y' and lastName = 'Iverson' and firstName = 'Riley' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where isActive <> 'Y' and lastName = 'Kammerude' and firstName = 'Hades' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where isActive <> 'Y' and lastName = 'Lindquist' and firstName = 'Rylan' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where isActive <> 'Y' and lastName = 'Maki' and firstName = 'Gunnar' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where isActive <> 'Y' and lastName = 'Medcraft' and firstName = 'Makenzie' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where isActive <> 'Y' and lastName = 'Medcraft' and firstName = 'Sebastian' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where isActive <> 'Y' and lastName = 'Otterness' and firstName = 'Edmon' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where isActive <> 'Y' and lastName = 'Propst' and firstName = 'Addy' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where isActive <> 'Y' and lastName = 'Rezac' and firstName = 'Kaeda' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where isActive <> 'Y' and lastName = 'Stark' and firstName = 'Avery' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where isActive <> 'Y' and lastName = 'Zheng' and firstName = 'William' and teamId = (select id from Team where teamNumber = 6217);

update Scout set isAdmin = 'N' where isActive = 'N' and isAdmin = 'Y';

-- Sponsors 2026
-- delete from teamSponsor where gameid in (select g.id from game g where g.name = 'Rebuilt')
insert into TeamSponsor select t.id, g.id, 'Gemini Signworks', 1, 10, 'Sponsors/Gemini.jpg', 'https://geminimade.com/', 50, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'VFW Post 4452', 0, 13, 'Sponsors/VFW.jpg', 'https://cannonfallsvfw.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'American Legion Post 142', 0, 15, 'Sponsors/AmericanLegion.png', 'https://www.facebook.com/CannonFallsAmericanLegionPost142/', 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'Aliveo Military Museum', 0, 20, 'Sponsors/AliveoMilitaryMuseum.jpg', 'http://www.aliveomuseum.org/', 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'Gene Haas Foundation', 0, 25, 'Sponsors/GeneHaasFoundation.png', 'https://www.ghaasfoundation.org//', 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'Cannon Falls Fire Department', 0, 26, 'Sponsors/CF Fire Department.jpg', 'https://www.cannonfallsmn.gov/fire', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
--insert into TeamSponsor select t.id, g.id, 'Argosy Foundation', 0, 28, 'Sponsors/ArgosyFoundation_Logo_CMYK.jpg', 'https://www.argosyfnd.org/', 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'Hernke Heating', 0, 30, 'Sponsors/hernkes heating and cooling.png', null, 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
--insert into TeamSponsor select t.id, g.id, 'BARR', 0, 35, 'Sponsors/BARRblue.png', 'https://barr.com/', 50, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'Flex Craft', 0, 40, 'Sponsors/flex craft logo.png', 'https://flex-craft.com/', 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'Jim Althoff Real Estate', 0, 45, 'Sponsors/JimAlthoffRealEstate.jpeg', 'https://www.facebook.com/JimAlthoffRealtor/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'Quality One Woodworking', 0, 50, 'Sponsors/QualityOne.png', 'https://www.qualityonewoodwork.com/', 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'StarTech Computing', 0, 60, 'Sponsors/StarTech-logo.png', 'https://www.startech-comp.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'Milwaukee Tool', 0, 70, 'Sponsors/Milwaukee.jpg', 'https://www.milwaukeetool.com/', 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
--insert into TeamSponsor select t.id, g.id, 'Red Wing Area Manufacturers Association', 0, 80, 'Sponsors/RW Area Mfg Assoc.jpg', 'https://www.facebook.com/RWAreaMfrsAssoc/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
--insert into TeamSponsor select t.id, g.id, 'Auto Value', 0, 85, 'Sponsors/autovalueps.jpg', 'https://autovaluestores.com/ellsworth/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'Caseys', 0, 90, 'Sponsors/Casey_s.png', 'https://www.caseys.com/', 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
--insert into TeamSponsor select t.id, g.id, 'Swan and Bower', 0, 100, 'Sponsors/SwanAndBower.png', 'https://www.swanandbower.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
--insert into TeamSponsor select t.id, g.id, 'Brewster''s Bar & Grill', 0, 150, null, null, 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
--insert into TeamSponsor select t.id, g.id, 'Chuck & Carrie Olson', 0, 180, null, null, 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'Twist Solutions', 0, 190, null, null, 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
--insert into TeamSponsor select t.id, g.id, 'Jack Schlicting', 0, 200, null, null, 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
update teamSponsor set maxWidthPercent = 10 where gameid = (select id from game where name = 'Rebuilt') and sortOrder = 15 -- American Legion
update teamSponsor set maxWidthPercent = 40 where gameid = (select id from game where name = 'Rebuilt') and sortOrder = 20 -- Aliveo
update teamSponsor set maxWidthPercent = 15 where gameid = (select id from game where name = 'Rebuilt') and sortOrder = 25 -- Haas
update teamSponsor set maxWidthPercent = 10 where gameid = (select id from game where name = 'Rebuilt') and sortOrder = 26 -- CFFD
update teamSponsor set maxWidthPercent = 15 where gameid = (select id from game where name = 'Rebuilt') and sortOrder = 30 -- Hernke
update teamSponsor set maxWidthPercent = 30 where gameid = (select id from game where name = 'Rebuilt') and sortOrder = 35 -- BARR
update teamSponsor set maxWidthPercent = 40 where gameid = (select id from game where name = 'Rebuilt') and sortOrder = 40 -- FlexCraft
update teamSponsor set maxWidthPercent = 15 where gameid = (select id from game where name = 'Rebuilt') and sortOrder = 45 -- Jim ALthoff
update teamSponsor set maxWidthPercent = 20 where gameid = (select id from game where name = 'Rebuilt') and sortOrder = 60 -- StarTech
update teamSponsor set maxWidthPercent = 12 where gameid = (select id from game where name = 'Rebuilt') and sortOrder = 85 -- Auto Value
update teamSponsor set maxWidthPercent = 10 where gameid = (select id from game where name = 'Rebuilt') and sortOrder = 90 -- Caseys
update teamSponsor set maxWidthPercent = 10 where gameid = (select id from game where name = 'Rebuilt') and sortOrder = 100 -- Swan & Bower

/*
-- Sponsors 2024
insert into TeamSponsor select t.id, g.id, 'CF Education Foundation', 0, 20, 'Sponsors/CF Ed Foundation.jpg', 'https://www.cannonfallsschools.com/community/education_foundation', 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'Oldcastle Infrastructure', 0, 50, 'Sponsors/Oldcastle_Infrastructure_Logo.jpg', 'https://oldcastleinfrastructure.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'Remax Realty', 0, 60, 'Sponsors/REMAX.png', 'https://www.remax.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, '3M', 0, 110, 'Sponsors/3M.png', 'https://www.3m.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'Highland Sanitation', 0, 130, 'Sponsors/HighlandSanitation.png', 'https://www.highlandsanitation.com', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'Master CAM', 0, 140, 'Sponsors/mastercam_logo.png', 'https://www.mastercam.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'Sjoquist Hay and Straw', 0, 160, 'Sponsors/SjoquistHayAndStraw.jpg', 'https://www.facebook.com/SjoquistHayandStraw/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'Snap Fitness', 0, 170, 'Sponsors/Snap Fitness.jpg', 'https://www.snapfitness.com/us/gyms/cannon-falls-mn', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'Community Resource Bank', 0, 190, 'Sponsors/CommunityResourceBank.jpg', 'https://crb.bank/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'Interstate Building Supply', 0, 200, 'Sponsors/InterstateBuildingSupply.png', 'https://www.interstatebuildingsupply.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'Cannon Falls Rotary', 0, 220, 'Sponsors/Rotary.jpg', 'https://www.facebook.com/Cannonfallsrotary/', 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'Midwest Machinery - John Deere', 0, 230, 'Sponsors/midwest machinery.png', 'https://mmcjd.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'Northlands Safety Solution', 0, 250, 'Sponsors/Northland Safety logo.png', 'https://www.northlandsafety.com/', 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'MN Woodcraft', 0, 255, 'Sponsors/MN Woodcraft.jpg', 'https://mnwoodcraft.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'Lorentz Meats', 0, 260, 'Sponsors/LorentzMeats.jpg', 'https://lorentzmeats.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'Cannon Falls Lions', 0, 271, 'Sponsors/Lions.jpg', 'https://www.facebook.com/cannonfallslionsclub/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'Ace Hardware', 0, 272, 'Sponsors/AceHardware.png', 'https://www.acehardware.com/store-details/14225', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'Liberty Tax', 0, 275, 'Sponsors/Liberty.jpg', 'https://www.libertytax.com/income-tax-preparation-locations/minnesota/cannon-falls/14375', 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'Cannon River Catering', 0, 276, 'Sponsors/Cannon River Catering.png', 'https://www.cannonrivercatering.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'Small Engine Service', 0, 278, 'Sponsors/SmallEngineService.jpg', 'https://www.smallengineservicewelch.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'Guhring', 0, 300, 'Sponsors/gurhing.png', 'https://www.guhring.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'J&J Aircraft Maint and Consulting', 0, 310, null, null, 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'Busy Bee Honey Farm', 0, 320, null, null, 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'Seed Plus', 0, 330, null, null, 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'Ron & Marcia Freeburg', 0, 340, null, null, 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'Strike Tool Products', 0, 345, null, 'https://www.striketool.com/', 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'Fastenal Company Purchasing', 0, 350, null, null, 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'Mark & Cindy Sjoquist', 0, 360, null, null, 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';
insert into TeamSponsor select t.id, g.id, 'Barbara McGeough', 0, 370, null, null, 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Rebuilt';

update teamSponsor set maxWidthPercent = 10 where gameid = 7 and sortOrder = 20 -- CFEF
update teamSponsor set maxWidthPercent = 20 where gameid = 7 and sortOrder = 50 -- Old Castle
update teamSponsor set maxWidthPercent = 15 where gameid = 7 and sortOrder = 60 -- ReMax
update teamSponsor set maxWidthPercent = 10 where gameid = 7 and sortOrder = 110 -- 3M
update teamSponsor set maxWidthPercent = 20 where gameid = 7 and sortOrder = 120 -- Flex Craft
update teamSponsor set maxWidthPercent = 20 where gameid = 7 and sortOrder = 130 -- Highland Sanitation
update teamSponsor set maxWidthPercent = 20 where gameid = 7 and sortOrder = 140 -- Master CAM
update teamSponsor set maxWidthPercent = 25 where gameid = 7 and sortOrder = 150 -- Quality One
update teamSponsor set maxWidthPercent = 15 where gameid = 7 and sortOrder = 160 -- Sjoquist
update teamSponsor set maxWidthPercent = 15 where gameid = 7 and sortOrder = 170 -- Snap
update teamSponsor set maxWidthPercent = 20 where gameid = 7 and sortOrder = 190 -- CRB
update teamSponsor set maxWidthPercent = 10 where gameid = 7 and sortOrder = 220 -- CF Rotary
update teamSponsor set maxWidthPercent = 10 where gameid = 7 and sortOrder = 230 -- Midwest Machinery
update teamSponsor set maxWidthPercent = 15 where gameid = 7 and sortOrder = 255 -- MN Woodcraft
update teamSponsor set maxWidthPercent = 10 where gameid = 7 and sortOrder = 260 -- Lorentz
update teamSponsor set maxWidthPercent = 20 where gameid = 7 and sortOrder = 271 -- Lions
update teamSponsor set maxWidthPercent = 20 where gameid = 7 and sortOrder = 272 -- ACE Hardware
update teamSponsor set maxWidthPercent = 20 where gameid = 7 and sortOrder = 275 -- Liberty Tax
update teamSponsor set maxWidthPercent = 15 where gameid = 7 and sortOrder = 276 -- Cannon River Catering
update teamSponsor set maxWidthPercent = 10 where gameid = 7 and sortOrder = 278 -- Small Engine Service
update teamSponsor set maxWidthPercent = 15 where gameid = 7 and sortOrder = 300 -- Guhring
*/
