-- Match Report (as a stored procedure to improve query performance
CREATE PROCEDURE sp_rpt_matchReport (@pv_matchId int
                                     ,@pv_loginGUID varchar(128)
									 ,@pv_is6217 int)
AS
BEGIN
	SET NOCOUNT ON

    -- Create and populate temp table of teams for this match
	CREATE TABLE #MatchTeams(teamId int);

	INSERT INTO #MatchTeams
	select tm.teamId
      from Match m
	       inner join v_GameEvent ge
	       on ge.id = m.gameEventId
           inner join TeamMatch tm
           on tm.matchId = m.id
	 where ge.loginGUID = @pv_loginGUID
	   and m.id = @pv_matchId;

	-- Create and populate temp table of Average Scout Records for the teams
	CREATE TABLE #AvgScoutRecord(teamId int, value1 numeric(11,3), value2 numeric(11,3), value3 numeric(11,3), value4 numeric(11,3), value5 numeric(11,3)
	                                       , value6 numeric(11,3), value7 numeric(11,3), value8 numeric(11,3), value9 numeric(11,3), value10 numeric(11,3)
	                                       , value11 numeric(11,3), value12 numeric(11,3), value13 numeric(11,3), value14 numeric(11,3), value15 numeric(11,3)
	                                       , value16 numeric(11,3), value17 numeric(11,3), value18 numeric(11,3), value19 numeric(11,3), value20 numeric(11,3)
	                                       , portionOfAlliancePoints numeric(11,3), totalScoreValue numeric(11,3)
										   , loginGUID uniqueidentifier, tbaScout int, matchId int, matchCnt int);

    INSERT INTO #AvgScoutRecord
	select asr.teamId
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
         , round(avg(asr.value16),2) value16
         , round(avg(asr.value17),2) value17
         , round(avg(asr.value18),2) value18
         , round(avg(asr.value19),2) value19
         , round(avg(asr.value20),2) value20
         , round(avg(asr.portionOfAlliancePoints),2) portionOfAlliancePoints
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
	             coalesce(asr.scoreValue15,0) +
	             coalesce(asr.scoreValue16,0) +
	             coalesce(asr.scoreValue17,0) +
	             coalesce(asr.scoreValue18,0) +
	             coalesce(asr.scoreValue19,0) +
	             coalesce(asr.scoreValue20,0) +
				 coalesce(asr.portionOfAlliancePoints,0)), 2) totalScoreValue
		 , loginGUID
		 , 0 tbaScout, @pv_matchId matchId
		 , count(asr.MatchId)
      from v_Report_AvgScoutRecord asr
     where asr.TeamId in (select teamId
                            from #MatchTeams)
	   and asr.loginGUID = @pv_loginGUID
       and asr.tbaScout = 0
       and exists (select 1
                     from match m2
                    where m2.id = asr.matchId
                      and m2.isActive = 'Y')
	group by asr.teamId, loginGUID;

	-- Add empty records for teams that haven't been scouted
	INSERT INTO #AvgScoutRecord
	select teamId, null value1, null value2, null value3, null value4, null value5, null value6, null value7, null value8, null value9, null value10
	             , null value11, null value12, null value13, null value14, null value15, null value16, null value17, null value18, null value19, null value20
				 , null portionOfAlliancePoints, 0 totalScoreValue, @pv_loginGUID loginGUID, 0 tbaScout, @pv_matchId matchId, 0 matchCnt
	  from #MatchTeams mt
	 where not exists
	       (select 1
		      from #AvgScoutRecord asr
			 where asr.teamId = mt.teamId);

	-- Handle query for returning 6217 hyperlinks
	IF @pv_is6217 != 0
		-- Team Average Scores
		select m.type + ' ' + m.number matchNumber
			 , tm.matchId
			 , tm.teamId
			 , t.TeamNumber
			 , t.teamName
			 , case when tm.alliance = 'R' then 'Red'
					when tm.alliance = 'B' then 'Blue'
					else tm.alliance end alliance
			 , tm.alliancePosition alliancePos
			 , '<a href="../Reports/robotReport6217.php?TeamId=' + convert(varchar, tm.teamId) + '"> ' + convert(varchar, t.teamNumber) + '</a> ' teamReportUrl
			 , asr.matchCnt
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
			 , round(asr.value16,2) value16
			 , round(asr.value17,2) value17
			 , round(asr.value18,2) value18
			 , round(asr.value19,2) value19
			 , round(asr.value20,2) value20
			 , asr.portionOfAlliancePoints
			 , asr.totalScoreValue
			 , ge.loginGUID
			 , (select max(sr.id)
				  from scoutRecord sr
				 where sr.matchId = tm.matchId
				   and sr.teamId = tm.teamId) scoutRecordId
		  from Match m
			   inner join v_GameEvent ge
			   on ge.id = m.gameEventId
			   inner join TeamMatch tm
			   on tm.matchId = m.id
			   inner join Team t
			   on t.id = tm.teamId
			   inner join #AvgScoutRecord asr
			   on asr.TeamId = tm.teamId
			   and asr.loginGUID = ge.loginGUID
		 where m.isActive = 'Y'
		   and m.id = @pv_matchId
		   and ge.loginGUID = @pv_loginGUID
        union
		-- Alliance Average Scores
		select subquery.matchNumber
			 , subquery.matchId
			 , null teamId
			 , null TeamNumber
			 , null teamName
			 , subquery.alliance
			 , 99 alliancePos
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
			 , sum(subquery.value16) value16
			 , sum(subquery.value17) value17
			 , sum(subquery.value18) value18
			 , sum(subquery.value19) value19
			 , sum(subquery.value20) value20
			 , sum(subquery.portionOfAlliancePoints) portionOfAlliancePoints
			 , sum(subquery.totalScoreValue) totalScoreValue
			 , subquery.loginGUID
			 , null scoutRecordId
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
			 , '<a href="../Reports/robotReport6217.php?TeamId=' + convert(varchar, tm.teamId) + '"> ' + convert(varchar, t.teamNumber) + '</a> ' teamReportUrl
			 , asr.matchCnt
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
			 , round(asr.value16,2) value16
			 , round(asr.value17,2) value17
			 , round(asr.value18,2) value18
			 , round(asr.value19,2) value19
			 , round(asr.value20,2) value20
			 , asr.portionOfAlliancePoints
			 , asr.totalScoreValue
			 , ge.loginGUID
		  from Match m
			   inner join v_GameEvent ge
			   on ge.id = m.gameEventId
			   inner join TeamMatch tm
			   on tm.matchId = m.id
			   inner join Team t
			   on t.id = tm.teamId
			   inner join #AvgScoutRecord asr
			   on asr.TeamId = tm.teamId
		 where m.isActive = 'Y'
		   and m.id = @pv_matchId
		   and ge.loginGUID = @pv_loginGUID) subquery
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
			 , null value16
			 , null value17
			 , null value18
			 , null value19
			 , null value20
			 , null portionOfAlliancePoints
			 , null totalScoreValue
			 , ge.loginGUID
			 , null scoutRecordId
		  from Match m
			   inner join v_GameEvent ge
			   on ge.id = m.gameEventId
		 where m.isActive = 'Y'
		   and m.id = @pv_matchId
		   and ge.loginGUID = @pv_loginGUID
		order by allianceSort, alliance desc, alliancePosition;
	-- Handle query for returning non-6217 hyperlinks
	ELSE
/*  -- Old method, save until sure performance improved
       select matchNumber
            , matchId
            , teamId
            , TeamNumber
            , teamName
            , alliance
            , alliancePosition alliancePos
            , teamReportUrl
            , matchCnt
            , allianceSort
            , value1
            , value2
            , value3
            , value4
            , value5
            , value6
            , value7
            , value8
            , value9
            , value10
            , value11
            , value12
            , value13
            , value14
            , value15
            , value16
            , value17
            , value18
            , value19
            , value20
            , portionOfAlliancePoints
            , totalScoreValue
            , loginGUID
	     from v_MatchReport
		where matchId = @pv_matchId
		  and loginGUID = @pv_loginGUID
*/
        -- Team Average Scores
		select m.type + ' ' + m.number matchNumber
			 , tm.matchId
			 , tm.teamId
			 , t.TeamNumber
			 , t.teamName
			 , case when tm.alliance = 'R' then 'Red'
					when tm.alliance = 'B' then 'Blue'
					else tm.alliance end alliance
			 , tm.alliancePosition alliancePos
			 , '<a href="../Reports/robotReport.php?TeamId=' + convert(varchar, tm.teamId) + '"> ' + convert(varchar, t.teamNumber) + '</a> ' teamReportUrl
			 , asr.matchCnt
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
			 , round(asr.value16,2) value16
			 , round(asr.value17,2) value17
			 , round(asr.value18,2) value18
			 , round(asr.value19,2) value19
			 , round(asr.value20,2) value20
			 , asr.portionOfAlliancePoints
			 , asr.totalScoreValue
			 , ge.loginGUID
			 , (select max(sr.id)
				  from scoutRecord sr
				 where sr.matchId = tm.matchId
				   and sr.teamId = tm.teamId) scoutRecordId
		  from Match m
			   inner join v_GameEvent ge
			   on ge.id = m.gameEventId
			   inner join TeamMatch tm
			   on tm.matchId = m.id
			   inner join Team t
			   on t.id = tm.teamId
			   inner join #AvgScoutRecord asr
			   on asr.TeamId = tm.teamId
			   and asr.loginGUID = ge.loginGUID
		 where m.isActive = 'Y'
		   and m.id = @pv_matchId
		   and ge.loginGUID = @pv_loginGUID
        union
		-- Alliance Average Scores
		select subquery.matchNumber
			 , subquery.matchId
			 , null teamId
			 , null TeamNumber
			 , null teamName
			 , subquery.alliance
			 , 99 alliancePos
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
			 , sum(subquery.value16) value16
			 , sum(subquery.value17) value17
			 , sum(subquery.value18) value18
			 , sum(subquery.value19) value19
			 , sum(subquery.value20) value20
			 , sum(subquery.portionOfAlliancePoints) portionOfAlliancePoints
			 , sum(subquery.totalScoreValue) totalScoreValue
			 , subquery.loginGUID
			 , null scoutRecordId
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
			 , asr.matchCnt
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
			 , round(asr.value16,2) value16
			 , round(asr.value17,2) value17
			 , round(asr.value18,2) value18
			 , round(asr.value19,2) value19
			 , round(asr.value20,2) value20
			 , asr.portionOfAlliancePoints
			 , asr.totalScoreValue
			 , ge.loginGUID
		  from Match m
			   inner join v_GameEvent ge
			   on ge.id = m.gameEventId
			   inner join TeamMatch tm
			   on tm.matchId = m.id
			   inner join Team t
			   on t.id = tm.teamId
			   inner join #AvgScoutRecord asr
			   on asr.TeamId = tm.teamId
		 where m.isActive = 'Y'
		   and m.id = @pv_matchId
		   and ge.loginGUID = @pv_loginGUID) subquery
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
			 , null value16
			 , null value17
			 , null value18
			 , null value19
			 , null value20
			 , null portionOfAlliancePoints
			 , null totalScoreValue
			 , ge.loginGUID
			 , null scoutRecordId
		  from Match m
			   inner join v_GameEvent ge
			   on ge.id = m.gameEventId
		 where m.isActive = 'Y'
		   and m.id = @pv_matchId
		   and ge.loginGUID = @pv_loginGUID
		order by allianceSort, alliance desc, alliancePosition;

END