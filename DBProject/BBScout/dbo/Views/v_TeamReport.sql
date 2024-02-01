-- View for Team history and average
CREATE view [dbo].[v_TeamReport] as
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
     , round(avg(sr.value16),2) value16
     , round(avg(sr.value17),2) value17
     , round(avg(sr.value18),2) value18
     , round(avg(sr.value19),2) value19
     , round(avg(sr.value20),2) value20
     , case when g.alliancePtsHeader is not null
	        then coalesce(round(avg(sr.portionOfAlliancePoints),2),0)
			else null end portionOfAlliancePoints
	 , coalesce(round(avg(sr.scoreValue1),2), 0) +
       coalesce(round(avg(sr.scoreValue2),2), 0) +
       coalesce(round(avg(sr.scoreValue3),2), 0) +
       coalesce(round(avg(sr.scoreValue4),2), 0) +
       coalesce(round(avg(sr.scoreValue5),2), 0) +
       coalesce(round(avg(sr.scoreValue6),2), 0) +
       coalesce(round(avg(sr.scoreValue7),2), 0) +
       coalesce(round(avg(sr.scoreValue8),2), 0) +
       coalesce(round(avg(sr.scoreValue9),2), 0) +
       coalesce(round(avg(sr.scoreValue10),2), 0) +
       coalesce(round(avg(sr.scoreValue11),2), 0) +
       coalesce(round(avg(sr.scoreValue12),2), 0) +
       coalesce(round(avg(sr.scoreValue13),2), 0) +
       coalesce(round(avg(sr.scoreValue14),2), 0) +
       coalesce(round(avg(sr.scoreValue15),2), 0) +
       coalesce(round(avg(sr.scoreValue16),2), 0) +
       coalesce(round(avg(sr.scoreValue17),2), 0) +
       coalesce(round(avg(sr.scoreValue18),2), 0) +
       coalesce(round(avg(sr.scoreValue19),2), 0) +
       coalesce(round(avg(sr.scoreValue20),2), 0) +
	   coalesce(round(avg(sr.portionOfAlliancePoints),2), 0) totalScoreValue
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
     , null textValue16
     , null textValue17
     , null textValue18
     , null textValue19
     , null textValue20
     , null videos
     , t.id TeamId
     , null matchId
     , null scoutId
	 , sr.gameEventId
	 , null scoutRecordId
	 , null scoutComment
	 , null robotPosition
	 , null matchScore
	 , sr.loginGUID
 from Team t
      inner join v_Report_AvgScoutRecord sr
      on sr.TeamId = t.id
      inner join Match m
      on m.id = sr.matchId
	  inner join gameEvent ge
	  on ge.id = sr.gameEventId
	  inner join game g
	  on g.id = ge.gameId
 where m.isActive = 'Y'
   and m.type in ('QM','PR')
group by t.TeamNumber
       , t.id
	   , sr.gameEventId
	   , g.alliancePtsHeader
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
     , sr.value16
     , sr.value17
     , sr.value18
     , sr.value19
     , sr.value20
     , case when g.alliancePtsHeader is not null
	        then coalesce(round(sr.portionOfAlliancePoints,2),0)
			else null end portionOfAlliancePoints
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
			 coalesce(sr.scoreValue15,0) +
			 coalesce(sr.scoreValue16,0) +
			 coalesce(sr.scoreValue17,0) +
			 coalesce(sr.scoreValue18,0) +
			 coalesce(sr.scoreValue19,0) +
			 coalesce(sr.scoreValue20,0) +
			 coalesce(sr.portionOfAlliancePoints, 0), 2) totalScoreValue
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
     , sr.textValue16
     , sr.textValue17
     , sr.textValue18
     , sr.textValue19
     , sr.textValue20
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
	 , tm.alliance + convert(varchar, tm.alliancePosition) robotPosition
	 , case when tm.alliance = 'R'
	        then convert(varchar, m.redScore) + '-' + convert(varchar, m.blueScore) + case when m.redScore > m.blueScore
			                                                                               then ' W'
																						   when m.blueScore > m.redScore
			                                                                               then ' L'
																						   when m.blueScore = m.redScore
																						   then ' T'
																						   else '' end
			when tm.alliance = 'B'
	        then convert(varchar, m.blueScore) + '-' + convert(varchar, m.redScore) + case when m.blueScore > m.redScore
			                                                                               then ' W'
																						   when m.redScore > m.blueScore
			                                                                               then ' L'
																						   when m.blueScore = m.redScore
																						   then ' T'
																						   else '' end
			else '' end matchScore
	 , sr.loginGUID
 from Team t
      inner join v_Report_ScoutRecord sr
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
	  inner join game g
	  on g.id = ge.gameId
	  inner join teamMatch tm
	  on tm.teamId = t.id
	  and tm.matchId = m.id
 where m.isActive = 'Y';
