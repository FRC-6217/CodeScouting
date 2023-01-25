-- Game
insert into Game (name, gameYear) values ('Charged Up', 2023);

-- Attributes
insert into Attribute select g.id, 'robotWidth', 'What is the width of your robot with bumpers (inches)?', st.id, null, null, 1, getdate(), 'Width', 'N' from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Integer'
insert into Attribute select g.id, 'robotWheelBase', 'What is the width of your robot wheel base (inches)?', st.id, null, null, 2, getdate(), 'Width', 'N' from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Integer'
insert into Attribute select g.id, 'autoChargeStation', 'Do you have an auto charge station program?', st.id, null, null, 3, getdate(), 'Charge Stat', 'N' from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Radio Button'
insert into Attribute select g.id, 'preferredStart', 'What is preferred start location?', st.id, null, null, 4, getdate(), 'Pref Start', 'N' from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Radio Button'
insert into Attribute select g.id, 'flexibleStart', 'Does your autonomous allow for flexible start location?', st.id, null, null, 5, getdate(), 'Flex Start', 'N' from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Radio Button'
insert into Attribute select g.id, 'movementDescription', 'Describe autonomous movement?', st.id, null, null, 6, getdate(), 'Move Desc', 'N' from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Free Form'
insert into Attribute select g.id, 'gamePiecePickup', 'How does your robot attain game pieces?', st.id, null, null, 7, getdate(), 'Pickup', 'N' from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Radio Button'
insert into Attribute select g.id, 'chargeStationDescription', 'Describe your charge station end game plan?', st.id, null, null, 8, getdate(), 'Chg Stat', 'N' from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Free Form'
-- Attribute Values
insert into attributeValue select a.id, 'No', 0, 1, getdate() from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'autoChargeStation';
insert into attributeValue select a.id, 'Yes - Docked', 1, 2, getdate() from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'autoChargeStation';
insert into attributeValue select a.id, 'Yes - Engaged', 1, 2, getdate() from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'autoChargeStation';
insert into attributeValue select a.id, 'Above Charge Station', 0, 1, getdate() from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'preferredStart';
insert into attributeValue select a.id, 'Behind Charge Station', 1, 2, getdate() from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'preferredStart';
insert into attributeValue select a.id, 'Below Charge Station', 2, 3, getdate() from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'preferredStart';
insert into attributeValue select a.id, 'No Preference', 3, 4, getdate() from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'preferredStart';
insert into attributeValue select a.id, 'No', 0, 1, getdate() from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'flexibleStart';
insert into attributeValue select a.id, 'Yes', 1, 2, getdate() from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'flexibleStart';
insert into attributeValue select a.id, 'Off Floor', 0, 1, getdate() from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'gamePiecePickup';
insert into attributeValue select a.id, 'Substation Shelf', 1, 2, getdate() from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'gamePiecePickup';
insert into attributeValue select a.id, 'Both', 2, 3, getdate() from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'gamePiecePickup';
insert into attributeValue select a.id, 'Neither', 3, 4, getdate() from Game g inner join Attribute a on a.gameId = g.id where g.name = 'Charged Up' and a.name = 'gamePiecePickup';

/* To Do
-- Objectives
insert into Objective select g.id, 'aMove', 'Move out of Tarmac:', st.id, null, null, null, 1, getdate(), 'aMove', 'S', 'N', 'N' from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Radio Button'
insert into Objective select g.id, 'aHP', 'Human Player Shot:', st.id, null, null, null, 2, getdate(), 'HPShot', 'I', 'N', 'N' from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Radio Button'
insert into Objective select g.id, 'aCLower', 'Auto Lwr:', st.id, 0, 5, 2, 3, getdate(), 'aLower', 'I', 'N', 'N' from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Integer'
insert into Objective select g.id, 'aCUpper', 'Upper:', st.id, 0, 5, 4, 4, getdate(), 'aUpper', 'I', 'Y', 'N' from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Integer'
insert into Objective select g.id, 'toCLower', 'T/O Lwr:', st.id, 0, 20, 1, 5, getdate(), 'toLower', 'I', 'N', 'N' from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Integer'
insert into Objective select g.id, 'toCUpper', 'Upper:', st.id, 0, 20, 2, 6, getdate(), 'toUpper', 'I', 'Y', 'N' from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Integer'
insert into Objective select g.id, 'toDefense', 'Defense:', st.id, null, null, null, 7, getdate(), 'Defense', 'I', 'N', 'N' from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Radio Button'
insert into Objective select g.id, 'toHang', 'Hang:', st.id, null, null, null, 8, getdate(), 'Hang', 'S', 'N', 'N' from Game g, ScoringType st where g.name = 'Charged Up' and st.name = 'Radio Button'
-- Objective Group Objectives
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'aHP' and og.name = 'Autonomous' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'aMove' and og.name = 'Autonomous' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'aCLower' and og.name = 'Autonomous' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'aCUpper' and og.name = 'Autonomous' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'toCLower' and og.name = 'Tele Op' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'toCUpper' and og.name = 'Tele Op' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'toDefense' and og.name = 'Tele Op' and og.groupCode = 'Scout Match'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'toHang' and og.name = 'End Game' and og.groupCode = 'Scout Match'

insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'aMove' and og.name = 'Autonomous' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'aCLower' and og.name = 'Autonomous' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'aCUpper' and og.name = 'Autonomous' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'toCLower' and og.name = 'TeleOp' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'toCUpper' and og.name = 'TeleOp' and og.groupCode = 'Report Pie Chart'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'toHang' and og.name = 'End Game' and og.groupCode = 'Report Pie Chart'

insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'aMove' and og.name = 'Autonomous' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'aCLower' and og.name = 'Autonomous' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'aCUpper' and og.name = 'Autonomous' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'aCLower' and og.name = 'Cargo' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'aCUpper' and og.name = 'Cargo' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'toCLower' and og.name = 'Cargo' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'toCUpper' and og.name = 'Cargo' and og.groupCode = 'Report Line Graph'
insert into ObjectiveGroupObjective select og.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id, ObjectiveGroup og where g.name = 'Charged Up' and o.name = 'toHang' and og.name = 'End Game' and og.groupCode = 'Report Line Graph'

-- Objective Value
insert into ObjectiveValue select o.id, 'No', 0, 1, 0, getdate(), 'N', 'No', null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Charged Up' and o.name = 'aMove'
insert into ObjectiveValue select o.id, 'Yes', 1, 2, 2, getdate(), 'Y', 'Yes', null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Charged Up' and o.name = 'aMove'
insert into ObjectiveValue select o.id, 'No Shot', 0, 1, 0, getdate(), 'N', null, null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Charged Up' and o.name = 'aHP'
insert into ObjectiveValue select o.id, 'Missed Shot', -1, 2, 0, getdate(), 'N', null, null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Charged Up' and o.name = 'aHP'
insert into ObjectiveValue select o.id, 'Made Shot', 1, 3, 0, getdate(), 'Y', null, null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Charged Up' and o.name = 'aHP'
insert into ObjectiveValue select o.id, 'No Defense', 0, 1, 0, getdate(), 'N', null, null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Charged Up' and o.name = 'toDefense'
insert into ObjectiveValue select o.id, 'Poor Defense', -1, 2, 0, getdate(), 'Y', null, null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Charged Up' and o.name = 'toDefense'
insert into ObjectiveValue select o.id, 'Good Defense', 1, 3, 0, getdate(), 'N', null, null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Charged Up' and o.name = 'toDefense'
insert into ObjectiveValue select o.id, 'Excellent Defense', 2, 4, 0, getdate(), 'Y', null, null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Charged Up' and o.name = 'toDefense'
insert into ObjectiveValue select o.id, 'No Hang', 0, 1, 0, getdate(), 'N', 'None', null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Charged Up' and o.name = 'toHang'
insert into ObjectiveValue select o.id, 'Low Rung', 1, 2, 4, getdate(), 'N', 'Low', null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Charged Up' and o.name = 'toHang'
insert into ObjectiveValue select o.id, 'Mid Rung', 2, 3, 6, getdate(), 'Y', 'Mid', null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Charged Up' and o.name = 'toHang'
insert into ObjectiveValue select o.id, 'High Rung', 3, 4, 10, getdate(), 'N', 'High', null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Charged Up' and o.name = 'toHang'
insert into ObjectiveValue select o.id, 'Traverse', 4, 5, 15, getdate(), 'Y', 'Traversal', null, null, null, null, null from Game g inner join Objective o on o.gameId = g.id where g.name = 'Charged Up' and o.name = 'toHang'

-- Ranks
insert into Rank select 'Auto', 'rankAuto', 'S', 1, getdate(), g.id from Game g where g.name = 'Charged Up'
insert into Rank select 'Cargo', 'rankC', 'S', 2, getdate(), g.id from Game g where g.name = 'Charged Up'
insert into Rank select 'End Game', 'rankFinish', 'S', 3, getdate(), g.id from Game g where g.name = 'Charged Up'
insert into Rank select 'Defense', 'rankPlayedDefense', 'V', 5, getdate(), g.id from Game g where g.name = 'Charged Up'
insert into Rank select 'Scr Imp', 'rankScoreImpact', 'S', 4, getdate(), g.id from Game g where g.name = 'Charged Up'
insert into Rank select 'HP', 'rankHP', 'V', 6, getdate(), g.id from Game g where g.name = 'Charged Up'

-- Rank Objective
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'aMove' and r.name = 'Auto'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'aCLower' and r.name = 'Auto'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'aCUpper' and r.name = 'Auto'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'aCLower' and r.name = 'Cargo'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'aCUpper' and r.name = 'Cargo'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'toCLower' and r.name = 'Cargo'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'toCUpper' and r.name = 'Cargo'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'toHang' and r.name = 'End Game'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'toDefense' and r.name = 'Defense'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'aMove' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'aCLower' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'aCUpper' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'toCLower' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'toCUpper' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'toHang' and r.name = 'Scr Imp'
insert into RankObjective select r.id, o.id, getdate() from Game g inner join Objective o on o.gameId = g.id inner join Rank r on r.gameId = g.id where g.name = 'Charged Up' and o.name = 'aHP' and r.name = 'HP'

-- Scout
update Scout set isActive = 'N' where teamId in (select id from Team where teamNumber = 6217) and lastname + firstname not in ('CoyleJoe', 'EngebretsenDave', 'BuchheitRiley' ,'TBA');
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Addington', 'Cam', t.id, 'Y', '25ca01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Addington' and s.firstName = 'Cam' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Anderson', 'Gideon', t.id, 'Y', '23ga01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Anderson' and s.firstName = 'Gideon' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Auger', 'Sara', t.id, 'Y', '24sa01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Auger' and s.firstName = 'Sara' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Banitt', 'Brody', t.id, 'Y', '26bb02@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Banitt' and s.firstName = 'Brody' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Beyer', 'Ashton', t.id, 'Y', '22ab04@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Beyer' and s.firstName = 'Ashton' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Broenen', 'Jon', t.id, 'Y', '23jb01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Broenen' and s.firstName = 'Jon' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Brokate', 'Max', t.id, 'Y', '25mb02@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Brokate' and s.firstName = 'Max' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Caputo', 'Lachlan', t.id, 'Y', '24lc01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Delk' and s.firstName = 'Joshua' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Coyle', 'Samuel', t.id, 'Y', '22sc01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Coyle' and s.firstName = 'Samuel' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Coyle', 'Thomas', t.id, 'Y', '25tc01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Coyle' and s.firstName = 'Thomas' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Dettmann', 'Madison', t.id, 'Y', '26md01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Dettmann' and s.firstName = 'Madison' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Fick', 'Charles', t.id, 'Y', '26cf02@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Dettmann' and s.firstName = 'Madison' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Giese', 'Matthew', t.id, 'Y', '22mg01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Giese' and s.firstName = 'Matthew' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Hernke', 'Luke', t.id, 'Y', 'hernkelm@gmail.com', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Hernke' and s.firstName = 'Luke' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Lochner', 'Brighton', t.id, 'Y', '23bl01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Lochner' and s.firstName = 'Brighton' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Loeschke', 'Connor', t.id, 'Y', 'cjloeschke@gmail.com', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Loeschke' and s.firstName = 'Connor' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Lopez', 'Emma', t.id, 'Y', '23el02@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Ludden' and s.firstName = 'Lauren' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'McGeough', 'Andrew', t.id, 'Y', '26am01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'McGeough' and s.firstName = 'Andrew' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'McGeough', 'Riley', t.id, 'Y', 'riley.mcgeough@icloud.com', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'McGeough' and s.firstName = 'Riley' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'McGuire', 'Tyler', t.id, 'Y', '24tm01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'McGuire' and s.firstName = 'Tyler' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Nelson', 'Isaac', t.id, 'Y', '23in01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Nelson' and s.firstName = 'Isaac' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Rapp', 'Axel', t.id, 'Y', null, 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Rapp' and s.firstName = 'Axel' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Smith', 'Ivy', t.id, 'Y', '26is01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Strecker' and s.firstName = 'Teagan' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Strecker', 'Teagan', t.id, 'Y', '23ts01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Strecker' and s.firstName = 'Teagan' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Strecker', 'Torin', t.id, 'Y', '26ts01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Strecker' and s.firstName = 'Torin' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Swenson', 'Brandon', t.id, 'Y', '24bs01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Swenson' and s.firstName = 'Brandon' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'White', 'Brandon', t.id, 'Y', '25bw01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'White' and s.firstName = 'Brandon' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'White', 'Ethan', t.id, 'Y', '22ew01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'White' and s.firstName = 'Ethan' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Fick', 'Charles', t.id, 'Y', '26cf02@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Fick' and s.firstName = 'Charles' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Lopez', 'Emma', t.id, 'Y', '23el02@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Lopez' and s.firstName = 'Emma' and s.teamId = t.id);
update Scout set isActive = 'Y' where lastName = 'Addington' and firstName = 'Cam' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Anderson' and firstName = 'Gideon' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Auger' and firstName = 'Sara' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Banitt' and firstName = 'Brody' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Beyer' and firstName = 'Ashton' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Broenen' and firstName = 'Jon' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Brokate' and firstName = 'Max' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Caputo' and firstName = 'Lachlan' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Coyle' and firstName = 'Samuel' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Coyle' and firstName = 'Thomas' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Dettmann' and firstName = 'Madison' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Fick' and firstName = 'Charles' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Giese' and firstName = 'Matthew' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Hernke' and firstName = 'Luke' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Lochner' and firstName = 'Brighton' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Loeschke' and firstName = 'Connor' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Lopez' and firstName = 'Emma' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'McGeough' and firstName = 'Andrew' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'McGeough' and firstName = 'Riley' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'McGuire' and firstName = 'Tyler' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Nelson' and firstName = 'Isaac' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Rapp' and firstName = 'Axel' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Smith' and firstName = 'Ivy' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Strecker' and firstName = 'Teagan' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Strecker' and firstName = 'Torin' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Swenson' and firstName = 'Brandon' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'White' and firstName = 'Brandon' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'White' and firstName = 'Ethan' and teamId = (select id from Team where teamNumber = 6217);

update Scout set isAdmin = 'N' where isActive = 'N' and isAdmin = 'Y';
*/
