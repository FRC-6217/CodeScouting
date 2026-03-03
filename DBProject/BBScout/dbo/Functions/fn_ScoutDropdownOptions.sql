-- Function to return HTML for Scout Dropdown options
CREATE function [dbo].[fn_ScoutDropdownOptions] ( @pv_ScoutId int
                                               , @pv_LoginGUID uniqueidentifier)
returns varchar(max)
as
begin
	declare @lv_Return varchar(max);

-- Get the Scount Options
select @lv_Return = 
       STRING_AGG(CAST(
       '<option value=' + convert(varchar, subquery.id) + 
       case when subquery.id = @pv_ScoutId then ' selected' else '' end +
	   '>' + subquery.fullName + '</option>'
	   as varchar(max))
	   , '') WITHIN GROUP (ORDER BY subquery.fullName)
from (
select distinct ts.id, ts.lastName + ', ' + ts.firstName fullName
  from Scout s
       inner join Team t
	   on t.id = s.teamId
	   inner join Scout ts
	   on ts.teamId = t.id
 where ts.isActive = 'Y'
   and s.scoutGUID = @pv_LoginGUID
union
select s.id, s.lastName + ', ' + s.firstName fullName
  from Scout s
 where s.id = @pv_ScoutId
) subquery

return @lv_Return;
end;