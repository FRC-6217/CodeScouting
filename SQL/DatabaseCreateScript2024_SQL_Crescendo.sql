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
delete from teamAttribute where attributeId in (select a.id from Attribute a inner join Game g on g.id = a.gameId where g.name = 'Crescendo');
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
insert into Attribute select g.id, 'gamePieceLevel', 'Which targets can your robot score game pieces?', st.id, null, null, 11, getdate(), 'Note Targets', 'N', null from Game g, ScoringType st where g.name = 'Crescendo' and st.name = 'Radio Button'
insert into Attribute select g.id, 'endGameDescription', 'Describe your on-stage end game plan?', st.id, null, null, 12, getdate(), 'End Game', 'N', 'Plan for Harmony with another robot' from Game g, ScoringType st where g.name = 'Crescendo' and st.name = 'Free Form'
insert into Attribute select g.id, 'coopertition', 'Does your strategy include engaging in the Coopertition bonus?', st.id, null, null, 13, getdate(), 'Coopertition', 'N', null from Game g, ScoringType st where g.name = 'Crescendo' and st.name = 'Radio Button'

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
insert into AttributeValue select a.id, 'Always', 0, 1, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Crescendo' and a.name = 'coopertition';
insert into AttributeValue select a.id, 'Never', 1, 2, getdate(), 'Y', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Crescendo' and a.name = 'coopertition';
insert into AttributeValue select a.id, 'Depends on Alliance Partners', 2, 3, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Crescendo' and a.name = 'coopertition';
insert into AttributeValue select a.id, 'Requires agreement from opponent', 3, 4, getdate(), 'N', 'N' from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Crescendo' and a.name = 'coopertition';

-- Objectives
insert into Objective select g.id, 'toHPLoc', 'HP Loc:', st.id, null, null, null, 1, getdate(), 'HP', 'I', 'N', 'N', 1 from Game g, ScoringType st where g.name = 'Crescendo' and st.name = 'Radio Button'
insert into Objective select g.id, 'aLeave', 'Leave:', st.id, null, null, null, 2, getdate(), 'aLeave', 'S', 'Y', 'N', 2 from Game g, ScoringType st where g.name = 'Crescendo' and st.name = 'Radio Button'
insert into Objective select g.id, 'aSpeaker', 'Speaker:', st.id, 0, 6, 5, 3, getdate(), 'aSpeaker', 'I', 'N', 'N', 3 from Game g, ScoringType st where g.name = 'Crescendo' and st.name = 'Integer'
insert into Objective select g.id, 'aAmp', 'Amp:', st.id, 0, 3, 2, 4, getdate(), 'aAmp', 'I', 'Y', 'N', 4 from Game g, ScoringType st where g.name = 'Crescendo' and st.name = 'Integer'
insert into Objective select g.id, 'toSpeaker', 'Speaker:', st.id, 0, 15, 2, 5, getdate(), 'toSpeaker', 'I', 'N', 'Y', 5 from Game g, ScoringType st where g.name = 'Crescendo' and st.name = 'Integer'
insert into Objective select g.id, 'toAmp', 'Amp:', st.id, 0, 15, 1, 6, getdate(), 'toAmp', 'I', 'Y', 'Y', 6 from Game g, ScoringType st where g.name = 'Crescendo' and st.name = 'Integer'
insert into Objective select g.id, 'toTrap', 'Trap:', st.id, 0, 3, 5, 7, getdate(), 'toTrap', 'I', 'Y', 'N', 7 from Game g, ScoringType st where g.name = 'Crescendo' and st.name = 'Integer'
insert into Objective select g.id, 'toEnd', 'Stage:', st.id, null, null, null, 8, getdate(), 'Stage', 'S', 'N', 'N', 8 from Game g, ScoringType st where g.name = 'Crescendo' and st.name = 'Radio Button'
insert into Objective select g.id, 'toHPShot', 'HP Shots:', st.id, 0, 3, 0, 9, getdate(), 'HP Shot', 'I', 'N', 'N', 9 from Game g, ScoringType st where g.name = 'Crescendo' and st.name = 'Integer'
insert into Objective select g.id, 'toHPMade', 'HP Made:', st.id, 0, 3, 0, 10, getdate(), 'HP Made', 'I', 'Y', 'N', 10 from Game g, ScoringType st where g.name = 'Crescendo' and st.name = 'Integer'
insert into Objective select g.id, 'toDefense', 'Defense (0=None, 1=Poor to 4=Great):', st.id, null, null, null, 11, getdate(), 'Def', 'I', 'N', 'N', 11 from Game g, ScoringType st where g.name = 'Crescendo' and st.name = 'Radio Button'

-- Objective Value
insert into ObjectiveValue select o.id, 'Amp', 0, 1, 0, getdate(), 'Y', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Crescendo' and o.name = 'toHPLoc'
insert into ObjectiveValue select o.id, 'Source', 1, 2, 0, getdate(), 'Y', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Crescendo' and o.name = 'toHPLoc'
insert into ObjectiveValue select o.id, 'No', 0, 1, 0, getdate(), 'Y', 'No', null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Crescendo' and o.name = 'aLeave'
insert into ObjectiveValue select o.id, 'Yes', 1, 2, 2, getdate(), 'Y', 'Yes', null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Crescendo' and o.name = 'aLeave'
insert into ObjectiveValue select o.id, 'None', 0, 1, 0, getdate(), 'N', 'None', null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Crescendo' and o.name = 'toEnd'
insert into ObjectiveValue select o.id, 'Park', 1, 2, 1, getdate(), 'Y', 'Parked', null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Crescendo' and o.name = 'toEnd'
insert into ObjectiveValue select o.id, 'On Stage', 2, 3, 3, getdate(), 'Y', 'StageLeft', 'StageRight', 'CenterStage', null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Crescendo' and o.name = 'toEnd'
insert into ObjectiveValue select o.id, 'On Stage Spot', 3, 4, 4, getdate(), 'N', 'On Stage Spot', null, null, null, null, null, 'N' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Crescendo' and o.name = 'toEnd'
insert into ObjectiveValue select o.id, 'On Stage Harmony', 4, 5, 4, getdate(), 'N', 'On Stage Harmony', null, null, null, null, null, 'N' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Crescendo' and o.name = 'toEnd'
insert into ObjectiveValue select o.id, 'On Stage Spot/Harmony', 5, 6, 5, getdate(), 'N', 'On Stage Spot/Harmony', null, null, null, null, null, 'N' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Crescendo' and o.name = 'toEnd'
insert into ObjectiveValue select o.id, '0', null, 1, null, getdate(), 'N', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Crescendo' and o.name = 'toDefense'
insert into ObjectiveValue select o.id, '1', 1, 2, 0, getdate(), 'Y', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Crescendo' and o.name = 'toDefense'
insert into ObjectiveValue select o.id, '2', 2, 3, 0, getdate(), 'Y', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Crescendo' and o.name = 'toDefense'
insert into ObjectiveValue select o.id, '3', 3, 4, 0, getdate(), 'Y', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Crescendo' and o.name = 'toDefense'
insert into ObjectiveValue select o.id, '4', 4, 5, 0, getdate(), 'Y', null, null, null, null, null, null, 'Y' from Game g inner join Objective o on o.gameId = g.id where g.name = 'Crescendo' and o.name = 'toDefense'

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

insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Crescendo' and o.name = 'aLeave' and og.name = 'Autonomous' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Crescendo' and o.name = 'aSpeaker' and og.name = 'Autonomous' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Crescendo' and o.name = 'aAmp' and og.name = 'Autonomous' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Crescendo' and o.name = 'toSpeaker' and og.name = 'TeleOp' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Crescendo' and o.name = 'toAmp' and og.name = 'TeleOp' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Crescendo' and o.name = 'toTrap' and og.name = 'TeleOp' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Crescendo' and o.name = 'toEnd' and og.name = 'End Game' and og.groupCode = 'Report Line Graph'

-- Ranks
insert into Rank select 'Auto', 'rankAuto', 'S', 1, getdate(), g.id, 'N' from Game g where g.name = 'Crescendo'
insert into Rank select 'TO Spkr', 'rankSpeaker', 'V', 2, getdate(), g.id, 'N' from Game g where g.name = 'Crescendo'
insert into Rank select 'Amp', 'rankAmp', 'V', 3, getdate(), g.id, 'N' from Game g where g.name = 'Crescendo'
insert into Rank select 'Trap', 'rankTrap', 'V', 4, getdate(), g.id, 'N' from Game g where g.name = 'Crescendo'
insert into Rank select 'Stage', 'rankStage', 'S', 5, getdate(), g.id, 'N' from Game g where g.name = 'Crescendo'
insert into Rank select 'Defense', 'rankPlayedDefense', 'V', 6, getdate(), g.id, 'N' from Game g where g.name = 'Crescendo'
insert into Rank select 'Scr Imp', 'rankScoreImpact', 'S', 7, getdate(), g.id, 'Y' from Game g where g.name = 'Crescendo'
--insert into Rank select 'HP', 'rankHP', 'V', 6, getdate(), g.id from Game g where g.name = 'Crescendo'

-- Rank Objective
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Crescendo' and o.name = 'aLeave' and r.name = 'Auto'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Crescendo' and o.name = 'aSpeaker' and r.name = 'Auto'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Crescendo' and o.name = 'aAmp' and r.name = 'Auto'

insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Crescendo' and o.name = 'toSpeaker' and r.name = 'TO Spkr'

insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Crescendo' and o.name = 'toAmp' and r.name = 'Amp'

insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Crescendo' and o.name = 'toTrap' and r.name = 'Trap'

insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Crescendo' and o.name = 'toTrap' and r.name = 'Stage'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Crescendo' and o.name = 'toEnd' and r.name = 'Stage'

insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Crescendo' and o.name = 'aLeave' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Crescendo' and o.name = 'aSpeaker' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Crescendo' and o.name = 'aAmp' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Crescendo' and o.name = 'toSpeaker' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Crescendo' and o.name = 'toAmp' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Crescendo' and o.name = 'toTrap' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Crescendo' and o.name = 'toEnd' and r.name = 'Scr Imp'

insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Crescendo' and o.name = 'toDefense' and r.name = 'Defense'

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

insert into TeamSponsor select t.id, g.id, 'Gemini Signworks', 1, 10, 'Sponsors/Gemini.jpg', 'https://geminimade.com/', 50, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';
insert into TeamSponsor select t.id, g.id, 'CF Education Foundation', 0, 20, 'Sponsors/CF Ed Foundation.jpg', 'https://www.cannonfallsschools.com/community/education_foundation', 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';
insert into TeamSponsor select t.id, g.id, 'Aliveo Military Museum', 0, 30, 'Sponsors/AliveoMilitaryMuseum.jpg', 'http://www.aliveomuseum.org/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';
insert into TeamSponsor select t.id, g.id, 'VFW Post 4452', 0, 40, 'Sponsors/VFW.jpg', 'https://cannonfallsvfw.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';
insert into TeamSponsor select t.id, g.id, 'Oldcastle Infrastructure', 0, 50, 'Sponsors/Oldcastle_Infrastructure_Logo.jpg', 'https://oldcastleinfrastructure.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';
insert into TeamSponsor select t.id, g.id, 'Remax Realty', 0, 60, 'Sponsors/REMAX.png', 'https://www.remax.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';
insert into TeamSponsor select t.id, g.id, 'Cannon Falls Fire Department', 0, 70, 'Sponsors/CF Fire Department.jpg', 'https://www.cannonfallsmn.gov/fire', 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';
insert into TeamSponsor select t.id, g.id, 'American Legion Post 142', 0, 80, 'Sponsors/AmericanLegion.png', 'https://www.facebook.com/CannonFallsAmericanLegionPost142/', 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';
insert into TeamSponsor select t.id, g.id, 'Hernke Heating', 0, 100, 'Sponsors/hernkes heating and cooling.png', null, 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';
insert into TeamSponsor select t.id, g.id, '3M', 0, 110, 'Sponsors/3M.png', 'https://www.3m.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';
insert into TeamSponsor select t.id, g.id, 'Flex Craft', 0, 120, 'Sponsors/flex craft logo.png', 'https://flex-craft.com/', 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';
insert into TeamSponsor select t.id, g.id, 'Highland Sanitation', 0, 130, 'Sponsors/HighlandSanitation.png', 'https://www.highlandsanitation.com', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';
insert into TeamSponsor select t.id, g.id, 'Master CAM', 0, 140, 'Sponsors/mastercam_logo.png', 'https://www.mastercam.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';
insert into TeamSponsor select t.id, g.id, 'Quality One Woodworking', 0, 150, 'Sponsors/QualityOne.png', 'https://www.qualityonewoodwork.com/', 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';
insert into TeamSponsor select t.id, g.id, 'Sjoquist Hay and Straw', 0, 160, 'Sponsors/SjoquistHayAndStraw.jpg', 'https://www.facebook.com/SjoquistHayandStraw/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';
insert into TeamSponsor select t.id, g.id, 'Snap Fitness', 0, 170, 'Sponsors/Snap Fitness.jpg', 'https://www.snapfitness.com/us/gyms/cannon-falls-mn', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';
insert into TeamSponsor select t.id, g.id, 'StarTech Computing', 0, 180, 'Sponsors/StarTech-logo.png', 'https://www.startech-comp.com/', 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';
insert into TeamSponsor select t.id, g.id, 'Community Resource Bank', 0, 190, 'Sponsors/CommunityResourceBank.jpg', 'https://crb.bank/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';
insert into TeamSponsor select t.id, g.id, 'Interstate Building Supply', 0, 200, 'Sponsors/InterstateBuildingSupply.png', 'https://www.interstatebuildingsupply.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';
insert into TeamSponsor select t.id, g.id, 'Cannon Falls Rotary', 0, 220, 'Sponsors/Rotary.jpg', 'https://www.facebook.com/Cannonfallsrotary/', 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';
insert into TeamSponsor select t.id, g.id, 'Midwest Machinery - John Deere', 0, 230, 'Sponsors/midwest machinery.png', 'https://mmcjd.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';
insert into TeamSponsor select t.id, g.id, 'Jim Althoff Real Estate', 0, 240, 'Sponsors/JimAlthoffRealEstate.jpeg', 'https://www.facebook.com/JimAlthoffRealtor/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';
insert into TeamSponsor select t.id, g.id, 'Northlands Safety Solution', 0, 250, 'Sponsors/Northland Safety logo.png', 'https://www.northlandsafety.com/', 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';
insert into TeamSponsor select t.id, g.id, 'MN Woodcraft', 0, 255, 'Sponsors/MN Woodcraft.jpg', 'https://mnwoodcraft.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';
insert into TeamSponsor select t.id, g.id, 'Lorentz Meats', 0, 260, 'Sponsors/LorentzMeats.jpg', 'https://lorentzmeats.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';
insert into TeamSponsor select t.id, g.id, 'Milwaukee Tool', 0, 270, 'Sponsors/Milwaukee.jpg', 'https://www.milwaukeetool.com/', 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';
insert into TeamSponsor select t.id, g.id, 'Ace Hardware', 0, 272, 'Sponsors/AceHardware.png', 'https://www.acehardware.com/store-details/14225', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';
insert into TeamSponsor select t.id, g.id, 'Liberty Tax', 0, 275, 'Sponsors/Liberty.jpg', 'https://www.libertytax.com/income-tax-preparation-locations/minnesota/cannon-falls/14375', 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';
insert into TeamSponsor select t.id, g.id, 'Small Engine Service', 0, 278, 'Sponsors/SmallEngineService.jpg', 'https://www.smallengineservicewelch.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';
insert into TeamSponsor select t.id, g.id, 'Red Wing Area Manufacturers Association', 0, 280, 'Sponsors/RW Area Mfg Assoc.jpg', 'https://www.facebook.com/RWAreaMfrsAssoc/', 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';
insert into TeamSponsor select t.id, g.id, 'Caseys', 0, 290, 'Sponsors/Casey_s.png', 'https://www.caseys.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';
insert into TeamSponsor select t.id, g.id, 'Guhring', 0, 300, 'Sponsors/gurhing.png', 'https://www.guhring.com/', 30, getdate(), null, null, 'Y' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';
insert into TeamSponsor select t.id, g.id, 'J&J Aircraft Maint and Consulting', 0, 310, null, null, 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';
insert into TeamSponsor select t.id, g.id, 'Bob Draheim', 0, 320, null, null, 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';
insert into TeamSponsor select t.id, g.id, 'Seed Plus', 0, 330, null, null, 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';
insert into TeamSponsor select t.id, g.id, 'Ron & Marcia Freeburg', 0, 340, null, null, 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';
insert into TeamSponsor select t.id, g.id, 'Fastenal Company Purchasing', 0, 350, null, null, 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';
insert into TeamSponsor select t.id, g.id, 'Mark & Cindy Sjoquist', 0, 360, null, null, 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';
insert into TeamSponsor select t.id, g.id, 'Barbara McGeough', 0, 370, null, null, 30, getdate(), null, null, 'N' from team t, game g where t.teamNumber = 6217 and g.name = 'Crescendo';

update teamSponsor set maxWidthPercent = 10 where gameid = 7 and sortOrder = 20 -- CFEF
update teamSponsor set maxWidthPercent = 20 where gameid = 7 and sortOrder = 50 -- Old Castle
update teamSponsor set maxWidthPercent = 15 where gameid = 7 and sortOrder = 60 -- ReMax
update teamSponsor set maxWidthPercent = 10 where gameid = 7 and sortOrder = 70 -- CFFD
update teamSponsor set maxWidthPercent = 10 where gameid = 7 and sortOrder = 80 -- American Legion
update teamSponsor set maxWidthPercent = 15 where gameid = 7 and sortOrder = 100 -- Hernke
update teamSponsor set maxWidthPercent = 10 where gameid = 7 and sortOrder = 110 -- 3M
update teamSponsor set maxWidthPercent = 20 where gameid = 7 and sortOrder = 120 -- Flex Craft
update teamSponsor set maxWidthPercent = 20 where gameid = 7 and sortOrder = 130 -- Highland Sanitation
update teamSponsor set maxWidthPercent = 20 where gameid = 7 and sortOrder = 140 -- Master CAM
update teamSponsor set maxWidthPercent = 25 where gameid = 7 and sortOrder = 150 -- Quality One
update teamSponsor set maxWidthPercent = 15 where gameid = 7 and sortOrder = 160 -- Sjoquist
update teamSponsor set maxWidthPercent = 15 where gameid = 7 and sortOrder = 170 -- Snap
update teamSponsor set maxWidthPercent = 20 where gameid = 7 and sortOrder = 180 -- StarTech
update teamSponsor set maxWidthPercent = 20 where gameid = 7 and sortOrder = 190 -- CRB
update teamSponsor set maxWidthPercent = 10 where gameid = 7 and sortOrder = 220 -- CF Rotary
update teamSponsor set maxWidthPercent = 10 where gameid = 7 and sortOrder = 230 -- Midwest Machinery
update teamSponsor set maxWidthPercent = 15 where gameid = 7 and sortOrder = 240 -- Jim ALthoff
update teamSponsor set maxWidthPercent = 15 where gameid = 7 and sortOrder = 255 -- MN Woodcraft
update teamSponsor set maxWidthPercent = 10 where gameid = 7 and sortOrder = 260 -- Lorentz
update teamSponsor set maxWidthPercent = 20 where gameid = 7 and sortOrder = 270 -- Milwaukee
update teamSponsor set maxWidthPercent = 20 where gameid = 7 and sortOrder = 272 -- ACE Hardware
update teamSponsor set maxWidthPercent = 20 where gameid = 7 and sortOrder = 275 -- Liberty Tax
update teamSponsor set maxWidthPercent = 10 where gameid = 7 and sortOrder = 278 -- Small Engine Service
update teamSponsor set maxWidthPercent = 15 where gameid = 7 and sortOrder = 280 -- RW Area Mfg
update teamSponsor set maxWidthPercent = 10 where gameid = 7 and sortOrder = 290 -- Caseys
update teamSponsor set maxWidthPercent = 15 where gameid = 7 and sortOrder = 300 -- Guhring

select * from teamSponsor order by gameid desc, sortOrder

