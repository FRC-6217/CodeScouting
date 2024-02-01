select t.teamNumber, t.teamName
  from team t
       inner join teamGameEvent tge
	   on tge.teamId = t.id
	   inner join gameEvent ge
	   on ge.id = tge.gameEventId
	   inner join Game g
	   on g.id = ge.gameId
	   inner join Event e
	   on e.id = ge.eventId
 where g.name = 'Crescendo'
   and e.name = 'Blue Twilight Week Zero Invitational'
order by 1

select m.*
--update m set dateTime = dateTime - (2.0 / 24.0)
  from match m
	   inner join gameEvent ge
	   on ge.id = m.gameEventId
	   inner join Game g
	   on g.id = ge.gameId
	   inner join Event e
	   on e.id = ge.eventId
 where g.name = 'Crescendo'
   and e.name = 'Blue Twilight Week Zero Invitational'
order by 4

/* Clear data
delete from teamMatch where matchId in (select m.id from Game g inner join gameEvent ge on g.id = ge.gameId inner join match m on m.gameEventId = ge.id where g.name = 'Crescendo');
delete from ScoutRecord where matchId in (select m.id from Game g inner join gameEvent ge on g.id = ge.gameId inner join match m on m.gameEventId = ge.id where g.name = 'Crescendo');

delete from AttributeValue where attributeId in (select a.id from Attribute a inner join Game g on g.id = a.gameId where g.name = 'Crescendo');
delete from Attribute where gameId in (select g.id from Game g where g.name = 'Crescendo');

delete from RankObjective where rankId in (select r.id from Rank r inner join Game g on g.id = r.gameId where g.name = 'Crescendo');
delete from Rank where gameId in (select g.id from Game g where g.name = 'Crescendo');

delete from ObjectiveGroupObjective where objectiveId in (select o.id from Objective o inner join Game g on g.id = o.gameId where g.name = 'Crescendo');
delete from ObjectiveValue where objectiveId in (select o.id from Objective o inner join Game g on g.id = o.gameId where g.name = 'Crescendo');
delete from Objective where gameId in (select g.id from Game g where g.name = 'Crescendo');

delete from game where name = 'Crescendo';
*/

-- Game
insert into Game (name, gameYear) values ('Crescendo', 2024);

-- Attributes
insert into Attribute select g.id, 'name', 'What''s your name?', st.id, null, null, 1, getdate(), 'Name', 'N', '<Enter Name Here>' from Game g, ScoringType st where g.name = 'Crescendo' and st.name = 'Free Form'
insert into Attribute select g.id, 'role', 'What''s your role on the team?', st.id, null, null, 2, getdate(), 'Role', 'N', 'Drive Team' from Game g, ScoringType st where g.name = 'Crescendo' and st.name = 'Free Form'
insert into Attribute select g.id, 'driveTrain', 'What drivetrain is robot using?', st.id, null, null, 3, getdate(), 'Drive Train', 'N', null from Game g, ScoringType st where g.name = 'Crescendo' and st.name = 'Radio Button'
insert into Attribute select g.id, 'robotWidth', 'Width of robot with bumpers (inches)?', st.id, null, null, 4, getdate(), 'Width', 'N', null from Game g, ScoringType st where g.name = 'Crescendo' and st.name = 'Integer'
insert into Attribute select g.id, 'autoLeave', 'Do you have an autonomous program to leave scoring area?', st.id, null, null, 5, getdate(), 'Leave', 'N', null from Game g, ScoringType st where g.name = 'Crescendo' and st.name = 'Radio Button'
insert into Attribute select g.id, 'preferredStart', 'What is preferred start location?', st.id, null, null, 6, getdate(), 'Pref Start', 'N', null from Game g, ScoringType st where g.name = 'Crescendo' and st.name = 'Radio Button'
insert into Attribute select g.id, 'flexibleStart', 'Does autonomous program allow for flexible start location?', st.id, null, null, 7, getdate(), 'Flex Start', 'N', null from Game g, ScoringType st where g.name = 'Crescendo' and st.name = 'Radio Button'
insert into Attribute select g.id, 'autoNow', 'Describe current autonomous program movement?', st.id, null, null, 8, getdate(), 'Auto Now', 'N', 'Drive out of Robot Start Area' from Game g, ScoringType st where g.name = 'Crescendo' and st.name = 'Free Form'
insert into Attribute select g.id, 'AutoPlan', 'Describe any plans for changes to autonomous movement?', st.id, null, null, 9, getdate(), 'Auto Plan', 'N', 'Pick up second Note' from Game g, ScoringType st where g.name = 'Crescendo' and st.name = 'Free Form'
insert into Attribute select g.id, 'gamePiecePickup', 'How does robot attain Notes?', st.id, null, null, 10, getdate(), 'Pickup', 'N', null from Game g, ScoringType st where g.name = 'Crescendo' and st.name = 'Radio Button'
insert into Attribute select g.id, 'gamePieceLevel', 'Which targets can your robot score game pieces?', st.id, null, null, 12, getdate(), 'Note Targets', 'N', null from Game g, ScoringType st where g.name = 'Crescendo' and st.name = 'Radio Button'
insert into Attribute select g.id, 'endGameDescription', 'Describe your on-stage end game plan?', st.id, null, null, 13, getdate(), 'End Game', 'N', 'Plan for Harmony with another robot' from Game g, ScoringType st where g.name = 'Crescendo' and st.name = 'Free Form'

-- Attribute Values
insert into AttributeValue select a.id, 'Tank', 0, 1, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Crescendo' and a.name = 'driveTrain';
insert into AttributeValue select a.id, 'Tank with Omni', 1, 2, getdate(), 'Y', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Crescendo' and a.name = 'driveTrain';
insert into AttributeValue select a.id, 'Swerve', 2, 3, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Crescendo' and a.name = 'driveTrain';
insert into AttributeValue select a.id, 'Mecanum', 3, 4, getdate(), 'Y', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Crescendo' and a.name = 'driveTrain';
insert into AttributeValue select a.id, 'Kiwi', 4, 5, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Crescendo' and a.name = 'driveTrain';
insert into AttributeValue select a.id, 'Other', 5, 6, getdate(), 'Y', 'Y' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Crescendo' and a.name = 'driveTrain';
insert into AttributeValue select a.id, 'No', 0, 1, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Crescendo' and a.name = 'autoLeave';
insert into AttributeValue select a.id, 'Yes', 2, 3, getdate(), 'Y', 'Y' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Crescendo' and a.name = 'autoLeave';
insert into AttributeValue select a.id, 'No Preference', 0, 1, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Crescendo' and a.name = 'preferredStart';
insert into AttributeValue select a.id, 'Speaker Front', 1, 2, getdate(), 'Y', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Crescendo' and a.name = 'preferredStart';
insert into AttributeValue select a.id, 'Speaker Left', 2, 3, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Crescendo' and a.name = 'preferredStart';
insert into AttributeValue select a.id, 'Speaker Right', 3, 4, getdate(), 'Y', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Crescendo' and a.name = 'preferredStart';
insert into AttributeValue select a.id, 'Near Amp', 4, 5, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Crescendo' and a.name = 'preferredStart';
insert into AttributeValue select a.id, 'Near Source', 5, 6, getdate(), 'Y', 'Y' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Crescendo' and a.name = 'preferredStart';
insert into AttributeValue select a.id, 'No', 0, 1, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Crescendo' and a.name = 'flexibleStart';
insert into AttributeValue select a.id, 'Yes', 1, 2, getdate(), 'Y', 'Y' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Crescendo' and a.name = 'flexibleStart';
insert into AttributeValue select a.id, 'Off Floor', 0, 1, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Crescendo' and a.name = 'gamePiecePickup';
insert into AttributeValue select a.id, 'Source', 1, 2, getdate(), 'Y', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Crescendo' and a.name = 'gamePiecePickup';
insert into AttributeValue select a.id, 'Both', 2, 3, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Crescendo' and a.name = 'gamePiecePickup';
insert into AttributeValue select a.id, 'Neither', 3, 4, getdate(), 'Y', 'Y' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Crescendo' and a.name = 'gamePiecePickup';
insert into AttributeValue select a.id, 'None', 0, 1, getdate(), 'Y', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Crescendo' and a.name = 'gamePieceLevel';
insert into AttributeValue select a.id, 'Speaker', 1, 2, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Crescendo' and a.name = 'gamePieceLevel';
insert into AttributeValue select a.id, 'Amp', 2, 3, getdate(), 'Y', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Crescendo' and a.name = 'gamePieceLevel';
insert into AttributeValue select a.id, 'Trap', 3, 4, getdate(), 'Y', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Crescendo' and a.name = 'gamePieceLevel';
insert into AttributeValue select a.id, 'Speaker & Amp', 4, 5, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Crescendo' and a.name = 'gamePieceLevel';
insert into AttributeValue select a.id, 'Amp & Trap', 5, 6, getdate(), 'Y', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Crescendo' and a.name = 'gamePieceLevel';
insert into AttributeValue select a.id, 'All Targets', 6, 7, getdate(), 'N', 'Y' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Crescendo' and a.name = 'gamePieceLevel';

-- Objectives
insert into Objective select g.id, 'toHPLoc', 'HP Loc:', st.id, null, null, null, 1, getdate(), 'HP', 'I', 'N', 'N', 1 from Game g, ScoringType st where g.name = 'Crescendo' and st.name = 'Radio Button'
insert into Objective select g.id, 'aLeave', 'Leave:', st.id, null, null, null, 2, getdate(), 'aLeave', 'I', 'Y', 'N', 2 from Game g, ScoringType st where g.name = 'Crescendo' and st.name = 'Radio Button'
insert into Objective select g.id, 'aSpeaker', 'Speaker:', st.id, 0, 6, 5, 3, getdate(), 'aSpeaker', 'I', 'N', 'N', 3 from Game g, ScoringType st where g.name = 'Crescendo' and st.name = 'Integer'
insert into Objective select g.id, 'aAmp', 'Amp:', st.id, 0, 3, 2, 4, getdate(), 'aAmp', 'I', 'Y', 'N', 4 from Game g, ScoringType st where g.name = 'Crescendo' and st.name = 'Integer'
insert into Objective select g.id, 'toSpeaker', 'Speaker:', st.id, 0, 15, 2, 5, getdate(), 'toSpeaker', 'I', 'N', 'N', 5 from Game g, ScoringType st where g.name = 'Crescendo' and st.name = 'Integer'
insert into Objective select g.id, 'toAmp', 'Amp:', st.id, 0, 15, 1, 6, getdate(), 'toAmp', 'I', 'Y', 'N', 6 from Game g, ScoringType st where g.name = 'Crescendo' and st.name = 'Integer'
insert into Objective select g.id, 'toTrap', 'Trap:', st.id, 0, 3, 5, 7, getdate(), 'toTrap', 'I', 'Y', 'N', 7 from Game g, ScoringType st where g.name = 'Crescendo' and st.name = 'Integer'
insert into Objective select g.id, 'toEnd', 'Stage:', st.id, null, null, null, 8, getdate(), 'Stage', 'S', 'N', 'N', 8 from Game g, ScoringType st where g.name = 'Crescendo' and st.name = 'Radio Button'
insert into Objective select g.id, 'toHPShot', 'HP Shots:', st.id, 0, 3, 0, 9, getdate(), 'HP Shot', 'I', 'N', 'N', 9 from Game g, ScoringType st where g.name = 'Crescendo' and st.name = 'Integer'
insert into Objective select g.id, 'toHPMade', 'HP Made:', st.id, 0, 3, 0, 10, getdate(), 'HP Made', 'I', 'Y', 'N', 10 from Game g, ScoringType st where g.name = 'Crescendo' and st.name = 'Integer'
insert into Objective select g.id, 'toDefense', 'Defense (0=None, 1=Poor to 4=Great):', st.id, null, null, null, 11, getdate(), 'Def', 'I', 'N', 'N', 11 from Game g, ScoringType st where g.name = 'Crescendo' and st.name = 'Radio Button'
insert into Objective select g.id, 'toHarm', 'Harmony:', st.id, null, null, null, 12, getdate(), 'Harmony', 'I', 'N', 'N', 12 from Game g, ScoringType st where g.name = 'Crescendo' and st.name = 'Radio Button'

-- Objective Value
insert into ObjectiveValue select o.id, 'Amp', 0, 1, 0, getdate(), 'Y', null, null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Crescendo' and o.name = 'toHPLoc'
insert into ObjectiveValue select o.id, 'Source', 1, 2, 0, getdate(), 'Y', null, null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Crescendo' and o.name = 'toHPLoc'
insert into ObjectiveValue select o.id, 'No', 0, 1, 0, getdate(), 'Y', 'No', null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Crescendo' and o.name = 'aLeave'
insert into ObjectiveValue select o.id, 'Yes', 1, 2, 2, getdate(), 'Y', 'Yes', null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Crescendo' and o.name = 'aLeave'
insert into ObjectiveValue select o.id, 'None', 0, 1, 0, getdate(), 'N', 'None', null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Crescendo' and o.name = 'toEnd'
insert into ObjectiveValue select o.id, 'Park', 1, 2, 1, getdate(), 'Y', 'Park', null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Crescendo' and o.name = 'toEnd'
insert into ObjectiveValue select o.id, 'On Stage', 2, 3, 3, getdate(), 'Y', 'On Stage', null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Crescendo' and o.name = 'toEnd'
insert into ObjectiveValue select o.id, 'On Stage Spot', 3, 4, 4, getdate(), 'N', 'On Stage Spot', null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Crescendo' and o.name = 'toEnd'
insert into ObjectiveValue select o.id, 'No', 0, 1, 0, getdate(), 'Y', 'No', null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Crescendo' and o.name = 'toHarm'
insert into ObjectiveValue select o.id, 'Yes', 1, 2, 1, getdate(), 'Y', 'Yes', null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Crescendo' and o.name = 'toHarm'
insert into ObjectiveValue select o.id, '0', 0, 1, 0, getdate(), 'N', null, null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Crescendo' and o.name = 'toDefense'
insert into ObjectiveValue select o.id, '1', 1, 2, 0, getdate(), 'Y', null, null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Crescendo' and o.name = 'toDefense'
insert into ObjectiveValue select o.id, '2', 2, 3, 0, getdate(), 'Y', null, null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Crescendo' and o.name = 'toDefense'
insert into ObjectiveValue select o.id, '3', 3, 4, 0, getdate(), 'Y', null, null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Crescendo' and o.name = 'toDefense'
insert into ObjectiveValue select o.id, '4', 4, 5, 0, getdate(), 'Y', null, null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Crescendo' and o.name = 'toDefense'

-- Objective Group Objectives
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Crescendo' and o.name = 'toHPLoc' and og.name = 'Autonomous' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Crescendo' and o.name = 'aLeave' and og.name = 'Autonomous' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Crescendo' and o.name = 'aSpeaker' and og.name = 'Autonomous' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Crescendo' and o.name = 'aAmp' and og.name = 'Autonomous' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Crescendo' and o.name = 'toSpeaker' and og.name = 'Tele Op' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Crescendo' and o.name = 'toAmp' and og.name = 'Tele Op' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Crescendo' and o.name = 'toTrap' and og.name = 'Tele Op' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Crescendo' and o.name = 'toEnd' and og.name = 'End Game' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Crescendo' and o.name = 'toHPShot' and og.name = 'End Game' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Crescendo' and o.name = 'toHPMade' and og.name = 'End Game' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Crescendo' and o.name = 'toDefense' and og.name = 'End Game' and og.groupCode = 'Scout Match'

insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Crescendo' and o.name = 'aLeave' and og.name = 'Autonomous' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Crescendo' and o.name = 'aSpeaker' and og.name = 'Autonomous' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Crescendo' and o.name = 'aAmp' and og.name = 'Autonomous' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Crescendo' and o.name = 'toSpeaker' and og.name = 'TeleOp' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Crescendo' and o.name = 'toAmp' and og.name = 'TeleOp' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Crescendo' and o.name = 'toTrap' and og.name = 'TeleOp' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Crescendo' and o.name = 'toEnd' and og.name = 'End Game' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Crescendo' and o.name = 'toHarm' and og.name = 'End Game' and og.groupCode = 'Report Pie Chart'

insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Crescendo' and o.name = 'aLeave' and og.name = 'Autonomous' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Crescendo' and o.name = 'aSpeaker' and og.name = 'Autonomous' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Crescendo' and o.name = 'aAmp' and og.name = 'Autonomous' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Crescendo' and o.name = 'toSpeaker' and og.name = 'TeleOp' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Crescendo' and o.name = 'toAmp' and og.name = 'TeleOp' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Crescendo' and o.name = 'toTrap' and og.name = 'TeleOp' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Crescendo' and o.name = 'toEnd' and og.name = 'End Game' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Crescendo' and o.name = 'toHarm' and og.name = 'End Game' and og.groupCode = 'Report Line Graph'

-- Ranks
insert into Rank select 'Auto', 'rankAuto', 'S', 1, getdate(), g.id, 'N' from Game g where g.name = 'Crescendo'
insert into Rank select 'Speaker', 'rankSpeaker', 'V', 2, getdate(), g.id, 'N' from Game g where g.name = 'Crescendo'
insert into Rank select 'Amp', 'rankAmp', 'V', 3, getdate(), g.id, 'N' from Game g where g.name = 'Crescendo'
insert into Rank select 'Trap', 'rankTrap', 'V', 4, getdate(), g.id, 'N' from Game g where g.name = 'Crescendo'
insert into Rank select 'Stage', 'rankStage', 'S', 5, getdate(), g.id, 'N' from Game g where g.name = 'Crescendo'
insert into Rank select 'Scr Imp', 'rankScoreImpact', 'S', 6, getdate(), g.id, 'Y' from Game g where g.name = 'Crescendo'
--insert into Rank select 'Defense', 'rankPlayedDefense', 'V', 5, getdate(), g.id from Game g where g.name = 'Crescendo'
--insert into Rank select 'HP', 'rankHP', 'V', 6, getdate(), g.id from Game g where g.name = 'Crescendo'

-- Rank Objective
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Crescendo' and o.name = 'aLeave' and r.name = 'Auto'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Crescendo' and o.name = 'aSpeaker' and r.name = 'Auto'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Crescendo' and o.name = 'aAmp' and r.name = 'Auto'

insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Crescendo' and o.name = 'aSpeaker' and r.name = 'Speaker'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Crescendo' and o.name = 'toSpeaker' and r.name = 'Speaker'

insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Crescendo' and o.name = 'aAmp' and r.name = 'Amp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Crescendo' and o.name = 'toAmp' and r.name = 'Amp'

insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Crescendo' and o.name = 'toTrap' and r.name = 'Trap'

insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Crescendo' and o.name = 'toTrap' and r.name = 'Stage'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Crescendo' and o.name = 'toEnd' and r.name = 'Stage'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Crescendo' and o.name = 'toHarm' and r.name = 'Stage'

insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Crescendo' and o.name = 'aLeave' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Crescendo' and o.name = 'aSpeaker' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Crescendo' and o.name = 'aAmp' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Crescendo' and o.name = 'toSpeaker' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Crescendo' and o.name = 'toAmp' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Crescendo' and o.name = 'toTrap' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Crescendo' and o.name = 'toEnd' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Crescendo' and o.name = 'toHarm' and r.name = 'Scr Imp'

--insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Crescendo' and o.name = 'toDefense' and r.name = 'Defense'

--insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Crescendo' and o.name = 'toHP' and r.name = 'HP'

-- Scout
update Scout set isActive = 'N' where teamId in (select id from Team where teamNumber = 6217) and lastname + firstname not in ('CoyleJoe', 'EngebretsenDave', 'HernkeKyle (Lead Scout)','TBA');
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Auger', 'Sara', t.id, 'Y', '24sa01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Auger' and s.firstName = 'Sara' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Beck', 'Zane', t.id, 'Y', 'zebual.l.beck@gmail.com', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Beck' and s.firstName = 'Zane' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Bray', 'Graham', t.id, 'Y', '26gb01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Bray' and s.firstName = 'Graham' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Brokate', 'Max', t.id, 'Y', '25mb02@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Brokate' and s.firstName = 'Max' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Coyle', 'Thomas', t.id, 'Y', '25tc01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Coyle' and s.firstName = 'Thomas' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Dettmann', 'Madison', t.id, 'Y', '26md01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Dettmann' and s.firstName = 'Madison' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Dolan', 'Garrett', t.id, 'Y', '24gd01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Dolan' and s.firstName = 'Garrett' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Ehlers', 'Thomas', t.id, 'Y', '24te01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Ehlers' and s.firstName = 'Thomas' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Hernke', 'Ava', t.id, 'Y', '27ah02@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Hernke' and s.firstName = 'Ava' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Hernke', 'Luke', t.id, 'Y', '25lh02@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Hernke' and s.firstName = 'Luke' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Holmen', 'Apollo', t.id, 'Y', '28rh01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Holmen' and s.firstName = 'Apollo' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Lindquist', 'Rylan', t.id, 'Y', '26rl01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Lindquist' and s.firstName = 'Rylan' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Kammerude', 'Hades', t.id, 'Y', '28lk01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Kammerude' and s.firstName = 'Hades' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Lochner', 'Cooper', t.id, 'Y', '24cl01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Lochner' and s.firstName = 'Cooper' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Lopez', 'Brody', t.id, 'Y', '28bl01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Lopez' and s.firstName = 'Brody' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Maki', 'Gunnar', t.id, 'Y', '27gm01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Maki' and s.firstName = 'Gunnar' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'McGeough', 'Andy', t.id, 'Y', '26am01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'McGeough' and s.firstName = 'Andy' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'McGuire', 'Tyler', t.id, 'Y', '24tm01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'McGuire' and s.firstName = 'Tyler' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'McManus', 'Oscar', t.id, 'Y', '28om01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'McManus' and s.firstName = 'Oscar' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Medcraft', 'Makenzie', t.id, 'Y', '27mm03@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Medcraft' and s.firstName = 'Makenzie' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Nelsen', 'Marcus', t.id, 'Y', '26mn02@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Nelsen' and s.firstName = 'Marcus' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Olson', 'Maddie', t.id, 'Y', '27mo01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Olson' and s.firstName = 'Maddie' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Rapp', 'Isaac', t.id, 'Y', '25ir01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Rapp' and s.firstName = 'Isaac' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Rezac', 'Kaeda', t.id, 'Y', '27kr01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Rezac' and s.firstName = 'Kaeda' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Stark', 'Avery', t.id, 'Y', '27as02@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Stark' and s.firstName = 'Avery' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Strecker', 'Torin', t.id, 'Y', '26ts01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Strecker' and s.firstName = 'Torin' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Sullivan', 'Danny', t.id, 'Y', '24ds01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Sullivan' and s.firstName = 'Danny' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Swenson', 'Brandon', t.id, 'Y', '24bs01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Swenson' and s.firstName = 'Brandon' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'White', 'Brandon', t.id, 'Y', '25bw01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'White' and s.firstName = 'Brandon' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Zheng', 'William', t.id, 'Y', '27wz01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Zheng' and s.firstName = 'William' and s.teamId = t.id);
update Scout set isActive = 'Y' where lastName = 'Auger' and firstName = 'Sara' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Beck' and firstName = 'Zane' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Bray' and firstName = 'Graham' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Brokate' and firstName = 'Max' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Coyle' and firstName = 'Thomas' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Dettmann' and firstName = 'Madison' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Dolan' and firstName = 'Garrett' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Ehlers' and firstName = 'Thomas' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Hernke' and firstName = 'Ava' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Hernke' and firstName = 'Luke' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Holmen' and firstName = 'Apollo' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Lindquist' and firstName = 'Rylan' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Kammerude' and firstName = 'Hades' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Lochner' and firstName = 'Cooper' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Lopez' and firstName = 'Brody' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Maki' and firstName = 'Gunnar' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'McGeough' and firstName = 'Andy' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'McGuire' and firstName = 'Tyler' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'McManus' and firstName = 'Oscar' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Medcraft' and firstName = 'Makenzie' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Nelsen' and firstName = 'Marcus' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Olson' and firstName = 'Maddie' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Rapp' and firstName = 'Isaac' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Rezac' and firstName = 'Kaeda' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Stark' and firstName = 'Avery' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Strecker' and firstName = 'Torin' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Sullivan' and firstName = 'Danny' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Swenson' and firstName = 'Brandon' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'White' and firstName = 'Brandon' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Zheng' and firstName = 'William' and teamId = (select id from Team where teamNumber = 6217);

update Scout set isAdmin = 'N' where isActive = 'N' and isAdmin = 'Y';

