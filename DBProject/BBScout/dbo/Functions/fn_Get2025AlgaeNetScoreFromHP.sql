-- Function to calculate score impact for objective
CREATE function fn_Get2025AlgaeNetScoreFromHP ( @pv_MatchId int
				                 			 , @pv_Alliance char(1))
returns int
as
begin
	declare @lv_Return int;
	declare @lv_OtherAllianceProc int;

-- Get the Score for the Net 	
select @lv_Return = coalesce(min(mo.scoreValue), 0)
  from MatchObjective mo
	   inner join Objective o
       on o.id = mo.objectiveId
 where mo.matchId = @pv_MatchId
   and mo.alliance = @pv_Alliance
   and o.name = 'toNet';

-- If not zero, then check the other alliance processor total
if (@lv_Return > 0)
begin
	select @lv_OtherAllianceProc = coalesce(min(mo.integerValue * 4), 0)
	  from MatchObjective mo
		   inner join Objective o
		   on o.id = mo.objectiveId
	 where mo.matchId = @pv_MatchId
	   and mo.alliance = case when @pv_Alliance = 'R' then 'B' else 'R' end
	   and o.name = 'toProc';

	-- Score is the minimum of the scores
	if (@lv_OtherAllianceProc < @lv_Return)
	begin
		set @lv_Return = @lv_OtherAllianceProc;
	end
end

return @lv_Return;
end;