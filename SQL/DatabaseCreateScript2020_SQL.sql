/*
drop trigger tr_SOR_CalcScoreValue;
drop function calcScoreValue;
drop view v_TeamAvgRank;
drop view v_AvgTeamRecord;
drop view v_AvgScoutRecord;
drop view v_MatchReport;
drop view v_TeamReport;
drop view v_ScoutRecord;
drop view v_MatchHyperlinks;
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
*/

create table Event(
	id int primary key IDENTITY(1, 1) NOT NULL,
	name varchar(128) not null,
	location varchar(128) not null,
	isActive char(1) not null);
create unique index idx_Event on Event(name);
insert into Event (name, location, isActive) values ('Lake Superior Regional', 'Duluth, MN', 'N');
insert into Event (name, location, isActive) values ('Iowa Regional', 'Cedar Falls, IA', 'N');
insert into Event (name, location, isActive) values ('EMCC Off-Season', 'Woodbury, MN', 'Y');
insert into Event (name, location, isActive) values ('Test Data Event', 'Cannon Falls, MN', 'N');

create table Game(
	id int primary key IDENTITY(1, 1) NOT NULL,
	name varchar(128) not null,
	gameYear integer not null,
	isActive char(1) not null);
create unique index idx_Game on Game(name);
insert into Game (name, gameYear, isActive) values ('Deep Space', 2019, 'Y');

create table GameEvent(
	id int primary key IDENTITY(1, 1) NOT NULL,
	eventId integer not null,
	gameId integer not null,
	eventDate date not null,
	isActive char(1) not null);
create unique index idx_GameEvent on GameEvent(eventId, eventDate);
alter table GameEvent add constraint fk_GameEvent_Team foreign key (eventId) references Event (id);
alter table GameEvent add constraint fk_GameEvent_Game foreign key (gameId) references Game (id);
insert into GameEvent (eventId, gameId, eventDate, isActive) select e.Id, g.Id, '03/07/2019', 'N' from event e, game g where e.Name = 'Lake Superior Regional' and g.name = 'Deep Space';
insert into GameEvent (eventId, gameId, eventDate, isActive) select e.Id, g.Id, '03/21/2019', 'N' from event e, game g where e.Name = 'Iowa Regional' and g.name = 'Deep Space';
insert into GameEvent (eventId, gameId, eventDate, isActive) select e.Id, g.Id, '09/21/2019', 'Y' from event e, game g where e.Name = 'EMCC Off-Season' and g.name = 'Deep Space';
insert into GameEvent (eventId, gameId, eventDate, isActive) select e.Id, g.Id, '12/31/2099', 'N' from event e, game g where e.Name = 'Test Data Event' and g.name = 'Deep Space';

create table Team(
	id int primary key IDENTITY(1, 1) NOT NULL,
	teamNumber integer not null,
	teamName varchar(128) not null,
	location varchar(128) null,
	isActive char(1) not null);
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
	gameEventId integer not null);
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
	isActive char(1) not null);
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
	hasValueList char(1) not null);
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
	scoreMultiplier integer null);
create unique index idx_Objective on Objective(gameId, name);
alter table Objective add constraint fk_Objective_Game foreign key (gameId) references Game (id);
alter table Objective add constraint fk_Objective_ScoringType foreign key (scoringTypeId) references ScoringType (id);
insert into Objective (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue, scoreMultiplier) select g.id, 'leaveHAB', 'Leave HAB Level', st.id, null, null, null from game g, scoringType st where g.name = 'Deep Space' and st.name = 'Radio Button';
insert into Objective (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue, scoreMultiplier) select g.id, 'ssHatchCnt', 'Sandstorm Hatches', st.id, 0, 2, 2 from game g, scoringType st where g.name = 'Deep Space' and st.name = 'Integer';
insert into Objective (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue, scoreMultiplier) select g.id, 'ssCargoCnt', 'Sandstorm Cargo', st.id, 0, 2, 3 from game g, scoringType st where g.name = 'Deep Space' and st.name = 'Integer';
insert into Objective (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue, scoreMultiplier) select g.id, 'toHatchCnt', 'TeleOp Hatches', st.id, 0, 10, 2 from game g, scoringType st where g.name = 'Deep Space' and st.name = 'Integer';
insert into Objective (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue, scoreMultiplier) select g.id, 'toCargoCnt', 'TeleOp Cargo', st.id, 0, 10, 3 from game g, scoringType st where g.name = 'Deep Space' and st.name = 'Integer';
insert into Objective (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue, scoreMultiplier) select g.id, 'playedDefense', 'Performed on Defense', st.id, null, null, null from game g, scoringType st where g.name = 'Deep Space' and st.name = 'Radio Button';
insert into Objective (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue, scoreMultiplier) select g.id, 'returnToHAB', 'Return HAB Level', st.id, null, null, null from game g, scoringType st where g.name = 'Deep Space' and st.name = 'Radio Button';

create table ObjectiveValue(
	id int primary key IDENTITY(1, 1) NOT NULL,
	objectiveId integer not null,
	displayValue varchar(64) not null,
	integerValue integer null,
	sortOrder integer null,
	scoreValue integer null);
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

create table Match(
	id int primary key IDENTITY(1, 1) NOT NULL,
	gameEventId integer not null,
	number varchar(8) not null,
	dateTime datetime not null,
	type char(1) not null,
	isActive char(1) not null);
create unique index idx_Match on Match(gameEventId, dateTime);
alter table Match add constraint fk_Match_GameEvent foreign key (gameEventId) references GameEvent (id);
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '01', '09/21/2019 08:45:00', 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '02', '09/21/2019 08:55:00', 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '03', '09/21/2019 09:05:00', 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '04', '09/21/2019 09:15:00', 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '05', '09/21/2019 09:25:00', 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '06', '09/21/2019 09:35:00', 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '07', '09/21/2019 09:45:00', 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '08', '09/21/2019 09:55:00', 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '09', '09/21/2019 10:05:00', 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '10', '09/21/2019 10:15:00', 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '11', '09/21/2019 10:25:00', 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '12', '09/21/2019 10:35:00', 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '13', '09/21/2019 10:45:00', 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '14', '09/21/2019 10:55:00', 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '15', '09/21/2019 11:05:00', 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '16', '09/21/2019 11:15:00', 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '17', '09/21/2019 11:25:00', 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '18', '09/21/2019 11:35:00', 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '19', '09/21/2019 11:45:00', 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '20', '09/21/2019 11:55:00', 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '21', '09/21/2019 13:05:00', 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '22', '09/21/2019 13:15:00', 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '23', '09/21/2019 13:25:00', 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '24', '09/21/2019 13:35:00', 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '25', '09/21/2019 13:45:00', 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '26', '09/21/2019 13:55:00', 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '27', '09/21/2019 14:05:00', 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '28', '09/21/2019 14:15:00', 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '29', '09/21/2019 14:25:00', 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '30', '09/21/2019 14:35:00', 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '31', '09/21/2019 14:45:00', 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '32', '09/21/2019 14:55:00', 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '33', '09/21/2019 15:05:00', 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'Test Data Event';

create table TeamMatch(
	id int primary key IDENTITY(1, 1) NOT NULL,
	matchId integer not null,
	teamId integer not null,
	alliance char(1) not null,
	alliancePosition integer not null);
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
	teamId integer not null);
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
	textValue numeric(10,3) null,
	scoreValue varchar(256) null);
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
    update ScoutObjectiveRecord
	   set scoreValue = (select dbo.calcScoreValue(i.objectiveId, i.integerValue, i.decimalValue)
	                       from inserted i
						  where i.id = ScoutObjectiveRecord.id)
	 where ScoutObjectiveRecord.id in (select i.id from inserted i);
end;
go

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
 
-- View for Match Teams
create view v_MatchHyperlinks as
select '<a href=\"Reports\matchReport.php?matchId=' + convert(varchar, subquery.matchId) + '\"> ' + subquery.matchNumber + '</a>' matchReportUrl
     , subquery.r1TeamNumber
     , '<a href=\"Reports\TeamReport.php?TeamId=' + convert(varchar, subquery.r1TeamId) + '\"> R </a>' r1TeamReportUrl
     , '<a href=\"scoutRecord.php?matchId=' + convert(varchar, subquery.matchId) + ';matchNumber=' + subquery.matchNumber + ';TeamId=' + convert(varchar, subquery.r1TeamId) + '\"> S </a>' r1TeamScoutUrl
     , subquery.r2TeamNumber
     , '<a href=\"Reports\TeamReport.php?TeamId=' + convert(varchar, subquery.r2TeamId) + '\"> R </a>' r2TeamReportUrl
     , '<a href=\"scoutRecord.php?matchId=' + convert(varchar, subquery.matchId) + ';matchNumber=' + subquery.matchNumber + ';TeamId=' + convert(varchar, subquery.r2TeamId) + '\"> S </a>' r2TeamScoutUrl
     , subquery.r3TeamNumber
     , '<a href=\"Reports\TeamReport.php?TeamId=' + convert(varchar, subquery.r3TeamId) + '\"> R </a>' r3TeamReportUrl
     , '<a href=\"scoutRecord.php?matchId=' + convert(varchar, subquery.matchId) + ';matchNumber=' + subquery.matchNumber + ';TeamId=' + convert(varchar, subquery.r3TeamId) + '\"> S </a>' r3TeamScoutUrl
     , subquery.b1TeamNumber
     , '<a href=\"Reports\TeamReport.php?TeamId=' + convert(varchar, subquery.b1TeamId) + '\"> R </a>' b1TeamReportUrl
     , '<a href=\"scoutRecord.php?matchId=' + convert(varchar, subquery.matchId) + ';matchNumber=' + subquery.matchNumber + ';TeamId=' + convert(varchar, subquery.b1TeamId) + '\"> S </a>' b1TeamScoutUrl
     , subquery.b2TeamNumber
     , '<a href=\"Reports\TeamReport.php?TeamId=' + convert(varchar, subquery.b2TeamId) + '\"> R </a>' b2TeamReportUrl
     , '<a href=\"scoutRecord.php?matchId=' + convert(varchar, subquery.matchId) + ';matchNumber=' + subquery.matchNumber + ';TeamId=' + convert(varchar, subquery.b2TeamId) + '\"> S </a>' b2TeamScoutUrl
     , subquery.b3TeamNumber
     , '<a href=\"Reports\TeamReport.php?TeamId=' + convert(varchar, subquery.b3TeamId) + '\"> R </a>' b3TeamReportUrl
     , '<a href=\"scoutRecord.php?matchId=' + convert(varchar, subquery.matchId) + ';matchNumber=' + subquery.matchNumber + ';TeamId=' + convert(varchar, subquery.b3TeamId) + '\"> S </a>' b3TeamScoutUrl
     , subquery.sortOrder
     , subquery.matchNumber
     , subquery.matchId
     , subquery.r1TeamId
     , subquery.r2TeamId
     , subquery.r3TeamId
     , subquery.b1TeamId
     , subquery.b2TeamId
     , subquery.b3TeamId
  from (
select case when (m.datetime - getdate()) + (6 / 24 / 60)  < 0 then 1 else 0 end sortOrder
     , m.type + ' ' + m.number matchNumber
     , m.id matchId
     , (select r.teamNumber
          from TeamMatch mr
               inner join Team r
               on r.id = mr.teamId
         where mr.matchId = m.id
           and alliance = 'R'
           and alliancePosition = 1) r1TeamNumber
     , (select mr.teamId
          from TeamMatch mr
               inner join Team r
               on r.id = mr.teamId
         where mr.matchId = m.id
           and alliance = 'R'
           and alliancePosition = 1) r1TeamId
     , (select r.teamNumber
          from TeamMatch mr
               inner join Team r
               on r.id = mr.teamId
         where mr.matchId = m.id
           and alliance = 'R'
           and alliancePosition = 2) r2TeamNumber
     , (select mr.teamId
          from TeamMatch mr
               inner join Team r
               on r.id = mr.teamId
         where mr.matchId = m.id
           and alliance = 'R'
           and alliancePosition = 2) r2TeamId
     , (select r.teamNumber
          from TeamMatch mr
               inner join Team r
               on r.id = mr.teamId
         where mr.matchId = m.id
           and alliance = 'R'
           and alliancePosition = 3) r3TeamNumber
     , (select mr.teamId
          from TeamMatch mr
               inner join Team r
               on r.id = mr.teamId
         where mr.matchId = m.id
           and alliance = 'R'
           and alliancePosition = 3) r3TeamId
     , (select r.teamNumber
          from TeamMatch mr
               inner join Team r
               on r.id = mr.teamId
         where mr.matchId = m.id
           and alliance = 'B'
           and alliancePosition = 1) b1TeamNumber
     , (select mr.teamId
          from TeamMatch mr
               inner join Team r
               on r.id = mr.teamId
         where mr.matchId = m.id
           and alliance = 'B'
           and alliancePosition = 1) b1TeamId
     , (select r.teamNumber
          from TeamMatch mr
               inner join Team r
               on r.id = mr.teamId
         where mr.matchId = m.id
           and alliance = 'B'
           and alliancePosition = 2) b2TeamNumber
     , (select mr.teamId
          from TeamMatch mr
               inner join Team r
               on r.id = mr.teamId
         where mr.matchId = m.id
           and alliance = 'B'
           and alliancePosition = 2) b2TeamId
     , (select r.teamNumber
          from TeamMatch mr
               inner join Team r
               on r.id = mr.teamId
         where mr.matchId = m.id
           and alliance = 'B'
           and alliancePosition = 3) b3TeamNumber
     , (select mr.teamId
          from TeamMatch mr
               inner join Team r
               on r.id = mr.teamId
         where mr.matchId = m.id
           and alliance = 'B'
           and alliancePosition = 3) b3TeamId
  from Match m
       inner join GameEvent ge
	   on ge.id = m.gameEventId
 where ge.isActive = 'Y'
   and m.isActive = 'Y') subquery;
go
 
-- View for Scout Record
create view v_ScoutRecord as
select sr.matchId
     , sr.teamId
	 , sr.scoutId
     , coalesce(
	   (select sor.integerValue
	      from scoutRecord sr2
		       inner join scoutObjectiveRecord sor
			   on sor.scoutRecordId = sr2.id
		       inner join Objective o
			   on o.id = sor.objectiveId
	           and o.name = 'leaveHAB'
		 where sr2.matchId = sr.matchId
		   and sr2.teamId = sr.teamId
		   and sr2.scoutId = sr.scoutId), 0) leaveHAB
     , coalesce(
	   (select sor.integerValue
	      from scoutRecord sr2
		       inner join scoutObjectiveRecord sor
			   on sor.scoutRecordId = sr2.id
		       inner join Objective o
			   on o.id = sor.objectiveId
	           and o.name = 'ssHatchCnt'
		 where sr2.matchId = sr.matchId
		   and sr2.teamId = sr.teamId
		   and sr2.scoutId = sr.scoutId), 0) ssHatchCnt
     , coalesce(
	   (select sor.integerValue
	      from scoutRecord sr2
		       inner join scoutObjectiveRecord sor
			   on sor.scoutRecordId = sr2.id
		       inner join Objective o
			   on o.id = sor.objectiveId
	           and o.name = 'ssCargoCnt'
		 where sr2.matchId = sr.matchId
		   and sr2.teamId = sr.teamId
		   and sr2.scoutId = sr.scoutId), 0) ssCargoCnt
     , coalesce(
	   (select sor.integerValue
	      from scoutRecord sr2
		       inner join scoutObjectiveRecord sor
			   on sor.scoutRecordId = sr2.id
		       inner join Objective o
			   on o.id = sor.objectiveId
	           and o.name = 'toHatchCnt'
		 where sr2.matchId = sr.matchId
		   and sr2.teamId = sr.teamId
		   and sr2.scoutId = sr.scoutId), 0) toHatchCnt
     , coalesce(
	   (select sor.integerValue
	      from scoutRecord sr2
		       inner join scoutObjectiveRecord sor
			   on sor.scoutRecordId = sr2.id
		       inner join Objective o
			   on o.id = sor.objectiveId
	           and o.name = 'toCargoCnt'
		 where sr2.matchId = sr.matchId
		   and sr2.teamId = sr.teamId
		   and sr2.scoutId = sr.scoutId), 0) toCargoCnt
     , coalesce(
	   (select sor.integerValue
	      from scoutRecord sr2
		       inner join scoutObjectiveRecord sor
			   on sor.scoutRecordId = sr2.id
		       inner join Objective o
			   on o.id = sor.objectiveId
	           and o.name = 'playedDefense'
		 where sr2.matchId = sr.matchId
		   and sr2.teamId = sr.teamId
		   and sr2.scoutId = sr.scoutId), 0) playedDefense
     , coalesce(
	   (select sor.integerValue
	      from scoutRecord sr2
		       inner join scoutObjectiveRecord sor
			   on sor.scoutRecordId = sr2.id
		       inner join Objective o
			   on o.id = sor.objectiveId
	           and o.name = 'returnToHAB'
		 where sr2.matchId = sr.matchId
		   and sr2.teamId = sr.teamId
		   and sr2.scoutId = sr.scoutId), 0) returnToHAB
  from scoutRecord sr
       inner join Match m
	   on m.id = sr.matchId
	   inner join GameEvent ge
	   on ge.id = m.gameEventId
 where ge.isActive = 'Y'
   and m.isActive = 'Y';
go

-- View for average Team report on a match
create view v_AvgScoutRecord as
select sr.matchId
     , sr.teamId
     , count(*) cnt
     , avg(convert(numeric, leaveHAB)) leaveHAB
     , avg(convert(numeric, ssHatchCnt)) ssHatchCnt
     , avg(convert(numeric, ssCargoCnt)) ssCargoCnt
     , avg(convert(numeric, toHatchCnt)) toHatchCnt
     , avg(convert(numeric, toCargoCnt)) toCargoCnt 
     , avg(convert(numeric, playedDefense)) playedDefense
     , avg(convert(numeric, returnToHAB)) returnToHAB
  from v_ScoutRecord sr
group by sr.matchId
       , sr.TeamId;
go

-- View for match averages
create view v_MatchReport as
select m.type + ' ' + m.number matchNumber
     , mr.matchId
     , mr.teamId
     , r.TeamNumber
     , mr.alliance
     , mr.alliancePosition
     , '<a href=\"Reports\TeamReport.php?TeamId=' + convert(varchar, mr.teamId) + '\"> ' + convert(varchar, r.teamNumber) + '</a> ' r3TeamReportUrl
     , count(*) matchCnt
     , round(avg(sr.leaveHab),1) leaveHabAvg
     , round(avg(sr.ssHatchCnt),1) ssHatchCnt
     , round(avg(sr.ssCargoCnt),1) ssCargoCnt
     , round(avg(sr.toHatchCnt + sr.ssHatchCnt),1) totHatchCnt
     , round(avg(sr.toCargoCnt + sr.ssCargoCnt),1) totCargoCnt
     , round(avg(sr.playedDefense),1) playedDefense
     , round(avg(sr.returnToHab),1) returnToHab
  from Match m
	   inner join GameEvent ge
	   on ge.id = m.gameEventId
       inner join TeamMatch mr
       on mr.matchId = m.id
       inner join Team r
       on r.id = mr.teamId
       left outer join v_AvgScoutRecord sr
       on sr.TeamId = mr.teamId
       and exists (select 1
                     from match m2
                    where m2.id = sr.matchId
                      and m2.isActive = 'Y')
 where ge.isActive = 'Y'
   and m.isActive = 'Y'
group by m.type + ' ' + m.number
       , mr.matchId
       , mr.teamId
       , r.TeamNumber
       , mr.alliance
       , mr.alliancePosition;
go
 
-- View for Team history and average
create view v_TeamReport as
select t.TeamNumber
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
     , t.id TeamId
     , null matchId
     , null scoutId
 from Team t
      inner join v_AvgScoutRecord sr
      on sr.TeamId = t.id
      inner join Match m
      on m.id = sr.matchId
 where t.isActive = 'Y'
   and m.isActive = 'Y'
group by t.TeamNumber
       , t.id
union
select t.TeamNumber
     , m.type + ' ' + m.number matchNumber
     , m.datetime matchTime
     , s.lastName + ', ' + firstName scoutName
     , sr.leaveHab
     , sr.ssHatchCnt
     , sr.ssCargoCnt
     , sr.toHatchCnt + sr.ssHatchCnt totHatchCnt
     , sr.toCargoCnt + sr.ssCargoCnt totCargoCnt
     , sr.playedDefense
     , sr.returnToHab
     , sr.TeamId
     , sr.matchId
     , sr.scoutId
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
group by asr.TeamId;
go

-- Rank Query
create view v_TeamAvgRank as
select t.TeamNumber
     , t.TeamName
     , avg(rank) avgRank
     , sum(case when measureType = 'leaveHab' then rank else 0 end) rankLeaveHab
     , sum(case when measureType = 'returnToHab' then rank else 0 end) rankReturnToHab
     , sum(case when measureType = 'ssHatchCnt' then rank else 0 end) rankSsHatch
     , sum(case when measureType = 'ssCargoCnt' then rank else 0 end) rankSsCargo
     , sum(case when measureType = 'totHatchCnt' then rank else 0 end) rankTotHatch
     , sum(case when measureType = 'totCargoCnt' then rank else 0 end) rankTotCargo
     , sum(case when measureType = 'playedDefense' then rank else 0 end) rankPlayedDefense
     , sum(case when measureType = 'leaveHab' then val else 0 end) leaveHab
     , sum(case when measureType = 'returnToHab' then val else 0 end) returnToHab
     , sum(case when measureType = 'ssHatchCnt' then val else 0 end) ssHatch
     , sum(case when measureType = 'ssCargoCnt' then val else 0 end) ssCargo
     , sum(case when measureType = 'totHatchCnt' then val else 0 end) totHatch
     , sum(case when measureType = 'totCargoCnt' then val else 0 end) totCargo
     , sum(case when measureType = 'playedDefense' then val else 0 end) playedDefense
  from (
select arr.TeamId
     , 'leaveHab' measureType
     , round(arr.leaveHab, 2) val
     , (select count(*)
          from v_AvgTeamRecord arr2
         where arr2.leaveHab > arr.leaveHab) + 1 rank
  from v_AvgTeamRecord arr
union
select arr.TeamId
     , 'ssHatchCnt' measureType
     , round(arr.ssHatchCnt, 2) val
     , (select count(*)
          from v_AvgTeamRecord arr2
         where arr2.ssHatchCnt > arr.ssHatchCnt ) + 1 rank
  from v_AvgTeamRecord arr
union
select arr.TeamId
     , 'ssCargoCnt' measureType
     , round(arr.ssCargoCnt, 2) val
     , (select count(*)
          from v_AvgTeamRecord arr2
         where arr2.ssCargoCnt > arr.ssCargoCnt ) + 1 rank
  from v_AvgTeamRecord arr
union
select arr.TeamId
     , 'totHatchCnt' measureType
     , round(arr.ssHatchCnt + arr.toHatchCnt, 2) val
     , (select count(*)
          from v_AvgTeamRecord arr2
         where arr2.ssHatchCnt + arr2.toHatchCnt > arr.ssHatchCnt + arr.toHatchCnt) + 1 rank
  from v_AvgTeamRecord arr
union
select arr.TeamId
     , 'totCargoCnt' measureType
     , round(arr.ssCargoCnt + arr.toCargoCnt, 2) val
     , (select count(*)
          from v_AvgTeamRecord arr2
         where arr2.ssCargoCnt + arr2.toCargoCnt > arr.ssCargoCnt + arr.toCargoCnt) + 1 rank
  from v_AvgTeamRecord arr
union
select arr.TeamId
     , 'playedDefense' measureType
     , round(arr.playedDefense, 2) val
     , (select count(*)
          from v_AvgTeamRecord arr2
         where arr2.playedDefense > arr.playedDefense) + 1 rank
  from v_AvgTeamRecord arr
union
select arr.TeamId
     , 'returnToHab' measureType
     , round(arr.returnToHab, 2) val
     , (select count(*)
          from v_AvgTeamRecord arr2
         where arr2.returnToHab > arr.returnToHab) + 1 rank
  from v_AvgTeamRecord arr
) subquery
       inner join Team t
       on t.id = subquery.TeamId
 where t.isActive = 'Y'
group by t.TeamNumber
       , t.TeamName;
