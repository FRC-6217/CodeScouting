/*
drop view v_AvgTeamRecord;
drop view v_AvgScoutRecord;
drop view v_MatchReport;
drop view v_TeamReport;
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
	id integer not null GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	name varchar(128) not null,
	location varchar(128) not null,
	isActive char(1) not null,
	primary key (id));
create unique index idx_Event on Event(name);
insert into Event (name, location, isActive) values ('Lake Superior Regional', 'Duluth, MN', 'N');
insert into Event (name, location, isActive) values ('Iowa Regional', 'Cedar Falls, IA', 'N');
insert into Event (name, location, isActive) values ('EMCC Off-Season', 'Woodbury, MN', 'Y');

create table Game(
	id integer not null GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	name varchar(128) not null,
	gameYear integer not null,
	isActive char(1) not null,
	primary key (id));
create unique index idx_Game on Game(name);
insert into Game (name, gameYear, isActive) values ('Deep Space', 2019, 'Y');
insert into Game (name, gameYear, isActive) values ('Infinite Recharge', 2020, 'N');

create table GameEvent(
	id integer not null GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	eventId integer not null,
	gameId integer not null,
	eventDate date not null,
	isActive char(1) not null,
	primary key (id));
create unique index idx_GameEvent on GameEvent(eventId, eventDate);
alter table GameEvent add foreign key fk_GameEvent_Team (eventId) references Event (id);
alter table GameEvent add foreign key fk_GameEvent_Game (gameId) references Game (id);
insert into GameEvent (eventId, eventDate, isActive) select e.Id, g.Id, '03/07/2019', 'N' from event e, game g where e.Name = 'Lake Superior Regional' and g.name = 'Deep Space';
insert into GameEvent (eventId, eventDate, isActive) select e.Id, g.Id, '03/21/2019', 'N' from event e, game g where e.Name = 'Iowa Regional' and g.name = 'Deep Space';
insert into GameEvent (eventId, eventDate, isActive) select e.Id, g.Id, '09/21/2019', 'Y' from event e, game g where e.Name = 'EMCC Off-Season' and g.name = 'Deep Space';

create table Team(
	id integer not null GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	teamNumber integer not null,
	teamName varchar(128) not null,
	location varchar(128) null,
	isActive char(1) not null,
	primary key (id));
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

create table TeamGameEvent(
	id integer not null GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	teamId integer not null,
	gameEventId integer not null,
	primary key (id));
create unique index idx_TeamGameEvent on TeamGameEvent(teamId, gameEventId);
alter table TeamGameEvent add foreign key fk_TeamGameEvent_Team (teamId) references Team (id);
alter table TeamGameEvent add foreign key fk_TeamGameEvent_GameEvent (gameEventId) references GameEvent (id);
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 1816;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2175;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2220;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2450;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2502;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2508;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2526;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2530;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2531;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2549;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2574;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2846;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3026;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3082;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3100;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3130;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3184;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3206;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3883;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4198;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4207;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4215;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4239;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4549;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 6217;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 7021;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 7028;
insert into TeamGameEvent (teamId, gameEventId) select t.id, ge.id from team t, gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 7432;

create table Scout(
	id integer not null GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	lastName varchar(128) not null,
	firstName varchar(128) not null,
	teamId integer not null,
	isActive char(1) not null,
	primary key (id));
create unique index idx_scout on Scout(lastName, firstName);
alter table Scout add foreign key fk_Scout_Team (TeamId) references Team (id);
insert into Scout (lastName, firstName, teamId, isActive) select 'Allen', 'Kristy', t.id 'Y' from Team where alliancePosition = 6217;
insert into Scout (lastName, firstName, teamId, isActive) select 'Auger', 'Sam', t.id 'Y' from Team where alliancePosition = 6217;
insert into Scout (lastName, firstName, teamId, isActive) select 'Bhakta', 'Sanskar', t.id 'Y' from Team where alliancePosition = 6217;
insert into Scout (lastName, firstName, teamId, isActive) select 'Coyle', 'Samuel', t.id 'Y' from Team where alliancePosition = 6217;
insert into Scout (lastName, firstName, teamId, isActive) select 'Deutsch', 'Alex', t.id 'Y' from Team where alliancePosition = 6217;
insert into Scout (lastName, firstName, teamId, isActive) select 'Engebretsen', 'Nick', t.id 'Y' from Team where alliancePosition = 6217;
insert into Scout (lastName, firstName, teamId, isActive) select 'Garrett', 'Nathaniel', t.id 'Y' from Team where alliancePosition = 6217;
insert into Scout (lastName, firstName, teamId, isActive) select 'Giese', 'Matthew', t.id 'Y' from Team where alliancePosition = 6217;
insert into Scout (lastName, firstName, teamId, isActive) select 'Jacobson', 'Tucker', t.id 'Y' from Team where alliancePosition = 6217;
insert into Scout (lastName, firstName, teamId, isActive) select 'Jesh', 'Zoe', t.id 'Y' from Team where alliancePosition = 6217;
insert into Scout (lastName, firstName, teamId, isActive) select 'Kehrberg', 'Kris', t.id 'Y' from Team where alliancePosition = 6217;
insert into Scout (lastName, firstName, teamId, isActive) select 'Klavon', 'Wyatt', t.id 'Y' from Team where alliancePosition = 6217;
insert into Scout (lastName, firstName, teamId, isActive) select 'Miller', 'Ella', t.id 'Y' from Team where alliancePosition = 6217;
insert into Scout (lastName, firstName, teamId, isActive) select 'Parks', 'Preston', t.id 'Y' from Team where alliancePosition = 6217;
insert into Scout (lastName, firstName, teamId, isActive) select 'Schlichting', 'Ryan', t.id 'Y' from Team where alliancePosition = 6217;
insert into Scout (lastName, firstName, teamId, isActive) select 'Souza', 'Izzy', t.id 'Y' from Team where alliancePosition = 6217;
insert into Scout (lastName, firstName, teamId, isActive) select 'Weinreich', 'Xander', t.id 'Y' from Team where alliancePosition = 6217;
insert into Scout (lastName, firstName, teamId, isActive) select 'White', 'Ethan', t.id 'Y' from Team where alliancePosition = 6217;
insert into Scout (lastName, firstName, teamId, isActive) select 'Wildenberg', 'Isaiah', t.id 'Y' from Team where alliancePosition = 6217;

create table ScoringType(
	id integer not null GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	name varchar(64) not null,
	hasValueList char(1) not null,
	primary key (id));
create unique index idx_ScoringType on ScoringType(name);
insert into ScoringType (name, hasValueList) values ('Drop Down', 'Y');
insert into ScoringType (name, hasValueList) values ('Radio Button', 'Y');
insert into ScoringType (name, hasValueList) values ('Integer', 'N');
insert into ScoringType (name, hasValueList) values ('Decimal', 'N');
insert into ScoringType (name, hasValueList) values ('Free Form', 'N');

create table Objective(
	id integer not null GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	gameId integer not null,
	name varchar(64) not null,
	label varchar(64) not null,
	scoringTypeId integer not null,
	lowRangeValue integer null,
	highRangeValue integer null,
	scoreMultiplier integer null,
	primary key (id));
create unique index idx_Objective on Match(gameId, name);
alter table Objective add foreign key fk_Objective_Game (gameId) references Game (id);
alter table Objective add foreign key fk_Objective_ScoringType (scoringTypeId) references ScoringType (id);
insert into Objective (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue) select g.id, 'leaveHAB', 'Leave HAB Level', st.id, null, null, null from game g, scoringType st where g.name = 'Deep Space' and st.name = 'Radio Button';
insert into Objective (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue) select g.id, 'ssHatchCnt', 'Sandstorm Hatches', st.id, 0, 2, 2 from game g, scoringType st where g.name = 'Deep Space' and st.name = 'Integer';
insert into Objective (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue) select g.id, 'ssCargoCnt', 'Sandstorm Cargo', st.id, 0, 2, 3 from game g, scoringType st where g.name = 'Deep Space' and st.name = 'Integer';
insert into Objective (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue) select g.id, 'toHatchCnt', 'TeleOp Hatches', st.id, 0, 10, 2 from game g, scoringType st where g.name = 'Deep Space' and st.name = 'Integer';
insert into Objective (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue) select g.id, 'toCargoCnt', 'TeleOp Cargo', st.id, 0, 10, 3 from game g, scoringType st where g.name = 'Deep Space' and st.name = 'Integer';
insert into Objective (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue) select g.id, 'playedDefense', 'Performed on Defense', st.id, null, null, null from game g, scoringType st where g.name = 'Deep Space' and st.name = 'Radio Button';
insert into Objective (gameId, name, label, scoringTypeId, lowRangeValue, highRangeValue) select g.id, 'returnToHAB', 'Return HAB Level', st.id, null, null, null from game g, scoringType st where g.name = 'Deep Space' and st.name = 'Radio Button';

create table ObjectiveValue(
	id integer not null GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	objectiveId integer not null,
	displayValue varchar(64) not null,
	integerValue integer null,
	charValue varchar(8) null,
	sortOrder integer null,
	scoreValue integer null,
	primary key (id));
create unique index idx_ObjectiveValue on Match(objectiveId, displayValue);
alter table ObjectiveValue add foreign key fk_ObjectiveValue_Objective (objectiveId) references Objective (id);
insert into ObjectiveValue (objectiveId, displayValue, integerValue, charValue, sortOrder, scoreValue) select o.id, 'Did Not Leave', 0, null, 1, 0 from Objective o inner join Game g on g.id = o.gameId where g.name = 'Deep Space' and o.name = 'leaveHAB';
insert into ObjectiveValue (objectiveId, displayValue, integerValue, charValue, sortOrder, scoreValue) select o.id, 'Level 1', 1, null, 2, 3 from Objective o inner join Game g on g.id = o.gameId where g.name = 'Deep Space' and o.name = 'leaveHAB';
insert into ObjectiveValue (objectiveId, displayValue, integerValue, charValue, sortOrder, scoreValue) select o.id, 'Level 2', 2, null, 3, 6 from Objective o inner join Game g on g.id = o.gameId where g.name = 'Deep Space' and o.name = 'leaveHAB';
insert into ObjectiveValue (objectiveId, displayValue, integerValue, charValue, sortOrder, scoreValue) select o.id, 'None or Not Effective', 0, null, 1, 0 from Objective o inner join Game g on g.id = o.gameId where g.name = 'Deep Space' and o.name = 'playedDefense';
insert into ObjectiveValue (objectiveId, displayValue, integerValue, charValue, sortOrder, scoreValue) select o.id, 'Average', 2, null, 2, 0 from Objective o inner join Game g on g.id = o.gameId where g.name = 'Deep Space' and o.name = 'playedDefense';
insert into ObjectiveValue (objectiveId, displayValue, integerValue, charValue, sortOrder, scoreValue) select o.id, 'Great', 4, null, 3, 0 from Objective o inner join Game g on g.id = o.gameId where g.name = 'Deep Space' and o.name = 'playedDefense';
insert into ObjectiveValue (objectiveId, displayValue, integerValue, charValue, sortOrder, scoreValue) select o.id, 'Did Not Return', 0, null, 1, 0 from Objective o inner join Game g on g.id = o.gameId where g.name = 'Deep Space' and o.name = 'returnToHAB';
insert into ObjectiveValue (objectiveId, displayValue, integerValue, charValue, sortOrder, scoreValue) select o.id, 'Level 1', 1, null, 2, 3 from Objective o inner join Game g on g.id = o.gameId where g.name = 'Deep Space' and o.name = 'returnToHAB';
insert into ObjectiveValue (objectiveId, displayValue, integerValue, charValue, sortOrder, scoreValue) select o.id, 'Level 2', 2, null, 3, 6 from Objective o inner join Game g on g.id = o.gameId where g.name = 'Deep Space' and o.name = 'returnToHAB';
insert into ObjectiveValue (objectiveId, displayValue, integerValue, charValue, sortOrder, scoreValue) select o.id, 'Level 3', 3, null, 4, 12 from Objective o inner join Game g on g.id = o.gameId where g.name = 'Deep Space' and o.name = 'returnToHAB';

create table Match(
	id integer not null GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	gameEventId integer not null,
	number varchar(8) not null,
	dateTime TIMESTAMP not null,
	type char(1) not null,
	isActive char(1) not null,
	primary key (id));
create unique index idx_Match on Match(gameEventId, dateTime);
alter table Match add foreign key fk_Match_GameEvent (gameEventId) references GameEvent (id);
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '01', TIMESTAMP ('2019-09-21 08:45:00'), 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '02', TIMESTAMP ('2019-09-21 08:55:00'), 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '03', TIMESTAMP ('2019-09-21 09:05:00'), 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '04', TIMESTAMP ('2019-09-21 09:15:00'), 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '05', TIMESTAMP ('2019-09-21 09:25:00'), 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '06', TIMESTAMP ('2019-09-21 09:35:00'), 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '07', TIMESTAMP ('2019-09-21 09:45:00'), 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '08', TIMESTAMP ('2019-09-21 09:55:00'), 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '09', TIMESTAMP ('2019-09-21 10:05:00'), 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '10', TIMESTAMP ('2019-09-21 10:15:00'), 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '11', TIMESTAMP ('2019-09-21 10:25:00'), 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '12', TIMESTAMP ('2019-09-21 10:35:00'), 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '13', TIMESTAMP ('2019-09-21 10:45:00'), 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '14', TIMESTAMP ('2019-09-21 10:55:00'), 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '15', TIMESTAMP ('2019-09-21 11:05:00'), 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '16', TIMESTAMP ('2019-09-21 11:15:00'), 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '17', TIMESTAMP ('2019-09-21 11:25:00'), 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '18', TIMESTAMP ('2019-09-21 11:35:00'), 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '19', TIMESTAMP ('2019-09-21 11:45:00'), 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '20', TIMESTAMP ('2019-09-21 11:55:00'), 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '21', TIMESTAMP ('2019-09-21 13:05:00'), 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '22', TIMESTAMP ('2019-09-21 13:15:00'), 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '23', TIMESTAMP ('2019-09-21 13:25:00'), 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '24', TIMESTAMP ('2019-09-21 13:35:00'), 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '25', TIMESTAMP ('2019-09-21 13:45:00'), 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '26', TIMESTAMP ('2019-09-21 13:55:00'), 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '27', TIMESTAMP ('2019-09-21 14:05:00'), 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '28', TIMESTAMP ('2019-09-21 14:15:00'), 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '29', TIMESTAMP ('2019-09-21 14:25:00'), 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '30', TIMESTAMP ('2019-09-21 14:35:00'), 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '31', TIMESTAMP ('2019-09-21 14:45:00'), 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '32', TIMESTAMP ('2019-09-21 14:55:00'), 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season';
insert into Match (gameEventId, number, dateTime, type, isActive) select ge.Id, '33', TIMESTAMP ('2019-09-21 15:05:00'), 'Q', 'Y' from gameEvent ge inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season';

create table TeamMatch(
	id integer not null GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	matchId integer not null,
	teamId integer not null,
	alliance char(1) not null,
	alliancePosition integer not null,
	primary key (id));
create unique index idx_TeamMatch on TeamMatch(matchId, teamId);
alter table TeamMatch add foreign key fk_TeamMatch_Match (matchId) references Match (id);
alter table TeamMatch add foreign key fk_TeamMatch_Team (teamId) references Team (id);
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2220 and m.type = 'Q' and m.number = '01';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2531 and m.type = 'Q' and m.number = '02';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3100 and m.type = 'Q' and m.number = '03';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4207 and m.type = 'Q' and m.number = '04';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 7028 and m.type = 'Q' and m.number = '05';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2526 and m.type = 'Q' and m.number = '06';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3026 and m.type = 'Q' and m.number = '07';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3883 and m.type = 'Q' and m.number = '08';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 6217 and m.type = 'Q' and m.number = '09';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2502 and m.type = 'Q' and m.number = '10';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2574 and m.type = 'Q' and m.number = '11';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3184 and m.type = 'Q' and m.number = '12';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4239 and m.type = 'Q' and m.number = '13';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2220 and m.type = 'Q' and m.number = '14';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2531 and m.type = 'Q' and m.number = '15';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3100 and m.type = 'Q' and m.number = '16';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4207 and m.type = 'Q' and m.number = '17';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 7028 and m.type = 'Q' and m.number = '18';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2526 and m.type = 'Q' and m.number = '19';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3026 and m.type = 'Q' and m.number = '20';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3883 and m.type = 'Q' and m.number = '21';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 6217 and m.type = 'Q' and m.number = '22';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2502 and m.type = 'Q' and m.number = '23';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2574 and m.type = 'Q' and m.number = '24';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3184 and m.type = 'Q' and m.number = '25';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4239 and m.type = 'Q' and m.number = '26';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2220 and m.type = 'Q' and m.number = '27';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2531 and m.type = 'Q' and m.number = '28';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3100 and m.type = 'Q' and m.number = '29';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4207 and m.type = 'Q' and m.number = '30';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 7028 and m.type = 'Q' and m.number = '31';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2526 and m.type = 'Q' and m.number = '32';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3026 and m.type = 'Q' and m.number = '33';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2450 and m.type = 'Q' and m.number = '01';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2549 and m.type = 'Q' and m.number = '02';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3130 and m.type = 'Q' and m.number = '03';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4215 and m.type = 'Q' and m.number = '04';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 7432 and m.type = 'Q' and m.number = '05';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2530 and m.type = 'Q' and m.number = '06';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3082 and m.type = 'Q' and m.number = '07';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4198 and m.type = 'Q' and m.number = '08';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 7021 and m.type = 'Q' and m.number = '09';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2508 and m.type = 'Q' and m.number = '10';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2846 and m.type = 'Q' and m.number = '11';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3206 and m.type = 'Q' and m.number = '12';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4549 and m.type = 'Q' and m.number = '13';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2450 and m.type = 'Q' and m.number = '14';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2549 and m.type = 'Q' and m.number = '15';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3130 and m.type = 'Q' and m.number = '16';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4215 and m.type = 'Q' and m.number = '17';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 7432 and m.type = 'Q' and m.number = '18';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2530 and m.type = 'Q' and m.number = '19';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3082 and m.type = 'Q' and m.number = '20';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4198 and m.type = 'Q' and m.number = '21';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 7021 and m.type = 'Q' and m.number = '22';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2508 and m.type = 'Q' and m.number = '23';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2846 and m.type = 'Q' and m.number = '24';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3206 and m.type = 'Q' and m.number = '25';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4549 and m.type = 'Q' and m.number = '26';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2450 and m.type = 'Q' and m.number = '27';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2549 and m.type = 'Q' and m.number = '28';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3130 and m.type = 'Q' and m.number = '29';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4215 and m.type = 'Q' and m.number = '30';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 7432 and m.type = 'Q' and m.number = '31';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2530 and m.type = 'Q' and m.number = '32';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3082 and m.type = 'Q' and m.number = '33';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2502 and m.type = 'Q' and m.number = '01';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2574 and m.type = 'Q' and m.number = '02';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3184 and m.type = 'Q' and m.number = '03';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4239 and m.type = 'Q' and m.number = '04';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2220 and m.type = 'Q' and m.number = '05';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2531 and m.type = 'Q' and m.number = '06';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3100 and m.type = 'Q' and m.number = '07';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4207 and m.type = 'Q' and m.number = '08';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 7028 and m.type = 'Q' and m.number = '09';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2526 and m.type = 'Q' and m.number = '10';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3026 and m.type = 'Q' and m.number = '11';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3883 and m.type = 'Q' and m.number = '12';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 6217 and m.type = 'Q' and m.number = '13';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2502 and m.type = 'Q' and m.number = '14';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2574 and m.type = 'Q' and m.number = '15';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3184 and m.type = 'Q' and m.number = '16';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4239 and m.type = 'Q' and m.number = '17';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2220 and m.type = 'Q' and m.number = '18';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2531 and m.type = 'Q' and m.number = '19';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3100 and m.type = 'Q' and m.number = '20';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4207 and m.type = 'Q' and m.number = '21';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 7028 and m.type = 'Q' and m.number = '22';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2526 and m.type = 'Q' and m.number = '23';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3026 and m.type = 'Q' and m.number = '24';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3883 and m.type = 'Q' and m.number = '25';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 6217 and m.type = 'Q' and m.number = '26';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2502 and m.type = 'Q' and m.number = '27';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2574 and m.type = 'Q' and m.number = '28';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3184 and m.type = 'Q' and m.number = '29';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4239 and m.type = 'Q' and m.number = '30';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2220 and m.type = 'Q' and m.number = '31';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2531 and m.type = 'Q' and m.number = '32';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'R', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3100 and m.type = 'Q' and m.number = '33';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2508 and m.type = 'Q' and m.number = '01';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2846 and m.type = 'Q' and m.number = '02';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3206 and m.type = 'Q' and m.number = '03';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4549 and m.type = 'Q' and m.number = '04';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2450 and m.type = 'Q' and m.number = '05';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2549 and m.type = 'Q' and m.number = '06';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3130 and m.type = 'Q' and m.number = '07';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4215 and m.type = 'Q' and m.number = '08';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 7432 and m.type = 'Q' and m.number = '09';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2530 and m.type = 'Q' and m.number = '10';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3082 and m.type = 'Q' and m.number = '11';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4198 and m.type = 'Q' and m.number = '12';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 7021 and m.type = 'Q' and m.number = '13';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2508 and m.type = 'Q' and m.number = '14';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2846 and m.type = 'Q' and m.number = '15';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3206 and m.type = 'Q' and m.number = '16';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4549 and m.type = 'Q' and m.number = '17';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2450 and m.type = 'Q' and m.number = '18';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2549 and m.type = 'Q' and m.number = '19';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3130 and m.type = 'Q' and m.number = '20';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4215 and m.type = 'Q' and m.number = '21';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 7432 and m.type = 'Q' and m.number = '22';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2530 and m.type = 'Q' and m.number = '23';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3082 and m.type = 'Q' and m.number = '24';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4198 and m.type = 'Q' and m.number = '25';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 7021 and m.type = 'Q' and m.number = '26';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2508 and m.type = 'Q' and m.number = '27';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2846 and m.type = 'Q' and m.number = '28';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3206 and m.type = 'Q' and m.number = '29';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4549 and m.type = 'Q' and m.number = '30';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2450 and m.type = 'Q' and m.number = '31';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2549 and m.type = 'Q' and m.number = '32';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 1 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3130 and m.type = 'Q' and m.number = '33';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2526 and m.type = 'Q' and m.number = '01';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3026 and m.type = 'Q' and m.number = '02';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3883 and m.type = 'Q' and m.number = '03';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 6217 and m.type = 'Q' and m.number = '04';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2502 and m.type = 'Q' and m.number = '05';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2574 and m.type = 'Q' and m.number = '06';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3184 and m.type = 'Q' and m.number = '07';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4239 and m.type = 'Q' and m.number = '08';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2220 and m.type = 'Q' and m.number = '09';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2531 and m.type = 'Q' and m.number = '10';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3100 and m.type = 'Q' and m.number = '11';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4207 and m.type = 'Q' and m.number = '12';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 7028 and m.type = 'Q' and m.number = '13';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2526 and m.type = 'Q' and m.number = '14';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3026 and m.type = 'Q' and m.number = '15';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3883 and m.type = 'Q' and m.number = '16';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 6217 and m.type = 'Q' and m.number = '17';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2502 and m.type = 'Q' and m.number = '18';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2574 and m.type = 'Q' and m.number = '19';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3184 and m.type = 'Q' and m.number = '20';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4239 and m.type = 'Q' and m.number = '21';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2220 and m.type = 'Q' and m.number = '22';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2531 and m.type = 'Q' and m.number = '23';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3100 and m.type = 'Q' and m.number = '24';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4207 and m.type = 'Q' and m.number = '25';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 7028 and m.type = 'Q' and m.number = '26';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2526 and m.type = 'Q' and m.number = '27';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3026 and m.type = 'Q' and m.number = '28';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3883 and m.type = 'Q' and m.number = '29';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 6217 and m.type = 'Q' and m.number = '30';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2502 and m.type = 'Q' and m.number = '31';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2574 and m.type = 'Q' and m.number = '32';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 2 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3184 and m.type = 'Q' and m.number = '33';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2530 and m.type = 'Q' and m.number = '01';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3082 and m.type = 'Q' and m.number = '02';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4198 and m.type = 'Q' and m.number = '03';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 7021 and m.type = 'Q' and m.number = '04';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2508 and m.type = 'Q' and m.number = '05';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2846 and m.type = 'Q' and m.number = '06';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3206 and m.type = 'Q' and m.number = '07';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4549 and m.type = 'Q' and m.number = '08';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2450 and m.type = 'Q' and m.number = '09';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2549 and m.type = 'Q' and m.number = '10';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3130 and m.type = 'Q' and m.number = '11';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4215 and m.type = 'Q' and m.number = '12';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 7432 and m.type = 'Q' and m.number = '13';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2530 and m.type = 'Q' and m.number = '14';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3082 and m.type = 'Q' and m.number = '15';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4198 and m.type = 'Q' and m.number = '16';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 7021 and m.type = 'Q' and m.number = '17';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2508 and m.type = 'Q' and m.number = '18';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2846 and m.type = 'Q' and m.number = '19';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3206 and m.type = 'Q' and m.number = '20';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4549 and m.type = 'Q' and m.number = '21';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2450 and m.type = 'Q' and m.number = '22';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2549 and m.type = 'Q' and m.number = '23';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3130 and m.type = 'Q' and m.number = '24';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4215 and m.type = 'Q' and m.number = '25';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 7432 and m.type = 'Q' and m.number = '26';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2530 and m.type = 'Q' and m.number = '27';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3082 and m.type = 'Q' and m.number = '28';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 4198 and m.type = 'Q' and m.number = '29';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 7021 and m.type = 'Q' and m.number = '30';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2508 and m.type = 'Q' and m.number = '31';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 2846 and m.type = 'Q' and m.number = '32';
insert into TeamMatch (matchId, teamId, alliance, TeamNumber) select m.id, t.id, 'B', 3 from Team t, Match m inner join GameEvent ge on ge.Id = m.gameEventId inner join game g on g.id = ge.gameId inner join event e on e.id = ge.eventId where g.name = 'Deep Space' and e.name = 'EMCC Off-Season' and t.alliancePosition = 3206 and m.type = 'Q' and m.number = '33';

create table ScoutRecord (
	id integer not null GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	scoutId integer not null,
	matchId integer not null,
	teamId integer not null,
	primary key (id));
create unique index idx_ScoutRecord on ScoutRecord(scoutId, matchId, teamId);
alter table ScoutRecord add foreign key fk_ScoutRecord_Scout (scoutId) references Scout (id);
alter table ScoutRecord add foreign key fk_ScoutRecord_Match (matchId) references Match (id);
alter table ScoutRecord add foreign key fk_ScoutRecord_Team (TeamId) references Team (id);

create table ScoutObjectiveRecord (
	id integer not null GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	scoutRecordId integer not null,
	objectiveId integer not null,
	integerValue integer not null,
	scoreValue integer not null,
	primary key (id));
create unique index idx_ScoutObjectiveRecord on ScoutObjectiveRecord(scoutRecordId, objectiveId);
alter table ScoutObjectiveRecord add foreign key fk_ScoutObjectiveRecord_ScoutRecord (scoutRecordId) references ScoutRecord (id);
alter table ScoutObjectiveRecord add foreign key fk_ScoutObjectiveRecord_Objective (objectiveId) references Objective (id);

-- Insert some random data
insert into ScoutRecord (scoutId, matchId, TeamId)
select s.Id
     , tm.matchId
     , tm.TeamId
  from TeamMatch tm, Scout s
 where s.lastName in ('Parks', 'Weinreich', 'Schlichting');

insert into ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue, scoreValue)
select sr.id
     , o.id
     , cast(round(rand() * 2, 0) as integer) integerValue
	 , 0 scoreValue
  from scoutRecord sr
     , objective o
 where o.name = 'leaveHAB';
insert into ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue, scoreValue)
select sr.id
     , o.id
     , cast(round(rand() * 2, 0) as integer) integerValue
	 , 0 scoreValue
  from scoutRecord sr
     , objective o
 where o.name = 'ssHatchCnt';
insert into ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue, scoreValue)
select sr.id
     , o.id
     , cast(round(rand() * 2, 0) as integer) integerValue
	 , 0 scoreValue
  from scoutRecord sr
     , objective o
 where o.name = 'ssCargoCnt';
insert into ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue, scoreValue)
select sr.id
     , o.id
     , cast(round(rand() * 10, 0) as integer) integerValue
	 , 0 scoreValue
  from scoutRecord sr
     , objective o
 where o.name = 'toHatchCnt';
insert into ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue, scoreValue)
select sr.id
     , o.id
     , cast(round(rand() * 10, 0) as integer) integerValue
	 , 0 scoreValue
  from scoutRecord sr
     , objective o
 where o.name = 'toCargoCnt';
insert into ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue, scoreValue)
select sr.id
     , o.id
     , cast(round(rand() * 3, 0) as integer) integerValue
	 , 0 scoreValue
  from scoutRecord sr
     , objective o
 where o.name = 'playedDefense';
insert into ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue, scoreValue)
select sr.id
     , o.id
     , cast(round(rand() * 3, 0) as integer) integerValue
	 , 0 scoreValue
  from scoutRecord sr
     , objective o
 where o.name = 'returnToHAB';
 
-- View for Match Teams
create view v_MatchHyperlinks as
select '<a href=\"Reports\matchReport.php?matchId=' || subquery.matchId || '\"> ' || subquery.matchNumber || '</a>' matchReportUrl
     , subquery.r1TeamNumber
     , '<a href=\"Reports\TeamReport.php?TeamId=' || subquery.r1TeamId || '\"> R </a>' r1TeamReportUrl
     , '<a href=\"scoutRecord.php?matchId=' || subquery.matchId || ';matchNumber=' || subquery.matchNumber || ';TeamId=' || subquery.r1TeamId || '\"> S </a>' r1TeamScoutUrl
     , subquery.r2TeamNumber
     , '<a href=\"Reports\TeamReport.php?TeamId=' || subquery.r2TeamId || '\"> R </a>' r2TeamReportUrl
     , '<a href=\"scoutRecord.php?matchId=' || subquery.matchId || ';matchNumber=' || subquery.matchNumber || ';TeamId=' || subquery.r2TeamId || '\"> S </a>' r2TeamScoutUrl
     , subquery.r3TeamNumber
     , '<a href=\"Reports\TeamReport.php?TeamId=' || subquery.r3TeamId || '\"> R </a>' r3TeamReportUrl
     , '<a href=\"scoutRecord.php?matchId=' || subquery.matchId || ';matchNumber=' || subquery.matchNumber || ';TeamId=' || subquery.r3TeamId || '\"> S </a>' r3TeamScoutUrl
     , subquery.b1TeamNumber
     , '<a href=\"Reports\TeamReport.php?TeamId=' || subquery.b1TeamId || '\"> R </a>' b1TeamReportUrl
     , '<a href=\"scoutRecord.php?matchId=' || subquery.matchId || ';matchNumber=' || subquery.matchNumber || ';TeamId=' || subquery.b1TeamId || '\"> S </a>' b1TeamScoutUrl
     , subquery.b2TeamNumber
     , '<a href=\"Reports\TeamReport.php?TeamId=' || subquery.b2TeamId || '\"> R </a>' b2TeamReportUrl
     , '<a href=\"scoutRecord.php?matchId=' || subquery.matchId || ';matchNumber=' || subquery.matchNumber || ';TeamId=' || subquery.b2TeamId || '\"> S </a>' b2TeamScoutUrl
     , subquery.b3TeamNumber
     , '<a href=\"Reports\TeamReport.php?TeamId=' || subquery.b3TeamId || '\"> R </a>' b3TeamReportUrl
     , '<a href=\"scoutRecord.php?matchId=' || subquery.matchId || ';matchNumber=' || subquery.matchNumber || ';TeamId=' || subquery.b3TeamId || '\"> S </a>' b3TeamScoutUrl
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
select case when timestampdiff(4, m.datetime - current timestamp) + 330 < 0 then 1 else 0 end sortOrder
     , m.type || ' ' || m.number matchNumber
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
 where isActive = 'Y') subquery;

-- View for average Team report on a match
create view v_AvgScoutRecord as
select sr.matchId
     , sr.teamId
     , count(*) cnt
     , (select avg(integerValue) from scoutObjectiveRecord sor inner join Objective o on o.id = sor.objectiveId where sor.scoutRecordId = sr.id and o.name = 'leaveHab') leaveHAB
     , (select avg(integerValue) from scoutObjectiveRecord sor inner join Objective o on o.id = sor.objectiveId where sor.scoutRecordId = sr.id and o.name = 'ssHatchCnt') ssHatchCnt
     , (select avg(integerValue) from scoutObjectiveRecord sor inner join Objective o on o.id = sor.objectiveId where sor.scoutRecordId = sr.id and o.name = 'ssCargoCnt') ssCargoCnt
     , (select avg(integerValue) from scoutObjectiveRecord sor inner join Objective o on o.id = sor.objectiveId where sor.scoutRecordId = sr.id and o.name = 'toHatchCnt') toHatchCnt
     , (select avg(integerValue) from scoutObjectiveRecord sor inner join Objective o on o.id = sor.objectiveId where sor.scoutRecordId = sr.id and o.name = 'toCargoCnt') toCargoCnt
     , (select avg(integerValue) from scoutObjectiveRecord sor inner join Objective o on o.id = sor.objectiveId where sor.scoutRecordId = sr.id and o.name = 'playedDefense') playedDefense
     , (select avg(integerValue) from scoutObjectiveRecord sor inner join Objective o on o.id = sor.objectiveId where sor.scoutRecordId = sr.id and o.name = 'returnToHab') returnToHAB
  from scoutRecord sr
group by sr.matchId
       , sr.TeamId;

/*
-- View for match averages
create view v_MatchReport as
select m.type || ' ' || m.number matchNumber
     , mr.matchId
     , mr.teamId
     , r.TeamNumber
     , mr.alliance
     , mr.TeamNumber
     , '<a href=\"Reports\TeamReport.php?TeamId=' || mr.teamId || '\"> ' || r.teamNumber || '</a> ' r3TeamReportUrl
     , count(*) matchCnt
     , round(avg(sr.leaveHab),1) leaveHabAvg
     , round(avg(sr.ssHatchCnt),1) ssHatchCnt
     , round(avg(sr.ssCargoCnt),1) ssCargoCnt
     , round(avg(sr.toHatchCnt + sr.ssHatchCnt),1) totHatchCnt
     , round(avg(sr.toCargoCnt + sr.ssCargoCnt),1) totCargoCnt
     , round(avg(sr.playedDefense),1) playedDefense
     , round(avg(sr.returnToHab),1) returnToHab
 from Match m
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
group by m.type || ' ' || m.number
       , mr.matchId
       , mr.teamId
       , r.TeamNumber
       , mr.alliance
       , mr.TeamNumber;
 
-- View for Team history and average
create view v_TeamReport as
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
     , r.id TeamId
     , null matchId
     , null scoutId
 from Team r
      inner join v_AvgScoutRecord sr
      on sr.TeamId = r.id
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
     , sr.TeamId
     , sr.matchId
     , sr.scoutId
 from Team r
      inner join scoutRecord sr
      on sr.TeamId = r.id
      inner join Match m
      on m.id = sr.matchId
      inner join scout s
      on s.id = sr.scoutId;

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
       inner join Team r
       on r.id = subquery.TeamId
 where r.isActive = 'Y'
group by r.TeamNumber
       , r.TeamName
order by avgRank;
*/

	  