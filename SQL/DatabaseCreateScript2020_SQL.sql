/*
drop procedure sp_ins_scoutRecord;
drop procedure sp_ins_scoutRobot;
drop procedure sp_rpt_rankReport;
drop procedure sp_upd_portionOfAlliancePoints;
drop procedure sp_upd_scoutDataFromTba;
drop trigger tr_SOR_CalcScoreValue;
drop function calcScoreValue;
drop view v_AvgTeamRecord;
drop view v_AvgScoutRecord;
drop view v_AvgScoutObjectiveRecord;
drop view v_MatchReport;
drop view v_MatchReportAttributes;
drop view v_TeamReport;
drop view v_ScoutRecord;
drop view v_MatchHyperlinks;
drop view v_ScoutTeamHyperlinks;
drop view v_EnterScoutRecordHTML;
drop view v_UpdateScoutRecordHTML;
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
	lastUpdated datetime null);
create unique index idx_GameEvent on GameEvent(eventId, eventDate);
alter table GameEvent add constraint fk_GameEvent_Team foreign key (eventId) references Event (id);
alter table GameEvent add constraint fk_GameEvent_Game foreign key (gameId) references Game (id);
insert into GameEvent (eventId, gameId, eventDate) select e.Id, g.Id, '03/07/2019' from event e, game g where e.Name = 'Lake Superior Regional' and g.name = 'Deep Space';
insert into GameEvent (eventId, gameId, eventDate) select e.Id, g.Id, '03/21/2019' from event e, game g where e.Name = 'Iowa Regional' and g.name = 'Deep Space';
insert into GameEvent (eventId, gameId, eventDate) select e.Id, g.Id, '09/21/2019' from event e, game g where e.Name = 'EMCC Off-Season' and g.name = 'Deep Space';
insert into GameEvent (eventId, gameId, eventDate) select e.Id, g.Id, '12/31/2099' from event e, game g where e.Name = 'Test Data Event' and g.name = 'Deep Space';
insert into GameEvent (eventId, gameId, eventDate) select e.Id, g.Id, '02/15/2020' from event e, game g where e.Name = 'Week Zero - Eagan' and g.name = 'Infinite Recharge';

create table Team(
	id int primary key IDENTITY(1, 1) NOT NULL,
	teamNumber integer not null,
	teamName varchar(128) not null,
	location varchar(128) null,
	lastUpdated datetime null,
	gameEventId integer null);
create unique index idx_Team on Team(teamNumber);
create index idx2_Team on Team(gameEventId);
insert into Team (teamNumber, teamName, location) values (93, 'NEW Apple Corps', 'Appleton, WI');
insert into Team (teamNumber, teamName, location) values (167, 'Children of the Corn', 'Iowa City, IA');
insert into Team (teamNumber, teamName, location) values (171, 'Cheese Curd Herd', 'Platteville, WI');
insert into Team (teamNumber, teamName, location) values (469, 'Las Guerrillas', 'Bloomfield Hills, MI');
insert into Team (teamNumber, teamName, location) values (525, 'Swartdogs', 'Cedar Falls, IA');
insert into Team (teamNumber, teamName, location) values (648, 'QC ELITE - Flaming Squirrels', 'Quad Cities, IA');
insert into Team (teamNumber, teamName, location) values (904, 'D Cubed', 'Grand Rapids, MI');
insert into Team (teamNumber, teamName, location) values (930, 'Mukwonago BEARs', 'Mukwonago, WI');
insert into Team (teamNumber, teamName, location) values (967, 'Iron Lions', 'Marion, IA');
insert into Team (teamNumber, teamName, location) values (1622, 'Team Spyder', 'Poway, CA');
insert into Team (teamNumber, teamName, location) values (1625, 'Winnovation', 'Winnebago, IL');
insert into Team (teamNumber, teamName, location) values (1732, 'Hilltoppers', 'Milwaukee, WI');
insert into Team (teamNumber, teamName, location) values (1816, 'The Green Machine', 'Edina, MN');
insert into Team (teamNumber, teamName, location) values (1985, 'Robohawks', 'Florissant, MO');
insert into Team (teamNumber, teamName, location) values (2175, 'The Fighting Calculators', 'St. Paul, MN');
insert into Team (teamNumber, teamName, location) values (2220, 'Blue Twilight', 'Eagan, MN');
insert into Team (teamNumber, teamName, location) values (2264, 'Wayzata Teamics', 'Plymouth, MN');
insert into Team (teamNumber, teamName, location) values (2450, 'Team 2450', 'St. Paul, MN');
insert into Team (teamNumber, teamName, location) values (2502, 'Talon Teamics', 'Eden Prairie, MN');
insert into Team (teamNumber, teamName, location) values (2503, 'Warrior Teamics', 'Brainerd, MN');
insert into Team (teamNumber, teamName, location) values (2506, 'Saber Teamics', 'Franklin, WI');
insert into Team (teamNumber, teamName, location) values (2508, 'Armada', 'Stillwater, MN');
insert into Team (teamNumber, teamName, location) values (2526, 'Crimson Teamics', 'Osseo, MN');
insert into Team (teamNumber, teamName, location) values (2530, 'Inconceivable', 'Rochester, MN');
insert into Team (teamNumber, teamName, location) values (2531, 'RoboHawks', 'Chaska, MN');
insert into Team (teamNumber, teamName, location) values (2538, 'The Plaid Pillagers', 'Morris, MN');
insert into Team (teamNumber, teamName, location) values (2549, 'Millerbots', 'Minneapolis, MN');
insert into Team (teamNumber, teamName, location) values (2574, 'RoboHuskie', 'St. Anthony, MN');
insert into Team (teamNumber, teamName, location) values (2846, 'FireBears', 'St. Paul, MN');
insert into Team (teamNumber, teamName, location) values (2957, 'Knights', 'Alden, MN');
insert into Team (teamNumber, teamName, location) values (2977, 'Sir Lancer Bots', 'La Crescent, MN');
insert into Team (teamNumber, teamName, location) values (3008, 'Team Magma', 'Honolulu, HI');
insert into Team (teamNumber, teamName, location) values (3026, 'Orange Crush Teamics', 'Delano, MN');
insert into Team (teamNumber, teamName, location) values (3082, 'Chicken Bot Pie', 'Minnetonka, MN');
insert into Team (teamNumber, teamName, location) values (3100, 'Lightning Turtles', 'Mendota Heights, MN');
insert into Team (teamNumber, teamName, location) values (3102, 'Tech-No-Tigers', 'Nevis, MN');
insert into Team (teamNumber, teamName, location) values (3130, 'The ERRORS', 'Woodbury , MN');
insert into Team (teamNumber, teamName, location) values (3134, 'The Accelerators', 'Cass Lake, MN');
insert into Team (teamNumber, teamName, location) values (3184, 'Blaze Teamics', 'Burnsville, MN');
insert into Team (teamNumber, teamName, location) values (3206, 'Royal T-Wrecks', 'Woodbury , MN');
insert into Team (teamNumber, teamName, location) values (3275, 'The Regulators', 'Cass Lake, MN');
insert into Team (teamNumber, teamName, location) values (3276, 'TOOLCATS', 'New London, MN');
insert into Team (teamNumber, teamName, location) values (3277, 'ProDigi', 'Thief River Falls, MN');
insert into Team (teamNumber, teamName, location) values (3291, 'Au Pirates (AKA Golden Pirates)', 'Brooklyn Park, MN');
insert into Team (teamNumber, teamName, location) values (3294, 'Backwoods Engineers', 'Pine River, MN');
insert into Team (teamNumber, teamName, location) values (3352, 'Flaming Monkeys 4-H Teamics Club', 'Belvidere, IL');
insert into Team (teamNumber, teamName, location) values (3381, 'Droid Rage', 'Valders, WI');
insert into Team (teamNumber, teamName, location) values (3633, 'Catalyst 3633', 'Albert Lea, MN');
insert into Team (teamNumber, teamName, location) values (3740, 'Storm Teamics', 'Sauk Rapids, MN');
insert into Team (teamNumber, teamName, location) values (3750, 'Gator Teamics', 'Badger, MN');
insert into Team (teamNumber, teamName, location) values (3755, 'Dragon Teamics', 'Litchfield, MN');
insert into Team (teamNumber, teamName, location) values (3883, 'Data Bits', 'Cottage Grove, MN');
insert into Team (teamNumber, teamName, location) values (3928, 'Team Neutrino', 'Ames, IA');
insert into Team (teamNumber, teamName, location) values (4009, 'Denfeld DNA Teamics', 'Duluth, MN');
insert into Team (teamNumber, teamName, location) values (4021, 'igKnightion', 'Onalaska, WI');
insert into Team (teamNumber, teamName, location) values (4166, 'Robostang', 'Mora, MN');
insert into Team (teamNumber, teamName, location) values (4198, 'RoboCats', 'Waconia, MN');
insert into Team (teamNumber, teamName, location) values (4207, 'PyTeamics', 'Victoria, MN');
insert into Team (teamNumber, teamName, location) values (4215, 'Tritons', 'St. Paul, MN');
insert into Team (teamNumber, teamName, location) values (4217, 'Scitobors', 'Nashwauk, MN');
insert into Team (teamNumber, teamName, location) values (4230, 'TopperBots', 'Duluth, MN');
insert into Team (teamNumber, teamName, location) values (4238, 'BBE Resistance Teamics', 'Belgrade, MN');
insert into Team (teamNumber, teamName, location) values (4239, 'WARPSPEED', 'Wilmar, MN');
insert into Team (teamNumber, teamName, location) values (4260, 'BEAR Bucs', 'Blue Earth Area, MN');
insert into Team (teamNumber, teamName, location) values (4480, 'UC-Botics', 'Upsala, MN');
insert into Team (teamNumber, teamName, location) values (4511, 'Power Amplified', 'Plymouth, MN');
insert into Team (teamNumber, teamName, location) values (4536, 'MinuteBots', 'Saint Paul, MN');
insert into Team (teamNumber, teamName, location) values (4539, 'KAOTIC Teamics', 'Frazee, MN');
insert into Team (teamNumber, teamName, location) values (4549, 'Iron Bulls', 'South St. Paul, MN');
insert into Team (teamNumber, teamName, location) values (4674, 'Robojacks', 'Bemidji, MN');
insert into Team (teamNumber, teamName, location) values (4728, 'Rocori Rench Reckers', 'Cold Spring, MN');
insert into Team (teamNumber, teamName, location) values (4741, 'WingNuts', 'Redwood Falls, MN');
insert into Team (teamNumber, teamName, location) values (4845, 'Lions Pride', 'Duluth, MN');
insert into Team (teamNumber, teamName, location) values (5013, 'TTeams', 'Kansas City, MO');
insert into Team (teamNumber, teamName, location) values (5041, 'CyBears', 'West Branch, IA');
insert into Team (teamNumber, teamName, location) values (5253, 'Bigfork Backwoods Bots', 'Bigfork, MN');
insert into Team (teamNumber, teamName, location) values (5290, 'Mechanical Howl', 'Forest Lake, MN');
insert into Team (teamNumber, teamName, location) values (5299, 'Winger Tech', 'Red Wing, MN');
insert into Team (teamNumber, teamName, location) values (5348, 'Charger Teamics', 'Cokato, MN');
insert into Team (teamNumber, teamName, location) values (5464, 'Bluejacket Teamics', 'Cambridge, MN');
insert into Team (teamNumber, teamName, location) values (5542, 'RoboHerd', 'Buffalo, MN');
insert into Team (teamNumber, teamName, location) values (5576, 'Team Terminator', 'Spirit Lake, IA');
insert into Team (teamNumber, teamName, location) values (5586, 'Bond Brigade', 'Kiel, WI');
insert into Team (teamNumber, teamName, location) values (5638, 'LQPV Teamics', 'Madison, MN');
insert into Team (teamNumber, teamName, location) values (5653, 'Iron Mosquitos', 'Babbitt, MN');
insert into Team (teamNumber, teamName, location) values (5690, 'SubZero Teamics', 'Esko, MN');
insert into Team (teamNumber, teamName, location) values (5837, 'Unity4Tech', 'Waterloo, IA');
insert into Team (teamNumber, teamName, location) values (5906, 'Titanium Badgers', 'Bennington, NE');
insert into Team (teamNumber, teamName, location) values (5913, 'Patriotics', 'Pequot Lakes, MN');
insert into Team (teamNumber, teamName, location) values (5914, 'Teamic Warriors', 'Caledonia, MN');
insert into Team (teamNumber, teamName, location) values (5935, 'Tech Tigers', 'Grinnell, IA');
insert into Team (teamNumber, teamName, location) values (5991, 'Chargers', 'Westbrook, MN');
insert into Team (teamNumber, teamName, location) values (5999, 'Byte Force', 'Milaca, MN');
insert into Team (teamNumber, teamName, location) values (6022, 'Wrench Warmers', 'Blooming Prairie, MN');
insert into Team (teamNumber, teamName, location) values (6045, 'Sabre Teamics', 'Sartell, MN');
insert into Team (teamNumber, teamName, location) values (6047, 'Proctor Frostbyte', 'Proctor, MN');
insert into Team (teamNumber, teamName, location) values (6146, 'Blackjacks', 'Dawson, MN');
insert into Team (teamNumber, teamName, location) values (6160, 'Bombatrons', 'Barnum, MN');
insert into Team (teamNumber, teamName, location) values (6164, 'Moonshot Slaybots', 'Dike, IA');
insert into Team (teamNumber, teamName, location) values (6166, 'ThoTeamics', 'Holmen, WI');
insert into Team (teamNumber, teamName, location) values (6217, 'Bomb-Botz', 'Cannon Falls, MN');
insert into Team (teamNumber, teamName, location) values (6317, 'Disruptive Innovation', 'Davenport, IA');
insert into Team (teamNumber, teamName, location) values (6318, 'FE Freedom Engineers', 'Freedom, WI');
insert into Team (teamNumber, teamName, location) values (6379, 'Terabyte of Ram', 'Pleasant Hill, IA');
insert into Team (teamNumber, teamName, location) values (6391, 'Ursuline Bearbotics', 'Saint Louis, MO');
insert into Team (teamNumber, teamName, location) values (6420, 'Fire Island Teamics', 'Muscatine, IA');
insert into Team (teamNumber, teamName, location) values (6424, 'Stealth Panther Teamics', 'Knob Noster, MO');
insert into Team (teamNumber, teamName, location) values (6453, 'Bog Bots!', 'Kelliher, MN');
insert into Team (teamNumber, teamName, location) values (6455, 'The Coded Collective', 'Waterloo, IA');
insert into Team (teamNumber, teamName, location) values (6628, 'KMS BOTKICKERS', 'Kerkhoven, MN');
insert into Team (teamNumber, teamName, location) values (6630, 'F.U.N. (Fiercely Uknighted Nation)', 'La Porte City, IA');
insert into Team (teamNumber, teamName, location) values (6732, 'BHS RoboRaiders', 'Bruce, WI');
insert into Team (teamNumber, teamName, location) values (6889, 'DC Current', 'Bloomfield, IA');
insert into Team (teamNumber, teamName, location) values (7021, 'TC Teamics', 'Arcadia, WI');
insert into Team (teamNumber, teamName, location) values (7028, 'Binary Battalion', 'St. Michael, MN');
insert into Team (teamNumber, teamName, location) values (7041, 'Doomsday Dogs', 'Carlton, MN');
insert into Team (teamNumber, teamName, location) values (7068, 'Mechanical Masterminds', 'Saint Francis, MN');
insert into Team (teamNumber, teamName, location) values (7142, 'Vulcan Eagles', 'Des Moines, IA');
insert into Team (teamNumber, teamName, location) values (7235, 'Red Lake Ogichidaag', 'Redlake, MN');
insert into Team (teamNumber, teamName, location) values (7309, 'Green Lightning', 'Storm Lake, IA');
insert into Team (teamNumber, teamName, location) values (7411, 'CrossThreaded', 'Cedar Falls, IA');
insert into Team (teamNumber, teamName, location) values (7432, 'NOS', 'Loretto, MN');
insert into Team (teamNumber, teamName, location) values (7531, 'Servos Strike Back', 'Dubuque, IA');
insert into Team (teamNumber, teamName, location) values (7541, 'Maple River Teamics', 'Mapleton, MN');
insert into Team (teamNumber, teamName, location) values (7646, 'Cadets', 'Cresco, IA');
insert into Team (teamNumber, teamName, location) values (7797, 'Cloquets RipSaw Teamics', 'Cloquet, MN');
insert into Team (teamNumber, teamName, location) values (7864, 'North Woods Teamics', 'Cook, MN');
insert into Team (teamNumber, teamName, location) values (7893, 'Maple Lake High School', 'Maple Lake, MN');
insert into Team (teamNumber, teamName, location) values (9992, 'EMCC Sub', 'Woodbury, MN');

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
	emailAddress varchar(128) not null,
	isAdmin char(1) not null,
	scoutGUID uniqueidentifier not null default newid());
create unique index idx_scout on Scout(lastName, firstName);
create index idx2_scout on Scout(emailAddress);
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
	reportDisplay varchar(1) not null,
	sameLineAsPrevious char(1) not null,
	addTeamScorePortion char(1) not null);
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
	lastUpdated datetime null,
	sameLineAsPrevious char(1) not null,
	tbaValue varchar(64) null,
	tbaValue2 varchar(64) null,
	tbaValue3 varchar(64) null,
	tbaValue4 varchar(64) null,
	tbaValue5 varchar(64) null,
	tbaValue6 varchar(64) null);
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
	lastUpdated datetime null,
	groupCode varchar(32) not null);
create unique index idx_ObjectiveGroup on ObjectiveGroup(name, groupCode);
insert into ObjectiveGroup (name, sortOrder, groupCode) values ('Sandstorm', 1, 'Scout Match');
insert into ObjectiveGroup (name, sortOrder, groupCode) values ('Autonomous', 1, 'Scout Match');
insert into ObjectiveGroup (name, sortOrder, groupCode) values ('Tele Op', 2, 'Scout Match');
insert into ObjectiveGroup (name, sortOrder, groupCode) values ('End Game', 3, 'Scout Match');

create table ObjectiveGroupObjective(
	id int primary key IDENTITY(1, 1) NOT NULL,
	objectiveGroupId integer not null,
	objectiveId integer not null,
	lastUpdated datetime null);
create unique index idx_ObjectiveGroupObjective on ObjectiveGroupObjective(objectiveGroupId, objectiveId);
alter table ObjectiveGroupObjective add constraint fk_ObjectiveGroupObjective_ObjectiveGroup foreign key (objectiveGroupId) references ObjectiveGroup (id);
alter table ObjectiveGroupObjective add constraint fk_ObjectiveGroupObjective_Objective foreign key (objectiveId) references Objective (id);
insert into ObjectiveGroupObjective (objectiveGroupId, objectiveId) select og.id, o.id from ObjectiveGroup og, Objective o where og.name = 'Sandstorm' and og.groupCode = 'Scout Match' and o.name = 'leaveHAB';
insert into ObjectiveGroupObjective (objectiveGroupId, objectiveId) select og.id, o.id from ObjectiveGroup og, Objective o where og.name = 'Sandstorm' and og.groupCode = 'Scout Match' and o.name = 'ssHatchCnt';
insert into ObjectiveGroupObjective (objectiveGroupId, objectiveId) select og.id, o.id from ObjectiveGroup og, Objective o where og.name = 'Sandstorm' and og.groupCode = 'Scout Match' and o.name = 'ssCargoCnt';
insert into ObjectiveGroupObjective (objectiveGroupId, objectiveId) select og.id, o.id from ObjectiveGroup og, Objective o where og.name = 'Tele Op' and og.groupCode = 'Scout Match' and o.name = 'toHatchCnt';
insert into ObjectiveGroupObjective (objectiveGroupId, objectiveId) select og.id, o.id from ObjectiveGroup og, Objective o where og.name = 'Tele Op' and og.groupCode = 'Scout Match' and o.name = 'toCargoCnt';
insert into ObjectiveGroupObjective (objectiveGroupId, objectiveId) select og.id, o.id from ObjectiveGroup og, Objective o where og.name = 'Tele Op' and og.groupCode = 'Scout Match' and o.name = 'playedDefense';
insert into ObjectiveGroupObjective (objectiveGroupId, objectiveId) select og.id, o.id from ObjectiveGroup og, Objective o where og.name = 'End Game' and og.groupCode = 'Scout Match' and o.name = 'returnToHAB';

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
	tableHeader varchar(64) not null,
	sameLineAsPrevious char(1) not null);
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
	redAlliancePoints integer null,
	redFoulPoints integer null,
	blueAlliancePoints integer null,
	blueFoulPoints integer null,
	matchCode varchar(16) null);
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

create table MatchVideo(
	id int primary key IDENTITY(1, 1) NOT NULL,
	matchId integer not null,
	videoKey varchar(64) not null,
	videoType varchar(64) not null,
	lastUpdated datetime null);
create unique index idx_MatchVideo on MatchVideo(matchId, videoKey, videoType);
alter table MatchVideo add constraint fk_MatchVideo_Match foreign key (matchId) references Match (id);

create table MatchObjective (
	id int primary key IDENTITY(1, 1) NOT NULL,
	matchId integer not null,
	alliance char(1) not null,
	objectiveId integer not null,
	integerValue integer null,
	decimalValue integer null,
	textValue varchar(4000) null,
	scoreValue integer null,
	lastUpdated datetime null);
create unique index idx_MatchObjective on MatchObjective(matchId, alliance, objectiveId);
alter table MatchObjective add constraint fk_MatchObjective_Match foreign key (matchId) references Match (id);
alter table MatchObjective add constraint fk_MatchObjective_Objective foreign key (objectiveId) references Objective (id);
go

create table TeamMatch(
	id int primary key IDENTITY(1, 1) NOT NULL,
	matchId integer not null,
	teamId integer not null,
	alliance char(1) not null,
	alliancePosition integer not null,
	lastUpdated datetime null,
	portionOfAlliancePoints numeric(11,3) null);
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

create table TeamMatchObjective (
	id int primary key IDENTITY(1, 1) NOT NULL,
	teamMatchId integer not null,
	objectiveId integer not null,
	integerValue integer null,
	decimalValue integer null,
	textValue varchar(4000) null,
	scoreValue integer null,
	lastUpdated datetime null);
create unique index idx_TeamMatchObjective on TeamMatchObjective(teamMatchId, objectiveId);
alter table TeamMatchObjective add constraint fk_TeamMatchObjective_TeamMatch foreign key (teamMatchId) references TeamMatch (id);
alter table TeamMatchObjective add constraint fk_TeamMatchObjective_Objective foreign key (objectiveId) references Objective (id);
go

create table ScoutRecord (
	id int primary key IDENTITY(1, 1) NOT NULL,
	scoutId integer not null,
	matchId integer not null,
	teamId integer not null,
	lastUpdated datetime null,
	scoutComment varchar(4000) null);
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
-- Trigger to maintain last updated and scoreValue after insert/update of MatchObjective
create trigger tr_mo_CalcScoreValue on MatchObjective after insert, update
as
begin
	set nocount on
    update MatchObjective
	   set scoreValue = (select dbo.calcScoreValue(i.objectiveId, i.integerValue, i.decimalValue)
	                       from inserted i
						  where i.id = MatchObjective.id)
		 , lastUpdated = getDate() at time zone 'UTC' at time zone 'Central Standard Time'
	 where MatchObjective.id in (select i.id from inserted i);
	set nocount off
end
GO
-- Trigger to maintain last updated value of MatchVideo
create trigger tr_mv_LastUpdated on MatchVideo after insert, update
as
begin
	set nocount on
    update MatchVideo set lastUpdated = getdate() at time zone 'UTC' at time zone 'Central Standard Time' where id in (select i.id from inserted i);
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
-- Trigger to maintain last updated and scoreValue after insert/update of TeamMatchObjective
create trigger tr_tmo_CalcScoreValue on TeamMatchObjective after insert, update
as
begin
	set nocount on
    update TeamMatchObjective
	   set scoreValue = (select dbo.calcScoreValue(i.objectiveId, i.integerValue, i.decimalValue)
	                       from inserted i
						  where i.id = TeamMatchObjective.id)
		 , lastUpdated = getDate() at time zone 'UTC' at time zone 'Central Standard Time'
	 where TeamMatchObjective.id in (select i.id from inserted i);
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
 
create view v_GameEvent as
select ge.id
     , ge.eventId
	 , ge.gameId
	 , ge.eventDate
	 , (select coalesce(max(case when s2.id is null then 'N' else 'Y' end), 'N')
	      from Team t2
		       inner join Scout s2
			   on s2.teamId = t2.id
		 where s2.emailAddress = s.emailAddress
		   and t2.gameEventId = ge.id) isActive
	 , ge.lastUpdated
	 , s.emailAddress loginEmailAddress
	 , s.scoutGUID loginGUID
  from GameEvent ge
	   left outer join Team t
	   on t.gameEventId = ge.id
	   left outer join Scout s
       on s.teamId = t.id
go

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
     , case when subquery.matchCode is not null
	        then '<a href="https://www.thebluealliance.com/match/' + subquery.matchCode + '" target="_blank">tba</a>'
			else '' end +
	   case when 
			   (select ', <a href="' + case when mv.videoType = 'youtube' then 'https://youtu.be/' else mv.videoType end + trim(mv.videoKey) + '" target="_blank">v</a>' AS 'data()'
				  from MatchVideo mv
				 where mv.matchId = subquery.matchId
				 FOR XML PATH('')) is not null
			then ', ' +
			   replace(replace(substring(
			   (select ', <a href="' + case when mv.videoType = 'youtube' then 'https://youtu.be/' else mv.videoType end + trim(mv.videoKey) + '" target="_blank">v</a>' AS 'data()'
				  from MatchVideo mv
				 where mv.matchId = subquery.matchId
				 FOR XML PATH('')), 3 , 9999), '&lt;', '<'), '&gt;', '>')
			else '' end videos
     , subquery.r1TeamId
     , subquery.r2TeamId
     , subquery.r3TeamId
     , subquery.b1TeamId
     , subquery.b2TeamId
     , subquery.b3TeamId
	 , case when isnumeric(subquery.number) = 1
	        then convert(numeric, subquery.number)
			else 1000 end matchSort
	 , subquery.loginGUID
  from (
select case when convert(decimal(18,10), (m.datetime - convert(datetime, SYSDATETIMEOFFSET() AT TIME ZONE 'Central Standard Time'))) + (6.0 / 24.0 / 60.0) < 0 then 1 else 0 end sortOrder
     , m.type + ' ' + m.number matchNumber
     , m.id matchId
	 , m.number
	 , m.datetime
	 , m.redScore
	 , m.blueScore
	 , m.matchCode
	 , max(case when tm.alliance = 'R' and tm.alliancePosition = 1 then t.teamNumber else null end) r1TeamNumber
	 , max(case when tm.alliance = 'R' and tm.alliancePosition = 1 then t.id else null end) r1TeamId
	 , case when sum(case when tm.alliance = 'R' and tm.alliancePosition = 1 and sr.id is not null and s.lastName <> 'TBA' then 1 else 0 end) = 0 then 'S' else 'a' end r1ScoutIndicator
	 , max(case when tm.alliance = 'R' and tm.alliancePosition = 2 then t.teamNumber else null end) r2TeamNumber
	 , max(case when tm.alliance = 'R' and tm.alliancePosition = 2 then t.id else null end) r2TeamId
	 , case when sum(case when tm.alliance = 'R' and tm.alliancePosition = 2 and sr.id is not null and s.lastName <> 'TBA' then 1 else 0 end) = 0 then 'S' else 'a' end r2ScoutIndicator
	 , max(case when tm.alliance = 'R' and tm.alliancePosition = 3 then t.teamNumber else null end) r3TeamNumber
	 , max(case when tm.alliance = 'R' and tm.alliancePosition = 3 then t.id else null end) r3TeamId
	 , case when sum(case when tm.alliance = 'R' and tm.alliancePosition = 3 and sr.id is not null and s.lastName <> 'TBA' then 1 else 0 end) = 0 then 'S' else 'a' end r3ScoutIndicator
	 , max(case when tm.alliance = 'B' and tm.alliancePosition = 1 then t.teamNumber else null end) b1TeamNumber
	 , max(case when tm.alliance = 'B' and tm.alliancePosition = 1 then t.id else null end) b1TeamId
	 , case when sum(case when tm.alliance = 'B' and tm.alliancePosition = 1 and sr.id is not null and s.lastName <> 'TBA' then 1 else 0 end) = 0 then 'S' else 'a' end b1ScoutIndicator
	 , max(case when tm.alliance = 'B' and tm.alliancePosition = 2 then t.teamNumber else null end) b2TeamNumber
	 , max(case when tm.alliance = 'B' and tm.alliancePosition = 2 then t.id else null end) b2TeamId
	 , case when sum(case when tm.alliance = 'B' and tm.alliancePosition = 2 and sr.id is not null and s.lastName <> 'TBA' then 1 else 0 end) = 0 then 'S' else 'a' end b2ScoutIndicator
	 , max(case when tm.alliance = 'B' and tm.alliancePosition = 3 then t.teamNumber else null end) b3TeamNumber
	 , max(case when tm.alliance = 'B' and tm.alliancePosition = 3 then t.id else null end) b3TeamId
	 , case when sum(case when tm.alliance = 'B' and tm.alliancePosition = 3 and sr.id is not null and s.lastName <> 'TBA' then 1 else 0 end) = 0 then 'S' else 'a' end b3ScoutIndicator
	 , ge.loginGUID
  from Match m
       inner join v_GameEvent ge
	   on ge.id = m.gameEventId
	   left outer join TeamMatch tm
	   on tm.matchId = m.id
	   left outer join Team t
	   on t.id = tm.teamId
	   left outer join ScoutRecord sr
	   on sr.matchId = tm.matchId
	   and sr.teamId = tm.teamId
	   left outer join Scout s
	   on s.id = sr.scoutId
 where m.isActive = 'Y'
group by m.type
       , m.id
	   , m.number
	   , m.datetime
	   , m.redScore
	   , m.blueScore
	   , m.matchCode
	   , ge.loginGUID
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
	 , ge.loginGUID
  from Team t 
       inner join TeamGameEvent tge 
       on tge.teamId = t.id
       inner join v_GameEvent ge 
       on ge.id = tge.gameEventId
go

create view v_RankButtons as
select distinct
       '<div id="reportsby"><a class="clickme danger" href="Reports/rankReport.php?sortOrder=' + r.queryString + '&rankName=' + r.name + '">Rank by ' + r.name + ' </a></div>' buttonHtml
	 , r.name
	 , r.queryString
     , r.sortOrder
     , ge.loginGUID
  from Rank r
       inner join RankObjective ro
	   on ro.rankId = r.id
	   inner join Objective o
	   on o.id = ro.objectiveId
	   inner join Game g
	   on g.id = o.gameId
	   inner join v_GameEvent ge
	   on ge.gameId = g.id
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
	 , case when og.sortOrder = 1 then '' else '<br><br>' end + '<b><u>' + og.name + '</u>' scoutRecordHtml
	 , ge.loginGUID
  from objectiveGroup og
       inner join objectiveGroupObjective ogo
	   on ogo.objectiveGroupId = og.id
       inner join objective o
	   on o.id = ogo.objectiveId
	   inner join game g
	   on g.id = o.gameId
	   inner join v_GameEvent ge
	   on ge.gameId = g.id
 where og.groupCode = 'Scout Match'
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
	 , case when st.hasValueList = 'N' and st.name = 'Free Form'
	        then '<br><br>' + o.label + '<br><input type="text" name ="value' + convert(varchar, o.sortOrder) + '" style="width: 320px"><br>'
			when st.hasValueList = 'N'
	        then case when o.sameLineAsPrevious = 'Y'
			          then '&nbsp;&nbsp;'
					  else case when o.sortOrder = 
					                (select min(o2.sortOrder)
                                       from Objective o2
		                                    inner join ObjectiveGroupObjective ogo2
			                                on ogo2.objectiveId = o2.id
			                                inner join ObjectiveGroup og2
			                                on og2.id = ogo2.objectiveGroupId
		                              where og2.groupCode = 'Scout Match'
									    and o2.gameId = o.gameId
		                                and og2.id = og.id)
								then '<br>'
								else '<br><br>' end end + o.label + '<input type="number" name ="value' + convert(varchar, o.sortOrder) + '" value=0 style="width: 40px;">'
			when ov.sortOrder = 1
	        then case when o.sortOrder = 
					      (select min(o2.sortOrder)
                             from Objective o2
		                          inner join ObjectiveGroupObjective ogo2
			                      on ogo2.objectiveId = o2.id
			                      inner join ObjectiveGroup og2
			                      on og2.id = ogo2.objectiveGroupId
		                    where og2.groupCode = 'Scout Match'
							  and o2.gameId = o.gameId
		                      and og2.id = og.id)
						then '<br>'
						else '<br><br>' end + o.label + '<br>&nbsp;&nbsp;&nbsp;&nbsp;' + ov.displayValue + '<input type="radio" checked="checked" name ="value' + convert(varchar, o.sortOrder) + '" value=' + convert(varchar, ov.integerValue) + '>'
			else case when ov.sameLineAsPrevious = 'Y' then '&nbsp;&nbsp;&nbsp;' else '<br>&nbsp;&nbsp;&nbsp;&nbsp;' end + ov.displayValue + '<input type="radio" name ="value' + convert(varchar, o.sortOrder) + '" value=' + convert(varchar, ov.integerValue) + '>' end scoutRecordHtml
     , ge.loginGUID
  from objectiveGroup og
       inner join objectiveGroupObjective ogo
	   on ogo.objectiveGroupId = og.id
       inner join objective o
	   on o.id = ogo.objectiveId
	   inner join scoringType st
	   on st.id = o.scoringTypeId
	   inner join game g
	   on g.id = o.gameId
	   inner join v_GameEvent ge
	   on ge.gameId = g.id
	   left outer join objectiveValue ov
	   on ov.objectiveId = o.id
 where og.groupCode = 'Scout Match'
--order by groupSort, objectiveSort, objectiveValueSort
go

-- View to get HTML for update of Scout Record
create view v_UpdateScoutRecordHTML as
select distinct
       og.name groupName
     , null objectiveName      
	 , null objectiveLabel
	 , null displayValue
	 , null integerValue
     , og.sortOrder groupSort
	 , null objectiveSort
	 , null objectiveValueSort
	 , case when og.sortOrder = 1 then '' else '<br><br>' end + '<b><u>' + og.name + '</u>' scoutRecordHtml
	 , sr.id scoutRecordId
	 , ge.loginGUID
  from objectiveGroup og
       inner join objectiveGroupObjective ogo
	   on ogo.objectiveGroupId = og.id
       inner join objective o
	   on o.id = ogo.objectiveId
	   inner join game g
	   on g.id = o.gameId
	   inner join v_GameEvent ge
	   on ge.gameId = g.id,
	   ScoutRecord sr
 where og.groupCode = 'Scout Match'
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
	 , case when st.hasValueList = 'N' and st.name = 'Free Form'
	        then '<br><br>' + o.label + '<br><input type="text" name ="value' + convert(varchar, o.sortOrder) + '" placeholder="' +
			     coalesce(sor.textValue, '') + '" style="width: 320px"><br>'
	        when st.hasValueList = 'N'
	        then case when o.sameLineAsPrevious = 'Y'
			          then '&nbsp;&nbsp;'
					  else case when o.sortOrder = 
					                (select min(o2.sortOrder)
                                       from Objective o2
		                                    inner join ObjectiveGroupObjective ogo2
			                                on ogo2.objectiveId = o2.id
			                                inner join ObjectiveGroup og2
			                                on og2.id = ogo2.objectiveGroupId
		                              where og2.groupCode = 'Scout Match'
									    and o2.gameId = o.gameId
		                                and og2.id = og.id)
								then '<br>'
								else '<br><br>' end end +
				 o.label + '<input type="number" name ="value' + convert(varchar, o.sortOrder) +
				 '" value=' + convert(varchar, coalesce(sor.integerValue, 0)) + ' style="width: 40px;">'
			when ov.sortOrder = 1
	        then case when o.sortOrder = 
					      (select min(o2.sortOrder)
                             from Objective o2
		                          inner join ObjectiveGroupObjective ogo2
			                      on ogo2.objectiveId = o2.id
			                      inner join ObjectiveGroup og2
			                      on og2.id = ogo2.objectiveGroupId
		                    where og2.groupCode = 'Scout Match'
							  and o2.gameId = o.gameId
		                      and og2.id = og.id)
						then '<br>'
						else '<br><br>' end +
				 o.label + '<br>&nbsp;&nbsp;&nbsp;&nbsp;' + ov.displayValue +
				 '<input type="radio" ' +
				 case when coalesce(sor.integerValue, ov.integerValue) = ov.integerValue
				      then 'checked="checked" '
					  else '' end +
				 'name ="value' + convert(varchar, o.sortOrder) +
				 '" value=' + convert(varchar, ov.integerValue) + '>'
			else case when ov.sameLineAsPrevious = 'Y'
			          then '&nbsp;&nbsp;&nbsp;'
					  else '<br>&nbsp;&nbsp;&nbsp;&nbsp;' end + ov.displayValue +
				 '<input type="radio" ' +
				 case when coalesce(sor.integerValue, -99) = ov.integerValue
				      then 'checked="checked" '
					  else '' end +
				 'name ="value' + convert(varchar, o.sortOrder) +
				 '" value=' + convert(varchar, ov.integerValue) + '>' end scoutRecordHtml
	 , sor.scoutRecordId
	 , ge.loginGUID
  from objectiveGroup og
       inner join objectiveGroupObjective ogo
	   on ogo.objectiveGroupId = og.id
       inner join objective o
	   on o.id = ogo.objectiveId
	   inner join scoringType st
	   on st.id = o.scoringTypeId
	   inner join ScoutObjectiveRecord sor
	   on sor.objectiveId = o.id
	   inner join game g
	   on g.id = o.gameId
	   inner join v_GameEvent ge
	   on ge.gameId = g.id
	   left outer join objectiveValue ov
	   on ov.objectiveId = o.id
 where og.groupCode = 'Scout Match'
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
	        then case when a.sameLineAsPrevious = 'Y' then '' else '<br>' end + a.label + '<input type="number" name ="value' + convert(varchar, a.sortOrder) + '" value=' +
			coalesce((select convert(varchar, ta.integerValue) from teamAttribute ta where ta.teamId = t.id and ta.attributeId = a.id), '0') +
			' style="width: 50px;">' + case when a.sameLineAsPrevious = 'Y' then '' else '<br>' end
			when av.sortOrder = 1
	        then '<br>' + a.label + '<br>&nbsp;&nbsp;&nbsp;&nbsp;' + av.displayValue + '<input type="radio" ' +
			coalesce((select case when ta.integerValue = av.integerValue then 'checked="checked"' else '' end from teamAttribute ta where ta.teamId = t.id and ta.attributeId = a.id), 'checked="checked"') +
			' name ="value' + convert(varchar, a.sortOrder) + '" value=' + convert(varchar, av.integerValue) + '><br>'
			else                        '&nbsp;&nbsp;&nbsp;&nbsp;' + av.displayValue + '<input type="radio" ' +
			coalesce((select case when ta.integerValue = av.integerValue then 'checked="checked"' else '' end from teamAttribute ta where ta.teamId = t.id and ta.attributeId = a.id), '') +
			' name ="value' + convert(varchar, a.sortOrder) + '" value=' + convert(varchar, av.integerValue) + '><br>' end scoutTeamHtml
	 , t.id teamId
	 , t.teamNumber
	 , ge.loginGUID
  from attribute a
	   inner join scoringType st
	   on st.id = a.scoringTypeId
	   left outer join attributeValue av
	   on av.attributeId = a.id,
	   team t
	   inner join TeamGameEvent tge
	   on tge.teamId = t.id
	   inner join v_GameEvent ge
	   on ge.id = tge.gameEventId
 where a.gameId = ge.gameId
--order by attributeSort, attributeValueSort
go

-- View for Scout Record
create view v_ScoutRecord as
select sr.id scoutRecordId
     , sr.matchId
     , sr.teamId
	 , sr.scoutId
	 , sr.scoutComment
	 , m.gameEventId
	 , sum(case when o.sortOrder = 1 and o.reportDisplay = 'S'
	            then sor.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 1 and o.reportDisplay = 'I'
				then sor.integerValue
	            else null end) value1
	 , sum(case when o.sortOrder = 2 and o.reportDisplay = 'S'
	            then sor.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 2 and o.reportDisplay = 'I'
				then sor.integerValue
	            else null end) value2
	 , sum(case when o.sortOrder = 3 and o.reportDisplay = 'S'
	            then sor.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 3 and o.reportDisplay = 'I'
				then sor.integerValue
	            else null end) value3
	 , sum(case when o.sortOrder = 4 and o.reportDisplay = 'S'
	            then sor.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 4 and o.reportDisplay = 'I'
				then sor.integerValue
	            else null end) value4
	 , sum(case when o.sortOrder = 5 and o.reportDisplay = 'S'
	            then sor.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 5 and o.reportDisplay = 'I'
				then sor.integerValue
	            else null end) value5
	 , sum(case when o.sortOrder = 6 and o.reportDisplay = 'S'
	            then sor.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 6 and o.reportDisplay = 'I'
				then sor.integerValue
	            else null end) value6
	 , sum(case when o.sortOrder = 7 and o.reportDisplay = 'S'
	            then sor.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 7 and o.reportDisplay = 'I'
				then sor.integerValue
	            else null end) value7
	 , sum(case when o.sortOrder = 8 and o.reportDisplay = 'S'
	            then sor.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 8 and o.reportDisplay = 'I'
				then sor.integerValue
	            else null end) value8
	 , sum(case when o.sortOrder = 9 and o.reportDisplay = 'S'
	            then sor.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 9 and o.reportDisplay = 'I'
				then sor.integerValue
	            else null end) value9
	 , sum(case when o.sortOrder = 10 and o.reportDisplay = 'S'
	            then sor.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 10 and o.reportDisplay = 'I'
				then sor.integerValue
	            else null end) value10
	 , sum(case when o.sortOrder = 11 and o.reportDisplay = 'S'
	            then sor.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 11 and o.reportDisplay = 'I'
				then sor.integerValue
	            else null end) value11
	 , sum(case when o.sortOrder = 12 and o.reportDisplay = 'S'
	            then sor.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 12 and o.reportDisplay = 'I'
				then sor.integerValue
	            else null end) value12
	 , sum(case when o.sortOrder = 13 and o.reportDisplay = 'S'
	            then sor.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 13 and o.reportDisplay = 'I'
				then sor.integerValue
	            else null end) value13
	 , sum(case when o.sortOrder = 14 and o.reportDisplay = 'S'
	            then sor.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 14 and o.reportDisplay = 'I'
				then sor.integerValue
	            else null end) value14
	 , sum(case when o.sortOrder = 15 and o.reportDisplay = 'S'
	            then sor.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 15 and o.reportDisplay = 'I'
				then sor.integerValue
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
	 , sum(case when o.sortOrder = 1
	            then sor.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue1
	 , sum(case when o.sortOrder = 2  
	            then sor.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue2
	 , sum(case when o.sortOrder = 3 
	            then sor.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue3
	 , sum(case when o.sortOrder = 4 
	            then sor.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue4
	 , sum(case when o.sortOrder = 5 
	            then sor.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue5
	 , sum(case when o.sortOrder = 6 
	            then sor.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue6
	 , sum(case when o.sortOrder = 7 
	            then sor.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue7
	 , sum(case when o.sortOrder = 8 
	            then sor.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue8
	 , sum(case when o.sortOrder = 9 
	            then sor.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue9
	 , sum(case when o.sortOrder = 10 
	            then sor.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue10
	 , sum(case when o.sortOrder = 11 
	            then sor.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue11
	 , sum(case when o.sortOrder = 12 
	            then sor.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue12
	 , sum(case when o.sortOrder = 13 
	            then sor.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue13
	 , sum(case when o.sortOrder = 14 
	            then sor.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue14
	 , sum(case when o.sortOrder = 15 
	            then sor.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue15
	 , max(case when o.sortOrder = 1 then sor.textValue else null end) textValue1
	 , max(case when o.sortOrder = 2 then sor.textValue else null end) textValue2
	 , max(case when o.sortOrder = 3 then sor.textValue else null end) textValue3
	 , max(case when o.sortOrder = 4 then sor.textValue else null end) textValue4
	 , max(case when o.sortOrder = 5 then sor.textValue else null end) textValue5
	 , max(case when o.sortOrder = 6 then sor.textValue else null end) textValue6
	 , max(case when o.sortOrder = 7 then sor.textValue else null end) textValue7
	 , max(case when o.sortOrder = 8 then sor.textValue else null end) textValue8
	 , max(case when o.sortOrder = 9 then sor.textValue else null end) textValue9
	 , max(case when o.sortOrder = 10 then sor.textValue else null end) textValue10
	 , max(case when o.sortOrder = 11 then sor.textValue else null end) textValue11
	 , max(case when o.sortOrder = 12 then sor.textValue else null end) textValue12
	 , max(case when o.sortOrder = 13 then sor.textValue else null end) textValue13
	 , max(case when o.sortOrder = 14 then sor.textValue else null end) textValue14
	 , max(case when o.sortOrder = 15 then sor.textValue else null end) textValue15
	 , sum(case when o.sortOrder = 1 then o.id else null end) objectiveId1
	 , sum(case when o.sortOrder = 2 then o.id else null end) objectiveId2
	 , sum(case when o.sortOrder = 3 then o.id else null end) objectiveId3
	 , sum(case when o.sortOrder = 4 then o.id else null end) objectiveId4
	 , sum(case when o.sortOrder = 5 then o.id else null end) objectiveId5
	 , sum(case when o.sortOrder = 6 then o.id else null end) objectiveId6
	 , sum(case when o.sortOrder = 7 then o.id else null end) objectiveId7
	 , sum(case when o.sortOrder = 8 then o.id else null end) objectiveId8
	 , sum(case when o.sortOrder = 9 then o.id else null end) objectiveId9
	 , sum(case when o.sortOrder = 10 then o.id else null end) objectiveId10
	 , sum(case when o.sortOrder = 11 then o.id else null end) objectiveId11
	 , sum(case when o.sortOrder = 12 then o.id else null end) objectiveId12
	 , sum(case when o.sortOrder = 13 then o.id else null end) objectiveId13
	 , sum(case when o.sortOrder = 14 then o.id else null end) objectiveId14
	 , sum(case when o.sortOrder = 15 then o.id else null end) objectiveId15
	 , max(case when o.sortOrder = 1 then st.name else null end) scoringTypeName1
	 , max(case when o.sortOrder = 2 then st.name else null end) scoringTypeName2
	 , max(case when o.sortOrder = 3 then st.name else null end) scoringTypeName3
	 , max(case when o.sortOrder = 4 then st.name else null end) scoringTypeName4
	 , max(case when o.sortOrder = 5 then st.name else null end) scoringTypeName5
	 , max(case when o.sortOrder = 6 then st.name else null end) scoringTypeName6
	 , max(case when o.sortOrder = 7 then st.name else null end) scoringTypeName7
	 , max(case when o.sortOrder = 8 then st.name else null end) scoringTypeName8
	 , max(case when o.sortOrder = 9 then st.name else null end) scoringTypeName9
	 , max(case when o.sortOrder = 10 then st.name else null end) scoringTypeName10
	 , max(case when o.sortOrder = 11 then st.name else null end) scoringTypeName11
	 , max(case when o.sortOrder = 12 then st.name else null end) scoringTypeName12
	 , max(case when o.sortOrder = 13 then st.name else null end) scoringTypeName13
	 , max(case when o.sortOrder = 14 then st.name else null end) scoringTypeName14
	 , max(case when o.sortOrder = 15 then st.name else null end) scoringTypeName15
	 , ge.loginGUID
  from ScoutRecord sr
       inner join Match m
	   on m.id = sr.matchId
	   inner join v_GameEvent ge
	   on ge.id = m.gameEventId
	   inner join Objective o
	   on o.gameId = ge.gameId
	   inner join ScoringType st
	   on st.id = o.scoringTypeId
	   inner join TeamMatch tm
	   on tm.matchId = sr.matchId
	   and tm.teamId = sr.teamId
	   left outer join ScoutObjectiveRecord sor
	   on sor.scoutRecordId = sr.id
	   and sor.objectiveId = o.id
 where m.isActive = 'Y'
group by sr.id
       , sr.matchId
       , sr.teamId
	   , sr.scoutId
	   , sr.scoutComment
	   , m.gameEventId
	   , ge.loginGUID
GO

-- View for average Team report on a match
create view v_AvgScoutRecord as
select sr.matchId
     , sr.teamId
	 , sr.gameEventId
     , count(*) cnt
     , avg(convert(numeric(11,3), sr.value1)) value1
     , avg(convert(numeric(11,3), sr.value2)) value2
     , avg(convert(numeric(11,3), sr.value3)) value3
     , avg(convert(numeric(11,3), sr.value4)) value4
     , avg(convert(numeric(11,3), sr.value5)) value5 
     , avg(convert(numeric(11,3), sr.value6)) value6
     , avg(convert(numeric(11,3), sr.value7)) value7
     , avg(convert(numeric(11,3), sr.value8)) value8
     , avg(convert(numeric(11,3), sr.value9)) value9
     , avg(convert(numeric(11,3), sr.value10)) value10
     , avg(convert(numeric(11,3), sr.value11)) value11
     , avg(convert(numeric(11,3), sr.value12)) value12
     , avg(convert(numeric(11,3), sr.value13)) value13
     , avg(convert(numeric(11,3), sr.value14)) value14
     , avg(convert(numeric(11,3), sr.value15)) value15 
     , avg(convert(numeric, sr.integerValue1)) integerValue1
     , avg(convert(numeric, sr.integerValue2)) integerValue2
     , avg(convert(numeric, sr.integerValue3)) integerValue3
     , avg(convert(numeric, sr.integerValue4)) integerValue4
     , avg(convert(numeric, sr.integerValue5)) integerValue5 
     , avg(convert(numeric, sr.integerValue6)) integerValue6
     , avg(convert(numeric, sr.integerValue7)) integerValue7
     , avg(convert(numeric, sr.integerValue8)) integerValue8
     , avg(convert(numeric, sr.integerValue9)) integerValue9
     , avg(convert(numeric, sr.integerValue10)) integerValue10
     , avg(convert(numeric, sr.integerValue11)) integerValue11
     , avg(convert(numeric, sr.integerValue12)) integerValue12
     , avg(convert(numeric, sr.integerValue13)) integerValue13
     , avg(convert(numeric, sr.integerValue14)) integerValue14
     , avg(convert(numeric, sr.integerValue15)) integerValue15 
     , avg(convert(numeric(11,3), sr.scoreValue1)) scoreValue1
     , avg(convert(numeric(11,3), sr.scoreValue2)) scoreValue2
     , avg(convert(numeric(11,3), sr.scoreValue3)) scoreValue3
     , avg(convert(numeric(11,3), sr.scoreValue4)) scoreValue4
     , avg(convert(numeric(11,3), sr.scoreValue5)) scoreValue5 
     , avg(convert(numeric(11,3), sr.scoreValue6)) scoreValue6
     , avg(convert(numeric(11,3), sr.scoreValue7)) scoreValue7
     , avg(convert(numeric(11,3), sr.scoreValue8)) scoreValue8
     , avg(convert(numeric(11,3), sr.scoreValue9)) scoreValue9
     , avg(convert(numeric(11,3), sr.scoreValue10)) scoreValue10
     , avg(convert(numeric(11,3), sr.scoreValue11)) scoreValue11
     , avg(convert(numeric(11,3), sr.scoreValue12)) scoreValue12
     , avg(convert(numeric(11,3), sr.scoreValue13)) scoreValue13
     , avg(convert(numeric(11,3), sr.scoreValue14)) scoreValue14
     , avg(convert(numeric(11,3), sr.scoreValue15)) scoreValue15 
     , avg(convert(integer, objectiveId1)) objectiveId1
     , avg(convert(integer, objectiveId2)) objectiveId2
     , avg(convert(integer, objectiveId3)) objectiveId3
     , avg(convert(integer, objectiveId4)) objectiveId4
     , avg(convert(integer, objectiveId5)) objectiveId5 
     , avg(convert(integer, objectiveId6)) objectiveId6
     , avg(convert(integer, objectiveId7)) objectiveId7
     , avg(convert(integer, objectiveId8)) objectiveId8
     , avg(convert(integer, objectiveId9)) objectiveId9
     , avg(convert(integer, objectiveId10)) objectiveId10
     , avg(convert(integer, objectiveId11)) objectiveId11
     , avg(convert(integer, objectiveId12)) objectiveId12
     , avg(convert(integer, objectiveId13)) objectiveId13
     , avg(convert(integer, objectiveId14)) objectiveId14
     , avg(convert(integer, objectiveId15)) objectiveId15
	 , max(scoringTypeName1) scoringTypeName1
	 , max(scoringTypeName2) scoringTypeName2
	 , max(scoringTypeName3) scoringTypeName3
	 , max(scoringTypeName4) scoringTypeName4
	 , max(scoringTypeName5) scoringTypeName5
	 , max(scoringTypeName6) scoringTypeName6
	 , max(scoringTypeName7) scoringTypeName7
	 , max(scoringTypeName8) scoringTypeName8
	 , max(scoringTypeName9) scoringTypeName9
	 , max(scoringTypeName10) scoringTypeName10
	 , max(scoringTypeName11) scoringTypeName11
	 , max(scoringTypeName12) scoringTypeName12
	 , max(scoringTypeName13) scoringTypeName13
	 , max(scoringTypeName14) scoringTypeName14
	 , max(scoringTypeName15) scoringTypeName15
	 , sr.loginGUID
  from v_ScoutRecord sr
group by sr.matchId
       , sr.TeamId
	   , sr.gameEventId
	   , sr.loginGUID;
go

create view v_AvgScoutObjectiveRecord as
select sr.teamId
	 , sr.matchId
     , m.isActive matchIsActive
	 , m.gameEventId
	 , ge.isActive gameEventIsActive
	 , sor.objectiveId
	 , o.name objectiveName
	 , o.addTeamScorePortion
	 , avg(sor.integerValue) avgIntegerValue
	 , min(sor.integerValue) minIntegerValue
	 , max(sor.integerValue) maxIntegerValue
	 , avg(sor.scoreValue) avgScoreValue
	 , min(sor.scoreValue) minScoreValue
	 , max(sor.scoreValue) maxScoreValue
	 , count(*) cntScoutRecord
  from ScoutRecord sr
       inner join ScoutObjectiveRecord sor
	   on sor.scoutRecordId = sr.id
	   inner join Objective o
	   on o.id = sor.objectiveId
	   inner join Match m
	   on m.id = sr.matchId
	   inner join v_GameEvent ge
	   on ge.id = m.gameEventId
group by sr.teamId
	   , sr.matchId
       , m.isActive
	   , m.gameEventId
	   , ge.isActive
	   , sor.objectiveId
	   , o.name
	   , o.addTeamScorePortion;
go

-- View for match averages
create view v_MatchReport as
-- Team Average Scores
select m.type + ' ' + m.number matchNumber
     , tm.matchId
     , tm.teamId
     , t.TeamNumber
	 , t.teamName
     , case when tm.alliance = 'R' then 'Red'
	        when tm.alliance = 'B' then 'Blue'
	        else tm.alliance end alliance
     , tm.alliancePosition
     , '<a href="../Reports/robotReport.php?TeamId=' + convert(varchar, tm.teamId) + '"> ' + convert(varchar, t.teamNumber) + '</a> ' teamReportUrl
     , sum(case when asr.TeamId is null then 0 else 1 end) matchCnt
	 , case when tm.alliance = 'R' then 1
	        when tm.alliance = 'B' then 3
	        else 2 end allianceSort
     , round(avg(asr.value1),2) value1
     , round(avg(asr.value2),2) value2
     , round(avg(asr.value3),2) value3
     , round(avg(asr.value4),2) value4
     , round(avg(asr.value5),2) value5
     , round(avg(asr.value6),2) value6
     , round(avg(asr.value7),2) value7
     , round(avg(asr.value8),2) value8
     , round(avg(asr.value9),2) value9
     , round(avg(asr.value10),2) value10
     , round(avg(asr.value11),2) value11
     , round(avg(asr.value12),2) value12
     , round(avg(asr.value13),2) value13
     , round(avg(asr.value14),2) value14
     , round(avg(asr.value15),2) value15
	 , round(avg(coalesce(asr.scoreValue1,0) +
	             coalesce(asr.scoreValue2,0) +
	             coalesce(asr.scoreValue3,0) +
	             coalesce(asr.scoreValue4,0) +
	             coalesce(asr.scoreValue5,0) +
	             coalesce(asr.scoreValue6,0) +
	             coalesce(asr.scoreValue7,0) +
	             coalesce(asr.scoreValue8,0) +
	             coalesce(asr.scoreValue9,0) +
	             coalesce(asr.scoreValue10,0) +
	             coalesce(asr.scoreValue11,0) +
	             coalesce(asr.scoreValue12,0) +
	             coalesce(asr.scoreValue13,0) +
	             coalesce(asr.scoreValue14,0) +
	             coalesce(asr.scoreValue15,0)), 2) totalScoreValue
	 , ge.loginGUID
  from Match m
	   inner join v_GameEvent ge
	   on ge.id = m.gameEventId
       inner join TeamMatch tm
       on tm.matchId = m.id
       inner join Team t
       on t.id = tm.teamId
       left outer join v_AvgScoutRecord asr
       on asr.TeamId = tm.teamId
       and exists (select 1
                     from match m2
                    where m2.id = asr.matchId
                      and m2.isActive = 'Y')
 where m.isActive = 'Y'
group by m.type + ' ' + m.number
       , tm.matchId
       , tm.teamId
       , t.TeamNumber
       , t.teamName
	   , tm.alliance
       , tm.alliancePosition
	   , ge.loginGUID
union
-- Alliance Average Scores
select subquery.matchNumber
     , subquery.matchId
     , null teamId
	 , null TeamNumber
	 , null teamName
	 , subquery.alliance
	 , 99 alliancePosition
	 , null teamReportUrl
	 , null matchCount
	 , subquery.allianceSort
	 , sum(subquery.value1) value1
	 , sum(subquery.value2) value2
	 , sum(subquery.value3) value3
	 , sum(subquery.value4) value4
	 , sum(subquery.value5) value5
	 , sum(subquery.value6) value6
	 , sum(subquery.value7) value7
	 , sum(subquery.value8) value8
	 , sum(subquery.value9) value9
	 , sum(subquery.value10) value10
	 , sum(subquery.value11) value11
	 , sum(subquery.value12) value12
	 , sum(subquery.value13) value13
	 , sum(subquery.value14) value14
	 , sum(subquery.value15) value15
	 , sum(subquery.totalScoreValue) totalScoreValue
	 , subquery.loginGUID
  from (
select m.type + ' ' + m.number matchNumber
     , tm.matchId
     , tm.teamId
     , t.TeamNumber
     , t.teamName
     , case when tm.alliance = 'R' then 'Red'
	        when tm.alliance = 'B' then 'Blue'
	        else tm.alliance end alliance
     , tm.alliancePosition
     , '<a href="../Reports/robotReport.php?TeamId=' + convert(varchar, tm.teamId) + '"> ' + convert(varchar, t.teamNumber) + '</a> ' teamReportUrl
     , sum(case when asr.TeamId is null then 0 else 1 end) matchCnt
	 , case when tm.alliance = 'R' then 1
	        when tm.alliance = 'B' then 3
	        else 2 end allianceSort
     , round(avg(asr.value1),2) value1
     , round(avg(asr.value2),2) value2
     , round(avg(asr.value3),2) value3
     , round(avg(asr.value4),2) value4
     , round(avg(asr.value5),2) value5
     , round(avg(asr.value6),2) value6
     , round(avg(asr.value7),2) value7
     , round(avg(asr.value8),2) value8
     , round(avg(asr.value9),2) value9
     , round(avg(asr.value10),2) value10
     , round(avg(asr.value11),2) value11
     , round(avg(asr.value12),2) value12
     , round(avg(asr.value13),2) value13
     , round(avg(asr.value14),2) value14
     , round(avg(asr.value15),2) value15
	 , round(avg(coalesce(asr.scoreValue1,0) +
	             coalesce(asr.scoreValue2,0) +
	             coalesce(asr.scoreValue3,0) +
	             coalesce(asr.scoreValue4,0) +
	             coalesce(asr.scoreValue5,0) +
	             coalesce(asr.scoreValue6,0) +
	             coalesce(asr.scoreValue7,0) +
	             coalesce(asr.scoreValue8,0) +
	             coalesce(asr.scoreValue9,0) +
	             coalesce(asr.scoreValue10,0) +
	             coalesce(asr.scoreValue11,0) +
	             coalesce(asr.scoreValue12,0) +
	             coalesce(asr.scoreValue13,0) +
	             coalesce(asr.scoreValue14,0) +
	             coalesce(asr.scoreValue15,0)), 2) totalScoreValue
	 , ge.loginGUID
  from Match m
	   inner join v_GameEvent ge
	   on ge.id = m.gameEventId
       inner join TeamMatch tm
       on tm.matchId = m.id
       inner join Team t
       on t.id = tm.teamId
       left outer join v_AvgScoutRecord asr
       on asr.TeamId = tm.teamId
       and exists (select 1
                     from match m2
                    where m2.id = asr.matchId
                      and m2.isActive = 'Y')
 where m.isActive = 'Y'
group by m.type + ' ' + m.number
       , tm.matchId
       , tm.teamId
       , t.TeamNumber
       , t.teamName
       , tm.alliance
       , tm.alliancePosition
       , ge.loginGUID) subquery
group by subquery.matchNumber
       , subquery.matchId
	   , subquery.alliance
	   , subquery.allianceSort
       , subquery.loginGUID
union
-- Divider needed in table between alliances
select m.type + ' ' + m.number matchNumber
     , m.id matchId
     , null teamId
     , null TeamNumber
     , null TeamName
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
	 , ge.loginGUID
  from Match m
	   inner join v_GameEvent ge
	   on ge.id = m.gameEventId
 where m.isActive = 'Y';
go

create view v_MatchActualScore as
select mo.alliance
     , mo.matchId
	 , mo.gameEventId
	 , coalesce(mo.value1, tmo.value1) value1
	 , coalesce(mo.value2, tmo.value2) value2
	 , coalesce(mo.value3, tmo.value3) value3
	 , coalesce(mo.value4, tmo.value4) value4
	 , coalesce(mo.value5, tmo.value5) value5
	 , coalesce(mo.value6, tmo.value6) value6
	 , coalesce(mo.value7, tmo.value7) value7
	 , coalesce(mo.value8, tmo.value8) value8
	 , coalesce(mo.value9, tmo.value9) value9
	 , coalesce(mo.value10, tmo.value10) value10
	 , coalesce(mo.value11, tmo.value11) value11
	 , coalesce(mo.value12, tmo.value12) value12
	 , coalesce(mo.value13, tmo.value13) value13
	 , coalesce(mo.value14, tmo.value14) value14
	 , coalesce(mo.value15, tmo.value15) value15
	 , coalesce(mo.integerValue1, tmo.integerValue1) integerValue1
	 , coalesce(mo.integerValue2, tmo.integerValue2) integerValue2
	 , coalesce(mo.integerValue3, tmo.integerValue3) integerValue3
	 , coalesce(mo.integerValue4, tmo.integerValue4) integerValue4
	 , coalesce(mo.integerValue5, tmo.integerValue5) integerValue5
	 , coalesce(mo.integerValue6, tmo.integerValue6) integerValue6
	 , coalesce(mo.integerValue7, tmo.integerValue7) integerValue7
	 , coalesce(mo.integerValue8, tmo.integerValue8) integerValue8
	 , coalesce(mo.integerValue9, tmo.integerValue9) integerValue9
	 , coalesce(mo.integerValue10, tmo.integerValue10) integerValue10
	 , coalesce(mo.integerValue11, tmo.integerValue11) integerValue11
	 , coalesce(mo.integerValue12, tmo.integerValue12) integerValue12
	 , coalesce(mo.integerValue13, tmo.integerValue13) integerValue13
	 , coalesce(mo.integerValue14, tmo.integerValue14) integerValue14
	 , coalesce(mo.integerValue15, tmo.integerValue15) integerValue15
	 , coalesce(mo.scoreValue1, tmo.scoreValue1) scoreValue1
	 , coalesce(mo.scoreValue2, tmo.scoreValue2) scoreValue2
	 , coalesce(mo.scoreValue3, tmo.scoreValue3) scoreValue3
	 , coalesce(mo.scoreValue4, tmo.scoreValue4) scoreValue4
	 , coalesce(mo.scoreValue5, tmo.scoreValue5) scoreValue5
	 , coalesce(mo.scoreValue6, tmo.scoreValue6) scoreValue6
	 , coalesce(mo.scoreValue7, tmo.scoreValue7) scoreValue7
	 , coalesce(mo.scoreValue8, tmo.scoreValue8) scoreValue8
	 , coalesce(mo.scoreValue9, tmo.scoreValue9) scoreValue9
	 , coalesce(mo.scoreValue10, tmo.scoreValue10) scoreValue10
	 , coalesce(mo.scoreValue11, tmo.scoreValue11) scoreValue11
	 , coalesce(mo.scoreValue12, tmo.scoreValue12) scoreValue12
	 , coalesce(mo.scoreValue13, tmo.scoreValue13) scoreValue13
	 , coalesce(mo.scoreValue14, tmo.scoreValue14) scoreValue14
	 , coalesce(mo.scoreValue15, tmo.scoreValue15) scoreValue15
	 , coalesce(mo.matchFoulPoints, tmo.matchFoulPoints) matchFoulPoints
	 , coalesce(mo.matchScore, tmo.matchScore) matchScore
	 , coalesce(mo.objectiveId1, tmo.objectiveId1) objectiveId1
	 , coalesce(mo.objectiveId2, tmo.objectiveId2) objectiveId2
	 , coalesce(mo.objectiveId3, tmo.objectiveId3) objectiveId3
	 , coalesce(mo.objectiveId4, tmo.objectiveId4) objectiveId4
	 , coalesce(mo.objectiveId5, tmo.objectiveId5) objectiveId5
	 , coalesce(mo.objectiveId6, tmo.objectiveId6) objectiveId6
	 , coalesce(mo.objectiveId7, tmo.objectiveId7) objectiveId7
	 , coalesce(mo.objectiveId8, tmo.objectiveId8) objectiveId8
	 , coalesce(mo.objectiveId9, tmo.objectiveId9) objectiveId9
	 , coalesce(mo.objectiveId10, tmo.objectiveId10) objectiveId10
	 , coalesce(mo.objectiveId11, tmo.objectiveId11) objectiveId11
	 , coalesce(mo.objectiveId12, tmo.objectiveId12) objectiveId12
	 , coalesce(mo.objectiveId13, tmo.objectiveId13) objectiveId13
	 , coalesce(mo.objectiveId14, tmo.objectiveId14) objectiveId14
	 , coalesce(mo.objectiveId15, tmo.objectiveId15) objectiveId15
	 , mo.loginGUID
  from (
select mo.alliance
     , mo.matchId
     , m.gameEventId
	 , sum(case when o.sortOrder = 1 and o.reportDisplay = 'S'
	            then mo.scoreValue
	            when o.sortOrder = 1 and o.reportDisplay = 'I'
				then mo.integerValue
	            else null end) value1
	 , sum(case when o.sortOrder = 2 and o.reportDisplay = 'S'
	            then mo.scoreValue
	            when o.sortOrder = 2 and o.reportDisplay = 'I'
				then mo.integerValue
	            else null end) value2
	 , sum(case when o.sortOrder = 3 and o.reportDisplay = 'S'
	            then mo.scoreValue
	            when o.sortOrder = 3 and o.reportDisplay = 'I'
				then mo.integerValue
	            else null end) value3
	 , sum(case when o.sortOrder = 4 and o.reportDisplay = 'S'
	            then mo.scoreValue
	            when o.sortOrder = 4 and o.reportDisplay = 'I'
				then mo.integerValue
	            else null end) value4
	 , sum(case when o.sortOrder = 5 and o.reportDisplay = 'S'
	            then mo.scoreValue
	            when o.sortOrder = 5 and o.reportDisplay = 'I'
				then mo.integerValue
	            else null end) value5
	 , sum(case when o.sortOrder = 6 and o.reportDisplay = 'S'
	            then mo.scoreValue
	            when o.sortOrder = 6 and o.reportDisplay = 'I'
				then mo.integerValue
	            else null end) value6
	 , sum(case when o.sortOrder = 7 and o.reportDisplay = 'S'
	            then mo.scoreValue
	            when o.sortOrder = 7 and o.reportDisplay = 'I'
				then mo.integerValue
	            else null end) value7
	 , sum(case when o.sortOrder = 8 and o.reportDisplay = 'S'
	            then mo.scoreValue
	            when o.sortOrder = 8 and o.reportDisplay = 'I'
				then mo.integerValue
	            else null end) value8
	 , sum(case when o.sortOrder = 9 and o.reportDisplay = 'S'
	            then mo.scoreValue
	            when o.sortOrder = 9 and o.reportDisplay = 'I'
				then mo.integerValue
	            else null end) value9
	 , sum(case when o.sortOrder = 10 and o.reportDisplay = 'S'
	            then mo.scoreValue
	            when o.sortOrder = 10 and o.reportDisplay = 'I'
				then mo.integerValue
	            else null end) value10
	 , sum(case when o.sortOrder = 11 and o.reportDisplay = 'S'
	            then mo.scoreValue
	            when o.sortOrder = 11 and o.reportDisplay = 'I'
				then mo.integerValue
	            else null end) value11
	 , sum(case when o.sortOrder = 12 and o.reportDisplay = 'S'
	            then mo.scoreValue
	            when o.sortOrder = 12 and o.reportDisplay = 'I'
				then mo.integerValue
	            else null end) value12
	 , sum(case when o.sortOrder = 13 and o.reportDisplay = 'S'
	            then mo.scoreValue
	            when o.sortOrder = 13 and o.reportDisplay = 'I'
				then mo.integerValue
	            else null end) value13
	 , sum(case when o.sortOrder = 14 and o.reportDisplay = 'S'
	            then mo.scoreValue
	            when o.sortOrder = 14 and o.reportDisplay = 'I'
				then mo.integerValue
	            else null end) value14
	 , sum(case when o.sortOrder = 15 and o.reportDisplay = 'S'
	            then mo.scoreValue
	            when o.sortOrder = 15 and o.reportDisplay = 'I'
				then mo.integerValue
	            else null end) value15
	 , sum(case when o.sortOrder = 1 then mo.integerValue else null end) integerValue1
	 , sum(case when o.sortOrder = 2 then mo.integerValue else null end) integerValue2
	 , sum(case when o.sortOrder = 3 then mo.integerValue else null end) integerValue3
	 , sum(case when o.sortOrder = 4 then mo.integerValue else null end) integerValue4
	 , sum(case when o.sortOrder = 5 then mo.integerValue else null end) integerValue5
	 , sum(case when o.sortOrder = 6 then mo.integerValue else null end) integerValue6
	 , sum(case when o.sortOrder = 7 then mo.integerValue else null end) integerValue7
	 , sum(case when o.sortOrder = 8 then mo.integerValue else null end) integerValue8
	 , sum(case when o.sortOrder = 9 then mo.integerValue else null end) integerValue9
	 , sum(case when o.sortOrder = 10 then mo.integerValue else null end) integerValue10
	 , sum(case when o.sortOrder = 11 then mo.integerValue else null end) integerValue11
	 , sum(case when o.sortOrder = 12 then mo.integerValue else null end) integerValue12
	 , sum(case when o.sortOrder = 13 then mo.integerValue else null end) integerValue13
	 , sum(case when o.sortOrder = 14 then mo.integerValue else null end) integerValue14
	 , sum(case when o.sortOrder = 15 then mo.integerValue else null end) integerValue15
	 , sum(case when o.sortOrder = 1
	            then mo.scoreValue
				else null end) scoreValue1
	 , sum(case when o.sortOrder = 2  
	            then mo.scoreValue
				else null end) scoreValue2
	 , sum(case when o.sortOrder = 3 
	            then mo.scoreValue
				else null end) scoreValue3
	 , sum(case when o.sortOrder = 4 
	            then mo.scoreValue
				else null end) scoreValue4
	 , sum(case when o.sortOrder = 5 
	            then mo.scoreValue
				else null end) scoreValue5
	 , sum(case when o.sortOrder = 6 
	            then mo.scoreValue
				else null end) scoreValue6
	 , sum(case when o.sortOrder = 7 
	            then mo.scoreValue
				else null end) scoreValue7
	 , sum(case when o.sortOrder = 8 
	            then mo.scoreValue
				else null end) scoreValue8
	 , sum(case when o.sortOrder = 9 
	            then mo.scoreValue
				else null end) scoreValue9
	 , sum(case when o.sortOrder = 10 
	            then mo.scoreValue
				else null end) scoreValue10
	 , sum(case when o.sortOrder = 11 
	            then mo.scoreValue
				else null end) scoreValue11
	 , sum(case when o.sortOrder = 12 
	            then mo.scoreValue
				else null end) scoreValue12
	 , sum(case when o.sortOrder = 13 
	            then mo.scoreValue
				else null end) scoreValue13
	 , sum(case when o.sortOrder = 14 
	            then mo.scoreValue
				else null end) scoreValue14
	 , sum(case when o.sortOrder = 15 
	            then mo.scoreValue
				else null end) scoreValue15
	 , case when mo.alliance = 'R' then m.redFoulPoints
	        when mo.alliance = 'B' then m.blueFoulPoints
	        else null end matchFoulPoints
	 , case when mo.alliance = 'R' then m.redScore
	        when mo.alliance = 'B' then m.blueScore
	        else null end matchScore
	 , max(case when o.sortOrder = 1 then mo.objectiveId else null end) objectiveId1
	 , max(case when o.sortOrder = 2 then mo.objectiveId else null end) objectiveId2
	 , max(case when o.sortOrder = 3 then mo.objectiveId else null end) objectiveId3
	 , max(case when o.sortOrder = 4 then mo.objectiveId else null end) objectiveId4
	 , max(case when o.sortOrder = 5 then mo.objectiveId else null end) objectiveId5
	 , max(case when o.sortOrder = 6 then mo.objectiveId else null end) objectiveId6
	 , max(case when o.sortOrder = 7 then mo.objectiveId else null end) objectiveId7
	 , max(case when o.sortOrder = 8 then mo.objectiveId else null end) objectiveId8
	 , max(case when o.sortOrder = 9 then mo.objectiveId else null end) objectiveId9
	 , max(case when o.sortOrder = 10 then mo.objectiveId else null end) objectiveId10
	 , max(case when o.sortOrder = 11 then mo.objectiveId else null end) objectiveId11
	 , max(case when o.sortOrder = 12 then mo.objectiveId else null end) objectiveId12
	 , max(case when o.sortOrder = 13 then mo.objectiveId else null end) objectiveId13
	 , max(case when o.sortOrder = 14 then mo.objectiveId else null end) objectiveId14
	 , max(case when o.sortOrder = 15 then mo.objectiveId else null end) objectiveId15
	 , ge.loginGUID
  from Match m
	   inner join MatchObjective mo
	   on mo.matchId = m.id
	   inner join v_GameEvent ge
	   on ge.id = m.gameEventId
	   inner join Objective o
	   on o.id = mo.objectiveId
 where m.isActive = 'Y'
group by mo.alliance
       , mo.matchId
       , m.gameEventId
	   , m.redFoulPoints
	   , m.blueFoulPoints
	   , m.redScore
	   , m.blueScore
	   , ge.loginGUID) mo
inner join (
select tm.alliance
     , m.id matchId
     , m.gameEventId
	 , sum(case when o.sortOrder = 1 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 1 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value1
	 , sum(case when o.sortOrder = 2 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 2 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value2
	 , sum(case when o.sortOrder = 3 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 3 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value3
	 , sum(case when o.sortOrder = 4 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 4 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value4
	 , sum(case when o.sortOrder = 5 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 5 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value5
	 , sum(case when o.sortOrder = 6 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 6 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value6
	 , sum(case when o.sortOrder = 7 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 7 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value7
	 , sum(case when o.sortOrder = 8 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 8 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value8
	 , sum(case when o.sortOrder = 9 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 9 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value9
	 , sum(case when o.sortOrder = 10 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 10 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value10
	 , sum(case when o.sortOrder = 11 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 11 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value11
	 , sum(case when o.sortOrder = 12 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 12 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value12
	 , sum(case when o.sortOrder = 13 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 13 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value13
	 , sum(case when o.sortOrder = 14 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 14 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value14
	 , sum(case when o.sortOrder = 15 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 15 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value15
	 , sum(case when o.sortOrder = 1 then tmo.integerValue else null end) integerValue1
	 , sum(case when o.sortOrder = 2 then tmo.integerValue else null end) integerValue2
	 , sum(case when o.sortOrder = 3 then tmo.integerValue else null end) integerValue3
	 , sum(case when o.sortOrder = 4 then tmo.integerValue else null end) integerValue4
	 , sum(case when o.sortOrder = 5 then tmo.integerValue else null end) integerValue5
	 , sum(case when o.sortOrder = 6 then tmo.integerValue else null end) integerValue6
	 , sum(case when o.sortOrder = 7 then tmo.integerValue else null end) integerValue7
	 , sum(case when o.sortOrder = 8 then tmo.integerValue else null end) integerValue8
	 , sum(case when o.sortOrder = 9 then tmo.integerValue else null end) integerValue9
	 , sum(case when o.sortOrder = 10 then tmo.integerValue else null end) integerValue10
	 , sum(case when o.sortOrder = 11 then tmo.integerValue else null end) integerValue11
	 , sum(case when o.sortOrder = 12 then tmo.integerValue else null end) integerValue12
	 , sum(case when o.sortOrder = 13 then tmo.integerValue else null end) integerValue13
	 , sum(case when o.sortOrder = 14 then tmo.integerValue else null end) integerValue14
	 , sum(case when o.sortOrder = 15 then tmo.integerValue else null end) integerValue15
	 , sum(case when o.sortOrder = 1
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue1
	 , sum(case when o.sortOrder = 2  
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue2
	 , sum(case when o.sortOrder = 3 
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue3
	 , sum(case when o.sortOrder = 4 
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue4
	 , sum(case when o.sortOrder = 5 
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue5
	 , sum(case when o.sortOrder = 6 
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue6
	 , sum(case when o.sortOrder = 7 
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue7
	 , sum(case when o.sortOrder = 8 
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue8
	 , sum(case when o.sortOrder = 9 
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue9
	 , sum(case when o.sortOrder = 10 
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue10
	 , sum(case when o.sortOrder = 11 
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue11
	 , sum(case when o.sortOrder = 12 
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue12
	 , sum(case when o.sortOrder = 13 
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue13
	 , sum(case when o.sortOrder = 14 
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue14
	 , sum(case when o.sortOrder = 15 
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
				else null end) scoreValue15
	 , case when tm.alliance = 'R' then m.redFoulPoints
	        when tm.alliance = 'B' then m.blueFoulPoints
	        else null end matchFoulPoints
	 , case when tm.alliance = 'R' then m.redScore
	        when tm.alliance = 'B' then m.blueScore
	        else null end matchScore
	 , max(case when o.sortOrder = 1 then tmo.objectiveId else null end) objectiveId1
	 , max(case when o.sortOrder = 2 then tmo.objectiveId else null end) objectiveId2
	 , max(case when o.sortOrder = 3 then tmo.objectiveId else null end) objectiveId3
	 , max(case when o.sortOrder = 4 then tmo.objectiveId else null end) objectiveId4
	 , max(case when o.sortOrder = 5 then tmo.objectiveId else null end) objectiveId5
	 , max(case when o.sortOrder = 6 then tmo.objectiveId else null end) objectiveId6
	 , max(case when o.sortOrder = 7 then tmo.objectiveId else null end) objectiveId7
	 , max(case when o.sortOrder = 8 then tmo.objectiveId else null end) objectiveId8
	 , max(case when o.sortOrder = 9 then tmo.objectiveId else null end) objectiveId9
	 , max(case when o.sortOrder = 10 then tmo.objectiveId else null end) objectiveId10
	 , max(case when o.sortOrder = 11 then tmo.objectiveId else null end) objectiveId11
	 , max(case when o.sortOrder = 12 then tmo.objectiveId else null end) objectiveId12
	 , max(case when o.sortOrder = 13 then tmo.objectiveId else null end) objectiveId13
	 , max(case when o.sortOrder = 14 then tmo.objectiveId else null end) objectiveId14
	 , max(case when o.sortOrder = 15 then tmo.objectiveId else null end) objectiveId15
	 , ge.loginGUID
  from Match m
	   inner join TeamMatch tm
	   on tm.matchId = m.id
	   inner join TeamMatchObjective tmo
	   on tmo.teamMatchId = tm.id
	   inner join v_GameEvent ge
	   on ge.id = m.gameEventId
	   inner join Objective o
	   on o.id = tmo.objectiveId
 where m.isActive = 'Y'
group by tm.alliance
       , m.id
       , m.gameEventId
	   , m.redFoulPoints
	   , m.blueFoulPoints
	   , m.redScore
	   , m.blueScore
	   , ge.loginGUID) tmo
on tmo.alliance = mo.alliance
and tmo.matchId = mo.matchId
and tmo.loginGUID = mo.loginGUID
go

-- View for Match Final Report
create view v_MatchFinalReport as
-- Team Scores
select case when tm.alliance = 'R' then 'Red'
	        when tm.alliance = 'B' then 'Blue'
	        else tm.alliance end alliance
	 , tm.alliancePosition
     , convert(varchar, t.TeamNumber) TeamNumber
	 , case when tm.alliance = 'R' then 1
	        when tm.alliance = 'B' then 3
	        else 2 end allianceSort
	 , round(asr.value1,2) value1
     , round(asr.value2,2) value2
     , round(asr.value3,2) value3
     , round(asr.value4,2) value4
     , round(asr.value5,2) value5
     , round(asr.value6,2) value6
     , round(asr.value7,2) value7
     , round(asr.value8,2) value8
     , round(asr.value9,2) value9
     , round(asr.value10,2) value10
     , round(asr.value11,2) value11
     , round(asr.value12,2) value12
     , round(asr.value13,2) value13
     , round(asr.value14,2) value14
     , round(asr.value15,2) value15
	 , round(coalesce(asr.scoreValue1,0) +
	         coalesce(asr.scoreValue2,0) +
	         coalesce(asr.scoreValue3,0) +
	         coalesce(asr.scoreValue4,0) +
	         coalesce(asr.scoreValue5,0) +
	         coalesce(asr.scoreValue6,0) +
	         coalesce(asr.scoreValue7,0) +
	         coalesce(asr.scoreValue8,0) +
	         coalesce(asr.scoreValue9,0) +
	         coalesce(asr.scoreValue10,0) +
	         coalesce(asr.scoreValue11,0) +
	         coalesce(asr.scoreValue12,0) +
	         coalesce(asr.scoreValue13,0) +
	         coalesce(asr.scoreValue14,0) +
	         coalesce(asr.scoreValue15,0),2) totalScoreValue
	 , null matchFoulPoints
	 , null matchScore
     , t.id TeamId
     , asr.matchId
     , asr.gameEventId
	 , m.matchCode
	 , asr.loginGUID
 from Team t
      inner join v_AvgScoutRecord asr
      on asr.TeamId = t.id
      inner join Match m
      on m.id = asr.matchId
	  inner join TeamMatch tm
	  on tm.matchId = asr.matchId
	  and tm.teamId = asr.teamId
 where m.isActive = 'Y'
union
-- Team Scores from  The Blue Alliance if no scout data
select case when tm.alliance = 'R' then 'Red'
	        when tm.alliance = 'B' then 'Blue'
	        else tm.alliance end alliance
	 , tm.alliancePosition
     , convert(varchar, t.TeamNumber) TeamNumber
	 , case when tm.alliance = 'R' then 1
	        when tm.alliance = 'B' then 3
	        else 2 end allianceSort
	 , sum(case when o.sortOrder = 1 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 1 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value1
	 , sum(case when o.sortOrder = 2 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 2 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value2
	 , sum(case when o.sortOrder = 3 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 3 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value3
	 , sum(case when o.sortOrder = 4 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 4 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value4
	 , sum(case when o.sortOrder = 5 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 5 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value5
	 , sum(case when o.sortOrder = 6 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 6 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value6
	 , sum(case when o.sortOrder = 7 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 7 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value7
	 , sum(case when o.sortOrder = 8 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 8 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value8
	 , sum(case when o.sortOrder = 9 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 9 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value9
	 , sum(case when o.sortOrder = 10 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 10 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value10
	 , sum(case when o.sortOrder = 11 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 11 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value11
	 , sum(case when o.sortOrder = 12 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 12 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value12
	 , sum(case when o.sortOrder = 13 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 13 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value13
	 , sum(case when o.sortOrder = 14 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 14 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value14
	 , sum(case when o.sortOrder = 15 and o.reportDisplay = 'S'
	            then tmo.scoreValue +
				     case when o.addTeamScorePortion = 'Y'
					      then coalesce(tm.portionOfAlliancePoints, 0)
						  else 0 end
	            when o.sortOrder = 15 and o.reportDisplay = 'I'
				then tmo.integerValue
	            else null end) value15
	 , null totalScoreValue
	 , null matchFoulPoints
	 , null matchScore
	 , tm.teamId
	 , tm.matchId
	 , m.gameEventId
	 , m.matchCode
	 , ge.loginGUID
  from Match m
	   inner join TeamMatch tm
	   on tm.matchId = m.id
	   inner join TeamMatchObjective tmo
	   on tmo.teamMatchId = tm.id
	   inner join Team t
	   on t.id = tm.teamId
	   inner join v_GameEvent ge
	   on ge.id = m.gameEventId
	   inner join Objective o
	   on o.id = tmo.objectiveId
 where m.isActive = 'Y'
   and not exists
       (select 1
	      from ScoutRecord sr
		 where sr.teamId = tm.teamId
		   and sr.matchId = tm.matchId)
group by tm.alliance
	   , tm.alliancePosition
	   , t.teamNumber
       , tm.teamId
	   , tm.matchId
	   , m.gameEventId
	   , m.matchCode
       , ge.loginGUID
union
-- Total Alliance Scores from Scout Data
select subquery.alliance
     , 98 alliancePosition
	 , 'Scout' teamNumber
	 , subquery.allianceSort
	 , sum(subquery.value1) value1
	 , sum(subquery.value2) value2
	 , sum(subquery.value3) value3
	 , sum(subquery.value4) value4
	 , sum(subquery.value5) value5
	 , sum(subquery.value6) value6
	 , sum(subquery.value7) value7
	 , sum(subquery.value8) value8
	 , sum(subquery.value9) value9
	 , sum(subquery.value10) value10
	 , sum(subquery.value11) value11
	 , sum(subquery.value12) value12
	 , sum(subquery.value13) value13
	 , sum(subquery.value14) value14
	 , sum(subquery.value15) value15
	 , sum(subquery.totalScoreValue) totalScoreValue
	 , subquery.matchFoulPoints
	 , subquery.matchScore
	 , null TeamId
	 , subquery.matchId
	 , subquery.gameEventId
	 , subquery.matchCode
     , subquery.loginGUID
  from (
select case when tm.alliance = 'R' then 'Red'
	        when tm.alliance = 'B' then 'Blue'
	        else tm.alliance end alliance
	 , tm.alliancePosition
     , convert(varchar, t.TeamNumber) TeamNumber
	 , case when tm.alliance = 'R' then 1
	        when tm.alliance = 'B' then 3
	        else 2 end allianceSort
	 , round(asr.scoreValue1,2) value1
     , round(asr.scoreValue2,2) value2
     , round(asr.scoreValue3,2) value3
     , round(asr.scoreValue4,2) value4
     , round(asr.scoreValue5,2) value5
     , round(asr.scoreValue6,2) value6
     , round(asr.scoreValue7,2) value7
     , round(asr.scoreValue8,2) value8
     , round(asr.scoreValue9,2) value9
     , round(asr.scoreValue10,2) value10
     , round(asr.scoreValue11,2) value11
     , round(asr.scoreValue12,2) value12
     , round(asr.scoreValue13,2) value13
     , round(asr.scoreValue14,2) value14
     , round(asr.scoreValue15,2) value15
	 , round(coalesce(asr.scoreValue1,0) +
	         coalesce(asr.scoreValue2,0) +
	         coalesce(asr.scoreValue3,0) +
	         coalesce(asr.scoreValue4,0) +
	         coalesce(asr.scoreValue5,0) +
	         coalesce(asr.scoreValue6,0) +
	         coalesce(asr.scoreValue7,0) +
	         coalesce(asr.scoreValue8,0) +
	         coalesce(asr.scoreValue9,0) +
	         coalesce(asr.scoreValue10,0) +
	         coalesce(asr.scoreValue11,0) +
	         coalesce(asr.scoreValue12,0) +
	         coalesce(asr.scoreValue13,0) +
	         coalesce(asr.scoreValue14,0) +
	         coalesce(asr.scoreValue15,0),2) totalScoreValue
	 , null matchFoulPoints
	 , null matchScore
     , t.id TeamId
     , asr.matchId
     , asr.gameEventId
	 , m.matchCode
	 , asr.loginGUID
 from Team t
      inner join v_AvgScoutRecord asr
      on asr.TeamId = t.id
      inner join Match m
      on m.id = asr.matchId
	  inner join TeamMatch tm
	  on tm.matchId = asr.matchId
	  and tm.teamId = asr.teamId
 where m.isActive = 'Y') subquery
group by subquery.alliance
       , subquery.allianceSort
	   , subquery.matchFoulPoints
	   , subquery.matchScore
	   , subquery.matchId
	   , subquery.gameEventId
	   , subquery.matchCode
	   , subquery.loginGUID
union
-- Divider needed in table between alliances
select '----' alliance
     , null alliancePosition
     , null TeamNumber
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
	 , null matchFoulPoints
	 , null matchScore
	 , null teamId
	 , m.id matchId
	 , m.gameEventId
	 , m.matchCode
	 , ge.loginGUID
  from Match m
	   inner join v_GameEvent ge
	   on ge.id = m.gameEventId
 where m.isActive = 'Y'
union
-- Total Alliance Scores from The Blue Alliance
select case when mas.alliance = 'R' then 'Red'
	        when mas.alliance = 'B' then 'Blue'
	        else mas.alliance end alliance
     , 99 alliancePosition
	 , 'TBA' teamNumber
	 , case when mas.alliance = 'R' then 1
	        when mas.alliance = 'B' then 3
	        else 2 end allianceSort
     , round(mas.value1,2) value1
     , round(mas.value2,2) value2
     , round(mas.value3,2) value3
     , round(mas.value4,2) value4
     , round(mas.value5,2) value5
     , round(mas.value6,2) value6
     , round(mas.value7,2) value7
     , round(mas.value8,2) value8
     , round(mas.value9,2) value9
     , round(mas.value10,2) value10
     , round(mas.value11,2) value11
     , round(mas.value12,2) value12
     , round(mas.value13,2) value13
     , round(mas.value14,2) value14
     , round(mas.value15,2) value15
	 , round(coalesce(mas.scoreValue1,0) +
	         coalesce(mas.scoreValue2,0) +
	         coalesce(mas.scoreValue3,0) +
	         coalesce(mas.scoreValue4,0) +
	         coalesce(mas.scoreValue5,0) +
	         coalesce(mas.scoreValue6,0) +
	         coalesce(mas.scoreValue7,0) +
	         coalesce(mas.scoreValue8,0) +
	         coalesce(mas.scoreValue9,0) +
	         coalesce(mas.scoreValue10,0) +
	         coalesce(mas.scoreValue11,0) +
	         coalesce(mas.scoreValue12,0) +
	         coalesce(mas.scoreValue13,0) +
	         coalesce(mas.scoreValue14,0) +
	         coalesce(mas.scoreValue15,0),2) totalScoreValue
	 , mas.matchFoulPoints
	 , mas.matchScore
	 , null TeamId
     , mas.matchId
	 , mas.gameEventId
	 , m.matchCode
	 , mas.loginGUID
  from v_MatchActualScore mas
       inner join Match m
	   on m.id = mas.matchId;
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
	 , ge.loginGUID
  from Team t 
       inner join TeamGameEvent tge 
       on tge.teamId = t.id
       inner join v_GameEvent ge 
       on ge.id = tge.gameEventId
       inner join Match m
	   on m.gameEventId = ge.id
	   inner join TeamMatch tm
	   on tm.matchId = m.id
	   and tm.teamId = t.id
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
	 , ge.loginGUID
  from Match m
       inner join v_GameEvent ge
       on ge.id = m.gameEventId
go

-- View for Team history and average
create view v_TeamReport as
select t.TeamNumber
     , 'N/A' matchNumber
     , max(m.datetime + 1) matchTime
     , 'QM Avg Score' scoutName
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
     , coalesce(round(avg(sr.value1),2), 0) +
       coalesce(round(avg(sr.value2),2), 0) +
       coalesce(round(avg(sr.value3),2), 0) +
       coalesce(round(avg(sr.value4),2), 0) +
       coalesce(round(avg(sr.value5),2), 0) +
       coalesce(round(avg(sr.value6),2), 0) +
       coalesce(round(avg(sr.value7),2), 0) +
       coalesce(round(avg(sr.value8),2), 0) +
       coalesce(round(avg(sr.value9),2), 0) +
       coalesce(round(avg(sr.value10),2), 0) +
       coalesce(round(avg(sr.value11),2), 0) +
       coalesce(round(avg(sr.value12),2), 0) +
       coalesce(round(avg(sr.value13),2), 0) +
       coalesce(round(avg(sr.value14),2), 0) +
       coalesce(round(avg(sr.value15),2), 0) totalScoreValue
     , null textValue1
     , null textValue2
     , null textValue3
     , null textValue4
     , null textValue5
     , null textValue6
     , null textValue7
     , null textValue8
     , null textValue9
     , null textValue10
     , null textValue11
     , null textValue12
     , null textValue13
     , null textValue14
     , null textValue15
     , null videos
     , t.id TeamId
     , null matchId
     , null scoutId
	 , sr.gameEventId
	 , null scoutRecordId
	 , null scoutComment
	 , sr.loginGUID
 from Team t
      inner join v_AvgScoutRecord sr
      on sr.TeamId = t.id
      inner join Match m
      on m.id = sr.matchId
 where m.isActive = 'Y'
   and m.type in ('QM','PR')
group by t.TeamNumber
       , t.id
	   , sr.gameEventId
	   , sr.loginGUID
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
	 , case when (sr.scoringTypeName1 <> 'Free Form' and sr.scoreValue1 is null and 1 <= o.cntObjectives) or
	             (sr.scoringTypeName2 <> 'Free Form' and sr.scoreValue2 is null and 2 <= o.cntObjectives) or
	             (sr.scoringTypeName3 <> 'Free Form' and sr.scoreValue3 is null and 3 <= o.cntObjectives) or
	             (sr.scoringTypeName4 <> 'Free Form' and sr.scoreValue4 is null and 4 <= o.cntObjectives) or
	             (sr.scoringTypeName5 <> 'Free Form' and sr.scoreValue5 is null and 5 <= o.cntObjectives) or
	             (sr.scoringTypeName6 <> 'Free Form' and sr.scoreValue6 is null and 6 <= o.cntObjectives) or
	             (sr.scoringTypeName7 <> 'Free Form' and sr.scoreValue7 is null and 7 <= o.cntObjectives) or
	             (sr.scoringTypeName8 <> 'Free Form' and sr.scoreValue8 is null and 8 <= o.cntObjectives) or
	             (sr.scoringTypeName9 <> 'Free Form' and sr.scoreValue9 is null and 9 <= o.cntObjectives) or
	             (sr.scoringTypeName10 <> 'Free Form' and sr.scoreValue10 is null and 10 <= o.cntObjectives) or
	             (sr.scoringTypeName11 <> 'Free Form' and sr.scoreValue11 is null and 11 <= o.cntObjectives) or
	             (sr.scoringTypeName12 <> 'Free Form' and sr.scoreValue12 is null and 12 <= o.cntObjectives) or
	             (sr.scoringTypeName13 <> 'Free Form' and sr.scoreValue13 is null and 13 <= o.cntObjectives) or
	             (sr.scoringTypeName14 <> 'Free Form' and sr.scoreValue14 is null and 14 <= o.cntObjectives) or
	             (sr.scoringTypeName15 <> 'Free Form' and sr.scoreValue15 is null and 15 <= o.cntObjectives)
	        then null           
	        else round(coalesce(sr.scoreValue1,0) +
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
					   coalesce(sr.scoreValue15,0),2) end totalScoreValue
     , sr.textValue1
     , sr.textValue2
     , sr.textValue3
     , sr.textValue4
     , sr.textValue5
     , sr.textValue6
     , sr.textValue7
     , sr.textValue8
     , sr.textValue9
     , sr.textValue10
     , sr.textValue11
     , sr.textValue12
     , sr.textValue13
     , sr.textValue14
     , sr.textValue15
     , case when m.matchCode is not null
	        then '<a href="https://www.thebluealliance.com/match/' + m.matchCode + '" target="_blank">tba</a>'
			else '' end +
	   case when 
			   (select ', <a href="' + case when mv.videoType = 'youtube' then 'https://youtu.be/' else mv.videoType end + trim(mv.videoKey) + '" target="_blank">v</a>' AS 'data()'
				  from MatchVideo mv
				 where mv.matchId = m.id
				 FOR XML PATH('')) is not null
			then ', ' +
			   replace(replace(substring(
			   (select ', <a href="' + case when mv.videoType = 'youtube' then 'https://youtu.be/' else mv.videoType end + trim(mv.videoKey) + '" target="_blank">v</a>' AS 'data()'
				  from MatchVideo mv
				 where mv.matchId = m.id
				 FOR XML PATH('')), 3 , 9999), '&lt;', '<'), '&gt;', '>')
			else '' end videos
     , sr.TeamId
     , sr.matchId
     , sr.scoutId
	 , sr.gameEventId
	 , sr.scoutRecordId
	 , sr.scoutComment
	 , sr.loginGUID
 from Team t
      inner join v_ScoutRecord sr
      on sr.TeamId = t.id
      inner join Match m
      on m.id = sr.matchId
      inner join scout s
      on s.id = sr.scoutId
	  inner join GameEvent ge
	  on ge.id = sr.gameEventId
	  inner join (select o.gameId, max(sortOrder) cntObjectives
	                from Objective o
				  group by o.gameId) o
      on o.gameId = ge.gameId
 where m.isActive = 'Y';
go

-- View for Team Average Pie Chart
create view v_TeamReportPieChart as
select objectiveScoutRecordAverages.teamNumber
     , objectiveScoutRecordAverages.objectiveGroupName
	 , objectiveScoutRecordAverages.objectiveGroupSortOrder
     , objectiveScoutRecordAverages.teamId
	 , objectiveScoutRecordAverages.loginGUID
	 , round(sum(objectiveScoutRecordAverages.avgScoreValue), 2) objectiveGroupScoreValue
 from (
select matchScoutRecordAverages.teamNumber
     , matchScoutRecordAverages.objectiveGroupName
	 , matchScoutRecordAverages.objectiveGroupSortOrder
     , matchScoutRecordAverages.objectiveName
	 , matchScoutRecordAverages.teamId
	 , matchScoutRecordAverages.loginGUID
	 , avg(matchScoutRecordAverages.scoreValue) avgScoreValue 
  from (
select t.teamNumber
     , og.name objectiveGroupName
	 , og.sortOrder objectiveGroupSortOrder
	 , o.name objectiveName
	 , sr.matchId
     , sr.teamId
	 , avg(convert(numeric, sor.scoreValue) +
	       case when o.addTeamScorePortion = 'Y'
		        then tm.portionOfAlliancePoints
				else 0 end) scoreValue
	 , ge.loginGUID
  from ScoutRecord sr
       inner join Match m
	   on m.id = sr.matchId
	   inner join v_GameEvent ge
	   on ge.id = m.gameEventId
	   inner join ScoutObjectiveRecord sor
	   on sor.scoutRecordId = sr.id
	   inner join Objective o
	   on o.id = sor.objectiveId
	   inner join ObjectiveGroupObjective ogo
	   on ogo.objectiveId = o.id
	   inner join ObjectiveGroup og
	   on og.id = ogo.objectiveGroupId
	   inner join Team t
	   on t.id = sr.teamId
	   inner join TeamMatch tm
	   on tm.matchId = sr.matchId
	   and tm.teamId = sr.teamId
 where m.isActive = 'Y'
   and og.groupCode = 'Report Pie Chart'
group by t.teamNumber
       , og.name
	   , og.sortOrder
	   , o.name
       , sr.matchId
       , sr.teamId
	   , ge.loginGUID
) matchScoutRecordAverages
group by matchScoutRecordAverages.teamNumber
       , matchScoutRecordAverages.objectiveGroupName
	   , matchScoutRecordAverages.objectiveGroupSortOrder
       , matchScoutRecordAverages.objectiveName
	   , matchScoutRecordAverages.teamId
	   , matchScoutRecordAverages.loginGUID
) objectiveScoutRecordAverages
group by objectiveScoutRecordAverages.teamNumber
       , objectiveScoutRecordAverages.objectiveGroupName
	   , objectiveScoutRecordAverages.objectiveGroupSortOrder
	   , objectiveScoutRecordAverages.teamId
	   , objectiveScoutRecordAverages.loginGUID;
go

-- View for Team Trend Line Chart
create view v_TeamReportLineGraph as
select objectiveScoutRecordAverages.teamNumber
     , objectiveScoutRecordAverages.matchNumber
     , objectiveScoutRecordAverages.matchDateTime
     , objectiveScoutRecordAverages.objectiveGroupName
	 , objectiveScoutRecordAverages.objectiveGroupSortOrder
     , objectiveScoutRecordAverages.teamId
	 , objectiveScoutRecordAverages.matchId
	 , objectiveScoutRecordAverages.loginGUID
	 , round(sum(objectiveScoutRecordAverages.avgScoreValue), 2) objectiveGroupScoreValue
	 , (select avg(tr.totalScoreValue)
	      from v_TeamReport tr
		 where tr.teamId = objectiveScoutRecordAverages.teamId
		   and tr.matchId = objectiveScoutRecordAverages.matchId
		   and tr.loginGUID = objectiveScoutRecordAverages.loginGUID) totalScoreValue
 from (
select matchScoutRecordAverages.teamNumber
     , matchScoutRecordAverages.matchNumber
     , matchScoutRecordAverages.matchDateTime
     , matchScoutRecordAverages.objectiveGroupName
	 , matchScoutRecordAverages.objectiveGroupSortOrder
     , matchScoutRecordAverages.objectiveName
	 , matchScoutRecordAverages.teamId
	 , matchScoutRecordAverages.matchId
	 , matchScoutRecordAverages.loginGUID
	 , avg(matchScoutRecordAverages.scoreValue) avgScoreValue 
  from (
select t.teamNumber
     , m.type + ' ' + convert(varchar, m.number) matchNumber
	 , m.dateTime matchDateTime
     , og.name objectiveGroupName
	 , og.sortOrder objectiveGroupSortOrder
	 , o.name objectiveName
	 , sr.matchId
     , sr.teamId
	 , avg(convert(numeric, sor.scoreValue) +
	       case when o.addTeamScorePortion = 'Y'
		        then tm.portionOfAlliancePoints
				else 0 end) scoreValue
	 , ge.loginGUID
  from ScoutRecord sr
       inner join Match m
	   on m.id = sr.matchId
	   inner join v_GameEvent ge
	   on ge.id = m.gameEventId
	   inner join ScoutObjectiveRecord sor
	   on sor.scoutRecordId = sr.id
	   inner join Objective o
	   on o.id = sor.objectiveId
	   inner join ObjectiveGroupObjective ogo
	   on ogo.objectiveId = o.id
	   inner join ObjectiveGroup og
	   on og.id = ogo.objectiveGroupId
	   inner join Team t
	   on t.id = sr.teamId
	   inner join TeamMatch tm
	   on tm.matchId = sr.matchId
	   and tm.teamId = sr.teamId
 where m.isActive = 'Y'
   and og.groupCode = 'Report Line Graph'
group by t.teamNumber
       , m.type + ' ' + convert(varchar, m.number)
	   , m.dateTime
       , og.name
	   , og.sortOrder
	   , o.name
       , sr.matchId
       , sr.teamId
	   , ge.loginGUID
) matchScoutRecordAverages
group by matchScoutRecordAverages.teamNumber
       , matchScoutRecordAverages.matchNumber
       , matchScoutRecordAverages.matchDateTime
       , matchScoutRecordAverages.objectiveGroupName
	   , matchScoutRecordAverages.objectiveGroupSortOrder
       , matchScoutRecordAverages.objectiveName
	   , matchScoutRecordAverages.teamId
	   , matchScoutRecordAverages.matchId
	   , matchScoutRecordAverages.loginGUID
) objectiveScoutRecordAverages
group by objectiveScoutRecordAverages.teamNumber
       , objectiveScoutRecordAverages.matchNumber
       , objectiveScoutRecordAverages.matchDateTime
       , objectiveScoutRecordAverages.objectiveGroupName
	   , objectiveScoutRecordAverages.objectiveGroupSortOrder
	   , objectiveScoutRecordAverages.teamId
	   , objectiveScoutRecordAverages.matchId
	   , objectiveScoutRecordAverages.loginGUID;
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
	 , asr.loginGUID
  from v_AvgScoutRecord asr
       inner join Match m
	   on m.id = asr.matchId
 where m.isActive = 'Y'
   and m.type in ('QM','PR')
group by asr.TeamId
	   , asr.loginGUID;
go

/*
-- Rank Query (as a stored procedure to improve query performance
CREATE PROCEDURE sp_rpt_rankReport (@pv_QueryString varchar(64)
                                   ,@pv_loginGUID varchar(128))
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
	SELECT @lv_SortOrder = coalesce(max(sortOrder), -99)
	  FROM Rank r
	       inner join v_GameEvent ge
		   on ge.gameId = r.gameId
	 WHERE ge.loginGUID = @pv_loginGUID
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
		   inner join v_GameEvent ge
		   on ge.gameId = o.gameId
		   inner join TeamGameEvent tge
		   on ge.id = tge.gameEventId
		   inner join v_AvgTeamRecord atr
		   on atr.teamId = tge.teamId
		   and atr.loginGUID = ge.loginGUID
	 where ge.loginGUID = @pv_loginGUID
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
		   inner join v_GameEvent ge
		   on ge.gameId = r.gameId
		   inner join TeamGameEvent tge
		   on tge.gameEventId = ge.id
	 where ge.loginGUID = @pv_loginGUID
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
	group by subquery.teamId
	       , t.TeamNumber
		   , t.TeamName
		   , subquery.TeamId
		   , subquery.cntMatches
 		   , subquery.eventRank
		   , subquery.rankingPointAverage
	order by case when @lv_SortOrder = -99 then subquery.eventRank
	              else sum(case when subquery.sortOrder = @lv_SortOrder then subquery.rank else null end) end
	       , t.teamNumber;

END
go

CREATE PROCEDURE sp_upd_scoutDataFromTba (@pv_loginGUID varchar(128))
as
begin
	-- Update scout record objectives for data specific to a team from TBA
	update ScoutObjectiveRecord
	   set integerValue =
		   (select tmo.integervalue
			  from TeamMatchObjective tmo
				   inner join TeamMatch tm
				   on tm.id = tmo.teamMatchId
				   inner join ScoutRecord sr
				   on sr.teamId = tm.teamId
				   and sr.matchId = tm.matchId
			 where ScoutObjectiveRecord.scoutRecordId = sr.id
			   and ScoutObjectiveRecord.objectiveId = tmo.objectiveId
			   and tmo.integervalue is not null)
	 where exists
		   (select 1
			  from TeamMatchObjective tmo
				   inner join TeamMatch tm
				   on tm.id = tmo.teamMatchId
				   inner join ScoutRecord sr
				   on sr.teamId = tm.teamId
				   and sr.matchId = tm.matchId
				   inner join Match m
				   on m.id = tm.matchId
				   inner join v_GameEvent ge
				   on ge.id = m.gameEventId
			 where ge.loginGUID = @pv_loginGUID
			   and ScoutObjectiveRecord.scoutRecordId = sr.id
			   and ScoutObjectiveRecord.objectiveId = tmo.objectiveId
			   and coalesce(ScoutObjectiveRecord.integerValue, -1) <> tmo.integerValue);

	-- If match has been scouted after TBA data added, then remove the TBA scout record
	delete from scoutObjectiveRecord
	 where scoutRecordId in (
		select sr.id
		  from scoutRecord sr
			   inner join Scout s
			   on s.id = sr.scoutId
			   inner join Match m
			   on m.id = sr.matchId
			   inner join v_GameEvent ge
			   on ge.id = m.gameEventId
		 where s.lastName = 'TBA'
		   and ge.loginGUID = @pv_loginGUID
		   and exists
			   (select 1
				  from ScoutRecord sr2
				 where sr2.matchId = sr.matchId
				   and sr2.teamId = sr.teamId
				   and sr2.scoutId <> sr.scoutId));
	delete from scoutRecord
	 where id in (
		select sr.id
		  from scoutRecord sr
			   inner join Scout s
			   on s.id = sr.scoutId
			   inner join Match m
			   on m.id = sr.matchId
			   inner join v_GameEvent ge
			   on ge.id = m.gameEventId
		 where s.lastName = 'TBA'
		   and ge.loginGUID = @pv_loginGUID
		   and exists
			   (select 1
				  from ScoutRecord sr2
				 where sr2.matchId = sr.matchId
				   and sr2.teamId = sr.teamId
				   and sr2.scoutId <> sr.scoutId));

	-- Add partial scout records for data which comes from TBA
	insert into ScoutRecord (scoutId, matchId, teamId)
	select distinct
		   s.id scoutId
		 , tm.matchId
		 , tm.teamId
	  from Scout s
		 , TeamMatch tm
		   inner join TeamMatchObjective tmo
		   on tmo.teamMatchId = tm.id
		   inner join Match m
		   on m.id = tm.matchId
		   inner join v_GameEvent ge
		   on ge.id = m.gameEventId
	 where s.lastName = 'TBA'
	   and ge.loginGUID = @pv_loginGUID
	   and tmo.integerValue is not null
	   and not exists
		   (select 1
			  from ScoutRecord sr
			 where sr.matchId = tm.matchId
			   and sr.teamId = tm.teamId);
	insert into ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue)
	select sr.id scoutRecordId
		 , tmo.objectiveId
		 , tmo.integerValue
	  from ScoutRecord sr
		   inner join Scout s
		   on s.id = sr.scoutId
		   inner join TeamMatch tm
		   on tm.matchId = sr.matchId
		   and tm.teamId = sr.teamId
		   inner join TeamMatchObjective tmo
		   on tmo.teamMatchId = tm.id
		   inner join Match m
		   on m.id = tm.matchId
		   inner join v_GameEvent ge
		   on ge.id = m.gameEventId
	 where s.lastName = 'TBA'
	   and ge.loginGUID = @pv_loginGUID
	   and tmo.integerValue is not null
	   and not exists
		   (select 1
			  from ScoutObjectiveRecord sor
			 where sor.scoutRecordId = sr.id
			   and sor.objectiveId = tmo.objectiveId);

	-- If alliance objective data from TBA is zero, then set all teams in alliance objective to zero
	update ScoutObjectiveRecord
	   set integerValue = 0
	 where id in (
			select sor.id
			  from MatchObjective mo
				   inner join Match m
				   on m.id = mo.matchId
				   inner join v_GameEvent ge
				   on ge.id = m.gameEventId
				   inner join TeamMatch tm
				   on tm.matchId = mo.matchId
				   and tm.alliance = mo.alliance
				   inner join ScoutRecord sr
				   on sr.matchId = tm.matchId
				   and sr.teamId = tm.teamId
				   inner join ScoutObjectiveRecord sor
				   on sor.scoutRecordId = sr.id
				   and sor.objectiveId = mo.objectiveId
			 where ge.loginGUID = @pv_loginGUID
			   and mo.integerValue = 0
			   and coalesce(sor.integerValue, -999) <> 0);
	insert into ScoutObjectiveRecord (scoutRecordId, objectiveId, integerValue)
	select sr.id scoutRecordId
		 , mo.objectiveId
		 , mo.integerValue
	  from ScoutRecord sr
		   inner join Match m
		   on m.id = sr.matchId
		   inner join MatchObjective mo
		   on mo.matchId = m.id
		   inner join v_GameEvent ge
		   on ge.id = m.gameEventId
		   inner join TeamMatch tm
		   on tm.matchId = sr.matchId
		   and tm.teamId = sr.teamId
		   and tm.alliance = mo.alliance
	 where ge.loginGUID = @pv_loginGUID
	   and mo.integerValue = 0
	   and not exists
		   (select 1
			  from ScoutObjectiveRecord sor
			 where sor.scoutRecordId = sr.id
			   and sor.objectiveId = mo.objectiveId);

	-- If alliance objective data from TBA is lower than any one team's objective value, then lower the team's objective value to TBA
	update ScoutObjectiveRecord
	   set integerValue =
		  (select mo.integerValue
			  from MatchObjective mo
				   inner join Match m
				   on m.id = mo.matchId
				   inner join GameEvent ge
				   on ge.id = m.gameEventId
				   inner join TeamMatch tm
				   on tm.matchId = mo.matchId
				   and tm.alliance = mo.alliance
				   inner join ScoutRecord sr
				   on sr.matchId = tm.matchId
				   and sr.teamId = tm.teamId
			 where sr.id = ScoutObjectiveRecord.scoutRecordId
			   and mo.objectiveId = ScoutObjectiveRecord.objectiveId)
     where id in (
			select sor.id
			  from MatchObjective mo
				   inner join Match m
				   on m.id = mo.matchId
				   inner join v_GameEvent ge
				   on ge.id = m.gameEventId
				   inner join TeamMatch tm
				   on tm.matchId = mo.matchId
				   and tm.alliance = mo.alliance
				   inner join ScoutRecord sr
				   on sr.matchId = tm.matchId
				   and sr.teamId = tm.teamId
				   inner join ScoutObjectiveRecord sor
				   on sor.scoutRecordId = sr.id
				   and sor.objectiveId = mo.objectiveId
			 where ge.loginGUID = @pv_loginGUID
			   and coalesce(sor.integerValue, -999) > mo.integerValue);
end
GO

CREATE PROCEDURE sp_ins_scoutRecord (@pv_ScoutId integer
                                   , @pv_MatchId integer
                                   , @pv_TeamId integer
								   , @pv_AlliancePosition varchar(64)
                                   , @pv_ScoutComment varchar(4000)
								   , @pv_loginGUID varchar(128)
                                   , @pv_TextValue01 varchar(4000)
                                   , @pv_TextValue02 varchar(4000) = null
                                   , @pv_TextValue03 varchar(4000) = null
                                   , @pv_TextValue04 varchar(4000) = null
                                   , @pv_TextValue05 varchar(4000) = null
                                   , @pv_TextValue06 varchar(4000) = null
                                   , @pv_TextValue07 varchar(4000) = null
                                   , @pv_TextValue08 varchar(4000) = null
                                   , @pv_TextValue09 varchar(4000) = null
                                   , @pv_TextValue10 varchar(4000) = null
                                   , @pv_TextValue11 varchar(4000) = null
                                   , @pv_TextValue12 varchar(4000) = null
                                   , @pv_TextValue13 varchar(4000) = null
                                   , @pv_TextValue14 varchar(4000) = null
                                   , @pv_TextValue15 varchar(4000) = null)
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
	   
	-- Add/update Scout Header Record
	IF @lv_Id is null
	BEGIN
		INSERT INTO ScoutRecord (scoutId, matchId, teamId, scoutComment)
		SELECT @pv_ScoutId, @pv_MatchId, @pv_TeamId, @pv_ScoutComment;
		SET @lv_Id = @@IDENTITY;
	END
	ELSE
	BEGIN
		UPDATE ScoutRecord
		   SET scoutComment = COALESCE(@pv_ScoutComment, scoutComment)
		WHERE scoutId = @pv_ScoutId
		  AND matchId = @pv_MatchId
		  AND teamId = @pv_TeamId;
	END

    -- Insert/Update Scout Objective Record data
	MERGE ScoutObjectiveRecord AS TARGET
	USING (
		SELECT @lv_Id scoutRecordId
			 , o.id objectiveId
			 , case when st.name = 'Free Form'
			        then null
					else case when o.sortOrder = 1 then convert(integer, @pv_TextValue01)
					          when o.sortOrder = 2 then convert(integer, @pv_TextValue02)
					          when o.sortOrder = 3 then convert(integer, @pv_TextValue03)
					          when o.sortOrder = 4 then convert(integer, @pv_TextValue04)
					          when o.sortOrder = 5 then convert(integer, @pv_TextValue05)
					          when o.sortOrder = 6 then convert(integer, @pv_TextValue06)
					          when o.sortOrder = 7 then convert(integer, @pv_TextValue07)
					          when o.sortOrder = 8 then convert(integer, @pv_TextValue08)
					          when o.sortOrder = 9 then convert(integer, @pv_TextValue09)
					          when o.sortOrder = 10 then convert(integer, @pv_TextValue10)
					          when o.sortOrder = 11 then convert(integer, @pv_TextValue11)
					          when o.sortOrder = 12 then convert(integer, @pv_TextValue12)
					          when o.sortOrder = 13 then convert(integer, @pv_TextValue13)
					          when o.sortOrder = 14 then convert(integer, @pv_TextValue14)
					          when o.sortOrder = 15 then convert(integer, @pv_TextValue15)
					          else null end
					end integerValue
			 , case when st.name = 'Free Form'
			        then case when o.sortOrder = 1 then @pv_TextValue01
					          when o.sortOrder = 2 then @pv_TextValue02
					          when o.sortOrder = 3 then @pv_TextValue03
					          when o.sortOrder = 4 then @pv_TextValue04
					          when o.sortOrder = 5 then @pv_TextValue05
					          when o.sortOrder = 6 then @pv_TextValue06
					          when o.sortOrder = 7 then @pv_TextValue07
					          when o.sortOrder = 8 then @pv_TextValue08
					          when o.sortOrder = 9 then @pv_TextValue09
					          when o.sortOrder = 10 then @pv_TextValue10
					          when o.sortOrder = 11 then @pv_TextValue11
					          when o.sortOrder = 12 then @pv_TextValue12
					          when o.sortOrder = 13 then @pv_TextValue13
					          when o.sortOrder = 14 then @pv_TextValue14
					          when o.sortOrder = 15 then @pv_TextValue15
					          else null end
					else null end textValue
		  FROM Match m
			   INNER JOIN GameEvent ge
			   ON ge.id = m.gameEventId
			   INNER JOIN Objective o
			   ON o.gameId = ge.gameId
			   INNER JOIN ScoringType st
			   ON st.id = o.scoringTypeId
		 WHERE m.id = @pv_MatchId ) AS SOURCE
	ON (TARGET.scoutRecordId = SOURCE.scoutRecordId
	AND TARGET.objectiveId = SOURCE.objectiveId)
    WHEN MATCHED AND (COALESCE(TARGET.integerValue, -999) <> COALESCE(SOURCE.integerValue, -999)
	               OR COALESCE(TARGET.textValue, '<XXXX>') <> COALESCE(SOURCE.textValue, '<XXXX>'))
    THEN UPDATE SET TARGET.integerValue = SOURCE.integerValue, TARGET.textValue = SOURCE.textValue
	WHEN NOT MATCHED
	THEN INSERT (scoutRecordId, objectiveId, integerValue, textValue) VALUES (SOURCE.scoutRecordId, SOURCE.objectiveId, SOURCE.integerValue, SOURCE.textValue);

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

    -- Resynch TBA data for all scout records
	exec sp_upd_scoutDataFromTba @pv_loginGUID;
END
GO

CREATE PROCEDURE sp_ins_scoutRobot  (@pv_TeamId integer
								   , @pv_loginGUID varchar(128)
                                   , @pv_TextValue01 varchar(4000) = null
                                   , @pv_TextValue02 varchar(4000) = null
                                   , @pv_TextValue03 varchar(4000) = null
                                   , @pv_TextValue04 varchar(4000) = null
                                   , @pv_TextValue05 varchar(4000) = null
                                   , @pv_TextValue06 varchar(4000) = null
                                   , @pv_TextValue07 varchar(4000) = null
                                   , @pv_TextValue08 varchar(4000) = null
                                   , @pv_TextValue09 varchar(4000) = null
                                   , @pv_TextValue10 varchar(4000) = null)
AS
declare @lv_AtributeId integer;
declare @lv_TeamAtributeId integer;
declare @lv_ScoringTypeName varchar(64);
declare @lv_IntegerValue integer;

BEGIN
	SET NOCOUNT ON
	-- Lookup Team Attribute Record
	if @pv_TextValue01 is not null
		BEGIN
		SELECT @lv_AtributeId = max(a.id)
		     , @lv_TeamAtributeId = max(ta.id)
			 , @lv_ScoringTypeName = max(st.name)
		  FROM Attribute a
		       INNER JOIN scoringType st
			   ON st.id = a.scoringTypeId
			   INNER JOIN v_GameEvent ge
			   ON ge.gameId = a.gameId
			   LEFT OUTER JOIN TeamAttribute ta
			   ON ta.attributeId = a.id
			   AND ta.teamId = @pv_TeamId
		 WHERE a.sortOrder = 1
		   AND ge.loginGUID = @pv_loginGUID;
		-- Decide if integer or text submitted
		IF @lv_ScoringTypeName = 'Free Form'
			BEGIN
			SET @lv_IntegerValue = NULL;
			END
		ELSE
			BEGIN
			SET @lv_IntegerValue = convert(integer, @pv_TextValue01);
			SET @pv_TextValue01 = NULL;
			END
		-- Add Team Attribute Record
		IF @lv_TeamAtributeId is null
			BEGIN
			INSERT INTO TeamAttribute (teamId, attributeId, integerValue, textValue)
			SELECT @pv_TeamId, @lv_AtributeId, @lv_IntegerValue, @pv_TextValue01;
			END
		ELSE
			BEGIN
			UPDATE TeamAttribute
               SET integerValue = @lv_IntegerValue
    			 , textValue = case when @pv_TextValue01 is null or @pv_TextValue01 = '' then textValue else @pv_TextValue01 end
             WHERE teamId = @pv_TeamId
			   AND attributeId = @lv_AtributeId;
			END
		END

	-- Lookup Team Attribute Record
	if @pv_TextValue02 is not null
		BEGIN
		SELECT @lv_AtributeId = max(a.id)
		     , @lv_TeamAtributeId = max(ta.id)
			 , @lv_ScoringTypeName = max(st.name)
		  FROM Attribute a
		       INNER JOIN scoringType st
			   ON st.id = a.scoringTypeId
			   INNER JOIN v_GameEvent ge
			   ON ge.gameId = a.gameId
			   LEFT OUTER JOIN TeamAttribute ta
			   ON ta.attributeId = a.id
			   AND ta.teamId = @pv_TeamId
		 WHERE a.sortOrder = 2
		   AND ge.loginGUID = @pv_loginGUID;
		-- Decide if integer or text submitted
		IF @lv_ScoringTypeName = 'Free Form'
			BEGIN
			SET @lv_IntegerValue = NULL;
			END
		ELSE
			BEGIN
			SET @lv_IntegerValue = convert(integer, @pv_TextValue02);
			SET @pv_TextValue02 = NULL;
			END
		-- Add Team Attribute Record
		IF @lv_TeamAtributeId is null
			BEGIN
			INSERT INTO TeamAttribute (teamId, attributeId, integerValue, textValue)
			SELECT @pv_TeamId, @lv_AtributeId, @lv_IntegerValue, @pv_TextValue02;
			END
		ELSE
			BEGIN
			UPDATE TeamAttribute
               SET integerValue = @lv_IntegerValue
    			 , textValue = case when @pv_TextValue02 is null or @pv_TextValue02 = '' then textValue else @pv_TextValue02 end
             WHERE teamId = @pv_TeamId
			   AND attributeId = @lv_AtributeId;
			END
		END

	-- Lookup Team Attribute Record
	if @pv_TextValue03 is not null
		BEGIN
		SELECT @lv_AtributeId = max(a.id)
		     , @lv_TeamAtributeId = max(ta.id)
			 , @lv_ScoringTypeName = max(st.name)
		  FROM Attribute a
		       INNER JOIN scoringType st
			   ON st.id = a.scoringTypeId
			   INNER JOIN v_GameEvent ge
			   ON ge.gameId = a.gameId
			   LEFT OUTER JOIN TeamAttribute ta
			   ON ta.attributeId = a.id
			   AND ta.teamId = @pv_TeamId
		 WHERE a.sortOrder = 3
		   AND ge.loginGUID = @pv_loginGUID;
		-- Decide if integer or text submitted
		IF @lv_ScoringTypeName = 'Free Form'
			BEGIN
			SET @lv_IntegerValue = NULL;
			END
		ELSE
			BEGIN
			SET @lv_IntegerValue = convert(integer, @pv_TextValue03);
			SET @pv_TextValue03 = NULL;
			END
		-- Add Team Attribute Record
		IF @lv_TeamAtributeId is null
			BEGIN
			INSERT INTO TeamAttribute (teamId, attributeId, integerValue, textValue)
			SELECT @pv_TeamId, @lv_AtributeId, @lv_IntegerValue, @pv_TextValue03;
			END
		ELSE
			BEGIN
			UPDATE TeamAttribute
               SET integerValue = @lv_IntegerValue
    			 , textValue = case when @pv_TextValue03 is null or @pv_TextValue03 = '' then textValue else @pv_TextValue03 end
             WHERE teamId = @pv_TeamId
			   AND attributeId = @lv_AtributeId;
			END
		END

	-- Lookup Team Attribute Record
	if @pv_TextValue04 is not null
		BEGIN
		SELECT @lv_AtributeId = max(a.id)
		     , @lv_TeamAtributeId = max(ta.id)
			 , @lv_ScoringTypeName = max(st.name)
		  FROM Attribute a
		       INNER JOIN scoringType st
			   ON st.id = a.scoringTypeId
			   INNER JOIN v_GameEvent ge
			   ON ge.gameId = a.gameId
			   LEFT OUTER JOIN TeamAttribute ta
			   ON ta.attributeId = a.id
			   AND ta.teamId = @pv_TeamId
		 WHERE a.sortOrder = 4
		   AND ge.loginGUID = @pv_loginGUID;
		-- Decide if integer or text submitted
		IF @lv_ScoringTypeName = 'Free Form'
			BEGIN
			SET @lv_IntegerValue = NULL;
			END
		ELSE
			BEGIN
			SET @lv_IntegerValue = convert(integer, @pv_TextValue04);
			SET @pv_TextValue04 = NULL;
			END
		-- Add Team Attribute Record
		IF @lv_TeamAtributeId is null
			BEGIN
			INSERT INTO TeamAttribute (teamId, attributeId, integerValue, textValue)
			SELECT @pv_TeamId, @lv_AtributeId, @lv_IntegerValue, @pv_TextValue04;
			END
		ELSE
			BEGIN
			UPDATE TeamAttribute
               SET integerValue = @lv_IntegerValue
    			 , textValue = case when @pv_TextValue04 is null or @pv_TextValue04 = '' then textValue else @pv_TextValue04 end
             WHERE teamId = @pv_TeamId
			   AND attributeId = @lv_AtributeId;
			END
		END

	-- Lookup Team Attribute Record
	if @pv_TextValue05 is not null
		BEGIN
		SELECT @lv_AtributeId = max(a.id)
		     , @lv_TeamAtributeId = max(ta.id)
			 , @lv_ScoringTypeName = max(st.name)
		  FROM Attribute a
		       INNER JOIN scoringType st
			   ON st.id = a.scoringTypeId
			   INNER JOIN v_GameEvent ge
			   ON ge.gameId = a.gameId
			   LEFT OUTER JOIN TeamAttribute ta
			   ON ta.attributeId = a.id
			   AND ta.teamId = @pv_TeamId
		 WHERE a.sortOrder = 5
		   AND ge.loginGUID = @pv_loginGUID;
		-- Decide if integer or text submitted
		IF @lv_ScoringTypeName = 'Free Form'
			BEGIN
			SET @lv_IntegerValue = NULL;
			END
		ELSE
			BEGIN
			SET @lv_IntegerValue = convert(integer, @pv_TextValue05);
			SET @pv_TextValue05 = NULL;
			END
		-- Add Team Attribute Record
		IF @lv_TeamAtributeId is null
			BEGIN
			INSERT INTO TeamAttribute (teamId, attributeId, integerValue, textValue)
			SELECT @pv_TeamId, @lv_AtributeId, @lv_IntegerValue, @pv_TextValue05;
			END
		ELSE
			BEGIN
			UPDATE TeamAttribute
               SET integerValue = @lv_IntegerValue
    			 , textValue = case when @pv_TextValue05 is null or @pv_TextValue05 = '' then textValue else @pv_TextValue05 end
             WHERE teamId = @pv_TeamId
			   AND attributeId = @lv_AtributeId;
			END
		END

	-- Lookup Team Attribute Record
	if @pv_TextValue06 is not null
		BEGIN
		SELECT @lv_AtributeId = max(a.id)
		     , @lv_TeamAtributeId = max(ta.id)
			 , @lv_ScoringTypeName = max(st.name)
		  FROM Attribute a
		       INNER JOIN scoringType st
			   ON st.id = a.scoringTypeId
			   INNER JOIN v_GameEvent ge
			   ON ge.gameId = a.gameId
			   LEFT OUTER JOIN TeamAttribute ta
			   ON ta.attributeId = a.id
			   AND ta.teamId = @pv_TeamId
		 WHERE a.sortOrder = 6
		   AND ge.loginGUID = @pv_loginGUID;
		-- Decide if integer or text submitted
		IF @lv_ScoringTypeName = 'Free Form'
			BEGIN
			SET @lv_IntegerValue = NULL;
			END
		ELSE
			BEGIN
			SET @lv_IntegerValue = convert(integer, @pv_TextValue06);
			SET @pv_TextValue06 = NULL;
			END
		-- Add Team Attribute Record
		IF @lv_TeamAtributeId is null
			BEGIN
			INSERT INTO TeamAttribute (teamId, attributeId, integerValue, textValue)
			SELECT @pv_TeamId, @lv_AtributeId, @lv_IntegerValue, @pv_TextValue06;
			END
		ELSE
			BEGIN
			UPDATE TeamAttribute
               SET integerValue = @lv_IntegerValue
    			 , textValue = case when @pv_TextValue06 is null or @pv_TextValue06 = '' then textValue else @pv_TextValue06 end
             WHERE teamId = @pv_TeamId
			   AND attributeId = @lv_AtributeId;
			END
		END

	-- Lookup Team Attribute Record
	if @pv_TextValue07 is not null
		BEGIN
		SELECT @lv_AtributeId = max(a.id)
		     , @lv_TeamAtributeId = max(ta.id)
			 , @lv_ScoringTypeName = max(st.name)
		  FROM Attribute a
		       INNER JOIN scoringType st
			   ON st.id = a.scoringTypeId
			   INNER JOIN v_GameEvent ge
			   ON ge.gameId = a.gameId
			   LEFT OUTER JOIN TeamAttribute ta
			   ON ta.attributeId = a.id
			   AND ta.teamId = @pv_TeamId
		 WHERE a.sortOrder = 7
		   AND ge.loginGUID = @pv_loginGUID;
		-- Decide if integer or text submitted
		IF @lv_ScoringTypeName = 'Free Form'
			BEGIN
			SET @lv_IntegerValue = NULL;
			END
		ELSE
			BEGIN
			SET @lv_IntegerValue = convert(integer, @pv_TextValue07);
			SET @pv_TextValue07 = NULL;
			END
		-- Add Team Attribute Record
		IF @lv_TeamAtributeId is null
			BEGIN
			INSERT INTO TeamAttribute (teamId, attributeId, integerValue, textValue)
			SELECT @pv_TeamId, @lv_AtributeId, @lv_IntegerValue, @pv_TextValue07;
			END
		ELSE
			BEGIN
			UPDATE TeamAttribute
               SET integerValue = @lv_IntegerValue
    			 , textValue = case when @pv_TextValue07 is null or @pv_TextValue07 = '' then textValue else @pv_TextValue07 end
             WHERE teamId = @pv_TeamId
			   AND attributeId = @lv_AtributeId;
			END
		END

	-- Lookup Team Attribute Record
	if @pv_TextValue08 is not null
		BEGIN
		SELECT @lv_AtributeId = max(a.id)
		     , @lv_TeamAtributeId = max(ta.id)
			 , @lv_ScoringTypeName = max(st.name)
		  FROM Attribute a
		       INNER JOIN scoringType st
			   ON st.id = a.scoringTypeId
			   INNER JOIN v_GameEvent ge
			   ON ge.gameId = a.gameId
			   LEFT OUTER JOIN TeamAttribute ta
			   ON ta.attributeId = a.id
			   AND ta.teamId = @pv_TeamId
		 WHERE a.sortOrder = 8
		   AND ge.loginGUID = @pv_loginGUID;
		-- Decide if integer or text submitted
		IF @lv_ScoringTypeName = 'Free Form'
			BEGIN
			SET @lv_IntegerValue = NULL;
			END
		ELSE
			BEGIN
			SET @lv_IntegerValue = convert(integer, @pv_TextValue08);
			SET @pv_TextValue08 = NULL;
			END
		-- Add Team Attribute Record
		IF @lv_TeamAtributeId is null
			BEGIN
			INSERT INTO TeamAttribute (teamId, attributeId, integerValue, textValue)
			SELECT @pv_TeamId, @lv_AtributeId, @lv_IntegerValue, @pv_TextValue08;
			END
		ELSE
			BEGIN
			UPDATE TeamAttribute
               SET integerValue = @lv_IntegerValue
    			 , textValue = case when @pv_TextValue08 is null or @pv_TextValue08 = '' then textValue else @pv_TextValue08 end
             WHERE teamId = @pv_TeamId
			   AND attributeId = @lv_AtributeId;
			END
		END

	-- Lookup Team Attribute Record
	if @pv_TextValue09 is not null
		BEGIN
		SELECT @lv_AtributeId = max(a.id)
		     , @lv_TeamAtributeId = max(ta.id)
			 , @lv_ScoringTypeName = max(st.name)
		  FROM Attribute a
		       INNER JOIN scoringType st
			   ON st.id = a.scoringTypeId
			   INNER JOIN v_GameEvent ge
			   ON ge.gameId = a.gameId
			   LEFT OUTER JOIN TeamAttribute ta
			   ON ta.attributeId = a.id
			   AND ta.teamId = @pv_TeamId
		 WHERE a.sortOrder = 9
		   AND ge.loginGUID = @pv_loginGUID;
		-- Decide if integer or text submitted
		IF @lv_ScoringTypeName = 'Free Form'
			BEGIN
			SET @lv_IntegerValue = NULL;
			END
		ELSE
			BEGIN
			SET @lv_IntegerValue = convert(integer, @pv_TextValue09);
			SET @pv_TextValue09 = NULL;
			END
		-- Add Team Attribute Record
		IF @lv_TeamAtributeId is null
			BEGIN
			INSERT INTO TeamAttribute (teamId, attributeId, integerValue, textValue)
			SELECT @pv_TeamId, @lv_AtributeId, @lv_IntegerValue, @pv_TextValue09;
			END
		ELSE
			BEGIN
			UPDATE TeamAttribute
               SET integerValue = @lv_IntegerValue
    			 , textValue = case when @pv_TextValue09 is null or @pv_TextValue09 = '' then textValue else @pv_TextValue09 end
             WHERE teamId = @pv_TeamId
			   AND attributeId = @lv_AtributeId;
			END
		END

	-- Lookup Team Attribute Record
	if @pv_TextValue10 is not null
		BEGIN
		SELECT @lv_AtributeId = max(a.id)
		     , @lv_TeamAtributeId = max(ta.id)
			 , @lv_ScoringTypeName = max(st.name)
		  FROM Attribute a
		       INNER JOIN scoringType st
			   ON st.id = a.scoringTypeId
			   INNER JOIN v_GameEvent ge
			   ON ge.gameId = a.gameId
			   LEFT OUTER JOIN TeamAttribute ta
			   ON ta.attributeId = a.id
			   AND ta.teamId = @pv_TeamId
		 WHERE a.sortOrder = 10
		   AND ge.loginGUID = @pv_loginGUID;
		-- Decide if integer or text submitted
		IF @lv_ScoringTypeName = 'Free Form'
			BEGIN
			SET @lv_IntegerValue = NULL;
			END
		ELSE
			BEGIN
			SET @lv_IntegerValue = convert(integer, @pv_TextValue10);
			SET @pv_TextValue10 = NULL;
			END
		-- Add Team Attribute Record
		IF @lv_TeamAtributeId is null
			BEGIN
			INSERT INTO TeamAttribute (teamId, attributeId, integerValue, textValue)
			SELECT @pv_TeamId, @lv_AtributeId, @lv_IntegerValue, @pv_TextValue10;
			END
		ELSE
			BEGIN
			UPDATE TeamAttribute
               SET integerValue = @lv_IntegerValue
    			 , textValue = case when @pv_TextValue10 is null or @pv_TextValue10 = '' then textValue else @pv_TextValue10 end
             WHERE teamId = @pv_TeamId
			   AND attributeId = @lv_AtributeId;
			END
		END

END
GO

CREATE PROCEDURE sp_upd_portionOfAlliancePoints
    (@pv_GameYear integer
    ,@pv_GameEventId integer)
as
begin
	SET NOCOUNT ON
	-- If year is 2020, allocate balanced hang points
	if @pv_GameYear = 2020
	begin
		-- Clear all portioning of points
		update TeamMatch
		   set portionOfAlliancePoints = null
		 where portionOfAlliancePoints is not null
		   and id in
			   (select tm.id
				  from TeamMatch tm
					   inner join Match m
					   on m.id = tm.matchId
				 where m.gameEventId = @pv_GameEventId);

		-- Set portion to zero if team did not hang
		update TeamMatch
		   set portionOfAlliancePoints = 0
		 where coalesce(portionOfAlliancePoints, -1) <> 0
		   and id in
			   (select tm.id
				  from TeamMatch tm
					   inner join Match m
					   on m.id = tm.matchId
				 where m.gameEventId = @pv_GameEventId)
		   and not exists
			   (select 1
				  from TeamMatchObjective tmo
				       inner join Objective o
					   on o.id = tmo.objectiveId
					   inner join Match m
					   on m.id = TeamMatch.matchId
				 where m.gameEventId = @pv_GameEventId
				   and tmo.teamMatchId = TeamMatch.id
				   and o.addTeamScorePortion = 'Y'
				   and tmo.scoreValue = 25); -- Indicates hang at end

		-- Set portion to alliance score divide by teams hanging
		update TeamMatch
		   set portionOfAlliancePoints =
			   convert(numeric(10,3),
			   (select case when TeamMatch.alliance = 'R'
							then m.redAlliancePoints
							when TeamMatch.alliance = 'B'
							then m.blueAlliancePoints
							else 0 end
				  from Match m
				 where m.id = TeamMatch.matchId)) /
			   convert(numeric(10,3),
			   (select count(*)
				  from TeamMatch tm
				 where tm.matchId = TeamMatch.matchId
				   and tm.alliance = TeamMatch.alliance
				   and tm.portionOfAlliancePoints is null))
		 where coalesce(portionOfAlliancePoints, -1) <> 0
		   and id in
			   (select tm.id
				  from TeamMatch tm
					   inner join Match m
					   on m.id = tm.matchId
				 where m.gameEventId = @pv_GameEventId);
	end
end
GO

*/
