/*
drop procedure sp_ins_scoutRecord;
drop procedure sp_ins_scoutRobot;
drop procedure sp_rpt_rankReport;
drop trigger tr_SOR_CalcScoreValue;
drop function calcScoreValue;
drop view v_AvgTeamRecord;
drop view v_AvgScoutRecord;
drop view v_MatchReport;
drop view v_MatchReportAttributes;
drop view v_TeamReport;
drop view v_ScoutRecord;
drop view v_MatchHyperlinks;
drop view v_ScoutTeamHyperlinks;
drop view v_EnterScoutRecordHTML;
drop view v_EnterScoutTeamHTML;
drop table ScoutObjectiveRecord;
drop table ScoutRecord;
drop table TeamMatch;
drop table Match;
drop table ObjectiveValue;
drop table Objective;
drop table ScoringType;
drop table Scout;
drop table TeamGameEvent;
drop table Team;
drop table GameEvent;
drop table Game;
drop table Event;

create table Event(
	id int primary key IDENTITY(1, 1) NOT NULL,
	name varchar(128) not null,
	location varchar(128) not null,
	eventCode varchar(16) not null,
	lastUpdated datetime null);
create unique index idx_Event on Event(name);
create unique index idx_Event_2 on Event(eventCode);
insert into Event (name, location, eventCode) values ('Lake Superior Regional', 'Duluth, MN', 'mndu');
insert into Event (name, location, eventCode) values ('Iowa Regional', 'Cedar Falls, IA', 'iacf');
insert into Event (name, location, eventCode) values ('EMCC Off-Season', 'Woodbury, MN', 'emcc');
insert into Event (name, location, eventCode) values ('Test Data Event', 'Cannon Falls, MN', null);
insert into Event (name, location, eventcode) values ('Week Zero - Eagan', 'Eagan, MN', null)

create table Game(
	id int primary key IDENTITY(1, 1) NOT NULL,
	name varchar(128) not null,
	gameYear integer not null,
	lastUpdated datetime null);
create unique index idx_Game on Game(name);
insert into Game (name, gameYear) values ('Deep Space', 2019);

create table GameEvent(
	id int primary key IDENTITY(1, 1) NOT NULL,
	eventId integer not null,
	gameId integer not null,
	eventDate date not null,
	isActive char(1) not null,
	lastUpdated datetime null);
create unique index idx_GameEvent on GameEvent(eventId, eventDate);
alter table GameEvent add constraint fk_GameEvent_Team foreign key (eventId) references Event (id);
alter table GameEvent add constraint fk_GameEvent_Game foreign key (gameId) references Game (id);
insert into GameEvent (eventId, gameId, eventDate, isActive) select e.Id, g.Id, '03/07/2019', 'N' from event e, game g where e.Name = 'Lake Superior Regional' and g.name = 'Deep Space';
insert into GameEvent (eventId, gameId, eventDate, isActive) select e.Id, g.Id, '03/21/2019', 'N' from event e, game g where e.Name = 'Iowa Regional' and g.name = 'Deep Space';
insert into GameEvent (eventId, gameId, eventDate, isActive) select e.Id, g.Id, '09/21/2019', 'Y' from event e, game g where e.Name = 'EMCC Off-Season' and g.name = 'Deep Space';
insert into GameEvent (eventId, gameId, eventDate, isActive) select e.Id, g.Id, '12/31/2099', 'N' from event e, game g where e.Name = 'Test Data Event' and g.name = 'Deep Space';
insert into GameEvent (eventId, gameId, eventDate, isActive) select e.Id, g.Id, '02/15/2020', 'Y' from event e, game g where e.Name = 'Week Zero - Eagan' and g.name = 'Infinite Recharge';

create table Team(
	id int primary key IDENTITY(1, 1) NOT NULL,
	teamNumber integer not null,
	teamName varchar(128) not null,
	location varchar(128) null,
	isActive char(1) not null,
	lastUpdated datetime null);
create unique index idx_Team on Team(teamNumber);
insert into Team (teamNumber, teamName, location, isActive) values (93, 'NEW Apple Corps', 'Appleton, WI', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (167, 'Children of the Corn', 'Iowa City, IA', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (171, 'Cheese Curd Herd', 'Platteville, WI', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (469, 'Las Guerrillas', 'Bloomfield Hills, MI', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (525, 'Swartdogs', 'Cedar Falls, IA', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (648, 'QC ELITE - Flaming Squirrels', 'Quad Cities, IA', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (904, 'D Cubed', 'Grand Rapids, MI', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (930, 'Mukwonago BEARs', 'Mukwonago, WI', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (967, 'Iron Lions', 'Marion, IA', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (1622, 'Team Spyder', 'Poway, CA', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (1625, 'Winnovation', 'Winnebago, IL', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (1732, 'Hilltoppers', 'Milwaukee, WI', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (1816, 'The Green Machine', 'Edina, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (1985, 'Robohawks', 'Florissant, MO', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (2175, 'The Fighting Calculators', 'St. Paul, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (2220, 'Blue Twilight', 'Eagan, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (2264, 'Wayzata Teamics', 'Plymouth, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (2450, 'Team 2450', 'St. Paul, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (2502, 'Talon Teamics', 'Eden Prairie, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (2503, 'Warrior Teamics', 'Brainerd, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (2506, 'Saber Teamics', 'Franklin, WI', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (2508, 'Armada', 'Stillwater, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (2526, 'Crimson Teamics', 'Osseo, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (2530, 'Inconceivable', 'Rochester, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (2531, 'RoboHawks', 'Chaska, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (2538, 'The Plaid Pillagers', 'Morris, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (2549, 'Millerbots', 'Minneapolis, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (2574, 'RoboHuskie', 'St. Anthony, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (2846, 'FireBears', 'St. Paul, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (2957, 'Knights', 'Alden, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (2977, 'Sir Lancer Bots', 'La Crescent, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (3008, 'Team Magma', 'Honolulu, HI', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (3026, 'Orange Crush Teamics', 'Delano, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (3082, 'Chicken Bot Pie', 'Minnetonka, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (3100, 'Lightning Turtles', 'Mendota Heights, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (3102, 'Tech-No-Tigers', 'Nevis, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (3130, 'The ERRORS', 'Woodbury , MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (3134, 'The Accelerators', 'Cass Lake, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (3184, 'Blaze Teamics', 'Burnsville, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (3206, 'Royal T-Wrecks', 'Woodbury , MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (3275, 'The Regulators', 'Cass Lake, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (3276, 'TOOLCATS', 'New London, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (3277, 'ProDigi', 'Thief River Falls, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (3291, 'Au Pirates (AKA Golden Pirates)', 'Brooklyn Park, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (3294, 'Backwoods Engineers', 'Pine River, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (3352, 'Flaming Monkeys 4-H Teamics Club', 'Belvidere, IL', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (3381, 'Droid Rage', 'Valders, WI', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (3633, 'Catalyst 3633', 'Albert Lea, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (3740, 'Storm Teamics', 'Sauk Rapids, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (3750, 'Gator Teamics', 'Badger, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (3755, 'Dragon Teamics', 'Litchfield, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (3883, 'Data Bits', 'Cottage Grove, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (3928, 'Team Neutrino', 'Ames, IA', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (4009, 'Denfeld DNA Teamics', 'Duluth, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (4021, 'igKnightion', 'Onalaska, WI', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (4166, 'Robostang', 'Mora, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (4198, 'RoboCats', 'Waconia, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (4207, 'PyTeamics', 'Victoria, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (4215, 'Tritons', 'St. Paul, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (4217, 'Scitobors', 'Nashwauk, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (4230, 'TopperBots', 'Duluth, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (4238, 'BBE Resistance Teamics', 'Belgrade, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (4239, 'WARPSPEED', 'Wilmar, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (4260, 'BEAR Bucs', 'Blue Earth Area, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (4480, 'UC-Botics', 'Upsala, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (4511, 'Power Amplified', 'Plymouth, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (4536, 'MinuteBots', 'Saint Paul, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (4539, 'KAOTIC Teamics', 'Frazee, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (4549, 'Iron Bulls', 'South St. Paul, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (4674, 'Robojacks', 'Bemidji, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (4728, 'Rocori Rench Reckers', 'Cold Spring, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (4741, 'WingNuts', 'Redwood Falls, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (4845, 'Lions Pride', 'Duluth, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (5013, 'TTeams', 'Kansas City, MO', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (5041, 'CyBears', 'West Branch, IA', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (5253, 'Bigfork Backwoods Bots', 'Bigfork, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (5290, 'Mechanical Howl', 'Forest Lake, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (5299, 'Winger Tech', 'Red Wing, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (5348, 'Charger Teamics', 'Cokato, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (5464, 'Bluejacket Teamics', 'Cambridge, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (5542, 'RoboHerd', 'Buffalo, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (5576, 'Team Terminator', 'Spirit Lake, IA', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (5586, 'Bond Brigade', 'Kiel, WI', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (5638, 'LQPV Teamics', 'Madison, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (5653, 'Iron Mosquitos', 'Babbitt, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (5690, 'SubZero Teamics', 'Esko, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (5837, 'Unity4Tech', 'Waterloo, IA', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (5906, 'Titanium Badgers', 'Bennington, NE', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (5913, 'Patriotics', 'Pequot Lakes, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (5914, 'Teamic Warriors', 'Caledonia, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (5935, 'Tech Tigers', 'Grinnell, IA', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (5991, 'Chargers', 'Westbrook, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (5999, 'Byte Force', 'Milaca, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (6022, 'Wrench Warmers', 'Blooming Prairie, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (6045, 'Sabre Teamics', 'Sartell, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (6047, 'Proctor Frostbyte', 'Proctor, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (6146, 'Blackjacks', 'Dawson, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (6160, 'Bombatrons', 'Barnum, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (6164, 'Moonshot Slaybots', 'Dike, IA', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (6166, 'ThoTeamics', 'Holmen, WI', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (6217, 'Bomb-Botz', 'Cannon Falls, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (6317, 'Disruptive Innovation', 'Davenport, IA', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (6318, 'FE Freedom Engineers', 'Freedom, WI', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (6379, 'Terabyte of Ram', 'Pleasant Hill, IA', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (6391, 'Ursuline Bearbotics', 'Saint Louis, MO', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (6420, 'Fire Island Teamics', 'Muscatine, IA', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (6424, 'Stealth Panther Teamics', 'Knob Noster, MO', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (6453, 'Bog Bots!', 'Kelliher, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (6455, 'The Coded Collective', 'Waterloo, IA', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (6628, 'KMS BOTKICKERS', 'Kerkhoven, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (6630, 'F.U.N. (Fiercely Uknighted Nation)', 'La Porte City, IA', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (6732, 'BHS RoboRaiders', 'Bruce, WI', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (6889, 'DC Current', 'Bloomfield, IA', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (7021, 'TC Teamics', 'Arcadia, WI', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (7028, 'Binary Battalion', 'St. Michael, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (7041, 'Doomsday Dogs', 'Carlton, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (7068, 'Mechanical Masterminds', 'Saint Francis, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (7142, 'Vulcan Eagles', 'Des Moines, IA', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (7235, 'Red Lake Ogichidaag', 'Redlake, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (7309, 'Green Lightning', 'Storm Lake, IA', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (7411, 'CrossThreaded', 'Cedar Falls, IA', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (7432, 'NOS', 'Loretto, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (7531, 'Servos Strike Back', 'Dubuque, IA', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (7541, 'Maple River Teamics', 'Mapleton, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (7646, 'Cadets', 'Cresco, IA', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (7797, 'Cloquets RipSaw Teamics', 'Cloquet, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (7864, 'North Woods Teamics', 'Cook, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (7893, 'Maple Lake High School', 'Maple Lake, MN', 'Y');
insert into Team (teamNumber, teamName, location, isActive) values (9992, 'EMCC Sub', 'Woodbury, MN', 'Y');

create table TeamGameEvent(
	id int primary key IDENTITY(1, 1) NOT NULL,
	teamId integer not null,
	gameEventId integer not null,
	lastUpdated datetime null,
	rank integer null,
	rankingPointAverage numeric(10,3) null);
create unique index idx_TeamGameEvent on TeamGameEvent(teamId, gameEventId);
alter table TeamGameEvent add constraint fk_TeamGameEvent_Team foreign key (teamId) references Team (id);
alter table TeamGameEvent add constraint fk_TeamGameEvent_GameEvent foreign key (gameEventId) references GameEvent (id);
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 1816;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2175;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2220;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2450;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2502;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2508;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2526;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2530;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2531;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2549;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2574;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2846;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3026;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3082;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3100;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3130;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3184;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3206;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3883;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4198;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4207;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4215;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4239;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4549;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 6217;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 7021;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 7028;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 7432;

create table Scout(
	id int primary key IDENTITY(1, 1) NOT NULL,
	lastName varchar(128) not null,
	firstName varchar(128) not null,
	teamId integer not null,
	isActive char(1) not null,
	lastUpdated datetime null,
	scoutGUID uniqueidentifier not null default newid());
create unique index idx_scout on Scout(lastName, firstName);
alter table Scout add constraint fk_Scout_Team foreign key (TeamId) references Team (id);
insert into Scout (lastName, firstName, teamId, isActive) select 'Allen', 'Kristy', id, 'Y' from Team where teamNumber = 6217;
insert into Scout (lastName, firstName, teamId, isActive) select 'Auger', 'Sam', id, 'Y' from Team where teamNumber = 6217;
insert into Scout (lastName, firstName, teamId, isActive) select 'Bhakta', 'Sanskar', id, 'Y' from Team where teamNumber = 6217;
insert into Scout (lastName, firstName, teamId, isActive) select 'Coyle', 'Samuel', id, 'Y' from Team where teamNumber = 6217;
insert into Scout (lastName, firstName, teamId, isActive) select 'Deutsch', 'Alex', id, 'Y' from Team where teamNumber = 6217;
insert into Scout (lastName, firstName, teamId, isActive) select 'Engebretsen', 'Nick', id, 'Y' from Team where teamNumber = 6217;
insert into Scout (lastName, firstName, teamId, isActive) select 'Garrett', 'Nathaniel', id, 'Y' from Team where teamNumber = 6217;
insert into Scout (lastName, firstName, teamId, isActive) select 'Giese', 'Matthew', id, 'Y' from Team where teamNumber = 6217;
insert into Scout (lastName, firstName, teamId, isActive) select 'Jacobson', 'Tucker', id, 'Y' from Team where teamNumber = 6217;
insert into Scout (lastName, firstName, teamId, isActive) select 'Jesh', 'Zoe', id, 'Y' from Team where teamNumber = 6217;
insert into Scout (lastName, firstName, teamId, isActive) select 'Kehrberg', 'Kris', id, 'Y' from Team where teamNumber = 6217;
insert into Scout (lastName, firstName, teamId, isActive) select 'Klavon', 'Wyatt', id, 'Y' from Team where teamNumber = 6217;
insert into Scout (lastName, firstName, teamId, isActive) select 'Miller', 'Ella', id, 'Y' from Team where teamNumber = 6217;
insert into Scout (lastName, firstName, teamId, isActive) select 'Parks', 'Preston', id, 'Y' from Team where teamNumber = 6217;
insert into Scout (lastName, firstName, teamId, isActive) select 'Schlichting', 'Ryan', id, 'Y' from Team where teamNumber = 6217;
insert into Scout (lastName, firstName, teamId, isActive) select 'Souza', 'Izzy', id, 'Y' from Team where teamNumber = 6217;
insert into Scout (lastName, firstName, teamId, isActive) select 'Weinreich', 'Xander', id, 'Y' from Team where teamNumber = 6217;
insert into Scout (lastName, firstName, teamId, isActive) select 'White', 'Ethan', id, 'Y' from Team where teamNumber = 6217;
insert into Scout (lastName, firstName, teamId, isActive) select 'Wildenberg', 'Isaiah', id, 'Y' from Team where teamNumber = 6217;

create table ScoringType(
	id int primary key IDENTITY(1, 1) NOT NULL,
	name varchar(64) not null,
	hasValueList char(1) not null,
	lastUpdated datetime null);
create unique index idx_ScoringType on ScoringType(name);
insert into ScoringType (name, hasValueList) values ('Drop Down', 'Y');
insert into ScoringType (name, hasValueList) values ('Radio Button', 'Y');
insert into ScoringType (name, hasValueList) values ('Integer', 'N');
insert into ScoringType (name, hasValueList) values ('Decimal', 'N');
insert into ScoringType (name, hasValueList) values ('Free Form', 'N');

create table Objective(
	id int primary key IDENTITY(1, 1) NOT NULL,
	gameId integer not null,
	name varchar(64) not null,
	label varchar(64) not null,
	scoringTypeId integer not null,
	lowRangeValue integer null,
	highRangeValue integer null,
	scoreMultiplier integer null,
	sortOrder integer not null,
	lastUpdated datetime null,
	tableHeader varchar(64) not null,
	reportDisplay varchar(1) not null);
create unique index idx_Objective on Objective(gameId, name);
alter table Objective add constraint fk_Objective_Game foreign key (gameId) references Game (id);
alter table Objective add constraint fk_Objective_ScoringType foreign key (scoringTypeId) references ScoringType (id);
insert into Objective (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue, scoreMultiplier, sortOrder, tableHeader, reportDisplay) select g.id, 'leaveHAB', 'Leave HAB Level', st.id, null, null, null, 1, 'Exit', 'I' from game g, scoringType st where g.name = 'Deep Space' and st.name = 'Radio Button';
insert into Objective (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue, scoreMultiplier, sortOrder, tableHeader, reportDisplay) select g.id, 'ssHatchCnt', 'Sandstorm Hatches', st.id, 0, 2, 2, 2, 'SSHatch', 'I' from game g, scoringType st where g.name = 'Deep Space' and st.name = 'Integer';
insert into Objective (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue, scoreMultiplier, sortOrder, tableHeader, reportDisplay) select g.id, 'ssCargoCnt', 'Sandstorm Cargo', st.id, 0, 2, 3, 3, 'SSCargo', 'I' from game g, scoringType st where g.name = 'Deep Space' and st.name = 'Integer';
insert into Objective (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue, scoreMultiplier, sortOrder, tableHeader, reportDisplay) select g.id, 'toHatchCnt', 'TeleOp Hatches', st.id, 0, 10, 2, 4, 'TOHatch', 'I' from game g, scoringType st where g.name = 'Deep Space' and st.name = 'Integer';
insert into Objective (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue, scoreMultiplier, sortOrder, tableHeader, reportDisplay) select g.id, 'toCargoCnt', 'TeleOp Cargo', st.id, 0, 10, 3, 5, 'TOCargo', 'I' from game g, scoringType st where g.name = 'Deep Space' and st.name = 'Integer';
insert into Objective (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue, scoreMultiplier, sortOrder, tableHeader, reportDisplay) select g.id, 'playedDefense', 'Performed on Defense', st.id, null, null, null, 6, 'Defense', 'I' from game g, scoringType st where g.name = 'Deep Space' and st.name = 'Radio Button';
insert into Objective (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue, scoreMultiplier, sortOrder, tableHeader, reportDisplay) select g.id, 'returnToHAB', 'Return HAB Level', st.id, null, null, null, 7, 'Return', 'I' from game g, scoringType st where g.name = 'Deep Space' and st.name = 'Radio Button';

create table ObjectiveValue(
	id int primary key IDENTITY(1, 1) NOT NULL,
	objectiveId integer not null,
	displayValue varchar(64) not null,
	integerValue integer null,
	sortOrder integer null,
	scoreValue integer null,
	lastUpdated datetime null);
create unique index idx_ObjectiveValue on ObjectiveValue(objectiveId, displayValue);
alter table ObjectiveValue add constraint fk_ObjectiveValue_Objective foreign key (objectiveId) references Objective (id);
insert into ObjectiveValue (objectiveId, displayValue, integerValue, sortOrder, scoreValue) select o.id, 'Did Not Leave', 0, 1, 0 from Objective o inner join Game g on g.id = o.gameId where g.name = 'Deep Space' and o.name = 'leaveHAB';
insert into ObjectiveValue (objectiveId, displayValue, integerValue, sortOrder, scoreValue) select o.id, 'Level 1', 1, 2, 3 from Objective o inner join Game g on g.id = o.gameId where g.name = 'Deep Space' and o.name = 'leaveHAB';
insert into ObjectiveValue (objectiveId, displayValue, integerValue, sortOrder, scoreValue) select o.id, 'Level 2', 2, 3, 6 from Objective o inner join Game g on g.id = o.gameId where g.name = 'Deep Space' and o.name = 'leaveHAB';
insert into ObjectiveValue (objectiveId, displayValue, integerValue, sortOrder, scoreValue) select o.id, 'None or Not Effective', 0, 1, 0 from Objective o inner join Game g on g.id = o.gameId where g.name = 'Deep Space' and o.name = 'playedDefense';
insert into ObjectiveValue (objectiveId, displayValue, integerValue, sortOrder, scoreValue) select o.id, 'Average', 2, 2, 0 from Objective o inner join Game g on g.id = o.gameId where g.name = 'Deep Space' and o.name = 'playedDefense';
insert into ObjectiveValue (objectiveId, displayValue, integerValue, sortOrder, scoreValue) select o.id, 'Great', 4, 3, 0 from Objective o inner join Game g on g.id = o.gameId where g.name = 'Deep Space' and o.name = 'playedDefense';
insert into ObjectiveValue (objectiveId, displayValue, integerValue, sortOrder, scoreValue) select o.id, 'Did Not Return', 0, 1, 0 from Objective o inner join Game g on g.id = o.gameId where g.name = 'Deep Space' and o.name = 'returnToHAB';
insert into ObjectiveValue (objectiveId, displayValue, integerValue, sortOrder, scoreValue) select o.id, 'Level 1', 1, 2, 3 from Objective o inner join Game g on g.id = o.gameId where g.name = 'Deep Space' and o.name = 'returnToHAB';
insert into ObjectiveValue (objectiveId, displayValue, integerValue, sortOrder, scoreValue) select o.id, 'Level 2', 2, 3, 6 from Objective o inner join Game g on g.id = o.gameId where g.name = 'Deep Space' and o.name = 'returnToHAB';
insert into ObjectiveValue (objectiveId, displayValue, integerValue, sortOrder, scoreValue) select o.id, 'Level 3', 3, 4, 12 from Objective o inner join Game g on g.id = o.gameId where g.name = 'Deep Space' and o.name = 'returnToHAB';

create table ObjectiveGroup(
	id int primary key IDENTITY(1, 1) NOT NULL,
	name varchar(64) not null,
	sortOrder integer null,
	lastUpdated datetime null);
create unique index idx_ObjectiveGroup on ObjectiveGroup(name);
insert into ObjectiveGroup (name, sortOrder) values ('Sandstorm', 1);
insert into ObjectiveGroup (name, sortOrder) values ('Autonomous', 1);
insert into ObjectiveGroup (name, sortOrder) values ('Tele Op', 2);
insert into ObjectiveGroup (name, sortOrder) values ('End Game', 3);

create table ObjectiveGroupObjective(
	id int primary key IDENTITY(1, 1) NOT NULL,
	objectiveGroupId integer not null,
	objectiveId integer not null,
	lastUpdated datetime null);
create unique index idx_ObjectiveGroupObjective on ObjectiveGroupObjective(objectiveGroupId, objectiveId);
alter table ObjectiveGroupObjective add constraint fk_ObjectiveGroupObjective_ObjectiveGroup foreign key (objectiveGroupId) references ObjectiveGroup (id);
alter table ObjectiveGroupObjective add constraint fk_ObjectiveGroupObjective_Objective foreign key (objectiveId) references Objective (id);
insert into ObjectiveGroupObjective (objectiveGroupId, objectiveId) select og.id, o.id from ObjectiveGroup og, Objective o where og.name = 'Sandstorm' and o.name = 'leaveHAB';
insert into ObjectiveGroupObjective (objectiveGroupId, objectiveId) select og.id, o.id from ObjectiveGroup og, Objective o where og.name = 'Sandstorm' and o.name = 'ssHatchCnt';
insert into ObjectiveGroupObjective (objectiveGroupId, objectiveId) select og.id, o.id from ObjectiveGroup og, Objective o where og.name = 'Sandstorm' and o.name = 'ssCargoCnt';
insert into ObjectiveGroupObjective (objectiveGroupId, objectiveId) select og.id, o.id from ObjectiveGroup og, Objective o where og.name = 'Tele Op' and o.name = 'toHatchCnt';
insert into ObjectiveGroupObjective (objectiveGroupId, objectiveId) select og.id, o.id from ObjectiveGroup og, Objective o where og.name = 'Tele Op' and o.name = 'toCargoCnt';
insert into ObjectiveGroupObjective (objectiveGroupId, objectiveId) select og.id, o.id from ObjectiveGroup og, Objective o where og.name = 'Tele Op' and o.name = 'playedDefense';
insert into ObjectiveGroupObjective (objectiveGroupId, objectiveId) select og.id, o.id from ObjectiveGroup og, Objective o where og.name = 'End Game' and o.name = 'returnToHAB';

create table Rank(
	id int primary key IDENTITY(1, 1) NOT NULL,
	name varchar(64) not null,
	queryString varchar(64) not null,
	type varchar(1) not null, -- V = Value, S = Score
	sortOrder integer null,
	lastUpdated datetime null,
	gameId integer not null);
create unique index idx_Rank on Rank(gameId, name);
alter table Rank add constraint fk_Rank_Game foreign key (gameId) references Game (id);
insert into Rank (gameId, name, queryString, type, sortOrder) select g.id, 'Exit', 'rankLeaveHab', 'V', 1 from game g where g.name = 'Deep Space';
insert into Rank (gameId, name, queryString, type, sortOrder) select g.id, 'Hatches', 'rankTotCargo', 'V', 2 from game g where g.name = 'Deep Space';
insert into Rank (gameId, name, queryString, type, sortOrder) select g.id, 'Cargo', 'rankPlayedDefense', 'V', 3 from game g where g.name = 'Deep Space';
insert into Rank (gameId, name, queryString, type, sortOrder) select g.id, 'Defense', 'rankPlayedDefense', 'V', 4 from game g where g.name = 'Deep Space';
insert into Rank (gameId, name, queryString, type, sortOrder) select g.id, 'Return', 'rankReturnToHab', 'V', 5 from game g where g.name = 'Deep Space';

create table RankObjective(
	id int primary key IDENTITY(1, 1) NOT NULL,
	rankId integer not null,
	objectiveId integer not null,
	lastUpdated datetime null);
create unique index idx_RankObjective on RankObjective(rankId, objectiveId);
alter table RankObjective add constraint fk_RankObjective_Rank foreign key (rankId) references Rank (id);
alter table RankObjective add constraint fk_RankObjective_Objective foreign key (objectiveId) references Objective (id);
insert into RankObjective (rankId, objectiveId) select r.id, o.id from Rank r inner join Game g on g.id = r.gameId, Objective o where r.name = 'Exit' and o.name = 'leaveHAB' and g.name = 'Deep Space';
insert into RankObjective (rankId, objectiveId) select r.id, o.id from Rank r inner join Game g on g.id = r.gameId, Objective o where r.name = 'Hatches' and o.name = 'ssHatchCnt' and g.name = 'Deep Space';
insert into RankObjective (rankId, objectiveId) select r.id, o.id from Rank r inner join Game g on g.id = r.gameId, Objective o where r.name = 'Hatches' and o.name = 'toHatchCnt' and g.name = 'Deep Space';
insert into RankObjective (rankId, objectiveId) select r.id, o.id from Rank r inner join Game g on g.id = r.gameId, Objective o where r.name = 'Cargo' and o.name = 'ssCargoCnt' and g.name = 'Deep Space';
insert into RankObjective (rankId, objectiveId) select r.id, o.id from Rank r inner join Game g on g.id = r.gameId, Objective o where r.name = 'Cargo' and o.name = 'toCargoCnt' and g.name = 'Deep Space';
insert into RankObjective (rankId, objectiveId) select r.id, o.id from Rank r inner join Game g on g.id = r.gameId, Objective o where r.name = 'Defense' and o.name = 'playedDefense' and g.name = 'Deep Space';
insert into RankObjective (rankId, objectiveId) select r.id, o.id from Rank r inner join Game g on g.id = r.gameId, Objective o where r.name = 'Return' and o.name = 'returnToHAB' and g.name = 'Deep Space';

create table Attribute(
	id int primary key IDENTITY(1, 1) NOT NULL,
	gameId integer not null,
	name varchar(64) not null,
	label varchar(64) not null,
	scoringTypeId integer not null,
	lowRangeValue integer null,
	highRangeValue integer null,
	sortOrder integer not null,
	lastUpdated datetime null,
	tableHeader varchar(64));
create unique index idx_Attribute on Attribute(gameId, name);
alter table Attribute add constraint fk_Attribute_Game foreign key (gameId) references Game (id);
alter table Attribute add constraint fk_Attribute_ScoringType foreign key (scoringTypeId) references ScoringType (id);

create table AttributeValue(
	id int primary key IDENTITY(1, 1) NOT NULL,
	attributeId integer not null,
	displayValue varchar(64) not null,
	integerValue integer null,
	sortOrder integer null,
	lastUpdated datetime null);
create unique index idx_AttributeValue on AttributeValue(attributeId, displayValue);
alter table AttributeValue add constraint fk_AttributeValue_Attribute foreign key (attributeId) references Attribute (id);

create table TeamAttribute (
	id int primary key IDENTITY(1, 1) NOT NULL,
	teamId integer not null,
	attributeId integer not null,
	integerValue integer null,
	decimalValue integer null,
	textValue varchar(4000) null,
	lastUpdated datetime null);
create unique index idx_TeamAttribute on TeamAttribute(teamId, attributeId);
alter table TeamAttribute add constraint fk_TeamAttribute_Team foreign key (teamId) references Team (id);
alter table TeamAttribute add constraint fk_TeamAttribute_Attribute foreign key (attributeId) references Attribute (id);
go

create table Match(
	id int primary key IDENTITY(1, 1) NOT NULL,
	gameEventId integer not null,
	number varchar(8) not null,
	dateTime datetime not null,
	type varchar(8) not null,
	isActive char(1) not null,
	redScore integer null,
	blueScore integer null,
	lastUpdated datetime null,
	redTeamPoints integer null,
	redFoulPoints integer null,
	blueTeamPoints integer null,
	blueFoulPoints integer null);
create unique index idx_Match on Match(gameEventId, type, number);
alter table Match add constraint fk_Match_GameEvent foreign key (gameEventId) references GameEvent (id);
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '01', '09/21/2019 08:45:00', 'QM', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '02', '09/21/2019 08:55:00', 'QM', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '03', '09/21/2019 09:05:00', 'QM', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '04', '09/21/2019 09:15:00', 'QM', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '05', '09/21/2019 09:25:00', 'QM', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '06', '09/21/2019 09:35:00', 'QM', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '07', '09/21/2019 09:45:00', 'QM', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '08', '09/21/2019 09:55:00', 'QM', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '09', '09/21/2019 10:05:00', 'QM', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '10', '09/21/2019 10:15:00', 'QM', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '11', '09/21/2019 10:25:00', 'QM', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '12', '09/21/2019 10:35:00', 'QM', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '13', '09/21/2019 10:45:00', 'QM', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '14', '09/21/2019 10:55:00', 'QM', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '15', '09/21/2019 11:05:00', 'QM', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '16', '09/21/2019 11:15:00', 'QM', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '17', '09/21/2019 11:25:00', 'QM', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '18', '09/21/2019 11:35:00', 'QM', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '19', '09/21/2019 11:45:00', 'QM', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '20', '09/21/2019 11:55:00', 'QM', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '21', '09/21/2019 13:05:00', 'QM', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '22', '09/21/2019 13:15:00', 'QM', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '23', '09/21/2019 13:25:00', 'QM', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '24', '09/21/2019 13:35:00', 'QM', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '25', '09/21/2019 13:45:00', 'QM', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '26', '09/21/2019 13:55:00', 'QM', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '27', '09/21/2019 14:05:00', 'QM', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '28', '09/21/2019 14:15:00', 'QM', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '29', '09/21/2019 14:25:00', 'QM', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '30', '09/21/2019 14:35:00', 'QM', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '31', '09/21/2019 14:45:00', 'QM', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '32', '09/21/2019 14:55:00', 'QM', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '33', '09/21/2019 15:05:00', 'QM', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';

create table TeamMatch(
	id int primary key IDENTITY(1, 1) NOT NULL,
	matchId integer not null,
	teamId integer not null,
	alliance char(1) not null,
	alliancePosition integer not null,
	lastUpdated datetime null);
create unique index idx_TeamMatch on TeamMatch(matchId, teamId);
alter table TeamMatch add constraint fk_TeamMatch_Match foreign key (matchId) references Match (id);
alter table TeamMatch add constraint fk_TeamMatch_Team foreign key (teamId) references Team (id);
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2220 and m.type = 'Q' and m.number = '01';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2531 and m.type = 'Q' and m.number = '02';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3100 and m.type = 'Q' and m.number = '03';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4207 and m.type = 'Q' and m.number = '04';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 7028 and m.type = 'Q' and m.number = '05';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2526 and m.type = 'Q' and m.number = '06';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3026 and m.type = 'Q' and m.number = '07';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3883 and m.type = 'Q' and m.number = '08';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 6217 and m.type = 'Q' and m.number = '09';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2502 and m.type = 'Q' and m.number = '10';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2574 and m.type = 'Q' and m.number = '11';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3184 and m.type = 'Q' and m.number = '12';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4239 and m.type = 'Q' and m.number = '13';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2220 and m.type = 'Q' and m.number = '14';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2531 and m.type = 'Q' and m.number = '15';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3100 and m.type = 'Q' and m.number = '16';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4207 and m.type = 'Q' and m.number = '17';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 7028 and m.type = 'Q' and m.number = '18';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2526 and m.type = 'Q' and m.number = '19';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3026 and m.type = 'Q' and m.number = '20';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3883 and m.type = 'Q' and m.number = '21';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 6217 and m.type = 'Q' and m.number = '22';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2502 and m.type = 'Q' and m.number = '23';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2574 and m.type = 'Q' and m.number = '24';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3184 and m.type = 'Q' and m.number = '25';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4239 and m.type = 'Q' and m.number = '26';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2220 and m.type = 'Q' and m.number = '27';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2531 and m.type = 'Q' and m.number = '28';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3100 and m.type = 'Q' and m.number = '29';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4207 and m.type = 'Q' and m.number = '30';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 7028 and m.type = 'Q' and m.number = '31';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2526 and m.type = 'Q' and m.number = '32';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3026 and m.type = 'Q' and m.number = '33';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2450 and m.type = 'Q' and m.number = '01';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2549 and m.type = 'Q' and m.number = '02';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3130 and m.type = 'Q' and m.number = '03';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4215 and m.type = 'Q' and m.number = '04';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 7432 and m.type = 'Q' and m.number = '05';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2530 and m.type = 'Q' and m.number = '06';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3082 and m.type = 'Q' and m.number = '07';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4198 and m.type = 'Q' and m.number = '08';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 7021 and m.type = 'Q' and m.number = '09';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2508 and m.type = 'Q' and m.number = '10';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2846 and m.type = 'Q' and m.number = '11';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3206 and m.type = 'Q' and m.number = '12';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4549 and m.type = 'Q' and m.number = '13';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2450 and m.type = 'Q' and m.number = '14';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2549 and m.type = 'Q' and m.number = '15';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3130 and m.type = 'Q' and m.number = '16';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4215 and m.type = 'Q' and m.number = '17';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 7432 and m.type = 'Q' and m.number = '18';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2530 and m.type = 'Q' and m.number = '19';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3082 and m.type = 'Q' and m.number = '20';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4198 and m.type = 'Q' and m.number = '21';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 7021 and m.type = 'Q' and m.number = '22';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2508 and m.type = 'Q' and m.number = '23';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2846 and m.type = 'Q' and m.number = '24';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3206 and m.type = 'Q' and m.number = '25';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4549 and m.type = 'Q' and m.number = '26';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2450 and m.type = 'Q' and m.number = '27';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2549 and m.type = 'Q' and m.number = '28';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3130 and m.type = 'Q' and m.number = '29';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4215 and m.type = 'Q' and m.number = '30';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 7432 and m.type = 'Q' and m.number = '31';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2530 and m.type = 'Q' and m.number = '32';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3082 and m.type = 'Q' and m.number = '33';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2502 and m.type = 'Q' and m.number = '01';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2574 and m.type = 'Q' and m.number = '02';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3184 and m.type = 'Q' and m.number = '03';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4239 and m.type = 'Q' and m.number = '04';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2220 and m.type = 'Q' and m.number = '05';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2531 and m.type = 'Q' and m.number = '06';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3100 and m.type = 'Q' and m.number = '07';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4207 and m.type = 'Q' and m.number = '08';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 7028 and m.type = 'Q' and m.number = '09';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2526 and m.type = 'Q' and m.number = '10';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3026 and m.type = 'Q' and m.number = '11';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3883 and m.type = 'Q' and m.number = '12';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 6217 and m.type = 'Q' and m.number = '13';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2502 and m.type = 'Q' and m.number = '14';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2574 and m.type = 'Q' and m.number = '15';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3184 and m.type = 'Q' and m.number = '16';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4239 and m.type = 'Q' and m.number = '17';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2220 and m.type = 'Q' and m.number = '18';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2531 and m.type = 'Q' and m.number = '19';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3100 and m.type = 'Q' and m.number = '20';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4207 and m.type = 'Q' and m.number = '21';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 7028 and m.type = 'Q' and m.number = '22';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2526 and m.type = 'Q' and m.number = '23';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3026 and m.type = 'Q' and m.number = '24';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3883 and m.type = 'Q' and m.number = '25';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 6217 and m.type = 'Q' and m.number = '26';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2502 and m.type = 'Q' and m.number = '27';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2574 and m.type = 'Q' and m.number = '28';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3184 and m.type = 'Q' and m.number = '29';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4239 and m.type = 'Q' and m.number = '30';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2220 and m.type = 'Q' and m.number = '31';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2531 and m.type = 'Q' and m.number = '32';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3100 and m.type = 'Q' and m.number = '33';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2508 and m.type = 'Q' and m.number = '01';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2846 and m.type = 'Q' and m.number = '02';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3206 and m.type = 'Q' and m.number = '03';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4549 and m.type = 'Q' and m.number = '04';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2450 and m.type = 'Q' and m.number = '05';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2549 and m.type = 'Q' and m.number = '06';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3130 and m.type = 'Q' and m.number = '07';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4215 and m.type = 'Q' and m.number = '08';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 7432 and m.type = 'Q' and m.number = '09';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2530 and m.type = 'Q' and m.number = '10';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3082 and m.type = 'Q' and m.number = '11';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4198 and m.type = 'Q' and m.number = '12';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 7021 and m.type = 'Q' and m.number = '13';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2508 and m.type = 'Q' and m.number = '14';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2846 and m.type = 'Q' and m.number = '15';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3206 and m.type = 'Q' and m.number = '16';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4549 and m.type = 'Q' and m.number = '17';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2450 and m.type = 'Q' and m.number = '18';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2549 and m.type = 'Q' and m.number = '19';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3130 and m.type = 'Q' and m.number = '20';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4215 and m.type = 'Q' and m.number = '21';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 7432 and m.type = 'Q' and m.number = '22';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2530 and m.type = 'Q' and m.number = '23';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3082 and m.type = 'Q' and m.number = '24';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4198 and m.type = 'Q' and m.number = '25';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 7021 and m.type = 'Q' and m.number = '26';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2508 and m.type = 'Q' and m.number = '27';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2846 and m.type = 'Q' and m.number = '28';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3206 and m.type = 'Q' and m.number = '29';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4549 and m.type = 'Q' and m.number = '30';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2450 and m.type = 'Q' and m.number = '31';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2549 and m.type = 'Q' and m.number = '32';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3130 and m.type = 'Q' and m.number = '33';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2526 and m.type = 'Q' and m.number = '01';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3026 and m.type = 'Q' and m.number = '02';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3883 and m.type = 'Q' and m.number = '03';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 6217 and m.type = 'Q' and m.number = '04';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2502 and m.type = 'Q' and m.number = '05';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2574 and m.type = 'Q' and m.number = '06';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3184 and m.type = 'Q' and m.number = '07';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4239 and m.type = 'Q' and m.number = '08';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2220 and m.type = 'Q' and m.number = '09';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2531 and m.type = 'Q' and m.number = '10';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3100 and m.type = 'Q' and m.number = '11';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4207 and m.type = 'Q' and m.number = '12';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 7028 and m.type = 'Q' and m.number = '13';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2526 and m.type = 'Q' and m.number = '14';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3026 and m.type = 'Q' and m.number = '15';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3883 and m.type = 'Q' and m.number = '16';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 6217 and m.type = 'Q' and m.number = '17';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2502 and m.type = 'Q' and m.number = '18';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2574 and m.type = 'Q' and m.number = '19';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3184 and m.type = 'Q' and m.number = '20';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4239 and m.type = 'Q' and m.number = '21';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2220 and m.type = 'Q' and m.number = '22';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2531 and m.type = 'Q' and m.number = '23';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3100 and m.type = 'Q' and m.number = '24';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4207 and m.type = 'Q' and m.number = '25';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 7028 and m.type = 'Q' and m.number = '26';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2526 and m.type = 'Q' and m.number = '27';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3026 and m.type = 'Q' and m.number = '28';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3883 and m.type = 'Q' and m.number = '29';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 6217 and m.type = 'Q' and m.number = '30';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2502 and m.type = 'Q' and m.number = '31';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2574 and m.type = 'Q' and m.number = '32';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3184 and m.type = 'Q' and m.number = '33';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2530 and m.type = 'Q' and m.number = '01';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3082 and m.type = 'Q' and m.number = '02';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4198 and m.type = 'Q' and m.number = '03';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 7021 and m.type = 'Q' and m.number = '04';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2508 and m.type = 'Q' and m.number = '05';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2846 and m.type = 'Q' and m.number = '06';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3206 and m.type = 'Q' and m.number = '07';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4549 and m.type = 'Q' and m.number = '08';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2450 and m.type = 'Q' and m.number = '09';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2549 and m.type = 'Q' and m.number = '10';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3130 and m.type = 'Q' and m.number = '11';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4215 and m.type = 'Q' and m.number = '12';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 7432 and m.type = 'Q' and m.number = '13';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2530 and m.type = 'Q' and m.number = '14';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3082 and m.type = 'Q' and m.number = '15';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4198 and m.type = 'Q' and m.number = '16';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 7021 and m.type = 'Q' and m.number = '17';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2508 and m.type = 'Q' and m.number = '18';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2846 and m.type = 'Q' and m.number = '19';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3206 and m.type = 'Q' and m.number = '20';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4549 and m.type = 'Q' and m.number = '21';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2450 and m.type = 'Q' and m.number = '22';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2549 and m.type = 'Q' and m.number = '23';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3130 and m.type = 'Q' and m.number = '24';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4215 and m.type = 'Q' and m.number = '25';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 7432 and m.type = 'Q' and m.number = '26';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2530 and m.type = 'Q' and m.number = '27';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3082 and m.type = 'Q' and m.number = '28';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 4198 and m.type = 'Q' and m.number = '29';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 7021 and m.type = 'Q' and m.number = '30';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2508 and m.type = 'Q' and m.number = '31';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 2846 and m.type = 'Q' and m.number = '32';
insert into TeamMatch (matchId, teamId, alliance, alliancePosition) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event' and t.teamNumber = 3206 and m.type = 'Q' and m.number = '33';

create table ScoutRecord (
	id int primary key IDENTITY(1, 1) NOT NULL,
	scoutId integer not null,
	matchId integer not null,
	teamId integer not null,
	lastUpdated datetime null);
create unique index idx_ScoutRecord on ScoutRecord(scoutId, matchId, teamId);
alter table ScoutRecord add constraint fk_ScoutRecord_Scout foreign key (scoutId) references Scout (id);
alter table ScoutRecord add constraint fk_ScoutRecord_Match foreign key (matchId) references Match (id);
alter table ScoutRecord add constraint fk_ScoutRecord_Team foreign key (TeamId) references Team (id);

create table ScoutObjectiveRecord (
	id int primary key IDENTITY(1, 1) NOT NULL,
	scoutRecordId integer not null,
	objectiveId integer not null,
	integerValue integer null,
	decimalValue integer null,
	textValue varchar(4000) null,
	scoreValue integer null,
	lastUpdated datetime null);
create unique index idx_ScoutObjectiveRecord on ScoutObjectiveRecord(scoutRecordId, objectiveId);
alter table ScoutObjectiveRecord add constraint fk_ScoutObjectiveRecord_ScoutRecord foreign key (scoutRecordId) references ScoutRecord (id);
alter table ScoutObjectiveRecord add constraint fk_ScoutObjectiveRecord_Objective foreign key (objectiveId) references Objective (id);
go

-- Function to calculate score impact for objective
create function calcScoreValue (@pv_ObjectiveId int
                             , @pv_IntegerValue int
							 , @pv_DecimalValue numeric(10,3))
returns int
as
begin
	declare @lv_ScoreValue int;
	set @lv_ScoreValue = null;
    select @lv_ScoreValue = coalesce(ov.scoreValue, @pv_IntegerValue * o.scoreMultiplier, @pv_DecimalValue * o.scoreMultiplier)
      from Objective o
	       left outer join ObjectiveValue ov
	       on ov.objectiveId = @pv_ObjectiveId
	       and ov.integerValue = @pv_IntegerValue
	 where o.id = @pv_ObjectiveId;
	return @lv_ScoreValue;
end;
go

-- Trigger to maintain scoreValue after insert/update of Scout Objective Record
create trigger tr_SOR_CalcScoreValue on ScoutObjectiveRecord
after insert, update
as
begin
	set nocount on
    update ScoutObjectiveRecord
	   set scoreValue = (select dbo.calcScoreValue(i.objectiveId, i.integerValue, i.decimalValue)
	                       from inserted i
						  where i.id = ScoutObjectiveRecord.id)
		 , lastUpdated = getDate() at time zone 'UTC' at time zone 'Central Standard Time'
	 where ScoutObjectiveRecord.id in (select i.id from inserted i);
	set nocount off
end;
go
-- Trigger to maintain last updated value of Attribute
create trigger tr_a_LastUpdated on Attribute after insert, update
as
begin
	set nocount on
    update Attribute set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
GO
-- Trigger to maintain last updated value of AttributeValue
create trigger tr_av_LastUpdated on AttributeValue after insert, update
as
begin
	set nocount on
    update AttributeValue set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
GO
-- Trigger to maintain last updated value of Event
create trigger tr_e_LastUpdated on Event after insert, update
as
begin
	set nocount on
    update Event set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
GO
-- Trigger to maintain last updated value of Game
create trigger tr_g_LastUpdated on Game after insert, update
as
begin
	set nocount on
    update Game set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
GO
-- Trigger to maintain last updated value of GameEvent
create trigger tr_ge_LastUpdated on GameEvent after insert, update
as
begin
	set nocount on
    update GameEvent set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
GO
-- Trigger to maintain last updated value of Match
create trigger tr_m_LastUpdated on Match after insert, update
as
begin
	set nocount on
    update Match set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
GO
-- Trigger to maintain last updated value of Objective
create trigger tr_o_LastUpdated on Objective after insert, update
as
begin
	set nocount on
    update Objective set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
GO
-- Trigger to maintain last updated value of ObjectiveGroup
create trigger tr_og_LastUpdated on ObjectiveGroup after insert, update
as
begin
	set nocount on
    update ObjectiveGroup set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
GO
-- Trigger to maintain last updated value of ObjectiveGroupObjective
create trigger tr_ogo_LastUpdated on ObjectiveGroupObjective after insert, update
as
begin
	set nocount on
    update ObjectiveGroupObjective set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
GO
-- Trigger to maintain last updated value of ObjectiveValue
create trigger tr_ov_LastUpdated on ObjectiveValue after insert, update
as
begin
	set nocount on
    update ObjectiveValue set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
GO
-- Trigger to maintain last updated value of Rank
create trigger tr_r_LastUpdated on Rank after insert, update
as
begin
	set nocount on
    update Rank set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
GO
-- Trigger to maintain last updated value of RankObjective
create trigger tr_ro_LastUpdated on RankObjective after insert, update
as
begin
	set nocount on
    update RankObjective set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
GO
-- Trigger to maintain last updated value of ScoringType
create trigger tr_st_LastUpdated on ScoringType after insert, update
as
begin
	set nocount on
    update ScoringType set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
GO
-- Trigger to maintain last updated value of Scout
create trigger tr_s_LastUpdated on Scout after insert, update
as
begin
	set nocount on
    update Scout set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
GO
-- Trigger to maintain last updated value of ScoutRecord
create trigger tr_sr_LastUpdated on ScoutRecord after insert, update
as
begin
	set nocount on
    update ScoutRecord set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
GO
-- Trigger to maintain last updated value of Team
create trigger tr_t_LastUpdated on Team after insert, update
as
begin
	set nocount on
    update Team set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
GO
-- Trigger to maintain last updated value of TeamAttribute
create trigger tr_ta_LastUpdated on TeamAttribute after insert, update
as
begin
	set nocount on
    update TeamAttribute set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
GO
-- Trigger to maintain last updated value of TeamGameEvent
create trigger tr_tge_LastUpdated on TeamGameEvent after insert, update
as
begin
	set nocount on
    update TeamGameEvent set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
GO
-- Trigger to maintain last updated value of TeamMatch
create trigger tr_tm_LastUpdated on TeamMatch after insert, update
as
begin
	set nocount on
    update TeamMatch set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
	set nocount off
end
GO

-- Insert some random data
insert into ScoutRecord (scoutId, matchId, TeamId)
select s.Id
     , tm.matchId
     , tm.TeamId
  from TeamMatch tm, Scout s
 where s.lastName in ('Parks', 'Weinreich', 'Schlichting');

insert into ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue)
select sr.id
     , o.id
     , cast(round(rand() * 2, 0) as integer) integerValue
  from scoutRecord sr
     , objective o
 where o.name = 'leaveHAB';
insert into ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue)
select sr.id
     , o.id
     , cast(round(rand() * 2, 0) as integer) integerValue
  from scoutRecord sr
     , objective o
 where o.name = 'ssHatchCnt';
insert into ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue)
select sr.id
     , o.id
     , cast(round(rand() * 2, 0) as integer) integerValue
  from scoutRecord sr
     , objective o
 where o.name = 'ssCargoCnt';
insert into ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue)
select sr.id
     , o.id
     , cast(round(rand() * 10, 0) as integer) integerValue
  from scoutRecord sr
     , objective o
 where o.name = 'toHatchCnt';
insert into ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue)
select sr.id
     , o.id
     , cast(round(rand() * 10, 0) as integer) integerValue
  from scoutRecord sr
     , objective o
 where o.name = 'toCargoCnt';
insert into ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue)
select sr.id
     , o.id
     , cast(round(rand() * 3, 0) as integer) integerValue
  from scoutRecord sr
     , objective o
 where o.name = 'playedDefense';
insert into ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue)
select sr.id
     , o.id
     , cast(round(rand() * 3, 0) as integer) integerValue
  from scoutRecord sr
     , objective o
 where o.name = 'returnToHAB';
update scoutObjectiveRecord
   set integerValue = abs(checksum(NewId()) % 1000000);
update scoutObjectiveRecord
   set integerValue = cast(round(1.0 * integerValue / power(10, len(convert(varchar, integervalue))) * 2, 0) as integer)
 where objectiveId in (select id from Objective where name in ('leaveHAB', 'ssHatchCnt', 'ssCargoCnt', 'playedDefense'));
update scoutObjectiveRecord
   set integerValue = integerValue * 2
 where objectiveId in (select id from Objective where name = 'playedDefense');
update scoutObjectiveRecord
   set integerValue = cast(round(1.0 * integerValue / power(10, len(convert(varchar, integervalue))) * 10, 0) as integer)
 where objectiveId in (select id from Objective where name in ('toHatchCnt', 'toCargoCnt'));
update scoutObjectiveRecord
   set integerValue = cast(round(1.0 * integerValue / power(10, len(convert(varchar, integervalue))) * 3, 0) as integer)
 where objectiveId in (select id from Objective where name in ('returnToHAB'));
go
*/
 
-- View for Match Teams
create view v_MatchHyperlinks as
select '<a href="Reports/matchReport.php?matchId=' + convert(varchar, subquery.matchId) + '"> ' + subquery.matchNumber + '</a>' matchReportUrl
     , subquery.r1TeamNumber
     , '<a href="Reports/robotReport.php?TeamId=' + convert(varchar, subquery.r1TeamId) + '"> ' + convert(varchar, subquery.r1TeamNumber) + '</a>' r1TeamReportUrl
     , '<a href="scoutRecord.php?matchId=' + convert(varchar, subquery.matchId) + '&matchNumber=' + subquery.matchNumber + '&teamId=' + coalesce(convert(varchar, subquery.r1TeamId), 'NA') + '&teamNumber=' + coalesce(convert(varchar, subquery.r1TeamNumber), 'NA') + '&alliancePosition=R1"> ' + subquery.r1ScoutIndicator + ' </a>' r1TeamScoutUrl
     , subquery.r2TeamNumber
     , '<a href="Reports/robotReport.php?TeamId=' + convert(varchar, subquery.r2TeamId) + '"> ' + convert(varchar, subquery.r2TeamNumber) + '</a>' r2TeamReportUrl
     , '<a href="scoutRecord.php?matchId=' + convert(varchar, subquery.matchId) + '&matchNumber=' + subquery.matchNumber + '&teamId=' + coalesce(convert(varchar, subquery.r2TeamId), 'NA') + '&teamNumber=' + coalesce(convert(varchar, subquery.r2TeamNumber), 'NA') + '&alliancePosition=R2"> ' + subquery.r2ScoutIndicator + ' </a>' r2TeamScoutUrl
     , subquery.r3TeamNumber
     , '<a href="Reports/robotReport.php?TeamId=' + convert(varchar, subquery.r3TeamId) + '"> ' + convert(varchar, subquery.r3TeamNumber) + '</a>' r3TeamReportUrl
     , '<a href="scoutRecord.php?matchId=' + convert(varchar, subquery.matchId) + '&matchNumber=' + subquery.matchNumber + '&teamId=' + coalesce(convert(varchar, subquery.r3TeamId), 'NA') + '&teamNumber=' + coalesce(convert(varchar, subquery.r3TeamNumber), 'NA') + '&alliancePosition=R3"> ' + subquery.r3ScoutIndicator + ' </a>' r3TeamScoutUrl
     , subquery.b1TeamNumber
     , '<a href="Reports/robotReport.php?TeamId=' + convert(varchar, subquery.b1TeamId) + '"> ' + convert(varchar, subquery.b1TeamNumber) +  '</a>' b1TeamReportUrl
     , '<a href="scoutRecord.php?matchId=' + convert(varchar, subquery.matchId) + '&matchNumber=' + subquery.matchNumber + '&teamId=' + coalesce(convert(varchar, subquery.b1TeamId), 'NA') + '&teamNumber=' + coalesce(convert(varchar, subquery.b1TeamNumber), 'NA') + '&alliancePosition=B1"> ' + subquery.b1ScoutIndicator + ' </a>' b1TeamScoutUrl
     , subquery.b2TeamNumber
     , '<a href="Reports/robotReport.php?TeamId=' + convert(varchar, subquery.b2TeamId) + '"> ' + convert(varchar, subquery.b2TeamNumber) +  '</a>' b2TeamReportUrl
     , '<a href="scoutRecord.php?matchId=' + convert(varchar, subquery.matchId) + '&matchNumber=' + subquery.matchNumber + '&teamId=' + coalesce(convert(varchar, subquery.b2TeamId), 'NA') + '&teamNumber=' + coalesce(convert(varchar, subquery.b2TeamNumber), 'NA') + '&alliancePosition=B2"> ' + subquery.b2ScoutIndicator + ' </a>' b2TeamScoutUrl
     , subquery.b3TeamNumber
     , '<a href="Reports/robotReport.php?TeamId=' + convert(varchar, subquery.b3TeamId) + '"> ' + convert(varchar, subquery.b3TeamNumber) +  '</a>' b3TeamReportUrl
     , '<a href="scoutRecord.php?matchId=' + convert(varchar, subquery.matchId) + '&matchNumber=' + subquery.matchNumber + '&teamId=' + coalesce(convert(varchar, subquery.b3TeamId), 'NA') + '&teamNumber=' + coalesce(convert(varchar, subquery.b3TeamNumber), 'NA') + '&alliancePosition=B3"> ' + subquery.b3ScoutIndicator + ' </a>' b3TeamScoutUrl
     , subquery.sortOrder
     , subquery.matchNumber
     , subquery.matchId
	 , subquery.datetime
	 , subquery.redScore
	 , subquery.blueScore
     , subquery.r1TeamId
     , subquery.r2TeamId
     , subquery.r3TeamId
     , subquery.b1TeamId
     , subquery.b2TeamId
     , subquery.b3TeamId
	 , case when isnumeric(subquery.number) = 1
	        then convert(numeric, subquery.number)
			else 1000 end matchSort
  from (
select case when convert(decimal(18,10), (m.datetime - convert(datetime, SYSDATETIMEOFFSET() AT TIME ZONE 'Central Standard Time'))) + (6.0 / 24.0 / 60.0) < 0 then 1 else 0 end sortOrder
     , m.type + ' ' + m.number matchNumber
     , m.id matchId
	 , m.number
	 , m.datetime
	 , m.redScore
	 , m.blueScore
	 , max(case when tm.alliance = 'R' and tm.alliancePosition = 1 then t.teamNumber else null end) r1TeamNumber
	 , max(case when tm.alliance = 'R' and tm.alliancePosition = 1 then t.id else null end) r1TeamId
	 , case when sum(case when tm.alliance = 'R' and tm.alliancePosition = 1 and sr.id is not null then 1 else 0 end) = 0 then 'S' else 's' end r1ScoutIndicator
	 , max(case when tm.alliance = 'R' and tm.alliancePosition = 2 then t.teamNumber else null end) r2TeamNumber
	 , max(case when tm.alliance = 'R' and tm.alliancePosition = 2 then t.id else null end) r2TeamId
	 , case when sum(case when tm.alliance = 'R' and tm.alliancePosition = 2 and sr.id is not null then 1 else 0 end) = 0 then 'S' else 's' end r2ScoutIndicator
	 , max(case when tm.alliance = 'R' and tm.alliancePosition = 3 then t.teamNumber else null end) r3TeamNumber
	 , max(case when tm.alliance = 'R' and tm.alliancePosition = 3 then t.id else null end) r3TeamId
	 , case when sum(case when tm.alliance = 'R' and tm.alliancePosition = 3 and sr.id is not null then 1 else 0 end) = 0 then 'S' else 's' end r3ScoutIndicator
	 , max(case when tm.alliance = 'B' and tm.alliancePosition = 1 then t.teamNumber else null end) b1TeamNumber
	 , max(case when tm.alliance = 'B' and tm.alliancePosition = 1 then t.id else null end) b1TeamId
	 , case when sum(case when tm.alliance = 'B' and tm.alliancePosition = 1 and sr.id is not null then 1 else 0 end) = 0 then 'S' else 's' end b1ScoutIndicator
	 , max(case when tm.alliance = 'B' and tm.alliancePosition = 2 then t.teamNumber else null end) b2TeamNumber
	 , max(case when tm.alliance = 'B' and tm.alliancePosition = 2 then t.id else null end) b2TeamId
	 , case when sum(case when tm.alliance = 'B' and tm.alliancePosition = 2 and sr.id is not null then 1 else 0 end) = 0 then 'S' else 's' end b2ScoutIndicator
	 , max(case when tm.alliance = 'B' and tm.alliancePosition = 3 then t.teamNumber else null end) b3TeamNumber
	 , max(case when tm.alliance = 'B' and tm.alliancePosition = 3 then t.id else null end) b3TeamId
	 , case when sum(case when tm.alliance = 'B' and tm.alliancePosition = 3 and sr.id is not null then 1 else 0 end) = 0 then 'S' else 's' end b3ScoutIndicator
  from Match m
       inner join GameEvent ge
	   on ge.id = m.gameEventId
	   left outer join TeamMatch tm
	   on tm.matchId = m.id
	   left outer join Team t
	   on t.id = tm.teamId
	   left outer join ScoutRecord sr
	   on sr.matchId = tm.matchId
	   and sr.teamId = tm.teamId
 where ge.isActive = 'Y'
   and m.isActive = 'Y'
group by m.type
       , m.id
	   , m.number
	   , m.datetime
	   , m.redScore
	   , m.blueScore
) subquery;
go

create view v_ScoutTeamHyperlinks as
select '<a href="robotAttrSetup.php?teamId=' + convert(varchar, t.id) + '&teamNumber=' + convert(varchar, t.teamNumber) + '">' + convert(varchar, t.teamNumber) + '</a>' teamUrl
     , t.teamNumber
	 , t.id teamId
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 1
		   and a.gameId = ge.gameId) attrValue1
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 2
		   and a.gameId = ge.gameId) attrValue2
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 3
		   and a.gameId = ge.gameId) attrValue3
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 4
		   and a.gameId = ge.gameId) attrValue4
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 5
		   and a.gameId = ge.gameId) attrValue5
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 6
		   and a.gameId = ge.gameId) attrValue6
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 7
		   and a.gameId = ge.gameId) attrValue7
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 8
		   and a.gameId = ge.gameId) attrValue8
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 9
		   and a.gameId = ge.gameId) attrValue9
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 10
		   and a.gameId = ge.gameId) attrValue10
  from Team t 
       inner join TeamGameEvent tge 
       on tge.teamId = t.id
       inner join GameEvent ge 
       on ge.id = tge.gameEventId
 where ge.isActive = 'Y';
go

create view v_RankButtons as
select distinct
       '<div id="reportsby"><a class="clickme danger" href="Reports/rankReport.php?sortOrder=' + r.queryString + '&rankName=' + r.name + '">Rank by ' + r.name + ' </a></div>' buttonHtml
	 , r.name
	 , r.queryString
     , r.sortOrder
  from Rank r
       inner join RankObjective ro
	   on ro.rankId = r.id
	   inner join Objective o
	   on o.id = ro.objectiveId
	   inner join Game g
	   on g.id = o.gameId
	   inner join GameEvent ge
	   on ge.gameId = g.id
 where ge.isActive = 'Y'
go

-- View to get HTML for entry of Scout Record
create view v_EnterScoutRecordHTML as
select distinct
       og.name groupName
     , null objectiveName      
	 , null objectiveLabel
	 , null displayValue
	 , null integerValue
     , og.sortOrder groupSort
	 , null objectiveSort
	 , null objectiveValueSort
	 , '<br><b><u>' + og.name + '</u></b>' scoutRecordHtml
  from objectiveGroup og
       inner join objectiveGroupObjective ogo
	   on ogo.objectiveGroupId = og.id
       inner join objective o
	   on o.id = ogo.objectiveId
 where o.gameId in
       (select g.id
	      from game g
		       inner join gameEvent ge
			   on ge.gameId = g.id
		 where ge.isActive = 'Y')
union
select distinct
       og.name groupName
     , o.name objectiveName
	 , o.label objectiveLabel
	 , ov.displayValue
	 , ov.integerValue
     , og.sortOrder groupSort
	 , o.sortOrder objectiveSort
	 , ov.sortOrder objectiveValueSort
	 , case when st.hasValueList = 'N'
	        then '<br>' + o.label + '<input type="number" name ="value' + convert(varchar, o.sortOrder) + '" value=0 style="width: 40px;"><br>'
			when ov.sortOrder = 1
	        then '<br>' + o.label + '<br>&nbsp;&nbsp;&nbsp;&nbsp;' + ov.displayValue + '<input type="radio" checked="checked" name ="value' + convert(varchar, o.sortOrder) + '" value=' + convert(varchar, ov.integerValue) + '><br>'
			else '&nbsp;&nbsp;&nbsp;&nbsp;' + ov.displayValue + '<input type="radio" name ="value' + convert(varchar, o.sortOrder) + '" value=' + convert(varchar, ov.integerValue) + '><br>' end scoutRecordHtml
  from objectiveGroup og
       inner join objectiveGroupObjective ogo
	   on ogo.objectiveGroupId = og.id
       inner join objective o
	   on o.id = ogo.objectiveId
	   inner join scoringType st
	   on st.id = o.scoringTypeId
	   left outer join objectiveValue ov
	   on ov.objectiveId = o.id
 where o.gameId in
       (select g.id
	      from game g
		       inner join gameEvent ge
			   on ge.gameId = g.id
		 where ge.isActive = 'Y')
--order by groupSort, objectiveSort, objectiveValueSort
go

create view v_EnterScoutTeamHTML as
select a.name attributeName
	 , a.label attributeLabel
	 , av.displayValue
	 , av.integerValue
     , a.sortOrder attributeSort
	 , av.sortOrder attributeValueSort
     , case when st.hasValueList = 'N' and st.name = 'Free Form'
	        then '<br>' + a.label + '<br><input type="text" name ="value' + convert(varchar, a.sortOrder) + '" placeholder="' +
			coalesce((select ta.textValue from teamAttribute ta where ta.teamId = t.id and ta.attributeId = a.id), 'Drive Straight 5 feet') +
			'" style="width: 320px"><br>'
			when st.hasValueList = 'N'
	        then '<br>' + a.label + '<input type="number" name ="value' + convert(varchar, a.sortOrder) + '" value=' +
			coalesce((select convert(varchar, ta.integerValue) from teamAttribute ta where ta.teamId = t.id and ta.attributeId = a.id), '0') +
			' style="width: 50px;"><br>'
			when av.sortOrder = 1
	        then '<br>' + a.label + '<br>&nbsp;&nbsp;&nbsp;&nbsp;' + av.displayValue + '<input type="radio" ' +
			coalesce((select case when ta.integerValue = av.integerValue then 'checked="checked"' else '' end from teamAttribute ta where ta.teamId = t.id and ta.attributeId = a.id), 'checked="checked"') +
			' name ="value' + convert(varchar, a.sortOrder) + '" value=' + convert(varchar, av.integerValue) + '><br>'
			else                        '&nbsp;&nbsp;&nbsp;&nbsp;' + av.displayValue + '<input type="radio" ' +
			coalesce((select case when ta.integerValue = av.integerValue then 'checked="checked"' else '' end from teamAttribute ta where ta.teamId = t.id and ta.attributeId = a.id), '') +
			' name ="value' + convert(varchar, a.sortOrder) + '" value=' + convert(varchar, av.integerValue) + '><br>' end scoutTeamHtml
	 , t.id teamId
	 , t.teamNumber
  from attribute a
	   inner join scoringType st
	   on st.id = a.scoringTypeId
	   left outer join attributeValue av
	   on av.attributeId = a.id,
	   team t
	   inner join TeamGameEvent tge
	   on tge.teamId = t.id
	   inner join GameEvent ge
	   on ge.id = tge.gameEventId
 where ge.isActive = 'Y'
   and a.gameId = ge.gameId
--order by attributeSort, attributeValueSort
go

-- View for Scout Record
create view v_ScoutRecord as
select sr.matchId
     , sr.teamId
	 , sr.scoutId
	 , m.gameEventId
	 , sum(case when o.sortOrder = 1 and o.reportDisplay = 'S' then sor.scoreValue
	            when o.sortOrder = 1 and o.reportDisplay = 'I' then sor.integerValue
--	            when o.sortOrder = 1 and o.reportDisplay = 'D' then sor.decimalValue
	            else null end) value1
	 , sum(case when o.sortOrder = 2 and o.reportDisplay = 'S' then sor.scoreValue
	            when o.sortOrder = 2 and o.reportDisplay = 'I' then sor.integerValue
--	            when o.sortOrder = 2 and o.reportDisplay = 'D' then sor.decimalValue
	            else null end) value2
	 , sum(case when o.sortOrder = 3 and o.reportDisplay = 'S' then sor.scoreValue
	            when o.sortOrder = 3 and o.reportDisplay = 'I' then sor.integerValue
--	            when o.sortOrder = 3 and o.reportDisplay = 'D' then sor.decimalValue
	            else null end) value3
	 , sum(case when o.sortOrder = 4 and o.reportDisplay = 'S' then sor.scoreValue
	            when o.sortOrder = 4 and o.reportDisplay = 'I' then sor.integerValue
--	            when o.sortOrder = 4 and o.reportDisplay = 'D' then sor.decimalValue
	            else null end) value4
	 , sum(case when o.sortOrder = 5 and o.reportDisplay = 'S' then sor.scoreValue
	            when o.sortOrder = 5 and o.reportDisplay = 'I' then sor.integerValue
--	            when o.sortOrder = 5 and o.reportDisplay = 'D' then sor.decimalValue
	            else null end) value5
	 , sum(case when o.sortOrder = 6 and o.reportDisplay = 'S' then sor.scoreValue
	            when o.sortOrder = 6 and o.reportDisplay = 'I' then sor.integerValue
--	            when o.sortOrder = 6 and o.reportDisplay = 'D' then sor.decimalValue
	            else null end) value6
	 , sum(case when o.sortOrder = 7 and o.reportDisplay = 'S' then sor.scoreValue
	            when o.sortOrder = 7 and o.reportDisplay = 'I' then sor.integerValue
--	            when o.sortOrder = 7 and o.reportDisplay = 'D' then sor.decimalValue
	            else null end) value7
	 , sum(case when o.sortOrder = 8 and o.reportDisplay = 'S' then sor.scoreValue
	            when o.sortOrder = 8 and o.reportDisplay = 'I' then sor.integerValue
--	            when o.sortOrder = 8 and o.reportDisplay = 'D' then sor.decimalValue
	            else null end) value8
	 , sum(case when o.sortOrder = 9 and o.reportDisplay = 'S' then sor.scoreValue
	            when o.sortOrder = 9 and o.reportDisplay = 'I' then sor.integerValue
--	            when o.sortOrder = 9 and o.reportDisplay = 'D' then sor.decimalValue
	            else null end) value9
	 , sum(case when o.sortOrder = 10 and o.reportDisplay = 'S' then sor.scoreValue
	            when o.sortOrder = 10 and o.reportDisplay = 'I' then sor.integerValue
--	            when o.sortOrder = 10 and o.reportDisplay = 'D' then sor.decimalValue
	            else null end) value10
	 , sum(case when o.sortOrder = 11 and o.reportDisplay = 'S' then sor.scoreValue
	            when o.sortOrder = 11 and o.reportDisplay = 'I' then sor.integerValue
--	            when o.sortOrder = 11 and o.reportDisplay = 'D' then sor.decimalValue
	            else null end) value11
	 , sum(case when o.sortOrder = 12 and o.reportDisplay = 'S' then sor.scoreValue
	            when o.sortOrder = 12 and o.reportDisplay = 'I' then sor.integerValue
--	            when o.sortOrder = 12 and o.reportDisplay = 'D' then sor.decimalValue
	            else null end) value12
	 , sum(case when o.sortOrder = 13 and o.reportDisplay = 'S' then sor.scoreValue
	            when o.sortOrder = 13 and o.reportDisplay = 'I' then sor.integerValue
--	            when o.sortOrder = 13 and o.reportDisplay = 'D' then sor.decimalValue
	            else null end) value13
	 , sum(case when o.sortOrder = 14 and o.reportDisplay = 'S' then sor.scoreValue
	            when o.sortOrder = 14 and o.reportDisplay = 'I' then sor.integerValue
--	            when o.sortOrder = 14 and o.reportDisplay = 'D' then sor.decimalValue
	            else null end) value14
	 , sum(case when o.sortOrder = 15 and o.reportDisplay = 'S' then sor.scoreValue
	            when o.sortOrder = 15 and o.reportDisplay = 'I' then sor.integerValue
--	            when o.sortOrder = 15 and o.reportDisplay = 'D' then sor.decimalValue
	            else null end) value15
	 , sum(case when o.sortOrder = 1 then sor.integerValue else null end) integerValue1
	 , sum(case when o.sortOrder = 2 then sor.integerValue else null end) integerValue2
	 , sum(case when o.sortOrder = 3 then sor.integerValue else null end) integerValue3
	 , sum(case when o.sortOrder = 4 then sor.integerValue else null end) integerValue4
	 , sum(case when o.sortOrder = 5 then sor.integerValue else null end) integerValue5
	 , sum(case when o.sortOrder = 6 then sor.integerValue else null end) integerValue6
	 , sum(case when o.sortOrder = 7 then sor.integerValue else null end) integerValue7
	 , sum(case when o.sortOrder = 8 then sor.integerValue else null end) integerValue8
	 , sum(case when o.sortOrder = 9 then sor.integerValue else null end) integerValue9
	 , sum(case when o.sortOrder = 10 then sor.integerValue else null end) integerValue10
	 , sum(case when o.sortOrder = 11 then sor.integerValue else null end) integerValue11
	 , sum(case when o.sortOrder = 12 then sor.integerValue else null end) integerValue12
	 , sum(case when o.sortOrder = 13 then sor.integerValue else null end) integerValue13
	 , sum(case when o.sortOrder = 14 then sor.integerValue else null end) integerValue14
	 , sum(case when o.sortOrder = 15 then sor.integerValue else null end) integerValue15
/*
	 , sum(case when o.sortOrder = 1 then sor.decimalValue else null end) decimalValue1
	 , sum(case when o.sortOrder = 2 then sor.decimalValue else null end) decimalValue2
	 , sum(case when o.sortOrder = 3 then sor.decimalValue else null end) decimalValue3
	 , sum(case when o.sortOrder = 4 then sor.decimalValue else null end) decimalValue4
	 , sum(case when o.sortOrder = 5 then sor.decimalValue else null end) decimalValue5
	 , sum(case when o.sortOrder = 6 then sor.decimalValue else null end) decimalValue6
	 , sum(case when o.sortOrder = 7 then sor.decimalValue else null end) decimalValue7
	 , sum(case when o.sortOrder = 8 then sor.decimalValue else null end) decimalValue8
	 , sum(case when o.sortOrder = 9 then sor.decimalValue else null end) decimalValue9
	 , sum(case when o.sortOrder = 10 then sor.decimalValue else null end) decimalValue10
	 , sum(case when o.sortOrder = 11 then sor.decimalValue else null end) decimalValue11
	 , sum(case when o.sortOrder = 12 then sor.decimalValue else null end) decimalValue12
	 , sum(case when o.sortOrder = 13 then sor.decimalValue else null end) decimalValue13
	 , sum(case when o.sortOrder = 14 then sor.decimalValue else null end) decimalValue14
	 , sum(case when o.sortOrder = 15 then sor.decimalValue else null end) decimalValue15
*/
	 , sum(case when o.sortOrder = 1 then sor.scoreValue else null end) scoreValue1
	 , sum(case when o.sortOrder = 2 then sor.scoreValue else null end) scoreValue2
	 , sum(case when o.sortOrder = 3 then sor.scoreValue else null end) scoreValue3
	 , sum(case when o.sortOrder = 4 then sor.scoreValue else null end) scoreValue4
	 , sum(case when o.sortOrder = 5 then sor.scoreValue else null end) scoreValue5
	 , sum(case when o.sortOrder = 6 then sor.scoreValue else null end) scoreValue6
	 , sum(case when o.sortOrder = 7 then sor.scoreValue else null end) scoreValue7
	 , sum(case when o.sortOrder = 8 then sor.scoreValue else null end) scoreValue8
	 , sum(case when o.sortOrder = 9 then sor.scoreValue else null end) scoreValue9
	 , sum(case when o.sortOrder = 10 then sor.scoreValue else null end) scoreValue10
	 , sum(case when o.sortOrder = 11 then sor.scoreValue else null end) scoreValue11
	 , sum(case when o.sortOrder = 12 then sor.scoreValue else null end) scoreValue12
	 , sum(case when o.sortOrder = 13 then sor.scoreValue else null end) scoreValue13
	 , sum(case when o.sortOrder = 14 then sor.scoreValue else null end) scoreValue14
	 , sum(case when o.sortOrder = 15 then sor.scoreValue else null end) scoreValue15
  from ScoutRecord sr
       inner join Match m
	   on m.id = sr.matchId
	   inner join GameEvent ge
	   on ge.id = m.gameEventId
	   inner join ScoutObjectiveRecord sor
	   on sor.scoutRecordId = sr.id
	   inner join Objective o
	   on o.id = sor.objectiveId
 where ge.isActive = 'Y'
   and m.isActive = 'Y'
group by sr.matchId
       , sr.teamId
	   , sr.scoutId
	   , m.gameEventId;
GO

-- View for average Team report on a match
create view v_AvgScoutRecord as
select sr.matchId
     , sr.teamId
	 , sr.gameEventId
     , count(*) cnt
     , avg(convert(numeric, value1)) value1
     , avg(convert(numeric, value2)) value2
     , avg(convert(numeric, value3)) value3
     , avg(convert(numeric, value4)) value4
     , avg(convert(numeric, value5)) value5 
     , avg(convert(numeric, value6)) value6
     , avg(convert(numeric, value7)) value7
     , avg(convert(numeric, value8)) value8
     , avg(convert(numeric, value9)) value9
     , avg(convert(numeric, value10)) value10
     , avg(convert(numeric, value11)) value11
     , avg(convert(numeric, value12)) value12
     , avg(convert(numeric, value13)) value13
     , avg(convert(numeric, value14)) value14
     , avg(convert(numeric, value15)) value15 
     , avg(convert(numeric, integerValue1)) integerValue1
     , avg(convert(numeric, integerValue2)) integerValue2
     , avg(convert(numeric, integerValue3)) integerValue3
     , avg(convert(numeric, integerValue4)) integerValue4
     , avg(convert(numeric, integerValue5)) integerValue5 
     , avg(convert(numeric, integerValue6)) integerValue6
     , avg(convert(numeric, integerValue7)) integerValue7
     , avg(convert(numeric, integerValue8)) integerValue8
     , avg(convert(numeric, integerValue9)) integerValue9
     , avg(convert(numeric, integerValue10)) integerValue10
     , avg(convert(numeric, integerValue11)) integerValue11
     , avg(convert(numeric, integerValue12)) integerValue12
     , avg(convert(numeric, integerValue13)) integerValue13
     , avg(convert(numeric, integerValue14)) integerValue14
     , avg(convert(numeric, integerValue15)) integerValue15 
/*
     , avg(convert(numeric, decimalValue1)) decimalValue1
     , avg(convert(numeric, decimalValue2)) decimalValue2
     , avg(convert(numeric, decimalValue3)) decimalValue3
     , avg(convert(numeric, decimalValue4)) decimalValue4
     , avg(convert(numeric, decimalValue5)) decimalValue5 
     , avg(convert(numeric, decimalValue6)) decimalValue6
     , avg(convert(numeric, decimalValue7)) decimalValue7
     , avg(convert(numeric, decimalValue8)) decimalValue8
     , avg(convert(numeric, decimalValue9)) decimalValue9
     , avg(convert(numeric, decimalValue10)) decimalValue10
     , avg(convert(numeric, decimalValue11)) decimalValue11
     , avg(convert(numeric, decimalValue12)) decimalValue12
     , avg(convert(numeric, decimalValue13)) decimalValue13
     , avg(convert(numeric, decimalValue14)) decimalValue14
     , avg(convert(numeric, decimalValue15)) decimalValue15 
*/
     , avg(convert(numeric, scoreValue1)) scoreValue1
     , avg(convert(numeric, scoreValue2)) scoreValue2
     , avg(convert(numeric, scoreValue3)) scoreValue3
     , avg(convert(numeric, scoreValue4)) scoreValue4
     , avg(convert(numeric, scoreValue5)) scoreValue5 
     , avg(convert(numeric, scoreValue6)) scoreValue6
     , avg(convert(numeric, scoreValue7)) scoreValue7
     , avg(convert(numeric, scoreValue8)) scoreValue8
     , avg(convert(numeric, scoreValue9)) scoreValue9
     , avg(convert(numeric, scoreValue10)) scoreValue10
     , avg(convert(numeric, scoreValue11)) scoreValue11
     , avg(convert(numeric, scoreValue12)) scoreValue12
     , avg(convert(numeric, scoreValue13)) scoreValue13
     , avg(convert(numeric, scoreValue14)) scoreValue14
     , avg(convert(numeric, scoreValue15)) scoreValue15 
  from v_ScoutRecord sr
group by sr.matchId
       , sr.TeamId
	   , sr.gameEventId;
go

-- View for match averages
create view v_MatchReport as
select m.type + ' ' + m.number matchNumber
     , tm.matchId
     , tm.teamId
     , t.TeamNumber
     , case when tm.alliance = 'R' then 'Red'
	        when tm.alliance = 'B' then 'Blue'
	        else tm.alliance end alliance
     , tm.alliancePosition
     , '<a href="../Reports/robotReport.php?TeamId=' + convert(varchar, tm.teamId) + '"> ' + convert(varchar, t.teamNumber) + '</a> ' teamReportUrl
     , sum(case when sr.TeamId is null then 0 else 1 end) matchCnt
	 , case when tm.alliance = 'R' then 1
	        when tm.alliance = 'B' then 3
	        else 2 end allianceSort
     , round(avg(sr.value1),2) value1
     , round(avg(sr.value2),2) value2
     , round(avg(sr.value3),2) value3
     , round(avg(sr.value4),2) value4
     , round(avg(sr.value5),2) value5
     , round(avg(sr.value6),2) value6
     , round(avg(sr.value7),2) value7
     , round(avg(sr.value8),2) value8
     , round(avg(sr.value9),2) value9
     , round(avg(sr.value10),2) value10
     , round(avg(sr.value11),2) value11
     , round(avg(sr.value12),2) value12
     , round(avg(sr.value13),2) value13
     , round(avg(sr.value14),2) value14
     , round(avg(sr.value15),2) value15
	 , round(avg(coalesce(sr.scoreValue1,0) +
	             coalesce(sr.scoreValue2,0) +
	             coalesce(sr.scoreValue3,0) +
	             coalesce(sr.scoreValue4,0) +
	             coalesce(sr.scoreValue5,0) +
	             coalesce(sr.scoreValue6,0) +
	             coalesce(sr.scoreValue7,0) +
	             coalesce(sr.scoreValue8,0) +
	             coalesce(sr.scoreValue9,0) +
	             coalesce(sr.scoreValue10,0) +
	             coalesce(sr.scoreValue11,0) +
	             coalesce(sr.scoreValue12,0) +
	             coalesce(sr.scoreValue13,0) +
	             coalesce(sr.scoreValue14,0) +
	             coalesce(sr.scoreValue15,0)), 2) totalScoreValue
  from Match m
	   inner join GameEvent ge
	   on ge.id = m.gameEventId
       inner join TeamMatch tm
       on tm.matchId = m.id
       inner join Team t
       on t.id = tm.teamId
       left outer join v_AvgScoutRecord sr
       on sr.TeamId = tm.teamId
       and exists (select 1
                     from match m2
                    where m2.id = sr.matchId
                      and m2.isActive = 'Y')
 where ge.isActive = 'Y'
   and m.isActive = 'Y'
group by m.type + ' ' + m.number
       , tm.matchId
       , tm.teamId
       , t.TeamNumber
       , tm.alliance
       , tm.alliancePosition
union
select m.type + ' ' + m.number matchNumber
     , m.id matchId
     , null teamId
     , null TeamNumber
     , '----' alliance
     , null alliancePosition
     , null teamReportUrl
     , null matchCnt
	 , 2 allianceSort
     , null value1
     , null value2
     , null value3
     , null value4
     , null value5
     , null value6
     , null value7
     , null value8
     , null value9
     , null value10
     , null value11
     , null value12
     , null value13
     , null value14
     , null value15
	 , null totalScoreValue
  from Match m;
go
 
-- View for Match Robot Attributes
create view v_MatchReportAttributes as
select '<a href="../robotAttrSetup.php?teamId=' + convert(varchar, t.id) + '&teamNumber=' + convert(varchar, t.teamNumber) + '">' + convert(varchar, t.teamNumber) + '</a>' teamUrl
     , t.teamNumber
	 , t.id teamId
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 1
		   and a.gameId = ge.gameId) attrValue1
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 2
		   and a.gameId = ge.gameId) attrValue2
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 3
		   and a.gameId = ge.gameId) attrValue3
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 4
		   and a.gameId = ge.gameId) attrValue4
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 5
		   and a.gameId = ge.gameId) attrValue5
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 6
		   and a.gameId = ge.gameId) attrValue6
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 7
		   and a.gameId = ge.gameId) attrValue7
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 8
		   and a.gameId = ge.gameId) attrValue8
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 9
		   and a.gameId = ge.gameId) attrValue9
     , (select coalesce(av.displayValue, ta.textValue, convert(varchar, ta.integerValue), ' ')
	      from Attribute a
		       left outer join TeamAttribute ta
			   on ta.attributeId = a.id
			   and ta.teamId = t.id
			   left outer join AttributeValue av
			   on av.attributeId = a.id
			   and av.integerValue = ta.integerValue
		 where a.sortOrder = 10
		   and a.gameId = ge.gameId) attrValue10
	 , tm.matchId
     , case when tm.alliance = 'R' then 'Red'
	        when tm.alliance = 'B' then 'Blue'
	        else tm.alliance end alliance
     , tm.alliancePosition
     , '<a href="../Reports/robotReport.php?TeamId=' + convert(varchar, tm.teamId) + '"> ' + convert(varchar, t.teamNumber) + '</a> ' teamReportUrl
	 , case when tm.alliance = 'R' then 1
	        when tm.alliance = 'B' then 3
	        else 2 end allianceSort
  from Team t 
       inner join TeamGameEvent tge 
       on tge.teamId = t.id
       inner join GameEvent ge 
       on ge.id = tge.gameEventId
       inner join Match m
	   on m.gameEventId = ge.id
	   inner join TeamMatch tm
	   on tm.matchId = m.id
	   and tm.teamId = t.id
 where ge.isActive = 'Y'
union
select null teamUrl
     , null TeamNumber
     , null teamId
     , null attrValue1
     , null attrValue2
     , null attrValue3
     , null attrValue4
     , null attrValue5
     , null attrValue6
     , null attrValue7
     , null attrValue8
     , null attrValue9
     , null attrValue10
     , m.id matchId
     , '----' alliance
     , null alliancePosition
     , null teamReportUrl
	 , 2 allianceSort
  from Match m;
go

-- View for Team history and average
create view v_TeamReport as
select t.TeamNumber
     , 'N/A' matchNumber
     , max(m.datetime + 1) matchTime
     , 'Average Score' scoutName
     , round(avg(sr.value1),2) value1
     , round(avg(sr.value2),2) value2
     , round(avg(sr.value3),2) value3
     , round(avg(sr.value4),2) value4
     , round(avg(sr.value5),2) value5
     , round(avg(sr.value6),2) value6
     , round(avg(sr.value7),2) value7
     , round(avg(sr.value8),2) value8
     , round(avg(sr.value9),2) value9
     , round(avg(sr.value10),2) value10
     , round(avg(sr.value11),2) value11
     , round(avg(sr.value12),2) value12
     , round(avg(sr.value13),2) value13
     , round(avg(sr.value14),2) value14
     , round(avg(sr.value15),2) value15
	 , round(avg(coalesce(sr.scoreValue1,0) +
	             coalesce(sr.scoreValue2,0) +
	             coalesce(sr.scoreValue3,0) +
	             coalesce(sr.scoreValue4,0) +
	             coalesce(sr.scoreValue5,0) +
	             coalesce(sr.scoreValue6,0) +
	             coalesce(sr.scoreValue7,0) +
	             coalesce(sr.scoreValue8,0) +
	             coalesce(sr.scoreValue9,0) +
	             coalesce(sr.scoreValue10,0) +
	             coalesce(sr.scoreValue11,0) +
	             coalesce(sr.scoreValue12,0) +
	             coalesce(sr.scoreValue13,0) +
	             coalesce(sr.scoreValue14,0) +
	             coalesce(sr.scoreValue15,0)),2) totalScoreValue
     , t.id TeamId
     , null matchId
     , null scoutId
	 , sr.gameEventId
 from Team t
      inner join v_AvgScoutRecord sr
      on sr.TeamId = t.id
      inner join Match m
      on m.id = sr.matchId
 where t.isActive = 'Y'
   and m.isActive = 'Y'
group by t.TeamNumber
       , t.id
	   , sr.gameEventId
union
select t.TeamNumber
     , m.type + ' ' + m.number matchNumber
     , m.datetime matchTime
     , s.lastName + ', ' + firstName scoutName
     , sr.value1
     , sr.value2
     , sr.value3
     , sr.value4
     , sr.value5
     , sr.value6
     , sr.value7
     , sr.value8
     , sr.value9
     , sr.value10
     , sr.value11
     , sr.value12
     , sr.value13
     , sr.value14
     , sr.value15
	 , round(coalesce(sr.scoreValue1,0) +
	         coalesce(sr.scoreValue2,0) +
	         coalesce(sr.scoreValue3,0) +
	         coalesce(sr.scoreValue4,0) +
	         coalesce(sr.scoreValue5,0) +
	         coalesce(sr.scoreValue6,0) +
	         coalesce(sr.scoreValue7,0) +
	         coalesce(sr.scoreValue8,0) +
	         coalesce(sr.scoreValue9,0) +
	         coalesce(sr.scoreValue10,0) +
	         coalesce(sr.scoreValue11,0) +
	         coalesce(sr.scoreValue12,0) +
	         coalesce(sr.scoreValue13,0) +
	         coalesce(sr.scoreValue14,0) +
	         coalesce(sr.scoreValue15,0),2) totalScoreValue
     , sr.TeamId
     , sr.matchId
     , sr.scoutId
	 , sr.gameEventId
 from Team t
      inner join v_ScoutRecord sr
      on sr.TeamId = t.id
      inner join Match m
      on m.id = sr.matchId
      inner join scout s
      on s.id = sr.scoutId
 where t.isActive = 'Y'
   and m.isActive = 'Y';
go

create view v_AvgTeamRecord as
select asr.TeamId
     , count(*) cntMatches
     , avg(asr.value1) value1
     , avg(asr.value2) value2
     , avg(asr.value3) value3
     , avg(asr.value4) value4
     , avg(asr.value5) value5
     , avg(asr.value6) value6
     , avg(asr.value7) value7
     , avg(asr.value8) value8
     , avg(asr.value9) value9
     , avg(asr.value10) value10
     , avg(asr.value11) value11
     , avg(asr.value12) value12
     , avg(asr.value13) value13
     , avg(asr.value14) value14
     , avg(asr.value15) value15
     , avg(asr.integerValue1) integerValue1
     , avg(asr.integerValue2) integerValue2
     , avg(asr.integerValue3) integerValue3
     , avg(asr.integerValue4) integerValue4
     , avg(asr.integerValue5) integerValue5
     , avg(asr.integerValue6) integerValue6
     , avg(asr.integerValue7) integerValue7
     , avg(asr.integerValue8) integerValue8
     , avg(asr.integerValue9) integerValue9
     , avg(asr.integerValue10) integerValue10
     , avg(asr.integerValue11) integerValue11
     , avg(asr.integerValue12) integerValue12
     , avg(asr.integerValue13) integerValue13
     , avg(asr.integerValue14) integerValue14
     , avg(asr.integerValue15) integerValue15
/*
     , avg(asr.decimalValue1) decimalValue1
     , avg(asr.decimalValue2) decimalValue2
     , avg(asr.decimalValue3) decimalValue3
     , avg(asr.decimalValue4) decimalValue4
     , avg(asr.decimalValue5) decimalValue5
     , avg(asr.decimalValue6) decimalValue6
     , avg(asr.decimalValue7) decimalValue7
     , avg(asr.decimalValue8) decimalValue8
     , avg(asr.decimalValue9) decimalValue9
     , avg(asr.decimalValue10) decimalValue10
     , avg(asr.decimalValue11) decimalValue11
     , avg(asr.decimalValue12) decimalValue12
     , avg(asr.decimalValue13) decimalValue13
     , avg(asr.decimalValue14) decimalValue14
     , avg(asr.decimalValue15) decimalValue15
*/
     , avg(asr.scoreValue1) scoreValue1
     , avg(asr.scoreValue2) scoreValue2
     , avg(asr.scoreValue3) scoreValue3
     , avg(asr.scoreValue4) scoreValue4
     , avg(asr.scoreValue5) scoreValue5
     , avg(asr.scoreValue6) scoreValue6
     , avg(asr.scoreValue7) scoreValue7
     , avg(asr.scoreValue8) scoreValue8
     , avg(asr.scoreValue9) scoreValue9
     , avg(asr.scoreValue10) scoreValue10
     , avg(asr.scoreValue11) scoreValue11
     , avg(asr.scoreValue12) scoreValue12
     , avg(asr.scoreValue13) scoreValue13
     , avg(asr.scoreValue14) scoreValue14
     , avg(asr.scoreValue15) scoreValue15
  from v_AvgScoutRecord asr
       inner join Match m
	   on m.id = asr.matchId
 where m.isActive = 'Y'
group by asr.TeamId;
go

/*
-- Rank Query (as a stored procedure to improve query performance
CREATE PROCEDURE sp_rpt_rankReport (@pv_QueryString varchar(64))
AS
DECLARE @lv_SortOrder int;
BEGIN
	create table #AvgTeamRecord(teamId int
	                          , gameId int
	                          , rankName varchar(64)
	                          , sortOrder int
							  , cntMatches int
	                          , value numeric(38, 6)
							  , rank integer
							  , rankingPointAverage numeric(10, 3));
	SET NOCOUNT ON
	-- Get Sort Order
	SELECT @lv_SortOrder = coalesce(max(sortOrder), 1)
	  FROM Rank r
	       inner join GameEvent ge
		   on ge.gameId = r.gameId
	 WHERE ge.isActive = 'Y'
	   AND r.queryString = @pv_QueryString;

	-- Populate local temporary table of team average scores.  This improves overall query performance
	INSERT INTO #AvgTeamRecord
	select atr.teamId
		 , r.gameId
		 , r.name rankName
		 , r.sortOrder
		 , atr.cntMatches
		 , sum(case when r.type = 'V' then case when o.sortOrder = 1 then atr.integerValue1
						                        when o.sortOrder = 2 then atr.integerValue2
												when o.sortOrder = 3 then atr.integerValue3
												when o.sortOrder = 4 then atr.integerValue4
												when o.sortOrder = 5 then atr.integerValue5
												when o.sortOrder = 6 then atr.integerValue6
												when o.sortOrder = 7 then atr.integerValue7
												when o.sortOrder = 8 then atr.integerValue8
												when o.sortOrder = 9 then atr.integerValue9
												when o.sortOrder = 10 then atr.integerValue10
												when o.sortOrder = 11 then atr.integerValue11
						                        when o.sortOrder = 12 then atr.integerValue12
												when o.sortOrder = 13 then atr.integerValue13
												when o.sortOrder = 14 then atr.integerValue14
												when o.sortOrder = 15 then atr.integerValue15
 						                        else null end
				    when r.type = 'S' then case when o.sortOrder = 1 then atr.scoreValue1
					                            when o.sortOrder = 2 then atr.scoreValue2
					                            when o.sortOrder = 3 then atr.scoreValue3
					                            when o.sortOrder = 4 then atr.scoreValue4
					                            when o.sortOrder = 5 then atr.scoreValue5
					                            when o.sortOrder = 6 then atr.scoreValue6
					                            when o.sortOrder = 7 then atr.scoreValue7
					                            when o.sortOrder = 8 then atr.scoreValue8
					                            when o.sortOrder = 9 then atr.scoreValue9
					                            when o.sortOrder = 10 then atr.scoreValue10
												when o.sortOrder = 11 then atr.scoreValue11
					                            when o.sortOrder = 12 then atr.scoreValue12
					                            when o.sortOrder = 13 then atr.scoreValue13
					                            when o.sortOrder = 14 then atr.scoreValue14
					                            when o.sortOrder = 15 then atr.scoreValue15
 						                        else null end
					else null end) value
		 , tge.rank
		 , tge.rankingPointAverage
	  from rank r
		   inner join RankObjective ro
		   on ro.rankId = r.id
		   inner join Objective o
		   on o.id = ro.objectiveId
		   inner join GameEvent ge
		   on ge.gameId = o.gameId
		   inner join TeamGameEvent tge
		   on ge.id = tge.gameEventId
		   inner join v_AvgTeamRecord atr
		   on atr.teamId = tge.teamId
	 where ge.isActive = 'Y'
	group by atr.teamId
		   , r.gameId
		   , r.name
		   , r.sortOrder
		   , atr.cntMatches
		   , tge.rank
		   , tge.rankingPointAverage;
	-- Add teams that do not have a scout record yet
	INSERT INTO #AvgTeamRecord
	select tge.teamId
		 , r.gameId
		 , r.name rankName
		 , r.sortOrder
		 , 0 cntMatches
		 , 0 value
		 , tge.rank
		 , tge.rankingPointAverage
      from rank r
		   inner join GameEvent ge
		   on ge.gameId = r.gameId
		   inner join TeamGameEvent tge
		   on tge.gameEventId = ge.id
	 where ge.isActive = 'Y'
	   and not exists
	       (select 1
		      from #AvgTeamRecord atr
			 where atr.TeamId = tge.teamId);

    -- Use temporary table to return rankings and average values
	select subquery.teamId
	     , t.TeamNumber
		 , t.TeamName
		 , subquery.cntMatches
		 , avg(subquery.rank) avgRank
		 , sum(case when subquery.sortOrder = 1 then subquery.rank else null end) rankValue1
		 , sum(case when subquery.sortOrder = 2 then subquery.rank else null end) rankValue2
		 , sum(case when subquery.sortOrder = 3 then subquery.rank else null end) rankValue3
		 , sum(case when subquery.sortOrder = 4 then subquery.rank else null end) rankValue4
		 , sum(case when subquery.sortOrder = 5 then subquery.rank else null end) rankValue5
		 , sum(case when subquery.sortOrder = 6 then subquery.rank else null end) rankValue6
		 , sum(case when subquery.sortOrder = 7 then subquery.rank else null end) rankValue7
		 , sum(case when subquery.sortOrder = 8 then subquery.rank else null end) rankValue8
		 , sum(case when subquery.sortOrder = 9 then subquery.rank else null end) rankValue9
		 , sum(case when subquery.sortOrder = 10 then subquery.rank else null end) rankValue10
		 , sum(case when subquery.sortOrder = 1 then subquery.value else null end) value1
		 , sum(case when subquery.sortOrder = 2 then subquery.value else null end) value2
		 , sum(case when subquery.sortOrder = 3 then subquery.value else null end) value3
		 , sum(case when subquery.sortOrder = 4 then subquery.value else null end) value4
		 , sum(case when subquery.sortOrder = 5 then subquery.value else null end) value5
		 , sum(case when subquery.sortOrder = 6 then subquery.value else null end) value6
		 , sum(case when subquery.sortOrder = 7 then subquery.value else null end) value7
		 , sum(case when subquery.sortOrder = 8 then subquery.value else null end) value8
		 , sum(case when subquery.sortOrder = 9 then subquery.value else null end) value9
		 , sum(case when subquery.sortOrder = 10 then subquery.value else null end) value10
		 , subquery.eventRank
		 , subquery.rankingPointAverage
	  from (
	select atr.teamId
		 , atr.gameId
		 , atr.rankName
		 , atr.sortOrder
		 , atr.cntMatches
		 , atr.value
		 , (select count(*)
		      from #AvgTeamRecord atr2
			 where atr2.gameId = atr.gameId
			   and atr2.rankName = atr.rankName
			   and atr2.sortOrder = atr.sortOrder
			   and atr2.value > atr.value) + 1 rank
		 , atr.rank eventRank
		 , atr.rankingPointAverage
      from #AvgTeamRecord atr) subquery
	       inner join Team t
		   on t.id = subquery.teamId
	 where t.isActive = 'Y'
	group by subquery.teamId
	       , t.TeamNumber
		   , t.TeamName
		   , subquery.TeamId
		   , subquery.cntMatches
 		   , subquery.eventRank
		   , subquery.rankingPointAverage
	order by sum(case when subquery.sortOrder = @lv_SortOrder then subquery.rank else null end)
	       , t.teamNumber;

END
go

CREATE PROCEDURE sp_ins_scoutRecord (@pv_ScoutId integer
                                   , @pv_MatchId integer
                                   , @pv_TeamId integer
								   , @pv_AlliancePosition varchar(64)
                                   , @pv_IntegerValue01 integer
                                   , @pv_IntegerValue02 integer = null
                                   , @pv_IntegerValue03 integer = null
                                   , @pv_IntegerValue04 integer = null
                                   , @pv_IntegerValue05 integer = null
                                   , @pv_IntegerValue06 integer = null
                                   , @pv_IntegerValue07 integer = null
                                   , @pv_IntegerValue08 integer = null
                                   , @pv_IntegerValue09 integer = null
                                   , @pv_IntegerValue10 integer = null
                                   , @pv_IntegerValue11 integer = null
                                   , @pv_IntegerValue12 integer = null
                                   , @pv_IntegerValue13 integer = null
                                   , @pv_IntegerValue14 integer = null
                                   , @pv_IntegerValue15 integer = null)
AS
declare @lv_Id integer;

BEGIN
	SET NOCOUNT ON
	-- Lookup Scout Header Record
	SELECT @lv_id = max(id)
	  FROM ScoutRecord
	 WHERE scoutId = @pv_ScoutId
	   AND matchId = @pv_MatchId
	   AND teamId = @pv_TeamId;
	   
	-- Add Scout Header Record
	IF @lv_Id is null
	BEGIN
		INSERT INTO ScoutRecord (scoutId, matchId, teamId)
		SELECT @pv_ScoutId, @pv_MatchId, @pv_TeamId;
		SET @lv_Id = @@IDENTITY;

		-- Add Objective Values
		if @pv_IntegerValue01 is not null
			INSERT INTO ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue)
			SELECT @lv_Id
				 , o.id
				 , @pv_IntegerValue01
			  FROM Match m
				   INNER JOIN GameEvent ge
				   ON ge.id = m.gameEventId
				   INNER JOIN Objective o
				   ON o.gameId = ge.gameId
			 WHERE m.id = @pv_MatchId
			   AND o.sortOrder = 1;

		-- Add Objective Values
		if @pv_IntegerValue02 is not null
			INSERT INTO ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue)
			SELECT @lv_Id
				 , o.id
				 , @pv_IntegerValue02
			  FROM Match m
				   INNER JOIN GameEvent ge
				   ON ge.id = m.gameEventId
				   INNER JOIN Objective o
				   ON o.gameId = ge.gameId
			 WHERE m.id = @pv_MatchId
			   AND o.sortOrder = 2;

		-- Add Objective Values
		if @pv_IntegerValue03 is not null
			INSERT INTO ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue)
			SELECT @lv_Id
				 , o.id
				 , @pv_IntegerValue03
			  FROM Match m
				   INNER JOIN GameEvent ge
				   ON ge.id = m.gameEventId
				   INNER JOIN Objective o
				   ON o.gameId = ge.gameId
			 WHERE m.id = @pv_MatchId
			   AND o.sortOrder = 3;

		-- Add Objective Values
		if @pv_IntegerValue04 is not null
			INSERT INTO ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue)
			SELECT @lv_Id
				 , o.id
				 , @pv_IntegerValue04
			  FROM Match m
				   INNER JOIN GameEvent ge
				   ON ge.id = m.gameEventId
				   INNER JOIN Objective o
				   ON o.gameId = ge.gameId
			 WHERE m.id = @pv_MatchId
			   AND o.sortOrder = 4;

		-- Add Objective Values
		if @pv_IntegerValue05 is not null
			INSERT INTO ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue)
			SELECT @lv_Id
				 , o.id
				 , @pv_IntegerValue05
			  FROM Match m
				   INNER JOIN GameEvent ge
				   ON ge.id = m.gameEventId
				   INNER JOIN Objective o
				   ON o.gameId = ge.gameId
			 WHERE m.id = @pv_MatchId
			   AND o.sortOrder = 5;

		-- Add Objective Values
		if @pv_IntegerValue06 is not null
			INSERT INTO ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue)
			SELECT @lv_Id
				 , o.id
				 , @pv_IntegerValue06
			  FROM Match m
				   INNER JOIN GameEvent ge
				   ON ge.id = m.gameEventId
				   INNER JOIN Objective o
				   ON o.gameId = ge.gameId
			 WHERE m.id = @pv_MatchId
			   AND o.sortOrder = 6;

		-- Add Objective Values
		if @pv_IntegerValue07 is not null
			INSERT INTO ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue)
			SELECT @lv_Id
				 , o.id
				 , @pv_IntegerValue07
			  FROM Match m
				   INNER JOIN GameEvent ge
				   ON ge.id = m.gameEventId
				   INNER JOIN Objective o
				   ON o.gameId = ge.gameId
			 WHERE m.id = @pv_MatchId
			   AND o.sortOrder = 7;

		-- Add Objective Values
		if @pv_IntegerValue08 is not null
			INSERT INTO ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue)
			SELECT @lv_Id
				 , o.id
				 , @pv_IntegerValue08
			  FROM Match m
				   INNER JOIN GameEvent ge
				   ON ge.id = m.gameEventId
				   INNER JOIN Objective o
				   ON o.gameId = ge.gameId
			 WHERE m.id = @pv_MatchId
			   AND o.sortOrder = 8;

		-- Add Objective Values
		if @pv_IntegerValue09 is not null
			INSERT INTO ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue)
			SELECT @lv_Id
				 , o.id
				 , @pv_IntegerValue09
			  FROM Match m
				   INNER JOIN GameEvent ge
				   ON ge.id = m.gameEventId
				   INNER JOIN Objective o
				   ON o.gameId = ge.gameId
			 WHERE m.id = @pv_MatchId
			   AND o.sortOrder = 9;

		-- Add Objective Values
		if @pv_IntegerValue10 is not null
			INSERT INTO ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue)
			SELECT @lv_Id
				 , o.id
				 , @pv_IntegerValue10
			  FROM Match m
				   INNER JOIN GameEvent ge
				   ON ge.id = m.gameEventId
				   INNER JOIN Objective o
				   ON o.gameId = ge.gameId
			 WHERE m.id = @pv_MatchId
			   AND o.sortOrder = 10;

		-- Add Objective Values
		if @pv_IntegerValue11 is not null
			INSERT INTO ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue)
			SELECT @lv_Id
				 , o.id
				 , @pv_IntegerValue11
			  FROM Match m
				   INNER JOIN GameEvent ge
				   ON ge.id = m.gameEventId
				   INNER JOIN Objective o
				   ON o.gameId = ge.gameId
			 WHERE m.id = @pv_MatchId
			   AND o.sortOrder = 11;

		-- Add Objective Values
		if @pv_IntegerValue12 is not null
			INSERT INTO ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue)
			SELECT @lv_Id
				 , o.id
				 , @pv_IntegerValue12
			  FROM Match m
				   INNER JOIN GameEvent ge
				   ON ge.id = m.gameEventId
				   INNER JOIN Objective o
				   ON o.gameId = ge.gameId
			 WHERE m.id = @pv_MatchId
			   AND o.sortOrder = 12;

		-- Add Objective Values
		if @pv_IntegerValue13 is not null
			INSERT INTO ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue)
			SELECT @lv_Id
				 , o.id
				 , @pv_IntegerValue13
			  FROM Match m
				   INNER JOIN GameEvent ge
				   ON ge.id = m.gameEventId
				   INNER JOIN Objective o
				   ON o.gameId = ge.gameId
			 WHERE m.id = @pv_MatchId
			   AND o.sortOrder = 13;

		-- Add Objective Values
		if @pv_IntegerValue14 is not null
			INSERT INTO ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue)
			SELECT @lv_Id
				 , o.id
				 , @pv_IntegerValue14
			  FROM Match m
				   INNER JOIN GameEvent ge
				   ON ge.id = m.gameEventId
				   INNER JOIN Objective o
				   ON o.gameId = ge.gameId
			 WHERE m.id = @pv_MatchId
			   AND o.sortOrder = 14;

		-- Add Objective Values
		if @pv_IntegerValue15 is not null
			INSERT INTO ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue)
			SELECT @lv_Id
				 , o.id
				 , @pv_IntegerValue15
			  FROM Match m
				   INNER JOIN GameEvent ge
				   ON ge.id = m.gameEventId
				   INNER JOIN Objective o
				   ON o.gameId = ge.gameId
			 WHERE m.id = @pv_MatchId
			   AND o.sortOrder = 15;
	END
	ELSE
	BEGIN
		-- Update Objective Values
		if @pv_IntegerValue01 is not null
			UPDATE ScoutObjectiveRecord
               SET integerValue = @pv_IntegerValue01
             WHERE scoutRecordId = @lv_Id
               AND objectiveId = (SELECT o.id
                                    FROM Match m
  				                         INNER JOIN GameEvent ge
				                         ON ge.id = m.gameEventId
				                         INNER JOIN Objective o
				                         ON o.gameId = ge.gameId
			                       WHERE m.id = @pv_MatchId
			                         AND o.sortOrder = 1);

		-- Update Objective Values
		if @pv_IntegerValue02 is not null
			UPDATE ScoutObjectiveRecord
               SET integerValue = @pv_IntegerValue02
             WHERE scoutRecordId = @lv_Id
               AND objectiveId = (SELECT o.id
                                    FROM Match m
  				                         INNER JOIN GameEvent ge
				                         ON ge.id = m.gameEventId
				                         INNER JOIN Objective o
				                         ON o.gameId = ge.gameId
			                       WHERE m.id = @pv_MatchId
			                         AND o.sortOrder = 2);

		-- Update Objective Values
		if @pv_IntegerValue03 is not null
			UPDATE ScoutObjectiveRecord
               SET integerValue = @pv_IntegerValue03
             WHERE scoutRecordId = @lv_Id
               AND objectiveId = (SELECT o.id
                                    FROM Match m
  				                         INNER JOIN GameEvent ge
				                         ON ge.id = m.gameEventId
				                         INNER JOIN Objective o
				                         ON o.gameId = ge.gameId
			                       WHERE m.id = @pv_MatchId
			                         AND o.sortOrder = 3);

		-- Update Objective Values
		if @pv_IntegerValue04 is not null
			UPDATE ScoutObjectiveRecord
               SET integerValue = @pv_IntegerValue04
             WHERE scoutRecordId = @lv_Id
               AND objectiveId = (SELECT o.id
                                    FROM Match m
  				                         INNER JOIN GameEvent ge
				                         ON ge.id = m.gameEventId
				                         INNER JOIN Objective o
				                         ON o.gameId = ge.gameId
			                       WHERE m.id = @pv_MatchId
			                         AND o.sortOrder = 4);

		-- Update Objective Values
		if @pv_IntegerValue05 is not null
			UPDATE ScoutObjectiveRecord
               SET integerValue = @pv_IntegerValue05
             WHERE scoutRecordId = @lv_Id
               AND objectiveId = (SELECT o.id
                                    FROM Match m
  				                         INNER JOIN GameEvent ge
				                         ON ge.id = m.gameEventId
				                         INNER JOIN Objective o
				                         ON o.gameId = ge.gameId
			                       WHERE m.id = @pv_MatchId
			                         AND o.sortOrder = 5);

		-- Update Objective Values
		if @pv_IntegerValue06 is not null
			UPDATE ScoutObjectiveRecord
               SET integerValue = @pv_IntegerValue06
             WHERE scoutRecordId = @lv_Id
               AND objectiveId = (SELECT o.id
                                    FROM Match m
  				                         INNER JOIN GameEvent ge
				                         ON ge.id = m.gameEventId
				                         INNER JOIN Objective o
				                         ON o.gameId = ge.gameId
			                       WHERE m.id = @pv_MatchId
			                         AND o.sortOrder = 6);

		-- Update Objective Values
		if @pv_IntegerValue07 is not null
			UPDATE ScoutObjectiveRecord
               SET integerValue = @pv_IntegerValue07
             WHERE scoutRecordId = @lv_Id
               AND objectiveId = (SELECT o.id
                                    FROM Match m
  				                         INNER JOIN GameEvent ge
				                         ON ge.id = m.gameEventId
				                         INNER JOIN Objective o
				                         ON o.gameId = ge.gameId
			                       WHERE m.id = @pv_MatchId
			                         AND o.sortOrder = 7);

		-- Update Objective Values
		if @pv_IntegerValue08 is not null
			UPDATE ScoutObjectiveRecord
               SET integerValue = @pv_IntegerValue08
             WHERE scoutRecordId = @lv_Id
               AND objectiveId = (SELECT o.id
                                    FROM Match m
  				                         INNER JOIN GameEvent ge
				                         ON ge.id = m.gameEventId
				                         INNER JOIN Objective o
				                         ON o.gameId = ge.gameId
			                       WHERE m.id = @pv_MatchId
			                         AND o.sortOrder = 8);

		-- Update Objective Values
		if @pv_IntegerValue09 is not null
			UPDATE ScoutObjectiveRecord
               SET integerValue = @pv_IntegerValue09
             WHERE scoutRecordId = @lv_Id
               AND objectiveId = (SELECT o.id
                                    FROM Match m
  				                         INNER JOIN GameEvent ge
				                         ON ge.id = m.gameEventId
				                         INNER JOIN Objective o
				                         ON o.gameId = ge.gameId
			                       WHERE m.id = @pv_MatchId
			                         AND o.sortOrder = 9);

		-- Update Objective Values
		if @pv_IntegerValue10 is not null
			UPDATE ScoutObjectiveRecord
               SET integerValue = @pv_IntegerValue10
             WHERE scoutRecordId = @lv_Id
               AND objectiveId = (SELECT o.id
                                    FROM Match m
  				                         INNER JOIN GameEvent ge
				                         ON ge.id = m.gameEventId
				                         INNER JOIN Objective o
				                         ON o.gameId = ge.gameId
			                       WHERE m.id = @pv_MatchId
			                         AND o.sortOrder = 10);

		-- Update Objective Values
		if @pv_IntegerValue11 is not null
			UPDATE ScoutObjectiveRecord
               SET integerValue = @pv_IntegerValue11
             WHERE scoutRecordId = @lv_Id
               AND objectiveId = (SELECT o.id
                                    FROM Match m
  				                         INNER JOIN GameEvent ge
				                         ON ge.id = m.gameEventId
				                         INNER JOIN Objective o
				                         ON o.gameId = ge.gameId
			                       WHERE m.id = @pv_MatchId
			                         AND o.sortOrder = 11);

		-- Update Objective Values
		if @pv_IntegerValue12 is not null
			UPDATE ScoutObjectiveRecord
               SET integerValue = @pv_IntegerValue12
             WHERE scoutRecordId = @lv_Id
               AND objectiveId = (SELECT o.id
                                    FROM Match m
  				                         INNER JOIN GameEvent ge
				                         ON ge.id = m.gameEventId
				                         INNER JOIN Objective o
				                         ON o.gameId = ge.gameId
			                       WHERE m.id = @pv_MatchId
			                         AND o.sortOrder = 12);

		-- Update Objective Values
		if @pv_IntegerValue13 is not null
			UPDATE ScoutObjectiveRecord
               SET integerValue = @pv_IntegerValue13
             WHERE scoutRecordId = @lv_Id
               AND objectiveId = (SELECT o.id
                                    FROM Match m
  				                         INNER JOIN GameEvent ge
				                         ON ge.id = m.gameEventId
				                         INNER JOIN Objective o
				                         ON o.gameId = ge.gameId
			                       WHERE m.id = @pv_MatchId
			                         AND o.sortOrder = 13);

		-- Update Objective Values
		if @pv_IntegerValue14 is not null
			UPDATE ScoutObjectiveRecord
               SET integerValue = @pv_IntegerValue14
             WHERE scoutRecordId = @lv_Id
               AND objectiveId = (SELECT o.id
                                    FROM Match m
  				                         INNER JOIN GameEvent ge
				                         ON ge.id = m.gameEventId
				                         INNER JOIN Objective o
				                         ON o.gameId = ge.gameId
			                       WHERE m.id = @pv_MatchId
			                         AND o.sortOrder = 14);

		-- Update Objective Values
		if @pv_IntegerValue15 is not null
			UPDATE ScoutObjectiveRecord
               SET integerValue = @pv_IntegerValue15
             WHERE scoutRecordId = @lv_Id
               AND objectiveId = (SELECT o.id
                                    FROM Match m
  				                         INNER JOIN GameEvent ge
				                         ON ge.id = m.gameEventId
				                         INNER JOIN Objective o
				                         ON o.gameId = ge.gameId
			                       WHERE m.id = @pv_MatchId
			                         AND o.sortOrder = 15);
	END

	-- Lookup Team Match Record by Alliance/Position
	SELECT @lv_id = max(id)
	  FROM TeamMatch
	 WHERE matchId = @pv_MatchId
	   AND alliance = substring(@pv_AlliancePosition, 1, 1)
	   AND alliancePosition = convert(int, substring(@pv_AlliancePosition, 2, 1));

	-- Lookup Team Match Record by Team Id
	IF @lv_Id is null
	BEGIN
		SELECT @lv_id = max(id)
		  FROM TeamMatch
		 WHERE matchId = @pv_MatchId
		   AND teamId = @pv_TeamId;

		-- Add Team Match Record
		IF @lv_Id is null
			insert into TeamMatch (matchId, teamId, alliance, alliancePosition)
			values (@pv_MatchId, @pv_TeamId, substring(@pv_AlliancePosition, 1, 1), convert(int, substring(@pv_AlliancePosition, 2, 1)));
		ELSE
			-- Update Team Match Record
			update TeamMatch
			   set alliance = substring(@pv_AlliancePosition, 1, 1)
			     , alliancePosition = convert(int, substring(@pv_AlliancePosition, 2, 1))
			 where matchId = @pv_MatchId
			   and teamId = @pv_TeamId;
	END
	ELSE
		-- Update Team Match Record
		update TeamMatch
		   set teamId = @pv_TeamId
		 where matchId = @pv_MatchId
		   and alliance = substring(@pv_AlliancePosition, 1, 1)
		   and alliancePosition = convert(int, substring(@pv_AlliancePosition, 2, 1));
END
GO

CREATE PROCEDURE sp_ins_scoutRobot  (@pv_TeamId integer
								   , @pv_IntegerValue01 integer = null
                                   , @pv_TextValue01 varchar(4000) = null
                                   , @pv_IntegerValue02 integer = null
                                   , @pv_TextValue02 varchar(4000) = null
                                   , @pv_IntegerValue03 integer = null
                                   , @pv_TextValue03 varchar(4000) = null
                                   , @pv_IntegerValue04 integer = null
                                   , @pv_TextValue04 varchar(4000) = null
                                   , @pv_IntegerValue05 integer = null
                                   , @pv_TextValue05 varchar(4000) = null
                                   , @pv_IntegerValue06 integer = null
                                   , @pv_TextValue06 varchar(4000) = null
                                   , @pv_IntegerValue07 integer = null
                                   , @pv_TextValue07 varchar(4000) = null
                                   , @pv_IntegerValue08 integer = null
                                   , @pv_TextValue08 varchar(4000) = null
                                   , @pv_IntegerValue09 integer = null
                                   , @pv_TextValue09 varchar(4000) = null
                                   , @pv_IntegerValue10 integer = null
                                   , @pv_TextValue10 varchar(4000) = null)
AS
declare @lv_AtributeId integer;
declare @lv_TeamAtributeId integer;

BEGIN
	SET NOCOUNT ON
	-- Lookup Team Attribute Record
	if @pv_IntegerValue01 is not null or
	   @pv_TextValue01 is not null
		BEGIN
		SELECT @lv_AtributeId = max(a.id)
		     , @lv_TeamAtributeId = max(ta.id)
		  FROM Attribute a
			   INNER JOIN GameEvent ge
			   ON ge.gameId = a.gameId
			   LEFT OUTER JOIN TeamAttribute ta
			   ON ta.attributeId = a.id
			   AND ta.teamId = @pv_TeamId
		 WHERE a.sortOrder = 1
		   AND ge.isActive = 'Y';
		-- Add Team Attribute Record
		IF @lv_TeamAtributeId is null
			BEGIN
			INSERT INTO TeamAttribute (teamId, attributeId, integerValue, textValue)
			SELECT @pv_TeamId, @lv_AtributeId, @pv_IntegerValue01, @pv_TextValue01;
			END
		ELSE
			BEGIN
			UPDATE TeamAttribute
               SET integerValue = @pv_IntegerValue01
    			 , textValue = case when @pv_TextValue01 is null or @pv_TextValue01 = '' then textValue else @pv_TextValue01 end
             WHERE teamId = @pv_TeamId
			   AND attributeId = @lv_AtributeId;
			END
		END

	-- Lookup Team Attribute Record
	if @pv_IntegerValue02 is not null or
	   @pv_TextValue02 is not null
		BEGIN
		SELECT @lv_AtributeId = max(a.id)
		     , @lv_TeamAtributeId = max(ta.id)
		  FROM Attribute a
			   INNER JOIN GameEvent ge
			   ON ge.gameId = a.gameId
			   LEFT OUTER JOIN TeamAttribute ta
			   ON ta.attributeId = a.id
			   AND ta.teamId = @pv_TeamId
		 WHERE a.sortOrder = 2
		   AND ge.isActive = 'Y';
		-- Add Team Attribute Record
		IF @lv_TeamAtributeId is null
			BEGIN
			INSERT INTO TeamAttribute (teamId, attributeId, integerValue, textValue)
			SELECT @pv_TeamId, @lv_AtributeId, @pv_IntegerValue02, @pv_TextValue02;
			END
		ELSE
			BEGIN
			UPDATE TeamAttribute
               SET integerValue = @pv_IntegerValue02
    			 , textValue = @pv_TextValue02
         WHERE teamId = @pv_TeamId
			   AND attributeId = @lv_AtributeId;
			END
		END

	-- Lookup Team Attribute Record
	if @pv_IntegerValue03 is not null or
	   @pv_TextValue03 is not null
		BEGIN
		SELECT @lv_AtributeId = max(a.id)
		     , @lv_TeamAtributeId = max(ta.id)
		  FROM Attribute a
			   INNER JOIN GameEvent ge
			   ON ge.gameId = a.gameId
			   LEFT OUTER JOIN TeamAttribute ta
			   ON ta.attributeId = a.id
			   AND ta.teamId = @pv_TeamId
		 WHERE a.sortOrder = 3
		   AND ge.isActive = 'Y';
		-- Add Team Attribute Record
		IF @lv_TeamAtributeId is null
			BEGIN
			INSERT INTO TeamAttribute (teamId, attributeId, integerValue, textValue)
			SELECT @pv_TeamId, @lv_AtributeId, @pv_IntegerValue03, @pv_TextValue03;
			END
		ELSE
			BEGIN
			UPDATE TeamAttribute
               SET integerValue = @pv_IntegerValue03
    			 , textValue = @pv_TextValue03
             WHERE teamId = @pv_TeamId
			   AND attributeId = @lv_AtributeId;
			END
		END

	-- Lookup Team Attribute Record
	if @pv_IntegerValue04 is not null or
	   @pv_TextValue04 is not null
		BEGIN
		SELECT @lv_AtributeId = max(a.id)
		     , @lv_TeamAtributeId = max(ta.id)
		  FROM Attribute a
			   INNER JOIN GameEvent ge
			   ON ge.gameId = a.gameId
			   LEFT OUTER JOIN TeamAttribute ta
			   ON ta.attributeId = a.id
			   AND ta.teamId = @pv_TeamId
		 WHERE a.sortOrder = 4
		   AND ge.isActive = 'Y';
		-- Add Team Attribute Record
		IF @lv_TeamAtributeId is null
			BEGIN
			INSERT INTO TeamAttribute (teamId, attributeId, integerValue, textValue)
			SELECT @pv_TeamId, @lv_AtributeId, @pv_IntegerValue04, @pv_TextValue04;
			END
		ELSE
			BEGIN
			UPDATE TeamAttribute
               SET integerValue = @pv_IntegerValue04
    			 , textValue = @pv_TextValue04
             WHERE teamId = @pv_TeamId
			   AND attributeId = @lv_AtributeId;
			END
		END

	-- Lookup Team Attribute Record
	if @pv_IntegerValue05 is not null or
	   @pv_TextValue05 is not null
		BEGIN
		SELECT @lv_AtributeId = max(a.id)
		     , @lv_TeamAtributeId = max(ta.id)
		  FROM Attribute a
			   INNER JOIN GameEvent ge
			   ON ge.gameId = a.gameId
			   LEFT OUTER JOIN TeamAttribute ta
			   ON ta.attributeId = a.id
			   AND ta.teamId = @pv_TeamId
		 WHERE a.sortOrder = 5
		   AND ge.isActive = 'Y';
		-- Add Team Attribute Record
		IF @lv_TeamAtributeId is null
			BEGIN
			INSERT INTO TeamAttribute (teamId, attributeId, integerValue, textValue)
			SELECT @pv_TeamId, @lv_AtributeId, @pv_IntegerValue05, @pv_TextValue05;
			END
		ELSE
			BEGIN
			UPDATE TeamAttribute
               SET integerValue = @pv_IntegerValue05
    			 , textValue = case when @pv_TextValue05 is null or @pv_TextValue05 = '' then textValue else @pv_TextValue05 end
             WHERE teamId = @pv_TeamId
			   AND attributeId = @lv_AtributeId;
			END
		END

	-- Lookup Team Attribute Record
	if @pv_IntegerValue06 is not null or
	   @pv_TextValue06 is not null
		BEGIN
		SELECT @lv_AtributeId = max(a.id)
		     , @lv_TeamAtributeId = max(ta.id)
		  FROM Attribute a
			   INNER JOIN GameEvent ge
			   ON ge.gameId = a.gameId
			   LEFT OUTER JOIN TeamAttribute ta
			   ON ta.attributeId = a.id
			   AND ta.teamId = @pv_TeamId
		 WHERE a.sortOrder = 6
		   AND ge.isActive = 'Y';
		-- Add Team Attribute Record
		IF @lv_TeamAtributeId is null
			BEGIN
			INSERT INTO TeamAttribute (teamId, attributeId, integerValue, textValue)
			SELECT @pv_TeamId, @lv_AtributeId, @pv_IntegerValue06, @pv_TextValue06;
			END
		ELSE
			BEGIN
			UPDATE TeamAttribute
               SET integerValue = @pv_IntegerValue06
    			 , textValue = @pv_TextValue06
             WHERE teamId = @pv_TeamId
			   AND attributeId = @lv_AtributeId;
			END
		END

	-- Lookup Team Attribute Record
	if @pv_IntegerValue07 is not null or
	   @pv_TextValue07 is not null
		BEGIN
		SELECT @lv_AtributeId = max(a.id)
		     , @lv_TeamAtributeId = max(ta.id)
		  FROM Attribute a
			   INNER JOIN GameEvent ge
			   ON ge.gameId = a.gameId
			   LEFT OUTER JOIN TeamAttribute ta
			   ON ta.attributeId = a.id
			   AND ta.teamId = @pv_TeamId
		 WHERE a.sortOrder = 7
		   AND ge.isActive = 'Y';
		-- Add Team Attribute Record
		IF @lv_TeamAtributeId is null
			BEGIN
			INSERT INTO TeamAttribute (teamId, attributeId, integerValue, textValue)
			SELECT @pv_TeamId, @lv_AtributeId, @pv_IntegerValue07, @pv_TextValue07;
			END
		ELSE
			BEGIN
			UPDATE TeamAttribute
               SET integerValue = @pv_IntegerValue07
    			 , textValue = @pv_TextValue07
             WHERE teamId = @pv_TeamId
			   AND attributeId = @lv_AtributeId;
			END
		END

	-- Lookup Team Attribute Record
	if @pv_IntegerValue08 is not null or
	   @pv_TextValue08 is not null
		BEGIN
		SELECT @lv_AtributeId = max(a.id)
		     , @lv_TeamAtributeId = max(ta.id)
		  FROM Attribute a
			   INNER JOIN GameEvent ge
			   ON ge.gameId = a.gameId
			   LEFT OUTER JOIN TeamAttribute ta
			   ON ta.attributeId = a.id
			   AND ta.teamId = @pv_TeamId
		 WHERE a.sortOrder = 8
		   AND ge.isActive = 'Y';
		-- Add Team Attribute Record
		IF @lv_TeamAtributeId is null
			BEGIN
			INSERT INTO TeamAttribute (teamId, attributeId, integerValue, textValue)
			SELECT @pv_TeamId, @lv_AtributeId, @pv_IntegerValue08, @pv_TextValue08;
			END
		ELSE
			BEGIN
			UPDATE TeamAttribute
               SET integerValue = @pv_IntegerValue08
    			 , textValue = @pv_TextValue08
             WHERE teamId = @pv_TeamId
			   AND attributeId = @lv_AtributeId;
			END
		END

	-- Lookup Team Attribute Record
	if @pv_IntegerValue09 is not null or
	   @pv_TextValue09 is not null
		BEGIN
		SELECT @lv_AtributeId = max(a.id)
		     , @lv_TeamAtributeId = max(ta.id)
		  FROM Attribute a
			   INNER JOIN GameEvent ge
			   ON ge.gameId = a.gameId
			   LEFT OUTER JOIN TeamAttribute ta
			   ON ta.attributeId = a.id
			   AND ta.teamId = @pv_TeamId
		 WHERE a.sortOrder = 9
		   AND ge.isActive = 'Y';
		-- Add Team Attribute Record
		IF @lv_TeamAtributeId is null
			BEGIN
			INSERT INTO TeamAttribute (teamId, attributeId, integerValue, textValue)
			SELECT @pv_TeamId, @lv_AtributeId, @pv_IntegerValue09, @pv_TextValue09;
			END
		ELSE
			BEGIN
			UPDATE TeamAttribute
               SET integerValue = @pv_IntegerValue09
    			 , textValue = @pv_TextValue09
             WHERE teamId = @pv_TeamId
			   AND attributeId = @lv_AtributeId;
			END
		END

	-- Lookup Team Attribute Record
	if @pv_IntegerValue10 is not null or
	   @pv_TextValue10 is not null
		BEGIN
		SELECT @lv_AtributeId = max(a.id)
		     , @lv_TeamAtributeId = max(ta.id)
		  FROM Attribute a
			   INNER JOIN GameEvent ge
			   ON ge.gameId = a.gameId
			   LEFT OUTER JOIN TeamAttribute ta
			   ON ta.attributeId = a.id
			   AND ta.teamId = @pv_TeamId
		 WHERE a.sortOrder = 10
		   AND ge.isActive = 'Y';
		-- Add Team Attribute Record
		IF @lv_TeamAtributeId is null
			BEGIN
			INSERT INTO TeamAttribute (teamId, attributeId, integerValue, textValue)
			SELECT @pv_TeamId, @lv_AtributeId, @pv_IntegerValue10, @pv_TextValue10;
			END
		ELSE
			BEGIN
			UPDATE TeamAttribute
               SET integerValue = @pv_IntegerValue10
    			 , textValue = @pv_TextValue10
             WHERE teamId = @pv_TeamId
			   AND attributeId = @lv_AtributeId;
			END
		END
END
GO
*/
