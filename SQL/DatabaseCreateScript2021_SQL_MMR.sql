-- Game
insert into Game (name, gameYear) values ('Infinite Recharge 2', 2021);

-- Events
insert into Event (name, location, eventCode) values ('Minne-Mini Offseason', 'Prior Lake High School', 'mmr');

-- Game Events
insert into GameEvent (eventId, gameId, eventDate) select e.Id, g.Id, '11/20/2021' from event e, game g where e.Name = 'Minne-Mini Offseason' and g.name = 'Infinite Recharge 2';

-- Teams
insert into Team (teamNumber, teamName, location) select 3023, 'Stark Industries', 'Elk River MN' where not exists (select 1 from Team where teamNumber = 3023);
insert into Team (teamNumber, teamName, location) select 4277, 'Thingamajiggers', 'New Hope MN' where not exists (select 1 from Team where teamNumber = 4277);
insert into Team (teamNumber, teamName, location) select 8516, 'Wired up', 'Andover MN' where not exists (select 1 from Team where teamNumber = 8516);

-- Team Game Events
insert into TeamGameEvent (teamId, gameEventId)
select t.id, ge.id
  from team t
     , gameEvent ge
	   inner join game g
	      on g.id = ge.gameId
	   inner join event e
	      on e.id = ge.eventId
 where g.name = 'Infinite Recharge 2'
   and e.name = 'Minne-Mini Offseason'
   and t.teamNumber in (1816,2052,2129,2169,2175,2227,2264,2472,2502,2512,2531,2574,2667,2823,2846,2847,3023,3042,3058,3184
                       ,3630,3848,3883,3926,4198,4239,4277,4607,5275,5690,6166,6217,7021,7028,7068,8516);

-- Scout
select * from scout order by isactive desc, 2, 3
update Scout set isActive = 'N' where teamId in (select id from Team where teamNumber = 6217) and lastname + firstname not in ('CoyleJoe', 'EngebretsenDave', 'BuchheitRiley' ,'TBA');
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Addington', 'Cam', t.id, 'Y', '25ca01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Addington' and s.firstName = 'Cam' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Anderson', 'Gideon', t.id, 'Y', '23ga01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Anderson' and s.firstName = 'Gideon' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Auger', 'Sara', t.id, 'Y', '24sa01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Auger' and s.firstName = 'Sara' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Banitt', 'Brody', t.id, 'Y', '26bb02@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Banitt' and s.firstName = 'Brody' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Beyer', 'Ashton', t.id, 'Y', '22ab04@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Beyer' and s.firstName = 'Ashton' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Broenen', 'Jon', t.id, 'Y', '23jb01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Broenen' and s.firstName = 'Jon' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Brokate', 'Max', t.id, 'Y', '25mb02@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Brokate' and s.firstName = 'Max' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Coyle', 'Samuel', t.id, 'Y', '22sc01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Coyle' and s.firstName = 'Samuel' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Coyle', 'Thomas', t.id, 'Y', '25tc01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Coyle' and s.firstName = 'Thomas' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Delk', 'Joshua', t.id, 'Y', '25jd01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Delk' and s.firstName = 'Joshua' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Dettmann', 'Madison', t.id, 'Y', '26md01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Dettmann' and s.firstName = 'Madison' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Giese', 'Matthew', t.id, 'Y', '22mg01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Giese' and s.firstName = 'Matthew' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Hernke', 'Luke', t.id, 'Y', 'hernkelm@gmail.com', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Hernke' and s.firstName = 'Luke' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Lochner', 'Brighton', t.id, 'Y', '23bl01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Lochner' and s.firstName = 'Brighton' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Loeschke', 'Connor', t.id, 'Y', 'cjloeschke@gmail.com', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Loeschke' and s.firstName = 'Connor' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Ludden', 'Lauren', t.id, 'Y', '23ll01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Ludden' and s.firstName = 'Lauren' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'McGeough', 'Andrew', t.id, 'Y', '26am01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'McGeough' and s.firstName = 'Andrew' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'McGeough', 'Riley', t.id, 'Y', 'riley.mcgeough@icloud.com', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'McGeough' and s.firstName = 'Riley' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'McGuire', 'Tyler', t.id, 'Y', '24tm01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'McGuire' and s.firstName = 'Tyler' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Nelson', 'Isaac', t.id, 'Y', '23in01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Nelson' and s.firstName = 'Isaac' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Rapp', 'Axel', t.id, 'Y', null, 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Rapp' and s.firstName = 'Axel' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Strecker', 'Teagan', t.id, 'Y', '23ts01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Strecker' and s.firstName = 'Teagan' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Strecker', 'Torin', t.id, 'Y', '26ts01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Strecker' and s.firstName = 'Torin' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'Swenson', 'Brandon', t.id, 'Y', '24bs01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'Swenson' and s.firstName = 'Brandon' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'White', 'Brandon', t.id, 'Y', '25bw01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'White' and s.firstName = 'Brandon' and s.teamId = t.id);
insert into Scout (lastName, firstName, teamId, isActive, emailAddress, isAdmin) select 'White', 'Ethan', t.id, 'Y', '22ew01@cf.k12.mn.us', 'N' from Team t where t.teamNumber = 6217 and not exists (select 1 from Scout s where s.lastName = 'White' and s.firstName = 'Ethan' and s.teamId = t.id);
update Scout set isActive = 'Y' where lastName = 'Addington' and firstName = 'Cam' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Anderson' and firstName = 'Gideon' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Auger' and firstName = 'Sara' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Banitt' and firstName = 'Brody' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Beyer' and firstName = 'Ashton' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Broenen' and firstName = 'Jon' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Brokate' and firstName = 'Max' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Coyle' and firstName = 'Samuel' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Coyle' and firstName = 'Thomas' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Delk' and firstName = 'Joshua' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Dettmann' and firstName = 'Madison' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Giese' and firstName = 'Matthew' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Hernke' and firstName = 'Luke' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Lochner' and firstName = 'Brighton' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Loeschke' and firstName = 'Connor' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Ludden' and firstName = 'Lauren' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'McGeough' and firstName = 'Andrew' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'McGeough' and firstName = 'Riley' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'McGuire' and firstName = 'Tyler' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Nelson' and firstName = 'Isaac' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Rapp' and firstName = 'Axel' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Strecker' and firstName = 'Teagan' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Strecker' and firstName = 'Torin' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'Swenson' and firstName = 'Brandon' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'White' and firstName = 'Brandon' and teamId = (select id from Team where teamNumber = 6217);
update Scout set isActive = 'Y' where lastName = 'White' and firstName = 'Ethan' and teamId = (select id from Team where teamNumber = 6217);

update Scout set isAdmin = 'N' where isActive = 'N' and isAdmin = 'Y';

-- Objective
insert into Objective
       (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue, scoreMultiplier, sortOrder, tableHeader, reportDisplay, sameLineAsPrevious, addTeamScorePortion)
select g2.id gameId, o.name, label, scoringTypeId, lowRangeValue, highRangeValue, scoreMultiplier, sortOrder, tableHeader, reportDisplay, sameLineAsPrevious, addTeamScorePortion
  from Objective o
       inner join Game g
	      on g.id = o.GameId
	 , game g2
 where g.Name = 'Infinite Recharge'
   and g2.Name = 'Infinite Recharge 2'

-- Objective Values
insert into ObjectiveValue
      (objectiveId, displayValue, integerValue, sortOrder, scoreValue, sameLineAsPrevious, tbaValue, tbaValue2, tbaValue3, tbaValue4, tbaValue5, tbaValue6)
select o2.id objectiveId, ov.displayValue, ov.integerValue, ov.sortOrder, ov.scoreValue, ov.sameLineAsPrevious, ov.tbaValue, ov.tbaValue2, ov.tbaValue3, ov.tbaValue4, ov.tbaValue5, ov.tbaValue6
  from ObjectiveValue ov
       inner join Objective o
	      on o.id = ov.objectiveId
       inner join Game g
	      on g.id = o.GameId
	 , Objective o2
	   inner join game g2
	      on g2.id = o2.GameId
 where g.Name = 'Infinite Recharge'
   and g2.Name = 'Infinite Recharge 2'
   and o.name = o2.name

-- Objective Group Objective
insert into ObjectiveGroupObjective
      (objectiveGroupId, objectiveId)
select objectiveGroupId, o2.id objectiveId
  from ObjectiveGroupObjective ogo
       inner join Objective o
	      on o.id = ogo.objectiveId
       inner join Game g
	      on g.id = o.GameId
	 , Objective o2
	   inner join game g2
	      on g2.id = o2.GameId
 where g.Name = 'Infinite Recharge'
   and g2.Name = 'Infinite Recharge 2'
   and o.name = o2.name

-- Rank
insert into Rank
       (name, queryString, type, sortOrder, gameId)
select r.name, queryString, type, sortOrder, g2.id gameId
  from Rank r
       inner join Game g
	      on g.id = r.GameId
	 , game g2
 where g.Name = 'Infinite Recharge'
   and g2.Name = 'Infinite Recharge 2'

-- Rank Objective
insert into RankObjective
      (rankId, objectiveId)
select r2.id rankId, o2.id objectiveId
  from Rank r
       inner join RankObjective ro
	      on ro.rankId = r.id
       inner join Objective o
	      on o.id = ro.objectiveId
       inner join Game g
	      on g.id = o.GameId
	 , Objective o2
	   inner join game g2
	      on g2.id = o2.GameId
	   inner join rank r2
	      on r2.gameId = g2.id
 where g.Name = 'Infinite Recharge'
   and g2.Name = 'Infinite Recharge 2'
   and o.name = o2.name
   and r.name = r2.name

-- Attribute
insert into Attribute
       (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue, sortOrder, tableHeader, sameLineAsPrevious)
select g2.id gameId, a.name, a.label, a.scoringTypeId, a.lowRangeValue, a.highRangeValue, a.sortOrder, a.tableHeader, a.sameLineAsPrevious
  from Attribute a
       inner join Game g
	      on g.id = a.GameId
	 , game g2
 where g.Name = 'Infinite Recharge'
   and g2.Name = 'Infinite Recharge 2'

-- Attribute Value
insert into AttributeValue
      (attributeId, displayValue, integerValue, sortOrder)
select a2.id attributeId, av.displayValue, av.integerValue, av.sortOrder
  from AttributeValue av
       inner join Attribute a
	      on a.id = av.attributeId
       inner join Game g
	      on g.id = a.GameId
	 , Attribute a2
	   inner join game g2
	      on g2.id = a2.GameId
 where g.Name = 'Infinite Recharge'
   and g2.Name = 'Infinite Recharge 2'
   and a.name = a2.name

select *
  from AttributeValue

-- Match
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 1, '11/20/2021 08:45', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 2, '11/20/2021 08:55', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 3, '11/20/2021 09:05', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 4, '11/20/2021 09:15', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 5, '11/20/2021 09:25', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 6, '11/20/2021 09:35', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 7, '11/20/2021 09:45', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 8, '11/20/2021 09:55', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 9, '11/20/2021 10:05', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 10, '11/20/2021 10:15', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 11, '11/20/2021 10:25', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 12, '11/20/2021 10:35', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 13, '11/20/2021 10:45', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 14, '11/20/2021 10:55', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 15, '11/20/2021 11:05', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 16, '11/20/2021 11:15', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 17, '11/20/2021 11:25', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 18, '11/20/2021 11:35', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 19, '11/20/2021 11:45', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 20, '11/20/2021 11:55', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 21, '11/20/2021 12:05', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 22, '11/20/2021 12:15', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 23, '11/20/2021 12:25', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 24, '11/20/2021 13:15', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 25, '11/20/2021 13:25', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 26, '11/20/2021 13:35', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 27, '11/20/2021 13:45', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 28, '11/20/2021 13:55', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 29, '11/20/2021 14:05', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 30, '11/20/2021 14:15', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 31, '11/20/2021 14:25', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 32, '11/20/2021 14:35', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 33, '11/20/2021 14:45', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 34, '11/20/2021 14:55', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 35, '11/20/2021 15:05', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 36, '11/20/2021 15:15', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 37, '11/20/2021 15:25', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 38, '11/20/2021 15:35', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, 39, '11/20/2021 15:45', 'QM', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'

insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, '1-1', '11/20/2021 16:20', 'QF', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, '2-1', '11/20/2021 16:27', 'QF', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, '1-2', '11/20/2021 16:34', 'QF', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, '2-2', '11/20/2021 16:41', 'QF', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, '1-3', '11/20/2021 16:48', 'QF', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, '2-3', '11/20/2021 16:55', 'QF', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, '1-1', '11/20/2021 17:02', 'F', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, '1-2', '11/20/2021 17:09', 'F', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.id, '1-3', '11/20/2021 17:16', 'F', 'Y' from game g inner join gameEvent ge on ge.gameId = g.id inner join Event e on e.id = ge.eventId where g.name = 'Infinite Recharge 2' and e.name = 'Minne-Mini Offseason'

-- Team Match
select * from teamMatch
--delete from teamMatch
 where matchId in (select m.id
                     from match m
						  inner join gameEvent ge
							 on ge.id = m.gameEventId
						  inner join game g
							 on g.id = ge.gameId
						  inner join event e
							 on e.id = ge.eventId
					where g.name = 'Infinite Recharge 2'
					  and e.name = 'Minne-Mini Offseason')

insert into teamMatch (matchId, teamId, alliance, alliancePosition)
select m.id matchId
     , (select t.id
	      from Team t
		 where t.teamNumber = subquery.teamNumber) teamId
	 , subquery.alliance
	 , subquery.position
  from (
select '1' matchNumber, 1816 teamNumber, 'R' alliance, 1 position union select '1' matchNumber, 2823 teamNumber, 'R' alliance, 2 position union select '1' matchNumber, 3883 teamNumber, 'R' alliance, 3 position union select '1' matchNumber, 4239 teamNumber, 'B' alliance, 1 position union select '1' matchNumber, 6217 teamNumber, 'B' alliance, 2 position union select '1' matchNumber, 8516 teamNumber, 'B' alliance, 3 position
) subquery
  inner join match m
     on m.number = subquery.matchNumber
  inner join gameEvent ge
	 on ge.id = m.gameEventId
  inner join game g
	 on g.id = ge.gameId
  inner join event e
	 on e.id = ge.eventId
 where g.name = 'Infinite Recharge 2'
   and e.name = 'Minne-Mini Offseason'

-- Scout Records
--insert into ScoutRecord (scoutId, matchId, teamId) select 20, m.id, t.id from match m, team t where t.teamNumber = 6022 and m.gameEventId = 7 and m.number = '1' and m.type = 'PR';	insert into ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue) select sr.id, 104, 1 from scoutRecord sr inner join match m on m.id = sr.matchId inner join team t on t.id = sr.teamId where t.teamNumber = 6022 and m.gameEventId = 7 and m.number = '1' and m.type = 'PR';	insert into ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue) select sr.id, 101, 0 from scoutRecord sr inner join match m on m.id = sr.matchId inner join team t on t.id = sr.teamId where t.teamNumber = 6022 and m.gameEventId = 7 and m.number = '1' and m.type = 'PR';	insert into ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue) select sr.id, 102, 1 from scoutRecord sr inner join match m on m.id = sr.matchId inner join team t on t.id = sr.teamId where t.teamNumber = 6022 and m.gameEventId = 7 and m.number = '1' and m.type = 'PR';	insert into ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue) select sr.id, 103, 2 from scoutRecord sr inner join match m on m.id = sr.matchId inner join team t on t.id = sr.teamId where t.teamNumber = 6022 and m.gameEventId = 7 and m.number = '1' and m.type = 'PR';	insert into ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue) select sr.id, 105, 0 from scoutRecord sr inner join match m on m.id = sr.matchId inner join team t on t.id = sr.teamId where t.teamNumber = 6022 and m.gameEventId = 7 and m.number = '1' and m.type = 'PR';	insert into ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue) select sr.id, 106, 0 from scoutRecord sr inner join match m on m.id = sr.matchId inner join team t on t.id = sr.teamId where t.teamNumber = 6022 and m.gameEventId = 7 and m.number = '1' and m.type = 'PR';	insert into ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue) select sr.id, 107, 0 from scoutRecord sr inner join match m on m.id = sr.matchId inner join team t on t.id = sr.teamId where t.teamNumber = 6022 and m.gameEventId = 7 and m.number = '1' and m.type = 'PR';	insert into ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue) select sr.id, 108, 0 from scoutRecord sr inner join match m on m.id = sr.matchId inner join team t on t.id = sr.teamId where t.teamNumber = 6022 and m.gameEventId = 7 and m.number = '1' and m.type = 'PR';	insert into ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue) select sr.id, 110, 0 from scoutRecord sr inner join match m on m.id = sr.matchId inner join team t on t.id = sr.teamId where t.teamNumber = 6022 and m.gameEventId = 7 and m.number = '1' and m.type = 'PR';	insert into ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue) select sr.id, 112, 0 from scoutRecord sr inner join match m on m.id = sr.matchId inner join team t on t.id = sr.teamId where t.teamNumber = 6022 and m.gameEventId = 7 and m.number = '1' and m.type = 'PR';	insert into ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue) select sr.id, 113, 0 from scoutRecord sr inner join match m on m.id = sr.matchId inner join team t on t.id = sr.teamId where t.teamNumber = 6022 and m.gameEventId = 7 and m.number = '1' and m.type = 'PR';
