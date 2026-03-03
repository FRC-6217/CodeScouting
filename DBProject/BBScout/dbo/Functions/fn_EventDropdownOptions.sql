
-- Function to return HTML for Event Dropdown options
CREATE function [dbo].[fn_EventDropdownOptions] ( @pv_EventId int
				                 	   , @pv_LoginGUID uniqueidentifier)
returns varchar(max)
as
begin
	declare @lv_Return varchar(max);

-- Get the Team Options
select @lv_Return = 
       STRING_AGG(CAST(
	   '<option value=' + convert(varchar, subquery.eventId) + 
       case when subquery.eventId = @pv_EventId then ' selected' else '' end +
	   '>' + convert(varchar, subquery.eventName) + '</option>'
	   as varchar(max))
	   , '') WITHIN GROUP (ORDER BY case when subquery.eventId = @pv_EventId then 0 else 1 end, subquery.eventName)
  from (
select distinct e.id eventId, e.name eventName
  from Scout s
       inner join Team t
	   on t.id = s.teamId
	   inner join TeamGameEvent tge
	   on tge.teamId = t.id
	   inner join GameEvent ge
	   on ge.id = tge.gameEventId
	   inner join Event e
	   on e.id = ge.eventId 
 where s.scoutGUID = @pv_LoginGUID
union
select distinct e.id eventId, e.name eventName
  from Event e
 where e.id = @pv_EventId
union
select distinct e.id eventId, e.name eventName
  from Event e
 where location like '%, MN'
    or location like '%, ND'
union
select 0 eventId, '(Choose Event)' eventName) as subquery;
return @lv_Return;
end;