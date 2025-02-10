/* Clear data
delete from teamAttribute where attributeId in (select a.id from Attribute a inner join Game g on g.id = a.gameId where g.name = 'Reefscape');
delete from teamMatch where matchId in (select m.id from Game g inner join gameEvent ge on g.id = ge.gameId inner join match m on m.gameEventId = ge.id where g.name = 'Reefscape');
delete from ScoutRecord where matchId in (select m.id from Game g inner join gameEvent ge on g.id = ge.gameId inner join match m on m.gameEventId = ge.id where g.name = 'Reefscape');

delete from AttributeValue where attributeId in (select a.id from Attribute a inner join Game g on g.id = a.gameId where g.name = 'Reefscape');
delete from Attribute where gameId in (select g.id from Game g where g.name = 'Reefscape');

delete from RankObjective where rankId in (select r.id from Rank r inner join Game g on g.id = r.gameId where g.name = 'Reefscape');
delete from Rank where gameId in (select g.id from Game g where g.name = 'Reefscape');

delete from ObjectiveGroupObjective where objectiveId in (select o.id from Objective o inner join Game g on g.id = o.gameId where g.name = 'Reefscape');
delete from ObjectiveValue where objectiveId in (select o.id from Objective o inner join Game g on g.id = o.gameId where g.name = 'Reefscape');
delete from Objective where gameId in (select g.id from Game g where g.name = 'Reefscape');

delete from game where name = 'Reefscape';
*/

-- Game
insert into Game (name, gameYear, tbaCoopMet, tbaCoopAchieved) values ('Reefscape', 2025, 'coopertitionCriteriaMet', 'coopertitionBonusAchieved');

-- Game Ranking Points
insert into GameRankingPoint select g.id, 1, 'Auto', 'ARP', 'autoBonusAchieved', getdate() from Game g where g.name = 'Reefscape'
insert into GameRankingPoint select g.id, 2, 'Coral', 'CRP', 'cargoBonusAchieved', getdate() from Game g where g.name = 'Reefscape'
insert into GameRankingPoint select g.id, 3, 'Barge', 'BRP', 'bargeBonusAchieved', getdate() from Game g where g.name = 'Reefscape'

-- Attributes
insert into Attribute select g.id, 'name', 'What''s your name?', st.id, null, null, 1, getdate(), 'Name', 'N', '<Enter Name Here>' from Game g, ScoringType st where g.name = 'Reefscape' and st.name = 'Free Form'
insert into Attribute select g.id, 'role', 'What''s your role on the team?', st.id, null, null, 2, getdate(), 'Role', 'N', 'Drive Team' from Game g, ScoringType st where g.name = 'Reefscape' and st.name = 'Free Form'
insert into Attribute select g.id, 'driveTrain', 'What drivetrain is robot using?', st.id, null, null, 3, getdate(), 'Drive Train', 'N', null from Game g, ScoringType st where g.name = 'Reefscape' and st.name = 'Radio Button'
insert into Attribute select g.id, 'robotWidth', 'Width of robot with bumpers (inches)?', st.id, null, null, 4, getdate(), 'Width', 'N', null from Game g, ScoringType st where g.name = 'Reefscape' and st.name = 'Integer'
insert into Attribute select g.id, 'robotWeight', 'Weight of robot?', st.id, null, null, 5, getdate(), 'Weight', 'N', null from Game g, ScoringType st where g.name = 'Reefscape' and st.name = 'Integer'
insert into Attribute select g.id, 'coralPickup', 'How does robot attain Coral?', st.id, null, null, 6, getdate(), 'Coral', 'N', null from Game g, ScoringType st where g.name = 'Reefscape' and st.name = 'Radio Button'
insert into Attribute select g.id, 'algaePickup', 'How does robot attain Algae?', st.id, null, null, 7, getdate(), 'Algae', 'N', null from Game g, ScoringType st where g.name = 'Reefscape' and st.name = 'Radio Button'
insert into Attribute select g.id, 'autoLeave', 'Do you have an autonomous program to leave start line?', st.id, null, null, 8, getdate(), 'Leave', 'N', null from Game g, ScoringType st where g.name = 'Reefscape' and st.name = 'Radio Button'
insert into Attribute select g.id, 'preferredStart', 'What is preferred start location?', st.id, null, null, 9, getdate(), 'Pref Start', 'N', null from Game g, ScoringType st where g.name = 'Reefscape' and st.name = 'Radio Button'
insert into Attribute select g.id, 'flexibleStart', 'Does autonomous program allow for flexible start location?', st.id, null, null, 10, getdate(), 'Flex Start', 'N', null from Game g, ScoringType st where g.name = 'Reefscape' and st.name = 'Radio Button'
insert into Attribute select g.id, 'autoNow', 'Describe current autonomous program movement?', st.id, null, null, 11, getdate(), 'Auto Now', 'N', 'Drive off Start Line' from Game g, ScoringType st where g.name = 'Reefscape' and st.name = 'Free Form'
insert into Attribute select g.id, 'AutoPlan', 'Describe any plans for changes to autonomous movement?', st.id, null, null, 12, getdate(), 'Auto Plan', 'N', 'Drop Off Coral' from Game g, ScoringType st where g.name = 'Reefscape' and st.name = 'Free Form'
insert into Attribute select g.id, 'coralScore', 'Which levels can your robot score coral?', st.id, null, null, 13, getdate(), 'Coral Levels', 'N', null from Game g, ScoringType st where g.name = 'Reefscape' and st.name = 'Radio Button'
insert into Attribute select g.id, 'algaeScore', 'Which locations can your robot score algae?', st.id, null, null, 14, getdate(), 'Algae Score', 'N', null from Game g, ScoringType st where g.name = 'Reefscape' and st.name = 'Radio Button'
insert into Attribute select g.id, 'endGamePlane', 'What is your end game plan?', st.id, null, null, 15, getdate(), 'End Game', 'N', null from Game g, ScoringType st where g.name = 'Reefscape' and st.name = 'Radio Button'
insert into Attribute select g.id, 'climbTime', 'Expected climb time (seconds)?', st.id, null, null, 16, getdate(), 'Climb', 'N', null from Game g, ScoringType st where g.name = 'Reefscape' and st.name = 'Integer'
insert into Attribute select g.id, 'coopertition', 'Does your strategy include engaging in the Coopertition bonus?', st.id, null, null, 17, getdate(), 'Coopertition', 'N', null from Game g, ScoringType st where g.name = 'Reefscape' and st.name = 'Radio Button'

-- Attribute Values
insert into AttributeValue select a.id, 'Tank', 0, 1, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'driveTrain';
insert into AttributeValue select a.id, 'Tank with Omni', 1, 2, getdate(), 'Y', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'driveTrain';
insert into AttributeValue select a.id, 'Swerve', 2, 3, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'driveTrain';
insert into AttributeValue select a.id, 'Mecanum', 3, 4, getdate(), 'Y', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'driveTrain';
insert into AttributeValue select a.id, 'Kiwi', 4, 5, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'driveTrain';
insert into AttributeValue select a.id, 'Other', 5, 6, getdate(), 'Y', 'Y' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'driveTrain';
insert into AttributeValue select a.id, 'No', 0, 1, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'autoLeave';
insert into AttributeValue select a.id, 'Yes', 2, 3, getdate(), 'Y', 'Y' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'autoLeave';
insert into AttributeValue select a.id, 'Neither', 0, 1, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'coralPickup';
insert into AttributeValue select a.id, 'Both', 1, 2, getdate(), 'Y', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'coralPickup';
insert into AttributeValue select a.id, 'Off Floor', 2, 3, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'coralPickup';
insert into AttributeValue select a.id, 'Station', 3, 4, getdate(), 'Y', 'Y' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'coralPickup';
insert into AttributeValue select a.id, 'Neither', 0, 1, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'AlgaePickup';
insert into AttributeValue select a.id, 'Both', 1, 2, getdate(), 'Y', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'AlgaePickup';
insert into AttributeValue select a.id, 'Off Floor', 2, 3, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'AlgaePickup';
insert into AttributeValue select a.id, 'Reef', 3, 4, getdate(), 'Y', 'Y' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'AlgaePickup';
insert into AttributeValue select a.id, 'No Preference', 0, 1, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'preferredStart';
insert into AttributeValue select a.id, 'Start Line Mid', 1, 2, getdate(), 'Y', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'preferredStart';
insert into AttributeValue select a.id, 'Start Line Left', 2, 3, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'preferredStart';
insert into AttributeValue select a.id, 'Start Line Right', 3, 4, getdate(), 'Y', 'Y' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'preferredStart';
insert into AttributeValue select a.id, 'No', 0, 1, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'flexibleStart';
insert into AttributeValue select a.id, 'Yes', 1, 2, getdate(), 'Y', 'Y' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'flexibleStart';
insert into AttributeValue select a.id, 'None', 0, 1, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'coralScore';
insert into AttributeValue select a.id, 'All', 1, 2, getdate(), 'Y', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'coralScore';
insert into AttributeValue select a.id, '1', 2, 3, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'coralScore';
insert into AttributeValue select a.id, '2', 3, 4, getdate(), 'Y', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'coralScore';
insert into AttributeValue select a.id, '3', 4, 5, getdate(), 'Y', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'coralScore';
insert into AttributeValue select a.id, '4', 5, 6, getdate(), 'Y', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'coralScore';
insert into AttributeValue select a.id, '1, 2', 6, 7, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'coralScore';
insert into AttributeValue select a.id, '1, 2, 3', 7, 8, getdate(), 'Y', 'Y' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'coralScore';
insert into AttributeValue select a.id, 'None', 0, 1, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'algaeScore';
insert into AttributeValue select a.id, 'Processor', 1, 2, getdate(), 'Y', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'algaeScore';
insert into AttributeValue select a.id, 'Barge Net', 2, 3, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'algaeScore';
insert into AttributeValue select a.id, 'Both', 3, 4, getdate(), 'Y', 'Y' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'algaeScore';
insert into AttributeValue select a.id, 'Continue Scoring', 0, 1, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'endGamePlane';
insert into AttributeValue select a.id, 'Park', 1, 2, getdate(), 'Y', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'endGamePlane';
insert into AttributeValue select a.id, 'Shallow Cage', 2, 3, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'endGamePlane';
insert into AttributeValue select a.id, 'Deep Cage', 3, 4, getdate(), 'Y', 'Y' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'endGamePlane';
insert into AttributeValue select a.id, 'Always', 0, 1, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'coopertition';
insert into AttributeValue select a.id, 'Never', 1, 2, getdate(), 'Y', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'coopertition';
insert into AttributeValue select a.id, 'Depends on Alliance Partners', 2, 3, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'coopertition';
insert into AttributeValue select a.id, 'Requires agreement from opponent', 3, 4, getdate(), 'N', 'Y' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Reefscape' and a.name = 'coopertition';

-- Objectives
insert into Objective select g.id, 'aL1', 'Coral L1:', st.id, 0, 6, 3, 1, getdate(), 'aL1', 'I', 'N', 'N', 2 from Game g, ScoringType st where g.name = 'Reefscape' and st.name = 'Integer'
insert into Objective select g.id, 'aL2', 'L2:', st.id, 0, 6, 4, 2, getdate(), 'aL2', 'I', 'Y', 'N', 3 from Game g, ScoringType st where g.name = 'Reefscape' and st.name = 'Integer'
insert into Objective select g.id, 'aL3', '.......... L3:', st.id, 0, 6, 6, 3, getdate(), 'aL3', 'I', 'N', 'N', 4 from Game g, ScoringType st where g.name = 'Reefscape' and st.name = 'Integer'
insert into Objective select g.id, 'aL4', 'L4:', st.id, 0, 6, 7, 4, getdate(), 'aL4', 'I', 'Y', 'N', 5 from Game g, ScoringType st where g.name = 'Reefscape' and st.name = 'Integer'
insert into Objective select g.id, 'aProc', 'Algae Proc:', st.id, 0, 6, 6, 5, getdate(), 'aProc', 'I', 'N', 'N', 6 from Game g, ScoringType st where g.name = 'Reefscape' and st.name = 'Integer'
insert into Objective select g.id, 'aNet', 'Net:', st.id, 0, 6, 4, 6, getdate(), 'aNet', 'I', 'Y', 'N', 7 from Game g, ScoringType st where g.name = 'Reefscape' and st.name = 'Integer'
insert into Objective select g.id, 'toL1', 'Coral L1:', st.id, 0, 12, 2, 7, getdate(), 'toL1', 'I', 'N', 'N', 8 from Game g, ScoringType st where g.name = 'Reefscape' and st.name = 'Integer'
insert into Objective select g.id, 'toL2', 'L2:', st.id, 0, 12, 3, 8, getdate(), 'toL2', 'I', 'Y', 'N', 9 from Game g, ScoringType st where g.name = 'Reefscape' and st.name = 'Integer'
insert into Objective select g.id, 'toL3', '.......... L3:', st.id, 0, 12, 4, 9, getdate(), 'toL3', 'I', 'N', 'N', 10 from Game g, ScoringType st where g.name = 'Reefscape' and st.name = 'Integer'
insert into Objective select g.id, 'toL4', 'L4:', st.id, 0, 12, 5, 10, getdate(), 'toL4', 'I', 'Y', 'N', 11 from Game g, ScoringType st where g.name = 'Reefscape' and st.name = 'Integer'
insert into Objective select g.id, 'toProc', 'Algae Proc:', st.id, 0, 9, 6, 11, getdate(), 'toProc', 'I', 'N', 'N', 12 from Game g, ScoringType st where g.name = 'Reefscape' and st.name = 'Integer'
insert into Objective select g.id, 'toNet', 'Net:', st.id, 0, 18, 4, 12, getdate(), 'toNet', 'I', 'Y', 'N', 13 from Game g, ScoringType st where g.name = 'Reefscape' and st.name = 'Integer'
insert into Objective select g.id, 'toDefense', 'Defense (0=None, 1=Poor to 4=Great):', st.id, null, null, null, 13, getdate(), 'Def', 'I', 'N', 'N', 15 from Game g, ScoringType st where g.name = 'Reefscape' and st.name = 'Radio Button'
insert into Objective select g.id, 'aLeave', 'Leave:', st.id, null, null, null, 14, getdate(), 'aLeave', 'S', 'N', 'N', 1 from Game g, ScoringType st where g.name = 'Reefscape' and st.name = 'Radio Button'
insert into Objective select g.id, 'toEnd', 'Barge:', st.id, null, null, null, 15, getdate(), 'Barge', 'S', 'N', 'N', 15 from Game g, ScoringType st where g.name = 'Reefscape' and st.name = 'Radio Button'
insert into Objective select g.id, 'Rating', 'How would you rate the robot (0-10)? (Gracious Professionalism):', st.id, null, null, null, 16, getdate(), 'Rate', 'I', 'N', 'N', 17 from Game g, ScoringType st where g.name = 'Reefscape' and st.name = 'Radio Button'

-- Objective Group Objectives
--insert into ObjectiveGroup values ('Blue Alliance Data', 5, getdate(), 'Scout Match');
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'aL1' and og.name = 'Autonomous' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'aL2' and og.name = 'Autonomous' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'aL3' and og.name = 'Autonomous' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'aL4' and og.name = 'Autonomous' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'aProc' and og.name = 'Autonomous' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'aNet' and og.name = 'Autonomous' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'toL1' and og.name = 'Tele Op' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'toL2' and og.name = 'Tele Op' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'toL3' and og.name = 'Tele Op' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'toL4' and og.name = 'Tele Op' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'toProc' and og.name = 'Tele Op' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'toNet' and og.name = 'Tele Op' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'toDefense' and og.name = 'End Game' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'Rating' and og.name = 'End Game' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'aLeave' and og.name = 'Blue Alliance Data' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'toEnd' and og.name = 'Blue Alliance Data' and og.groupCode = 'Scout Match'

insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'aLeave' and og.name = 'Autonomous' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'aL1' and og.name = 'Autonomous' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'aL2' and og.name = 'Autonomous' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'aL3' and og.name = 'Autonomous' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'aL4' and og.name = 'Autonomous' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'aProc' and og.name = 'Autonomous' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'aNet' and og.name = 'Autonomous' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'toL1' and og.name = 'TeleOp' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'toL2' and og.name = 'TeleOp' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'toL3' and og.name = 'TeleOp' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'toL4' and og.name = 'TeleOp' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'toProc' and og.name = 'TeleOp' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'toNet' and og.name = 'TeleOp' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'toEnd' and og.name = 'End Game' and og.groupCode = 'Report Pie Chart'

insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'aLeave' and og.name = 'Autonomous' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'aL1' and og.name = 'Autonomous' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'aL2' and og.name = 'Autonomous' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'aL3' and og.name = 'Autonomous' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'aL4' and og.name = 'Autonomous' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'aProc' and og.name = 'Autonomous' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'aNet' and og.name = 'Autonomous' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'toL1' and og.name = 'TeleOp' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'toL2' and og.name = 'TeleOp' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'toL3' and og.name = 'TeleOp' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'toL4' and og.name = 'TeleOp' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'toProc' and og.name = 'TeleOp' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'toNet' and og.name = 'TeleOp' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Reefscape' and o.name = 'toEnd' and og.name = 'End Game' and og.groupCode = 'Report Line Graph'

-- Objective Value
insert into ObjectiveValue select o.id, '0', null, 1, null, getdate(), 'N', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Reefscape' and o.name = 'toDefense'
insert into ObjectiveValue select o.id, '1', 1, 2, 0, getdate(), 'Y', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Reefscape' and o.name = 'toDefense'
insert into ObjectiveValue select o.id, '2', 2, 3, 0, getdate(), 'Y', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Reefscape' and o.name = 'toDefense'
insert into ObjectiveValue select o.id, '3', 3, 4, 0, getdate(), 'Y', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Reefscape' and o.name = 'toDefense'
insert into ObjectiveValue select o.id, '4', 4, 5, 0, getdate(), 'Y', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Reefscape' and o.name = 'toDefense'
insert into ObjectiveValue select o.id, 'No', 0, 1, 0, getdate(), 'N', 'No', null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Reefscape' and o.name = 'aLeave'
insert into ObjectiveValue select o.id, 'Yes', 3, 2, 3, getdate(), 'Y', 'Yes', null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Reefscape' and o.name = 'aLeave'
insert into ObjectiveValue select o.id, 'None', 0, 1, 0, getdate(), 'N', 'None', null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Reefscape' and o.name = 'toEnd'
insert into ObjectiveValue select o.id, 'Park', 1, 2, 2, getdate(), 'Y', 'Parked', null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Reefscape' and o.name = 'toEnd'
insert into ObjectiveValue select o.id, 'Shallow', 2, 3, 6, getdate(), 'N', 'Shallow', null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Reefscape' and o.name = 'toEnd'
insert into ObjectiveValue select o.id, 'Deep', 3, 4, 12, getdate(), 'Y', 'Deep', null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Reefscape' and o.name = 'toEnd'
insert into ObjectiveValue select o.id, 'Bypassed 0', 0, 1, 0, getdate(), 'N', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Reefscape' and o.name = 'Rating'
insert into ObjectiveValue select o.id, 'Below...... 1', 1, 2, 0, getdate(), 'N', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Reefscape' and o.name = 'Rating'
insert into ObjectiveValue select o.id, '2', 2, 3, 0, getdate(), 'Y', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Reefscape' and o.name = 'Rating'
insert into ObjectiveValue select o.id, '3', 3, 4, 0, getdate(), 'Y', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Reefscape' and o.name = 'Rating'
insert into ObjectiveValue select o.id, 'Average.. 4', 4, 5, 0, getdate(), 'N', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Reefscape' and o.name = 'Rating'
insert into ObjectiveValue select o.id, '5', 5, 6, 0, getdate(), 'Y', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Reefscape' and o.name = 'Rating'
insert into ObjectiveValue select o.id, '6', 6, 7, 0, getdate(), 'Y', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Reefscape' and o.name = 'Rating'
insert into ObjectiveValue select o.id, 'Above...... 7', 7, 8, 0, getdate(), 'N', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Reefscape' and o.name = 'Rating'
insert into ObjectiveValue select o.id, '8', 8, 9, 0, getdate(), 'Y', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Reefscape' and o.name = 'Rating'
insert into ObjectiveValue select o.id, '9', 9, 10, 0, getdate(), 'Y', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Reefscape' and o.name = 'Rating'
insert into ObjectiveValue select o.id, 'SuperBot 10', 10, 11, 0, getdate(), 'N', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Reefscape' and o.name = 'Rating'

-- Ranks
insert into Rank select 'Auto', 'rankAuto', 'S', 1, getdate(), g.id, 'N' from Game g where g.name = 'Reefscape'
insert into Rank select 'Coral', 'rankCoral', 'S', 2, getdate(), g.id, 'N' from Game g where g.name = 'Reefscape'
insert into Rank select 'Algae', 'rankAlgae', 'S', 3, getdate(), g.id, 'N' from Game g where g.name = 'Reefscape'
insert into Rank select 'Barge', 'rankBarge', 'S', 4, getdate(), g.id, 'N' from Game g where g.name = 'Reefscape'
insert into Rank select 'Defense', 'rankPlayedDefense', 'V', 5, getdate(), g.id, 'N' from Game g where g.name = 'Reefscape'
insert into Rank select 'Scr Imp', 'rankScoreImpact', 'S', 6, getdate(), g.id, 'Y' from Game g where g.name = 'Reefscape'

-- Rank Objective
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Reefscape' and o.name = 'aLeave' and r.name = 'Auto'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Reefscape' and o.name = 'aL1' and r.name = 'Auto'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Reefscape' and o.name = 'aL2' and r.name = 'Auto'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Reefscape' and o.name = 'aL3' and r.name = 'Auto'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Reefscape' and o.name = 'aL4' and r.name = 'Auto'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Reefscape' and o.name = 'aProc' and r.name = 'Auto'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Reefscape' and o.name = 'aNet' and r.name = 'Auto'

insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Reefscape' and o.name = 'aL1' and r.name = 'Coral'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Reefscape' and o.name = 'aL2' and r.name = 'Coral'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Reefscape' and o.name = 'aL3' and r.name = 'Coral'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Reefscape' and o.name = 'aL4' and r.name = 'Coral'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Reefscape' and o.name = 'toL1' and r.name = 'Coral'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Reefscape' and o.name = 'toL2' and r.name = 'Coral'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Reefscape' and o.name = 'toL3' and r.name = 'Coral'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Reefscape' and o.name = 'toL4' and r.name = 'Coral'

insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Reefscape' and o.name = 'aProc' and r.name = 'Algae'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Reefscape' and o.name = 'aNet' and r.name = 'Algae'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Reefscape' and o.name = 'toProc' and r.name = 'Algae'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Reefscape' and o.name = 'toNet' and r.name = 'Algae'

insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Reefscape' and o.name = 'toEnd' and r.name = 'Barge'

insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Reefscape' and o.name = 'aLeave' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Reefscape' and o.name = 'aL1' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Reefscape' and o.name = 'aL2' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Reefscape' and o.name = 'aL3' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Reefscape' and o.name = 'aL4' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Reefscape' and o.name = 'aProc' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Reefscape' and o.name = 'aNet' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Reefscape' and o.name = 'toL1' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Reefscape' and o.name = 'toL2' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Reefscape' and o.name = 'toL3' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Reefscape' and o.name = 'toL4' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Reefscape' and o.name = 'toProc' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Reefscape' and o.name = 'toNet' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Reefscape' and o.name = 'toEnd' and r.name = 'Scr Imp'

insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Reefscape' and o.name = 'toDefense' and r.name = 'Defense'

-- Scout
update Scout set isActive = 'N' where teamId in (select id from Team where teamNumber = 6217) and lastname + firstname not in ('CoyleJoe', 'EngebretsenDave', 'HernkeKyle (Lead Scout)','TBA');
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Beck', 'Zane', t.id, 'Y', 'zebual.l.beck@gmail.com', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Beck' and s.firstName = 'Zane' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Bray', 'Graham', t.id, 'Y', 'gbray4790@gmail.com', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Bray' and s.firstName = 'Graham' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Brokate', 'Max', t.id, 'Y', '25mb02@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Brokate' and s.firstName = 'Max' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Cernehous', 'Elsa', t.id, 'Y', '26ec01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Cernehous' and s.firstName = 'Elsa' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Conway', 'Mackston', t.id, 'Y', '29mc01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Conway' and s.firstName = 'Mackston' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Coyle', 'Thomas', t.id, 'Y', '25tc01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Coyle' and s.firstName = 'Thomas' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Dettmann', 'Madison', t.id, 'Y', '26md01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Dettmann' and s.firstName = 'Madison' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Flodeen', 'Henry', t.id, 'Y', '29hf01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Flodeen' and s.firstName = 'Henry' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Hernke', 'Ava', t.id, 'Y', '27ah02@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Hernke' and s.firstName = 'Ava' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Hernke', 'Luke', t.id, 'Y', 'hernkelm@gmail.com', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Hernke' and s.firstName = 'Luke' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Kammerude', 'Hades', t.id, 'Y', '28lk01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Kammerude' and s.firstName = 'Hades' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Lindquist', 'Rylan', t.id, 'Y', '26rl01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Lindquist' and s.firstName = 'Rylan' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Maki', 'Gunnar', t.id, 'Y', '27gm01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Maki' and s.firstName = 'Gunnar' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'McGeough', 'Andy', t.id, 'Y', '26am01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'McGeough' and s.firstName = 'Andy' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Medcraft', 'Makenzie', t.id, 'Y', '27mm03@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Medcraft' and s.firstName = 'Makenzie' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Medcraft', 'Sebastian', t.id, 'Y', '29sm01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Medcraft' and s.firstName = 'Sebastian' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Olson', 'Maddie', t.id, 'Y', '27mo01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Olson' and s.firstName = 'Maddie' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Rapp', 'Axel', t.id, 'Y', '26ar01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Rapp' and s.firstName = 'Axel' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Rapp', 'Isaac', t.id, 'Y', '25ir01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Rapp' and s.firstName = 'Isaac' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Rezac', 'Kaeda', t.id, 'Y', '27kr01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Rezac' and s.firstName = 'Kaeda' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Stark', 'Avery', t.id, 'Y', '27as02@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Stark' and s.firstName = 'Avery' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Strecker', 'Torin', t.id, 'Y', '26ts01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Strecker' and s.firstName = 'Torin' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'White', 'Brandon', t.id, 'Y', '25bw01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'White' and s.firstName = 'Brandon' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Zheng', 'William', t.id, 'Y', '27wz01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Zheng' and s.firstName = 'William' and s.teamId = t.id);

update Scout set isActive = 'Y' where lastName = 'Beck' and firstName = 'Zane' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Bray' and firstName = 'Graham' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Brokate' and firstName = 'Max' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Cernehous' and firstName = 'Elsa' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Conway' and firstName = 'Mackston' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Coyle' and firstName = 'Thomas' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Dettmann' and firstName = 'Madison' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Flodeen' and firstName = 'Henry' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Hernke' and firstName = 'Ava' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Hernke' and firstName = 'Luke' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Kammerude' and firstName = 'Hades' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Lindquist' and firstName = 'Rylan' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Maki' and firstName = 'Gunnar' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'McGeough' and firstName = 'Andy' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Medcraft' and firstName = 'Makenzie' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Medcraft' and firstName = 'Sebastian' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Olson' and firstName = 'Maddie' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Rapp' and firstName = 'Axel' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Rapp' and firstName = 'Isaac' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Rezac' and firstName = 'Kaeda' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Stark' and firstName = 'Avery' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Strecker' and firstName = 'Torin' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'White' and firstName = 'Brandon' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Zheng' and firstName = 'William' and teamId = (select id from Team where teamNumber = 6217);

update Scout set isAdmin = 'N' where isActive = 'N' and isAdmin = 'Y';

-- Sponsors 2025
-- delete from teamSponsor where gameid in (select g.id from game g where g.name = 'Reefscape')
insert into TeamSponsor select t.id, g.id, 'Gemini Signworks', 1, 10, 'Sponsors/Gemini.jpg', 'https://geminimade.com/', 50, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Aliveo Military Museum', 0, 20, 'Sponsors/AliveoMilitaryMuseum.jpg', 'http://www.aliveomuseum.org/', 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Gene Haas Foundation', 0, 25, 'Sponsors/GeneHaasFoundation.png', 'https://www.ghaasfoundation.org//', 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Cannon Falls Fire Department', 0, 26, 'Sponsors/CF Fire Department.jpg', 'https://www.cannonfallsmn.gov/fire', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Argosy Foundation', 0, 28, 'Sponsors/ArgosyFoundation_Logo_CMYK.jpg', 'https://www.argosyfnd.org/', 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Hernke Heating', 0, 30, 'Sponsors/hernkes heating and cooling.png', null, 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'BARR', 0, 35, 'Sponsors/BARRblue.png', 'https://barr.com/', 50, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Flex Craft', 0, 40, 'Sponsors/flex craft logo.png', 'https://flex-craft.com/', 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Jim Althoff Real Estate', 0, 45, 'Sponsors/JimAlthoffRealEstate.jpeg', 'https://www.facebook.com/JimAlthoffRealtor/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Quality One Woodworking', 0, 50, 'Sponsors/QualityOne.png', 'https://www.qualityonewoodwork.com/', 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'StarTech Computing', 0, 60, 'Sponsors/StarTech-logo.png', 'https://www.startech-comp.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Milwaukee Tool', 0, 70, 'Sponsors/Milwaukee.jpg', 'https://www.milwaukeetool.com/', 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Red Wing Area Manufacturers Association', 0, 80, 'Sponsors/RW Area Mfg Assoc.jpg', 'https://www.facebook.com/RWAreaMfrsAssoc/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Caseys', 0, 90, 'Sponsors/Casey_s.png', 'https://www.caseys.com/', 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Brewster''s Bar & Grill', 0, 150, null, null, 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';

insert into TeamSponsor select t.id, g.id, 'Swan and Bower', 0, 155, '', 'https://www.swanandbower.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';

insert into TeamSponsor select t.id, g.id, 'Chuck & Carrie Olson', 0, 180, null, null, 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Twist Solutions', 0, 190, null, null, 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Jack Schlicting', 0, 200, null, null, 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
update teamSponsor set maxWidthPercent = 40 where gameid = (select id from game where name = 'Reefscape') and sortOrder = 20 -- Aliveo
update teamSponsor set maxWidthPercent = 15 where gameid = (select id from game where name = 'Reefscape') and sortOrder = 25 -- Haas
update teamSponsor set maxWidthPercent = 10, sameLineAsPrevious = 'Y' where gameid = (select id from game where name = 'Reefscape') and sortOrder = 26 -- CFFD
update teamSponsor set maxWidthPercent = 15 where gameid = (select id from game where name = 'Reefscape') and sortOrder = 30 -- Hernke
update teamSponsor set maxWidthPercent = 30 where gameid = (select id from game where name = 'Reefscape') and sortOrder = 35 -- BARR
update teamSponsor set maxWidthPercent = 40 where gameid = (select id from game where name = 'Reefscape') and sortOrder = 40 -- FlexCraft
update teamSponsor set maxWidthPercent = 15 where gameid = (select id from game where name = 'Reefscape') and sortOrder = 45 -- Jim ALthoff
update teamSponsor set maxWidthPercent = 20 where gameid = (select id from game where name = 'Reefscape') and sortOrder = 60 -- StarTech


/*
-- Sponsors 2024
insert into TeamSponsor select t.id, g.id, 'CF Education Foundation', 0, 20, 'Sponsors/CF Ed Foundation.jpg', 'https://www.cannonfallsschools.com/community/education_foundation', 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'VFW Post 4452', 0, 40, 'Sponsors/VFW.jpg', 'https://cannonfallsvfw.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Oldcastle Infrastructure', 0, 50, 'Sponsors/Oldcastle_Infrastructure_Logo.jpg', 'https://oldcastleinfrastructure.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Remax Realty', 0, 60, 'Sponsors/REMAX.png', 'https://www.remax.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'American Legion Post 142', 0, 80, 'Sponsors/AmericanLegion.png', 'https://www.facebook.com/CannonFallsAmericanLegionPost142/', 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, '3M', 0, 110, 'Sponsors/3M.png', 'https://www.3m.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Highland Sanitation', 0, 130, 'Sponsors/HighlandSanitation.png', 'https://www.highlandsanitation.com', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Master CAM', 0, 140, 'Sponsors/mastercam_logo.png', 'https://www.mastercam.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Sjoquist Hay and Straw', 0, 160, 'Sponsors/SjoquistHayAndStraw.jpg', 'https://www.facebook.com/SjoquistHayandStraw/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Snap Fitness', 0, 170, 'Sponsors/Snap Fitness.jpg', 'https://www.snapfitness.com/us/gyms/cannon-falls-mn', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Community Resource Bank', 0, 190, 'Sponsors/CommunityResourceBank.jpg', 'https://crb.bank/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Interstate Building Supply', 0, 200, 'Sponsors/InterstateBuildingSupply.png', 'https://www.interstatebuildingsupply.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Cannon Falls Rotary', 0, 220, 'Sponsors/Rotary.jpg', 'https://www.facebook.com/Cannonfallsrotary/', 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Midwest Machinery - John Deere', 0, 230, 'Sponsors/midwest machinery.png', 'https://mmcjd.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Northlands Safety Solution', 0, 250, 'Sponsors/Northland Safety logo.png', 'https://www.northlandsafety.com/', 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'MN Woodcraft', 0, 255, 'Sponsors/MN Woodcraft.jpg', 'https://mnwoodcraft.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Lorentz Meats', 0, 260, 'Sponsors/LorentzMeats.jpg', 'https://lorentzmeats.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Cannon Falls Lions', 0, 271, 'Sponsors/Lions.jpg', 'https://www.facebook.com/cannonfallslionsclub/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Ace Hardware', 0, 272, 'Sponsors/AceHardware.png', 'https://www.acehardware.com/store-details/14225', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Liberty Tax', 0, 275, 'Sponsors/Liberty.jpg', 'https://www.libertytax.com/income-tax-preparation-locations/minnesota/cannon-falls/14375', 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Cannon River Catering', 0, 276, 'Sponsors/Cannon River Catering.png', 'https://www.cannonrivercatering.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Small Engine Service', 0, 278, 'Sponsors/SmallEngineService.jpg', 'https://www.smallengineservicewelch.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Guhring', 0, 300, 'Sponsors/gurhing.png', 'https://www.guhring.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'J&J Aircraft Maint and Consulting', 0, 310, null, null, 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Busy Bee Honey Farm', 0, 320, null, null, 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Seed Plus', 0, 330, null, null, 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Ron & Marcia Freeburg', 0, 340, null, null, 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Strike Tool Products', 0, 345, null, 'https://www.striketool.com/', 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Fastenal Company Purchasing', 0, 350, null, null, 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Mark & Cindy Sjoquist', 0, 360, null, null, 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';
insert into TeamSponsor select t.id, g.id, 'Barbara McGeough', 0, 370, null, null, 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Reefscape';

update teamSponsor set maxWidthPercent = 10 where gameid = 7 and sortOrder = 20 -- CFEF
update teamSponsor set maxWidthPercent = 20 where gameid = 7 and sortOrder = 50 -- Old Castle
update teamSponsor set maxWidthPercent = 15 where gameid = 7 and sortOrder = 60 -- ReMax
update teamSponsor set maxWidthPercent = 10 where gameid = 7 and sortOrder = 80 -- American Legion
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
