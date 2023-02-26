-- Function to calculate score impact for objective
CREATE function [dbo].[calcScoreValue] (@pv_ObjectiveId int
                             , @pv_IntegerValue int
							 , @pv_DecimalValue decimal(18,2))
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
