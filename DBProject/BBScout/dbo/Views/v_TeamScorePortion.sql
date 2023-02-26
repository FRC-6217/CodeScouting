				   CREATE view v_TeamScorePortion as
                   select subquery.matchId
				        , subquery.gameEventId
						, subquery.alliance
						, subquery.teamId
						, sum(intTeamScorePortion) intTeamScorePortion
						, sum(scrTeamScorePortion) scrTeamScorePortion
					 from (
				   select m.id matchId
				        , m.gameEventId
						, sr.teamId
						, o.id objectiveId
						, tm.alliance
						, max(coalesce(sor.integerValue, 0)) intTeamScorePortion
						, max(coalesce(sor.scoreValue, 0)) scrTeamScorePortion
				     from Match m
					      inner join ScoutRecord sr
						  on sr.matchId = m.id
						  inner join ScoutObjectiveRecord sor
						  on sor.scoutRecordId = sr.id
						  inner join Objective o
						  on o.id = sor.objectiveId
						  inner join TeamMatch tm
						  on tm.matchId = sr.matchId
						  and tm.teamId = sr.teamId
					where o.addTeamScorePortion = 'Y'
                    group by m.id
				           , m.gameEventId
						   , sr.teamId
						   , o.id
						   , tm.alliance) subquery
					group by subquery.matchId
                           , subquery.gameEventId
						   , subquery.teamId
						   , subquery.alliance