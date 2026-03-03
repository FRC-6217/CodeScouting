-- Function to return HTML for Team Dropdown options
CREATE function [dbo].[fn_TeamDropdownOptions] ( @pv_TeamId int
				                 	   , @pv_LoginGUID uniqueidentifier
									   , @pv_EventId int)
returns varchar(max)
as
begin
	declare @lv_Return varchar(max);

-- Get the Team Options
select @lv_Return = 
       STRING_AGG(CAST(
	   '<option value=' + convert(varchar, subquery.teamId) + 
       case when subquery.teamId = @pv_TeamId then ' selected' else '' end +
	   '>' + convert(varchar, subquery.teamNumber) + '</option>'
	   as varchar(max))
	   , '') WITHIN GROUP (ORDER BY case when subquery.teamId = @pv_TeamId then 0 else 1 end, subquery.teamNumber)
  from (
select distinct et.id teamId, et.teamNumber
  from Scout s
       inner join Team t
	   on t.id = s.teamId
	   inner join TeamGameEvent tge
	   on tge.teamId = t.id
	   inner join TeamGameEvent tge2
	   on tge2.gameEventId = tge.gameEventId
	   inner join Team et
	   on et.id = tge2.teamId
	   inner join GameEvent ge
	   on ge.id = tge2.gameEventId
 where s.scoutGUID = @pv_LoginGUID
   and ge.eventId = coalesce(@pv_EventId, ge.eventId)
union
select distinct t.id teamId, t.teamNumber
  from team t
 where id = @pv_TeamId
union
select distinct t.id teamId, t.teamNumber
  from team t
 where location like '%Minnesota%'
   and @pv_EventId is null
union
select 0 teamId, 0 teamNumber) as subquery;

return @lv_Return;
end;