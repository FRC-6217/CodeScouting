/* Temp tables for No Mythic scout data
create table nm_RawMatchData (
  id integer IDENTITY(1,1) NOT NULL
, ScoutName varchar(128)
, ScoutTeam varchar(128)
, MatchType varchar(128)
, MatchNumber integer
, DriverStation varchar(128)
, TeamNumber integer
, StartingPosition varchar(128)
, Leave varchar(128)
, aCoralL4 integer
, aCoralL3 integer
, aCoralL2 integer
, aCoralL1 integer
, aAlgaeProc integer
, aAlgaeNet integer
, toAlgaeProc integer
, toAlgaeNet integer
, toCoralL4 integer
, toCoralL3 integer
, toCoralL2 integer
, toCoralL1 integer
, egClimbTimer numeric(12,2)
, egPosition varchar(128)
, egComments varchar(1024)
, Defense varchar(128)
, RobotDisabled varchar(128)
, RobotTipped varchar(128)
, Card varchar(128)
, Comments varchar(1024)
, CorrectedMatchNumber integer
, CorrectedDriverStation varchar(128)
, Skip integer
)
*/

/*
Excel Formulas
=IF(ISBLANK(C2),"","insert into nm_RawMatchData values ('"&A2&"', '"&B2&"', '"&C2&"', "&D2&", '"&E2&"', "&F2&", '"&H2&"', '"&IF(J2=TRUE,"Yes","No")&"', "&N2&", "&O2&", "&P2&", "&Q2&", "&T2&", "&U2&", "&Y2&", "&Z2&", "&AG2&", "&AH2&", "&AI2&", "&AJ2&", "&AN2&", '"&AP2&"', '"&SUBSTITUTE(AQ2,"'","''")&"', '"&AR2&"', '"&IF(AU2=TRUE,"Yes","No")&"', '"&AV2&"', '"&AW2&"', '"&SUBSTITUTE(IF(ISBLANK(AX2),AY2,AX2),"'","''")&"', null, null, null);")
=IF(C126="Qualifications","exec sp_ins_NM_scoutRecord 'zz"&B126&"', "&D126&", "&F126&", '"&E126&"', "&IF(ISBLANK(AX126),IF(ISBLANK(AY126),"null","'"&SUBSTITUTE(AY126,"'","''")&"'"),"'"&SUBSTITUTE(AX126,"'","''")&"'")&", 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', '"&IF(J126=TRUE,"Yes","No")&"', "&IF(ISBLANK(Q126),"0",Q126)&", "&IF(ISBLANK(P126),"0",P126)&", "&IF(ISBLANK(O126),"0",O126)&", "&IF(ISBLANK(N126),"0",N126)&", "&IF(ISBLANK(AJ126),"0",AJ126)&", "&IF(ISBLANK(AI126),"0",AI126)&", "&IF(ISBLANK(AH126),"0",AH126)&", "&IF(ISBLANK(AG126),"0",AG126)&", "&IF(ISBLANK(T126),0,T126)+IF(ISBLANK(Y126),0,Y126)&", "&IF(ISBLANK(U126),0,U126)+IF(ISBLANK(Z126),0,Z126)&", '"&IF(AP126="P","Park",IF(AP126="Dc","Deep",IF(AP126="Sc","Shallow","None")))&"', "&ROUND(AN126,0)&", "&IF(OR(AR126=1,AR126=2,AR126=3),AR126,0)&", '5', '-99', '-99', '-99', '-99', '-99'","")

insert into nm_RawMatchData values ('Margo', 'NoMythic', 'Qualifications', 81, 'R3', 6758, 'Red Barge', 'Yes', 0, 0, 0, 0, 0, 0, 0, 4, 1, 0, 0, 0, 0, 'Dc', 'looks like a deep climb, but its hard to tell if they are fully of the ground.', 'x', 'No', '1', 'No Card', '', null, null, null);
insert into nm_RawMatchData values ('Mickey', 'Wind Chill', 'Qualifications', 81, 'R1', 7041, 'Blue Barge', 'Yes', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Dc', 'Tried intaking pieces but was often blocked by defense', 'x', 'No', 'x', 'No Card', '', null, null, null);

exec sp_ins_NM_scoutRecord 'zzNoMythic', 2, 2239, 'R1', 'Didn''t see much, cage was swinging, didn''t leave during auto', 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'No', 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 'None', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzWind Chill', 2, 3691, 'B3', 'Only the robot''s elevator was moved during the match. ', 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'No', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'None', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_upd_scoutDataFromTba 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3';
*/

-- Verify Scouted Data matches schedule
select nm.id
     , nm.ScoutName
	 , nm.ScoutTeam
	 , nm.MatchNumber
	 , nm.DriverStation
	 , nm.TeamNumber
  from nm_RawMatchData nm
 where nm.matchType = 'Qualifications'
   and coalesce(nm.Skip, 0) = 0
   and not exists (
select g.name game
     , e.name event
	 , m.type
	 , m.number matchNbr
	 , tm.alliance
	 , tm.alliancePosition
	 , t.teamNumber
  from v_GameEvent ge
       inner join game g
	   on g.id = ge.gameId
	   inner join event e
	   on e.id = ge.eventId
	   inner join Match m
	   on m.gameEventId = ge.id
	   inner join TeamMatch tm
	   on tm.matchId = m.id
	   inner join Team t
	   on t.id = tm.teamId
 where ge.loginGUID = 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3'
   and m.type = 'QM'
   and convert(integer, m.number) = coalesce(nm.CorrectedMatchNumber, nm.MatchNumber)
   and t.teamNumber = nm.TeamNumber
   and tm.alliance + convert(varchar, tm.alliancePosition) = coalesce(nm.CorrectedDriverStation, nm.DriverStation)
--order by convert(integer, m.number), tm.alliance, tm.alliancePosition
)
/* Combine with unscouted matches
union
select null id
	 , null ScoutName
	 , null ScoutTeam
	 , m.number matchNbr
	 , tm.alliance + convert(varchar, tm.alliancePosition) alliancePos
	 , t.teamNumber
  from v_GameEvent ge
       inner join game g
	   on g.id = ge.gameId
	   inner join event e
	   on e.id = ge.eventId
	   inner join Match m
	   on m.gameEventId = ge.id
	   inner join TeamMatch tm
	   on tm.matchId = m.id
	   inner join Team t
	   on t.id = tm.teamId
 where ge.loginGUID = 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3'
   and m.type = 'QM'
   and not exists (select 1
                     from ScoutRecord sr
					      inner join Scout s
						  on s.id = sr.scoutId
					where sr.matchId = m.id
					  and sr.teamId = t.id
					  and s.lastName <> 'TBA')
*/
order by TeamNumber, MatchNumber, DriverStation

-- Duplicate scouted data
select *
  from nm_RawMatchData nm
       inner join (
			select MatchNumber, DriverStation, TeamNumber, count(*) cnt
			  from nm_RawMatchData nm
			 where nm.matchType = 'Qualifications'
			   and coalesce(skip, 0) <> 1
			group by MatchNumber, DriverStation, TeamNumber
			having count(*) > 1) dup
       on dup.MatchNumber = nm.MatchNumber
	   and dup.DriverStation = nm.DriverStation
	   and dup.TeamNumber = nm.TeamNumber
 where nm.MatchType = 'Qualifications'
   and coalesce(nm.Skip, 0) = 0
order by nm.MatchNumber, nm.DriverStation, nm.TeamNumber

--update nm_RawMatchData set Skip = 1 where id = 428

-- Multiple Robots on same Match/Driver Station
select subquery.*
     , case when DriverStation = 'R1' and TeamNumber = r1Team
              or DriverStation = 'R2' and TeamNumber = r2Team
              or DriverStation = 'R3' and TeamNumber = r3Team
              or DriverStation = 'B1' and TeamNumber = b1Team
              or DriverStation = 'B2' and TeamNumber = b2Team
              or DriverStation = 'B3' and TeamNumber = b3Team
            then ''
			when TeamNumber = r1Team
			then 'update nm_RawMatchData set CorrectedDriverStation = ''R1'' where id = ' + convert(varchar, subquery.id)
			when TeamNumber = r2Team
			then 'update nm_RawMatchData set CorrectedDriverStation = ''R2'' where id = ' + convert(varchar, subquery.id)
			when TeamNumber = r3Team
			then 'update nm_RawMatchData set CorrectedDriverStation = ''R3'' where id = ' + convert(varchar, subquery.id)
			when TeamNumber = b1Team
			then 'update nm_RawMatchData set CorrectedDriverStation = ''B1'' where id = ' + convert(varchar, subquery.id)
			when TeamNumber = b2Team
			then 'update nm_RawMatchData set CorrectedDriverStation = ''B2'' where id = ' + convert(varchar, subquery.id)
			when TeamNumber = b3Team
			then 'update nm_RawMatchData set CorrectedDriverStation = ''B3'' where id = ' + convert(varchar, subquery.id)
			else 'Robot Not in Match' end stmt
  from (
select nm.id, nm.ScoutName, nm.ScoutTeam, nm.MatchNumber, nm.DriverStation, nm.TeamNumber
     , (select t.teamNumber
	      from v_GameEvent ge
		       inner join Match m
			   on m.gameEventId = ge.id
			   inner join TeamMatch tm
			   on tm.matchId = m.id
			   inner join Team t
			   on t.id = tm.teamId
		 where ge.loginGUID = 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3'
           and m.type = 'QM'  
           and convert(integer, m.number) = coalesce(nm.CorrectedMatchNumber, nm.MatchNumber)
           and tm.alliance = 'R' and tm.alliancePosition = 1) r1Team
     , (select t.teamNumber
	      from v_GameEvent ge
		       inner join Match m
			   on m.gameEventId = ge.id
			   inner join TeamMatch tm
			   on tm.matchId = m.id
			   inner join Team t
			   on t.id = tm.teamId
		 where ge.loginGUID = 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3'
           and m.type = 'QM'  
           and convert(integer, m.number) = coalesce(nm.CorrectedMatchNumber, nm.MatchNumber)
           and tm.alliance = 'R' and tm.alliancePosition = 2) r2Team
     , (select t.teamNumber
	      from v_GameEvent ge
		       inner join Match m
			   on m.gameEventId = ge.id
			   inner join TeamMatch tm
			   on tm.matchId = m.id
			   inner join Team t
			   on t.id = tm.teamId
		 where ge.loginGUID = 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3'
           and m.type = 'QM'  
           and convert(integer, m.number) = coalesce(nm.CorrectedMatchNumber, nm.MatchNumber)
           and tm.alliance = 'R' and tm.alliancePosition = 3) r3Team
     , (select t.teamNumber
	      from v_GameEvent ge
		       inner join Match m
			   on m.gameEventId = ge.id
			   inner join TeamMatch tm
			   on tm.matchId = m.id
			   inner join Team t
			   on t.id = tm.teamId
		 where ge.loginGUID = 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3'
           and m.type = 'QM'  
           and convert(integer, m.number) = coalesce(nm.CorrectedMatchNumber, nm.MatchNumber)
           and tm.alliance = 'B' and tm.alliancePosition = 1) b1Team
     , (select t.teamNumber
	      from v_GameEvent ge
		       inner join Match m
			   on m.gameEventId = ge.id
			   inner join TeamMatch tm
			   on tm.matchId = m.id
			   inner join Team t
			   on t.id = tm.teamId
		 where ge.loginGUID = 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3'
           and m.type = 'QM'  
           and convert(integer, m.number) = coalesce(nm.CorrectedMatchNumber, nm.MatchNumber)
           and tm.alliance = 'B' and tm.alliancePosition = 2) b2Team
     , (select t.teamNumber
	      from v_GameEvent ge
		       inner join Match m
			   on m.gameEventId = ge.id
			   inner join TeamMatch tm
			   on tm.matchId = m.id
			   inner join Team t
			   on t.id = tm.teamId
		 where ge.loginGUID = 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3'
           and m.type = 'QM'  
           and convert(integer, m.number) = coalesce(nm.CorrectedMatchNumber, nm.MatchNumber)
           and tm.alliance = 'B' and tm.alliancePosition = 3) b3Team
  from nm_RawMatchData nm
       inner join (
			select coalesce(nm.CorrectedMatchNumber, nm.MatchNumber) MatchNumber, coalesce(nm.CorrectedDriverStation, nm.DriverStation) DriverStation, count(*) cnt
			  from nm_RawMatchData nm
			 where nm.matchType = 'Qualifications'
               and coalesce(nm.Skip, 0) = 0
			group by coalesce(nm.CorrectedMatchNumber, nm.MatchNumber), coalesce(nm.CorrectedDriverStation, nm.DriverStation)
			having count(*) > 1) dup
       on dup.MatchNumber = coalesce(nm.CorrectedMatchNumber, nm.MatchNumber)
	   and dup.DriverStation = coalesce(nm.CorrectedDriverStation, nm.DriverStation)
 where nm.MatchType = 'Qualifications'
   and coalesce(nm.Skip, 0) = 0) subquery
order by stmt, MatchNumber, DriverStation, TeamNumber

-- Validate Team Numbers
select *
  from nm_RawMatchData nm
 where nm.MatchType = 'Qualifications'
   and coalesce(nm.Skip, 0) = 0
   and teamNumber not in
      (select convert(varchar, t.teamNumber)
	     from v_GameEvent ge
		      inner join TeamGameEvent tge
			  on tge.gameEventId = ge.id
			  inner join Team t
			  on t.id = tge.teamId
		 where ge.loginGUID = 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3')
order by nm.MatchNumber, nm.DriverStation, nm.TeamNumber

/*
update nm_RawMatchData set CorrectedDriverStation = 'B3' where id = 204
update nm_RawMatchData set CorrectedDriverStation = 'R1' where id = 206
update nm_RawMatchData set CorrectedDriverStation = 'B2' where id = 383
update nm_RawMatchData set CorrectedDriverStation = 'B3' where id = 182
update nm_RawMatchData set CorrectedDriverStation = 'B3' where id = 183
update nm_RawMatchData set CorrectedDriverStation = 'B3' where id = 188
update nm_RawMatchData set CorrectedDriverStation = 'B3' where id = 198
update nm_RawMatchData set CorrectedDriverStation = 'B3' where id = 210
update nm_RawMatchData set CorrectedDriverStation = 'B3' where id = 220
update nm_RawMatchData set CorrectedDriverStation = 'B3' where id = 221
update nm_RawMatchData set CorrectedDriverStation = 'R2' where id = 416
update nm_RawMatchData set CorrectedDriverStation = 'B3' where id = 230
update nm_RawMatchData set CorrectedDriverStation = 'B2' where id = 234
update nm_RawMatchData set CorrectedDriverStation = 'B3' where id = 237
update nm_RawMatchData set CorrectedDriverStation = 'B3' where id = 246
update nm_RawMatchData set CorrectedDriverStation = 'B3' where id = 253
update nm_RawMatchData set CorrectedDriverStation = 'B3' where id = 260
update nm_RawMatchData set CorrectedDriverStation = 'B3' where id = 266
update nm_RawMatchData set CorrectedDriverStation = 'B3' where id = 269
update nm_RawMatchData set CorrectedDriverStation = 'B3' where id = 274
update nm_RawMatchData set CorrectedDriverStation = 'B1' where id = 326
update nm_RawMatchData set CorrectedDriverStation = 'B1' where id = 332
update nm_RawMatchData set CorrectedDriverStation = 'B1' where id = 346
update nm_RawMatchData set CorrectedDriverStation = 'B1' where id = 351
update nm_RawMatchData set CorrectedDriverStation = 'B1' where id = 356
update nm_RawMatchData set CorrectedDriverStation = 'B1' where id = 359
update nm_RawMatchData set CorrectedDriverStation = 'B1' where id = 364
update nm_RawMatchData set CorrectedDriverStation = 'R3' where id = 402
update nm_RawMatchData set CorrectedDriverStation = 'B1' where id = 536
update nm_RawMatchData set CorrectedMatchNumber = 35 where id = 293
update nm_RawMatchData set CorrectedMatchNumber = 33 where id = 282
update nm_RawMatchData set CorrectedMatchNumber = 65 where id = 478
update nm_RawMatchData set CorrectedMatchNumber = 76 where id = 544
update nm_RawMatchData set CorrectedMatchNumber = 76 where id = 540
update nm_RawMatchData set CorrectedMatchNumber = 76 where id = 543
update nm_RawMatchData set CorrectedMatchNumber = 79 where id = 559
update nm_RawMatchData set CorrectedDriverStation = 'B3', TeamNumber = 4360 where id = 242 and TeamNumber = 4390

update nm_RawMatchData set CorrectedDriverStation = 'B1' where id = 385
update nm_RawMatchData set CorrectedDriverStation = 'B3' where id = 204
update nm_RawMatchData set CorrectedMatchNumber = 36 where id = 301
update nm_RawMatchData set CorrectedMatchNumber = 32 where id = 277
update nm_RawMatchData set CorrectedDriverStation = 'B3' where id = 206
update nm_RawMatchData set CorrectedDriverStation = 'B3' where id = 228
update nm_RawMatchData set CorrectedMatchNumber = 21 where id = 422
update nm_RawMatchData set CorrectedDriverStation = 'B1' where id = 340
update nm_RawMatchData set CorrectedMatchNumber = 35 where id = 295
update nm_RawMatchData set CorrectedMatchNumber = 31 where id = 271
update nm_RawMatchData set CorrectedMatchNumber = 75 where id = 528
*/

-- Import NM data into BBScout
select 'exec sp_ins_NM_scoutRecord ''zz' + ScoutTeam + ''', ' +
                                   convert(varchar, coalesce(CorrectedMatchNumber, MatchNumber)) + ', ' +
								   convert(varchar, TeamNumber) + ', ' +
								   '''' + coalesce(CorrectedDriverStation, DriverStation) + ''', ' +
								   case when Comments = ''
								        then 'null' + ', '
										else '''' + replace(Comments, '''', '''''') + ''', ' end +
								   '''B5671FC7-28DF-48E3-B2A7-F31F5FC509C3'', ' +
								   '''' + Leave + ''', ' +
								   convert(varchar, aCoralL1) + ', ' +
								   convert(varchar, aCoralL2) + ', ' +
								   convert(varchar, aCoralL3) + ', ' +
								   convert(varchar, aCoralL4) + ', ' +
								   convert(varchar, toCoralL1) + ', ' +
								   convert(varchar, toCoralL2) + ', ' +
								   convert(varchar, toCoralL3) + ', ' +
								   convert(varchar, toCoralL4) + ', ' +
								   convert(varchar, aAlgaeProc + toAlgaeProc) + ', ' +
								   convert(varchar, aAlgaeNet + toAlgaeNet) + ', ' +
								   '''' + case when egPosition = 'P'
								               then 'Park'
										       when egPosition = 'Dc'
								               then 'Deep'
										       when egPosition = 'Sc'
								               then 'Shallow'
										       else 'None' end + ''', ' +
								   substring(convert(varchar, round(egClimbTimer, 0)), 1, 1) + ', ' +
								   case when Defense in ('1', '2', '3')
								        then Defense
										else '0' end + ', ' +
								   '''5'', ''-99'', ''-99'', ''-99'', ''-99'', ''-99''' stmt
  from nm_RawMatchData nm
 where nm.matchType = 'Qualifications'
   and coalesce(skip, 0) <> 1
   and (CorrectedMatchNumber is not null 
     or CorrectedDriverStation is not null)
order by coalesce(CorrectedMatchNumber, MatchNumber), coalesce(CorrectedDriverStation, DriverStation)

/*
exec sp_ins_NM_scoutRecord 'zzNoMythic', 4, 5253, 'B2', null, 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'Yes', 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 'Park', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzWind Chill', 12, 2239, 'B3', null, 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'Yes', 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 'None', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzWind Chill', 13, 10474, 'B3', null, 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'Yes', 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 'Park', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzWind Chill', 14, 525, 'B3', null, 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'Yes', 0, 0, 0, 1, 4, 0, 1, 5, 0, 0, 'None', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzWind Chill', 16, 4360, 'B3', null, 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'Yes', 0, 0, 0, 0, 4, 5, 0, 0, 0, 0, 'None', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzWind Chill', 17, 1716, 'B3', null, 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'Yes', 0, 0, 0, 0, 2, 1, 0, 0, 0, 0, 'None', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzNoMythic', 17, 2512, 'R1', 'no show', 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'No', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'None', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzWind Chill', 18, 5232, 'B3', 'Very good defense ', 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'No', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'None', 0, 3, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzWind Chill', 19, 1410, 'B3', 'Was defense by others', 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'Yes', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'None', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzWind Chill', 20, 2240, 'B3', null, 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'Yes', 0, 0, 0, 0, 0, 0, 5, 6, 0, 0, 'None', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzNoMythic', 21, 112, 'B1', 'Entirely an Algae bot. Did nothing besides score algae', 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'Yes', 0, 0, 0, 0, 0, 0, 0, 0, 3, 2, 'None', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzNoMythic', 21, 3054, 'B3', 'Focused entirely on placing coral on L1, was having trouble getting it to stick to L1.', 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'No', 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 'Park', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzWind Chill', 23, 2512, 'B3', null, 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'No', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'None', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzNoMythic', 23, 2239, 'R2', 'tried to get an l4, dropped it, caught it, then got on l4', 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'No', 0, 0, 0, 0, 0, 0, 1, 3, 0, 0, 'Park', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzRobettes', 24, 5690, 'B2', '2450-drive team present but no robot present', 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'No', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'None', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzWind Chill', 24, 4166, 'B3', 'didnt score', 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'Yes', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Park', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzWind Chill', 25, 7048, 'B3', 'great teamwork', 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'Yes', 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'Park', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzWind Chill', 26, 4360, 'B3', null, 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'Yes', 0, 0, 0, 0, 0, 2, 4, 1, 0, 0, 'None', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzWind Chill', 27, 2290, 'B3', null, 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'Yes', 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'Park', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzWind Chill', 28, 112, 'B3', null, 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'Yes', 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 'None', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzWind Chill', 29, 6160, 'B3', null, 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'Yes', 1, 0, 0, 0, 3, 3, 0, 0, 0, 0, 'Park', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzWind Chill', 30, 2239, 'B3', null, 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'Yes', 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 'Park', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzWind Chill', 31, 5690, 'B3', null, 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'Yes', 1, 0, 0, 0, 0, 1, 3, 0, 1, 0, 'None', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzRobettes', 31, 4166, 'R3', null, 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'Yes', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Park', 0, 2, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzWind Chill', 32, 2513, 'B3', 'rammed into another robot causing its arm to fall off', 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'Yes', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Park', 0, 3, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzRobettes', 32, 2501, 'R3', null, 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'Yes', 0, 0, 0, 0, 0, 0, 1, 0, 5, 5, 'Deep', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzRobettes', 33, 2290, 'R3', null, 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'Yes', 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 'Park', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzNoMythic', 35, 4593, 'B2', 'team 4215', 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'Yes', 0, 0, 0, 1, 0, 1, 3, 2, 0, 0, 'Park', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzRobettes', 35, 3691, 'R3', null, 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'No', 0, 0, 0, 0, 0, 0, 2, 4, 0, 0, 'Park', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzRobettes', 36, 1816, 'R3', null, 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'Yes', 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'Park', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzRobettes', 41, 2290, 'B1', null, 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'Yes', 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 'Park', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzRobettes', 42, 2177, 'B1', null, 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'Yes', 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 'Park', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzRobettes', 43, 3298, 'B1', null, 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'Yes', 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 'Park', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzRobettes', 44, 5913, 'B1', null, 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'Yes', 0, 0, 0, 1, 0, 0, 2, 6, 0, 0, 'None', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzRobettes', 45, 111, 'B1', null, 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'Yes', 0, 0, 0, 2, 0, 0, 7, 1, 0, 3, 'Deep', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzRobettes', 46, 4360, 'B1', 'Had consistent cycles and coral scoring ', 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'Yes', 0, 0, 0, 0, 0, 2, 5, 0, 0, 0, 'Park', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzRobettes', 47, 10173, 'B1', ' Very good cycles ', 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'Yes', 0, 0, 0, 0, 2, 4, 4, 0, 0, 0, 'Park', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzRobettes', 48, 3883, 'B1', null, 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'No', 1, 0, 0, 0, 1, 0, 0, 6, 0, 0, 'Deep', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzRobettes', 53, 6047, 'R3', null, 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'Yes', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'None', 0, 2, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzWind Chill', 65, 4009, 'B3', 'fast cycle times!', 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'No', 0, 0, 0, 1, 0, 2, 3, 2, 0, 0, 'None', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzWind Chill', 75, 3054, 'B1', null, 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'Yes', 0, 0, 0, 0, 0, 0, 3, 3, 0, 0, 'Park', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzWind Chill', 75, 4166, 'B3', 'only played defense no scoring', 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'Yes', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Park', 0, 2, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzRobettes', 76, 525, 'B1', null, 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'No', 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 'None', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzRobettes', 76, 111, 'B2', 'Very efficient cycles', 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'No', 0, 0, 0, 1, 0, 0, 6, 2, 0, 1, 'Deep', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzWind Chill', 76, 4418, 'B3', null, 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'Yes', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'None', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_ins_NM_scoutRecord 'zzWind Chill', 79, 7048, 'R1', null, 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3', 'Yes', 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 'Park', 0, 0, '5', '-99', '-99', '-99', '-99', '-99'
exec sp_upd_scoutDataFromTba 'B5671FC7-28DF-48E3-B2A7-F31F5FC509C3';
*/


