-- View for Rank Report with Playoff Started indicator
CREATE view [dbo].[v_PlayoffStarted] as
select s.scoutGUID
     , s.emailAddress
     , case when convert(decimal(18,10), (coalesce(max(m.dateTime), '12/31/2099') - convert(datetime, SYSDATETIMEOFFSET() AT TIME ZONE 'Central Standard Time'))) - (15.0 / 24.0 / 60.0) < 0
	        then 1
			else 0 end playoffStarted
	 , (select count(*)
	      from TeamGameEvent tge
		 where tge.gameEventId = ge.id
		   and coalesce(tge.selectedForPlayoff, 'N') = 'Y') cntPlayoffSelected
  from Scout s
       inner join team t
	   on t.id = s.teamId
	   inner join gameEvent ge
	   on ge.id = t.gameEventId
	   left outer join match m
	   on m.gameEventId = ge.id
group by s.scoutGUID
       , s.emailAddress
	   , ge.id;