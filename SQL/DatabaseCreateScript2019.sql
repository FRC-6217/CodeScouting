/*
drop view v_AvgRobotRecord;
drop view v_AvgScoutRecord;
drop view v_MatchHyperlinks;
drop view v_MatchReport;
drop view v_RobotReport;
drop table ScoutRecord;
drop table MatchRobot;
drop table Match;
drop table Robot;
drop table Competition;
drop table Scout;
*/

create table Scout(
	id integer not null GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	lastName varchar(128) not null,
	firstName varchar(128) not null,
	isActive char(1) not null,
	primary key (id));
create unique index idx_scout on Scout(lastName, firstName);
insert into Scout (lastName, firstName, isActive) values ('Allen', 'Katie', 'Y');
insert into Scout (lastName, firstName, isActive) values ('Allen', 'Kristy', 'Y');
insert into Scout (lastName, firstName, isActive) values ('Auger', 'Sam', 'N');
insert into Scout (lastName, firstName, isActive) values ('Bhakta', 'Sanskar', 'Y');
insert into Scout (lastName, firstName, isActive) values ('Coyle', 'Samuel', 'Y');
insert into Scout (lastName, firstName, isActive) values ('Deutsch', 'Alex', 'N');
insert into Scout (lastName, firstName, isActive) values ('Engebretsen', 'Nick', 'Y');
insert into Scout (lastName, firstName, isActive) values ('Garrett', 'Nathaniel', 'Y');
insert into Scout (lastName, firstName, isActive) values ('Giese', 'Matthew', 'Y');
insert into Scout (lastName, firstName, isActive) values ('Jacobson', 'Tucker', 'Y');
insert into Scout (lastName, firstName, isActive) values ('Jesh', 'Zoe', 'Y');
insert into Scout (lastName, firstName, isActive) values ('Kehrberg', 'Kris', 'Y');
insert into Scout (lastName, firstName, isActive) values ('Klavon', 'Wyatt', 'Y');
insert into Scout (lastName, firstName, isActive) values ('Miller', 'Ella', 'Y');
insert into Scout (lastName, firstName, isActive) values ('Parks', 'Preston', 'Y');
insert into Scout (lastName, firstName, isActive) values ('Schlichting', 'Ryan', 'Y');
insert into Scout (lastName, firstName, isActive) values ('Souza', 'Izzy', 'Y');
insert into Scout (lastName, firstName, isActive) values ('Stadlinger', 'Lena', 'Y');
insert into Scout (lastName, firstName, isActive) values ('Sucher', 'Tom', 'Y');
insert into Scout (lastName, firstName, isActive) values ('Weinreich', 'Xander', 'Y');
insert into Scout (lastName, firstName, isActive) values ('White', 'Ethan', 'Y');
insert into Scout (lastName, firstName, isActive) values ('Wildenberg', 'Isaiah', 'Y');

create table Competition(
	id integer not null GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	name varchar(128) not null,
	competitionDate date not null,
	location varchar(128) not null,
	isActive char(1) not null,
	primary key (id));
create unique index idx_competition on Competition(name, competitionDate);
insert into Competition (name, competitionDate, location, isActive) values ('Lake Superior Regional', '03/07/2019', 'Duluth, MN', 'N');
insert into Competition (name, competitionDate, location, isActive) values ('Iowa Regional', '03/21/2019', 'Cedar Falls, IA', 'Y');

create table Match(
	id integer not null GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	competitionId integer not null,
	number varchar(8) not null,
	dateTime TIMESTAMP not null,
	type char(1) not null,
	isActive char(1) not null,
	primary key (id));
create unique index idx_match on Match(competitionId, dateTime);
alter table Match add foreign key fk_Match_Competition (competitionId) references Competition (id);
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '01', TIMESTAMP ('2019-03-21 12:00:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '02', TIMESTAMP ('2019-03-21 12:08:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '03', TIMESTAMP ('2019-03-21 12:16:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '04', TIMESTAMP ('2019-03-21 12:24:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '05', TIMESTAMP ('2019-03-21 12:32:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '06', TIMESTAMP ('2019-03-21 12:40:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '07', TIMESTAMP ('2019-03-21 12:48:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '08', TIMESTAMP ('2019-03-21 12:56:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '09', TIMESTAMP ('2019-03-21 13:04:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '10', TIMESTAMP ('2019-03-21 13:12:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '11', TIMESTAMP ('2019-03-21 13:20:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '12', TIMESTAMP ('2019-03-21 13:28:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '13', TIMESTAMP ('2019-03-21 13:36:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '14', TIMESTAMP ('2019-03-21 13:44:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '15', TIMESTAMP ('2019-03-21 13:52:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '16', TIMESTAMP ('2019-03-21 14:00:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '17', TIMESTAMP ('2019-03-21 14:08:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '18', TIMESTAMP ('2019-03-21 14:16:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '19', TIMESTAMP ('2019-03-21 14:24:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '20', TIMESTAMP ('2019-03-21 14:32:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '21', TIMESTAMP ('2019-03-21 14:40:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '22', TIMESTAMP ('2019-03-21 14:48:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '23', TIMESTAMP ('2019-03-21 14:56:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '24', TIMESTAMP ('2019-03-21 15:04:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '25', TIMESTAMP ('2019-03-21 15:12:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '26', TIMESTAMP ('2019-03-21 15:20:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '27', TIMESTAMP ('2019-03-21 15:28:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '28', TIMESTAMP ('2019-03-21 15:36:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '29', TIMESTAMP ('2019-03-21 15:44:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '30', TIMESTAMP ('2019-03-21 15:52:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '31', TIMESTAMP ('2019-03-21 16:00:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '32', TIMESTAMP ('2019-03-21 16:08:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '33', TIMESTAMP ('2019-03-21 16:16:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '34', TIMESTAMP ('2019-03-21 16:24:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '35', TIMESTAMP ('2019-03-21 16:32:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '36', TIMESTAMP ('2019-03-21 16:40:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '37', TIMESTAMP ('2019-03-21 16:48:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '38', TIMESTAMP ('2019-03-21 16:56:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '39', TIMESTAMP ('2019-03-21 17:04:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '40', TIMESTAMP ('2019-03-21 17:12:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '41', TIMESTAMP ('2019-03-21 17:20:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '42', TIMESTAMP ('2019-03-21 17:28:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '43', TIMESTAMP ('2019-03-21 17:36:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '44', TIMESTAMP ('2019-03-21 17:44:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '45', TIMESTAMP ('2019-03-21 17:52:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';
insert into Match (competitionId, number, dateTime, type, isActive) select c.Id, '46', TIMESTAMP ('2019-03-21 18:00:00'), 'P', 'Y' from competition c where c.name = 'Iowa Regional';

create table Robot(
	id integer not null GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	teamNumber integer not null,
	teamName varchar(128) not null,
	location varchar(128) null,
	isActive char(1) not null,
	primary key (id));
create unique index idx_robot on Robot(teamNumber);
insert into robot (teamNumber, teamName, location, isActive) values (171, 'Cheese Curd Herd', 'Platteville, WI', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (469, 'Las Guerrillas', 'Bloomfield Hills, MI', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (525, 'Swartdogs', 'Cedar Falls, IA', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (648, 'QC ELITE - Flaming Squirrels', 'Quad Cities, IA', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (904, 'D Cubed', 'Grand Rapids, MI', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (930, 'Mukwonago BEARs', 'Mukwonago, WI', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (967, 'Iron Lions', 'Marion, IA', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (1622, 'Team Spyder', 'Poway, CA', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (1625, 'Winnovation', 'Winnebago, IL', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (1732, 'Hilltoppers', 'Milwaukee, WI', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (1985, 'Robohawks', 'Florissant, MO', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (2526, 'Crimson Robotics', 'Osseo, MN', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (2530, 'Inconceivable', 'Rochester, MN', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (2538, 'The Plaid Pillagers', 'Morris, MN', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (2957, 'Knights', 'Alden, MN', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (3206, 'Royal T-Wrecks', 'Woodbury , MN', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (3352, 'Flaming Monkeys 4-H Robotics Club', 'Belvidere, IL', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (3633, 'Catalyst 3633', 'Albert Lea, MN', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (3928, 'Team Neutrino', 'Ames, IA', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (4021, 'igKnightion', 'Onalaska, WI', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (4260, 'BEAR Bucs', 'Blue Earth Area, MN', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (4536, 'MinuteBots', 'Saint Paul, MN', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (5013, 'Trobots', 'Kansas City, MO', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (5041, 'CyBears', 'West Branch, IA', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (5576, 'Team Terminator', 'Spirit Lake, IA', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (5837, 'Unity4Tech', 'Waterloo, IA', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (5906, 'Titanium Badgers', 'Bennington, NE', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (5914, 'Robotic Warriors', 'Caledonia, MN', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (5935, 'Tech Tigers', 'Grinnell, IA', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (6164, 'Moonshot Slaybots', 'Dike, IA', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (6166, 'Thorobotics', 'Holmen, WI', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (6217, 'Bomb-Botz', 'Cannon Falls, MN', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (6317, 'Disruptive Innovation', 'Davenport, IA', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (6379, 'Terabyte of Ram', 'Pleasant Hill, IA', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (6391, 'Ursuline Bearbotics', 'Saint Louis, MO', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (6420, 'Fire Island Robotics', 'Muscatine, IA', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (6424, 'Stealth Panther Robotics', 'Knob Noster, MO', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (6455, 'The Coded Collective', 'Waterloo, IA', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (6630, 'F.U.N. (Fiercely Uknighted Nation)', 'La Porte City, IA', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (6732, 'BHS RoboRaiders', 'Bruce, WI', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (6889, 'DC Current', 'Bloomfield, IA', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (7021, 'TC Robotics', 'Arcadia, WI', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (7142, 'Vulcan Eagles', 'Des Moines, IA', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (7309, 'Green Lightning', 'Storm Lake, IA', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (7411, 'CrossThreaded', 'Cedar Falls, IA', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (7531, 'Servos Strike Back', 'Dubuque, IA', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (7541, 'Maple River Robotics', 'Mapleton, MN', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (7646, 'Cadets', 'Cresco, IA', 'Y');
insert into robot (teamNumber, teamName, location, isActive) values (93, 'NEW Apple Corps', 'Appleton, WI', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (167, 'Children of the Corn', 'Iowa City, IA', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (1816, 'The Green Machine', 'Edina, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (2264, 'Wayzata Robotics', 'Plymouth, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (2503, 'Warrior Robotics', 'Brainerd, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (2506, 'Saber Robotics', 'Franklin, WI', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (2531, 'RoboHawks', 'Chaska, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (2574, 'RoboHuskie', 'St. Anthony, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (2977, 'Sir Lancer Bots', 'La Crescent, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (3008, 'Team Magma', 'Honolulu, HI', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (3102, 'Tech-No-Tigers', 'Nevis, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (3134, 'The Accelerators', 'Cass Lake, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (3275, 'The Regulators', 'Cass Lake, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (3276, 'TOOLCATS', 'New London, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (3277, 'ProDigi', 'Thief River Falls, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (3291, 'Au Pirates (AKA Golden Pirates)', 'Brooklyn Park, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (3294, 'Backwoods Engineers', 'Pine River, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (3381, 'Droid Rage', 'Valders, WI', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (3740, 'Storm Robotics', 'Sauk Rapids, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (3750, 'Gator Robotics', 'Badger, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (3755, 'Dragon Robotics', 'Litchfield, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (4009, 'Denfeld DNA Robotics', 'Duluth, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (4166, 'Robostang', 'Mora, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (4207, 'PyroBotics', 'Victoria, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (4217, 'Scitobors', 'Nashwauk, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (4230, 'TopperBots', 'Duluth, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (4238, 'BBE Resistance Robotics', 'Belgrade, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (4480, 'UC-Botics', 'Upsala, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (4511, 'Power Amplified', 'Plymouth, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (4539, 'KAOTIC Robotics', 'Frazee, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (4674, 'Robojacks', 'Bemidji, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (4728, 'Rocori Rench Reckers', 'Cold Spring, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (4741, 'WingNuts', 'Redwood Falls, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (4845, 'Lions Pride', 'Duluth, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (5253, 'Bigfork Backwoods Bots', 'Bigfork, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (5290, 'Mechanical Howl', 'Forest Lake, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (5299, 'Winger Tech', 'Red Wing, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (5348, 'Charger Robotics', 'Cokato, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (5464, 'Bluejacket Robotics', 'Cambridge, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (5542, 'RoboHerd', 'Buffalo, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (5586, 'Bond Brigade', 'Kiel, WI', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (5638, 'LQPV Robotics', 'Madison, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (5653, 'Iron Mosquitos', 'Babbitt, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (5690, 'SubZero Robotics', 'Esko, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (5913, 'Patriotics', 'Pequot Lakes, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (5991, 'Chargers', 'Westbrook, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (5999, 'Byte Force', 'Milaca, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (6022, 'Wrench Warmers', 'Blooming Prairie, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (6045, 'Sabre Robotics', 'Sartell, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (6047, 'Proctor Frostbyte', 'Proctor, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (6146, 'Blackjacks', 'Dawson, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (6160, 'Bombatrons', 'Barnum, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (6318, 'FE Freedom Engineers', 'Freedom, WI', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (6453, 'Bog Bots!', 'Kelliher, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (6628, 'KMS BOTKICKERS', 'Kerkhoven, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (7041, 'Doomsday Dogs', 'Carlton, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (7068, 'Mechanical Masterminds', 'Saint Francis, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (7235, 'Red Lake Ogichidaag', 'Redlake, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (7797, 'Cloquets RipSaw Robotics', 'Cloquet, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (7864, 'North Woods Robotics', 'Cook, MN', 'N');
insert into robot (teamNumber, teamName, location, isActive) values (7893, 'Maple Lake High School', 'Maple Lake, MN', 'N');

create table MatchRobot(
	id integer not null GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	matchId integer not null,
	robotId integer not null,
	alliance char(1) not null,
	robotNumber integer not null,
	primary key (id));
create unique index idx_matchrobot on MatchRobot(matchId, robotId);
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 171 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '01';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 469 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '02';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 525 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '03';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 648 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '04';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 904 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '05';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 930 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '06';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 967 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '07';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 1622 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '08';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 1625 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '09';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 1732 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '10';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 1985 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '11';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 4021 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '12';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 4260 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '13';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 4536 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '14';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7021 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '15';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7309 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '16';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7411 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '17';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7531 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '18';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7541 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '19';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7646 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '20';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6166 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '21';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6217 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '22';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6317 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '23';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7142 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '24';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6379 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '25';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6391 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '26';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6420 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '27';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6424 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '28';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6455 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '29';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6630 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '30';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6732 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '31';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6889 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '32';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5013 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '33';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5041 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '34';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5576 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '35';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5837 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '36';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5906 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '37';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5914 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '38';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5935 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '39';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6164 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '40';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 2526 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '41';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 2530 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '42';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 2538 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '43';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 2957 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '44';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 3206 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '45';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 3352 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '46';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 2526 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '01';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 2530 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '02';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 2538 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '03';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 2957 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '04';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 3206 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '05';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 3352 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '06';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 3633 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '07';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 3928 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '08';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 171 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '09';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 469 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '10';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 525 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '11';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 648 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '12';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 904 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '13';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 930 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '14';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 967 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '15';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 1622 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '16';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 1625 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '17';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 1732 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '18';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 1985 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '19';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 4021 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '20';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 4260 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '21';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 4536 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '22';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7021 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '23';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7309 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '24';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7411 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '25';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7531 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '26';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7541 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '27';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7646 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '28';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6166 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '29';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6217 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '30';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6317 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '31';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7142 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '32';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6379 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '33';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6391 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '34';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6420 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '35';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6424 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '36';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6455 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '37';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6630 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '38';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6732 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '39';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6889 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '40';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5013 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '41';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5041 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '42';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5576 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '43';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5837 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '44';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5906 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '45';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5914 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '46';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5013 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '01';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5041 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '02';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5576 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '03';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5837 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '04';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5906 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '05';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5914 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '06';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5935 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '07';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6164 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '08';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 2526 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '09';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 2530 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '10';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 2538 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '11';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 2957 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '12';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 3206 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '13';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 3352 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '14';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 3633 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '15';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 3928 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '16';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 171 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '17';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 469 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '18';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 525 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '19';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 648 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '20';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 904 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '21';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 930 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '22';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 967 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '23';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 1622 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '24';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 1625 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '25';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 1732 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '26';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 1985 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '27';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 4021 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '28';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 4260 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '29';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 4536 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '30';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7021 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '31';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7309 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '32';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7411 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '33';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7531 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '34';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7541 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '35';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7646 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '36';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6166 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '37';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6217 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '38';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6317 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '39';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7142 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '40';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6379 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '41';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6391 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '42';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6420 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '43';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6424 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '44';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6455 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '45';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'R', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6630 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '46';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6379 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '01';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6391 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '02';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6420 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '03';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6424 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '04';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6455 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '05';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6630 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '06';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6732 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '07';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6889 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '08';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5013 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '09';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5041 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '10';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5576 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '11';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5837 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '12';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5906 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '13';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5914 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '14';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5935 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '15';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6164 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '16';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 2526 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '17';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 2530 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '18';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 2538 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '19';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 2957 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '20';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 3206 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '21';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 3352 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '22';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 3633 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '23';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 3928 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '24';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 171 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '25';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 469 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '26';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 525 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '27';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 648 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '28';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 904 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '29';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 930 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '30';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 967 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '31';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 1622 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '32';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 1625 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '33';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 1732 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '34';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 1985 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '35';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 4021 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '36';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 4260 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '37';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 4536 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '38';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7021 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '39';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7309 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '40';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7411 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '41';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7531 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '42';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7541 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '43';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7646 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '44';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6166 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '45';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 1 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6217 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '46';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7411 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '01';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7531 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '02';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7541 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '03';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7646 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '04';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6166 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '05';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6217 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '06';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6317 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '07';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7142 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '08';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6379 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '09';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6391 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '10';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6420 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '11';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6424 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '12';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6455 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '13';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6630 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '14';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6732 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '15';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6889 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '16';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5013 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '17';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5041 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '18';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5576 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '19';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5837 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '20';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5906 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '21';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5914 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '22';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5935 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '23';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6164 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '24';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 2526 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '25';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 2530 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '26';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 2538 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '27';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 2957 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '28';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 3206 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '29';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 3352 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '30';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 3633 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '31';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 3928 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '32';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 171 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '33';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 469 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '34';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 525 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '35';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 648 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '36';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 904 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '37';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 930 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '38';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 967 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '39';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 1622 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '40';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 1625 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '41';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 1732 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '42';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 1985 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '43';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 4021 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '44';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 4260 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '45';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 2 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 4536 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '46';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 1625 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '01';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 1732 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '02';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 1985 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '03';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 4021 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '04';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 4260 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '05';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 4536 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '06';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7021 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '07';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7309 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '08';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7411 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '09';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7531 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '10';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7541 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '11';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7646 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '12';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6166 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '13';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6217 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '14';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6317 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '15';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 7142 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '16';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6379 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '17';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6391 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '18';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6420 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '19';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6424 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '20';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6455 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '21';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6630 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '22';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6732 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '23';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6889 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '24';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5013 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '25';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5041 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '26';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5576 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '27';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5837 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '28';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5906 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '29';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5914 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '30';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 5935 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '31';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 6164 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '32';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 2526 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '33';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 2530 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '34';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 2538 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '35';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 2957 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '36';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 3206 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '37';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 3352 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '38';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 3633 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '39';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 3928 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '40';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 171 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '41';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 469 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '42';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 525 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '43';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 648 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '44';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 904 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '45';
insert into MatchRobot (robotId, matchId, alliance, robotNumber) select r.id, m.id, 'B', 3 from robot r, Match m inner join Competition c on m.competitionId = c.id where r.teamNumber = 930 and c.name = 'Iowa Regional' and m.type = 'P' and m.number = '46';

create table ScoutRecord (
	id integer not null GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	matchId integer not null,
	robotId integer not null,
	scoutId integer not null,
	leaveHAB char(1) not null,
	ssHatchCnt integer not null,
	ssCargoCnt integer not null,
	toHatchCnt integer not null,
	toCargoCnt integer not null,
	playedDefense char(1) not null,
	returnToHAB char(1) not null,
	primary key (id));
create unique index idx_ScoutRecord on ScoutRecord(matchId, robotId, scoutId);
alter table ScoutRecord add foreign key fk_ScoutRecord_Match (matchId) references Match (id);
alter table ScoutRecord add foreign key fk_ScoutRecord_Robot (robotId) references Robot (id);
alter table ScoutRecord add foreign key fk_ScoutRecord_Scout (scoutId) references Scout (id);
-- Insert some random data
insert into ScoutRecord (matchId, robotId, scoutId, leaveHAB, ssHatchCnt, ssCargoCnt, toHatchCnt, toCargoCnt, playedDefense, returnToHAB)
select mr.matchId
     , mr.robotId
     , s.Id
     , cast(cast(round(rand() * 2, 0) as integer) as char) leaveHab
     , cast(round(rand() * 2, 0) as integer) ssHatchCnt
     , cast(round(rand() * 1, 0) as integer) ssCargoCnt
     , cast(round(rand() * 6, 0) as integer) toHatchCnt
     , cast(round(rand() * 3, 0) as integer) toCargoCnt
     , cast(cast(round(rand() * 3, 0) as integer) as char) playedDefense
     , cast(cast(round(rand() * 3, 0) as integer) as char) returnToHAB
  from MatchRobot mr, Scout s
 where s.lastName in ('Parks', 'Weinreich', 'Sucher', 'Schlichting');

-- View for Match Robots
create view v_MatchHyperlinks as
select '<a href=\"Reports\matchReport.php?matchId=' || subquery.matchId || '\"> ' || subquery.matchNumber || '</a>' matchReportUrl
     , subquery.r1TeamNumber
     , '<a href=\"Reports\robotReport.php?robotId=' || subquery.r1RobotId || '\"> R </a>' r1RobotReportUrl
     , '<a href=\"scoutRecord.php?matchId=' || subquery.matchId || ';matchNumber=' || subquery.matchNumber || ';robotId=' || subquery.r1RobotId || '\"> S </a>' r1RobotScoutUrl
     , subquery.r2TeamNumber
     , '<a href=\"Reports\robotReport.php?robotId=' || subquery.r2RobotId || '\"> R </a>' r2RobotReportUrl
     , '<a href=\"scoutRecord.php?matchId=' || subquery.matchId || ';matchNumber=' || subquery.matchNumber || ';robotId=' || subquery.r2RobotId || '\"> S </a>' r2RobotScoutUrl
     , subquery.r3TeamNumber
     , '<a href=\"Reports\robotReport.php?robotId=' || subquery.r3RobotId || '\"> R </a>' r3RobotReportUrl
     , '<a href=\"scoutRecord.php?matchId=' || subquery.matchId || ';matchNumber=' || subquery.matchNumber || ';robotId=' || subquery.r3RobotId || '\"> S </a>' r3RobotScoutUrl
     , subquery.b1TeamNumber
     , '<a href=\"Reports\robotReport.php?robotId=' || subquery.b1RobotId || '\"> R </a>' b1RobotReportUrl
     , '<a href=\"scoutRecord.php?matchId=' || subquery.matchId || ';matchNumber=' || subquery.matchNumber || ';robotId=' || subquery.b1RobotId || '\"> S </a>' b1RobotScoutUrl
     , subquery.b2TeamNumber
     , '<a href=\"Reports\robotReport.php?robotId=' || subquery.b2RobotId || '\"> R </a>' b2RobotReportUrl
     , '<a href=\"scoutRecord.php?matchId=' || subquery.matchId || ';matchNumber=' || subquery.matchNumber || ';robotId=' || subquery.b2RobotId || '\"> S </a>' b2RobotScoutUrl
     , subquery.b3TeamNumber
     , '<a href=\"Reports\robotReport.php?robotId=' || subquery.b3RobotId || '\"> R </a>' b3RobotReportUrl
     , '<a href=\"scoutRecord.php?matchId=' || subquery.matchId || ';matchNumber=' || subquery.matchNumber || ';robotId=' || subquery.b3RobotId || '\"> S </a>' b3RobotScoutUrl
     , subquery.sortOrder
     , subquery.matchNumber
     , subquery.matchId
     , subquery.r1RobotId
     , subquery.r2RobotId
     , subquery.r3RobotId
     , subquery.b1RobotId
     , subquery.b2RobotId
     , subquery.b3RobotId
  from (
select case when timestampdiff(4, m.datetime - current timestamp) + 330 < 0 then 1 else 0 end sortOrder
     , m.type || ' ' || m.number matchNumber
     , m.id matchId
     , (select r.teamNumber
          from MatchRobot mr
               inner join Robot r
               on r.id = mr.robotId
         where mr.matchId = m.id
           and alliance = 'R'
           and robotNumber = 1) r1TeamNumber
     , (select mr.robotId
          from MatchRobot mr
               inner join Robot r
               on r.id = mr.robotId
         where mr.matchId = m.id
           and alliance = 'R'
           and robotNumber = 1) r1RobotId
     , (select r.teamNumber
          from MatchRobot mr
               inner join Robot r
               on r.id = mr.robotId
         where mr.matchId = m.id
           and alliance = 'R'
           and robotNumber = 2) r2TeamNumber
     , (select mr.robotId
          from MatchRobot mr
               inner join Robot r
               on r.id = mr.robotId
         where mr.matchId = m.id
           and alliance = 'R'
           and robotNumber = 2) r2RobotId
     , (select r.teamNumber
          from MatchRobot mr
               inner join Robot r
               on r.id = mr.robotId
         where mr.matchId = m.id
           and alliance = 'R'
           and robotNumber = 3) r3TeamNumber
     , (select mr.robotId
          from MatchRobot mr
               inner join Robot r
               on r.id = mr.robotId
         where mr.matchId = m.id
           and alliance = 'R'
           and robotNumber = 3) r3RobotId
     , (select r.teamNumber
          from MatchRobot mr
               inner join Robot r
               on r.id = mr.robotId
         where mr.matchId = m.id
           and alliance = 'B'
           and robotNumber = 1) b1TeamNumber
     , (select mr.robotId
          from MatchRobot mr
               inner join Robot r
               on r.id = mr.robotId
         where mr.matchId = m.id
           and alliance = 'B'
           and robotNumber = 1) b1RobotId
     , (select r.teamNumber
          from MatchRobot mr
               inner join Robot r
               on r.id = mr.robotId
         where mr.matchId = m.id
           and alliance = 'B'
           and robotNumber = 2) b2TeamNumber
     , (select mr.robotId
          from MatchRobot mr
               inner join Robot r
               on r.id = mr.robotId
         where mr.matchId = m.id
           and alliance = 'B'
           and robotNumber = 2) b2RobotId
     , (select r.teamNumber
          from MatchRobot mr
               inner join Robot r
               on r.id = mr.robotId
         where mr.matchId = m.id
           and alliance = 'B'
           and robotNumber = 3) b3TeamNumber
     , (select mr.robotId
          from MatchRobot mr
               inner join Robot r
               on r.id = mr.robotId
         where mr.matchId = m.id
           and alliance = 'B'
           and robotNumber = 3) b3RobotId
  from Match m
 where isActive = 'Y') subquery;

-- View for average robot report on a match
create view v_AvgScoutRecord as
select sr.matchId
     , sr.robotId
     , count(*) cnt
     , avg(leaveHab) leaveHab
     , avg(ssHatchCnt) ssHatchCnt
     , avg(ssCargoCnt) ssCargoCnt
     , avg(toHatchCnt) toHatchCnt
     , avg(toCargoCnt) toCargoCnt
     , avg(playedDefense) playedDefense
     , avg(returnToHab) returnToHab
  from scoutRecord sr
group by sr.matchId
       , sr.robotId;

-- View for match averages
create view v_MatchReport as
select m.type || ' ' || m.number matchNumber
     , mr.matchId
     , mr.robotId
     , r.TeamNumber
     , mr.alliance
     , mr.robotNumber
     , '<a href=\"Reports\robotReport.php?robotId=' || mr.robotId || '\"> ' || r.teamNumber || '</a> ' r3RobotReportUrl
     , count(*) matchCnt
     , round(avg(sr.leaveHab),1) leaveHabAvg
     , round(avg(sr.ssHatchCnt),1) ssHatchCnt
     , round(avg(sr.ssCargoCnt),1) ssCargoCnt
     , round(avg(sr.toHatchCnt + sr.ssHatchCnt),1) totHatchCnt
     , round(avg(sr.toCargoCnt + sr.ssCargoCnt),1) totCargoCnt
     , round(avg(sr.playedDefense),1) playedDefense
     , round(avg(sr.returnToHab),1) returnToHab
 from Match m
       inner join MatchRobot mr
       on mr.matchId = m.id
       inner join Robot r
       on r.id = mr.robotId
       left outer join v_AvgScoutRecord sr
       on sr.robotId = mr.robotId
       and exists (select 1
                     from match m2
                    where m2.id = sr.matchId
                      and m2.isActive = 'Y')
group by m.type || ' ' || m.number
       , mr.matchId
       , mr.robotId
       , r.TeamNumber
       , mr.alliance
       , mr.robotNumber;
 
-- View for robot history and average
create view v_RobotReport as
select r.TeamNumber
     , 'N/A' matchNumber
     , max(m.datetime + 1) matchTime
     , 'Average Score' scoutName
     , round(avg(sr.leaveHab),1) leaveHab
     , round(avg(sr.ssHatchCnt),1) ssHatchCnt
     , round(avg(sr.ssCargoCnt),1) ssCargoCnt
     , round(avg(sr.toHatchCnt + sr.ssHatchCnt),1) totHatchCnt
     , round(avg(sr.toCargoCnt + sr.ssCargoCnt),1) totCargoCnt
     , round(avg(sr.playedDefense),1) playedDefense
     , round(avg(sr.returnToHab),1) returnToHab
     , r.id robotId
     , null matchId
     , null scoutId
 from Robot r
      inner join v_AvgScoutRecord sr
      on sr.robotId = r.id
      inner join Match m
      on m.id = sr.matchId
group by r.TeamNumber
       , r.id
union
select r.TeamNumber
     , m.type || ' ' || m.number matchNumber
     , m.datetime matchTime
     , s.lastName || ', ' || firstName scoutName
     , sr.leaveHab
     , sr.ssHatchCnt
     , sr.ssCargoCnt
     , sr.toHatchCnt + sr.ssHatchCnt totHatchCnt
     , sr.toCargoCnt + sr.ssCargoCnt totCargoCnt
     , sr.playedDefense
     , sr.returnToHab
     , sr.robotId
     , sr.matchId
     , sr.scoutId
 from Robot r
      inner join scoutRecord sr
      on sr.robotId = r.id
      inner join Match m
      on m.id = sr.matchId
      inner join scout s
      on s.id = sr.scoutId;

create view v_AvgRobotRecord as
select asr.robotId
     , count(*) cntMatches
     , avg(asr.leaveHab) leaveHab
     , avg(asr.ssHatchCnt) ssHatchCnt
     , avg(asr.ssCargoCnt) ssCargoCnt
     , avg(asr.toHatchCnt) toHatchCnt
     , avg(asr.toCargoCnt) toCargoCnt
     , avg(asr.playedDefense) playedDefense
     , avg(asr.returnToHab) returnToHab
  from v_AvgScoutRecord asr
       inner join Match m
	   on m.id = asr.matchId
 where m.isActive = 'Y'
group by asr.robotId;

/*
-- Rank Query
select r.TeamNumber
     , r.TeamName
     , avg(rank) avgRank
     , sum(decode(measureType, 'leaveHab', rank, 0)) rankLeaveHab
     , sum(decode(measureType, 'returnToHab', rank, 0)) rankReturnToHab
     , sum(decode(measureType, 'ssHatchCnt', rank, 0)) rankSsHatch
     , sum(decode(measureType, 'ssCargoCnt', rank, 0)) rankSsCargo
     , sum(decode(measureType, 'totHatchCnt', rank, 0)) rankTotHatch
     , sum(decode(measureType, 'totCargoCnt', rank, 0)) rankTotCargo
     , sum(decode(measureType, 'playedDefense', rank, 0)) rankPlayedDefense
     , sum(decode(measureType, 'leaveHab', val, 0)) leaveHab
     , sum(decode(measureType, 'returnToHab', val, 0)) returnToHab
     , sum(decode(measureType, 'ssHatchCnt', val, 0)) ssHatch
     , sum(decode(measureType, 'ssCargoCnt', val, 0)) ssCargo
     , sum(decode(measureType, 'totHatchCnt', val, 0)) totHatch
     , sum(decode(measureType, 'totCargoCnt', val, 0)) totCargo
     , sum(decode(measureType, 'playedDefense', val, 0)) playedDefense
  from (
select arr.robotId
     , 'leaveHab' measureType
     , round(arr.leaveHab, 2) val
     , (select count(*)
          from v_AvgRobotRecord arr2
         where arr2.leaveHab > arr.leaveHab) + 1 rank
  from v_AvgRobotRecord arr
union
select arr.robotId
     , 'ssHatchCnt' measureType
     , round(arr.ssHatchCnt, 2) val
     , (select count(*)
          from v_AvgRobotRecord arr2
         where arr2.ssHatchCnt > arr.ssHatchCnt ) + 1 rank
  from v_AvgRobotRecord arr
union
select arr.robotId
     , 'ssCargoCnt' measureType
     , round(arr.ssCargoCnt, 2) val
     , (select count(*)
          from v_AvgRobotRecord arr2
         where arr2.ssCargoCnt > arr.ssCargoCnt ) + 1 rank
  from v_AvgRobotRecord arr
union
select arr.robotId
     , 'totHatchCnt' measureType
     , round(arr.ssHatchCnt + arr.toHatchCnt, 2) val
     , (select count(*)
          from v_AvgRobotRecord arr2
         where arr2.ssHatchCnt + arr2.toHatchCnt > arr.ssHatchCnt + arr.toHatchCnt) + 1 rank
  from v_AvgRobotRecord arr
union
select arr.robotId
     , 'totCargoCnt' measureType
     , round(arr.ssCargoCnt + arr.toCargoCnt, 2) val
     , (select count(*)
          from v_AvgRobotRecord arr2
         where arr2.ssCargoCnt + arr2.toCargoCnt > arr.ssCargoCnt + arr.toCargoCnt) + 1 rank
  from v_AvgRobotRecord arr
union
select arr.robotId
     , 'playedDefense' measureType
     , round(arr.playedDefense, 2) val
     , (select count(*)
          from v_AvgRobotRecord arr2
         where arr2.playedDefense > arr.playedDefense) + 1 rank
  from v_AvgRobotRecord arr
union
select arr.robotId
     , 'returnToHab' measureType
     , round(arr.returnToHab, 2) val
     , (select count(*)
          from v_AvgRobotRecord arr2
         where arr2.returnToHab > arr.returnToHab) + 1 rank
  from v_AvgRobotRecord arr
) subquery
       inner join Robot r
       on r.id = subquery.robotId
 where r.isActive = 'Y'
group by r.TeamNumber
       , r.TeamName
order by avgRank;
*/

	  