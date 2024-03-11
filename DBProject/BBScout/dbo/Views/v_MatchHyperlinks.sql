-- View for Match Teams
CREATE view [dbo].[v_MatchHyperlinks] as
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
select case when m.redScore is null and m.blueScore is null
             and m.number not like '%-3'
            then 0
			when m.redScore is not null and m.blueScore is not null
			then 1
            when convert(decimal(18,10), (m.datetime - convert(datetime, SYSDATETIMEOFFSET() AT TIME ZONE 'Central Standard Time'))) + (15.0 / 24.0 / 60.0) < 0
            then 1
			else 0 end sortOrder
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
