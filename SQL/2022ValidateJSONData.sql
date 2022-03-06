declare @jsonData nvarchar(max)

select @jsonData = jsonData
from GameEventJSON
where gameEventId = 35
  and jsonType = 'Match'

-- Validate Blue Auto Cargo
select *
  from (
select json_value(value, '$.key') matchKey
     , convert(int, json_value(value, '$.score_breakdown.blue.autoCargoTotal')) autoCargoTotalBlue
     , convert(int, json_value(value, '$.score_breakdown.blue.autoCargoLowerBlue')) +
	   convert(int, json_value(value, '$.score_breakdown.blue.autoCargoLowerFar')) +
	   convert(int, json_value(value, '$.score_breakdown.blue.autoCargoLowerNear')) +
	   convert(int, json_value(value, '$.score_breakdown.blue.autoCargoLowerRed')) autoCargoLowerBlue
     , convert(int, json_value(value, '$.score_breakdown.blue.autoCargoUpperBlue')) +
	   convert(int, json_value(value, '$.score_breakdown.blue.autoCargoUpperFar')) +
	   convert(int, json_value(value, '$.score_breakdown.blue.autoCargoUpperNear')) +
	   convert(int, json_value(value, '$.score_breakdown.blue.autoCargoUpperRed')) autoCargoUpperBlue
     , convert(int, json_value(value, '$.score_breakdown.blue.autoCargoPoints')) autoCargoPointsBlue
     , (convert(int, json_value(value, '$.score_breakdown.blue.autoCargoLowerBlue')) +
	    convert(int, json_value(value, '$.score_breakdown.blue.autoCargoLowerFar')) +
	    convert(int, json_value(value, '$.score_breakdown.blue.autoCargoLowerNear')) +
	    convert(int, json_value(value, '$.score_breakdown.blue.autoCargoLowerRed')))
	   * 2 +
       (convert(int, json_value(value, '$.score_breakdown.blue.autoCargoUpperBlue')) +
	    convert(int, json_value(value, '$.score_breakdown.blue.autoCargoUpperFar')) +
	    convert(int, json_value(value, '$.score_breakdown.blue.autoCargoUpperNear')) +
	    convert(int, json_value(value, '$.score_breakdown.blue.autoCargoUpperRed')))
	   * 4 autoCargoPointsCalcBlue
  from openjson(@jsonData)) subquery
 where 1<>1
    or (subquery.autoCargoTotalBlue = 0 and subquery.autoCargoPointsBlue > 0)
    or subquery.autoCargoTotalBlue <> subquery.autoCargoLowerBlue + subquery.autoCargoUpperBlue
    or subquery.autoCargoPointsBlue <> subquery.autoCargoPointsCalcBlue

-- Validate Blue Teleop Cargo
select *
  from (
select json_value(value, '$.key') matchKey
     , convert(int, json_value(value, '$.score_breakdown.blue.teleopCargoTotal')) teleopCargoTotalBlue
     , convert(int, json_value(value, '$.score_breakdown.blue.teleopCargoLowerBlue')) +
	   convert(int, json_value(value, '$.score_breakdown.blue.teleopCargoLowerFar')) +
	   convert(int, json_value(value, '$.score_breakdown.blue.teleopCargoLowerNear')) +
	   convert(int, json_value(value, '$.score_breakdown.blue.teleopCargoLowerRed')) teleopCargoLowerBlue
     , convert(int, json_value(value, '$.score_breakdown.blue.teleopCargoUpperBlue')) +
	   convert(int, json_value(value, '$.score_breakdown.blue.teleopCargoUpperFar')) +
	   convert(int, json_value(value, '$.score_breakdown.blue.teleopCargoUpperNear')) +
	   convert(int, json_value(value, '$.score_breakdown.blue.teleopCargoUpperRed')) teleopCargoUpperBlue
     , convert(int, json_value(value, '$.score_breakdown.blue.teleopCargoPoints')) teleopCargoPointsBlue
     , (convert(int, json_value(value, '$.score_breakdown.blue.teleopCargoLowerBlue')) +
	    convert(int, json_value(value, '$.score_breakdown.blue.teleopCargoLowerFar')) +
	    convert(int, json_value(value, '$.score_breakdown.blue.teleopCargoLowerNear')) +
	    convert(int, json_value(value, '$.score_breakdown.blue.teleopCargoLowerRed')))
	   * 1 +
       (convert(int, json_value(value, '$.score_breakdown.blue.teleopCargoUpperBlue')) +
	    convert(int, json_value(value, '$.score_breakdown.blue.teleopCargoUpperFar')) +
	    convert(int, json_value(value, '$.score_breakdown.blue.teleopCargoUpperNear')) +
	    convert(int, json_value(value, '$.score_breakdown.blue.teleopCargoUpperRed')))
	   * 2 teleopCargoPointsCalcBlue
  from openjson(@jsonData)) subquery
 where 1<>1
    or (subquery.teleopCargoTotalBlue = 0 and subquery.teleopCargoPointsBlue > 0)
    or subquery.teleopCargoTotalBlue <> subquery.teleopCargoLowerBlue + subquery.teleopCargoUpperBlue
    or subquery.teleopCargoPointsBlue <> subquery.teleopCargoPointsCalcBlue

-- Validate Red Auto Cargo
select *
  from (
select json_value(value, '$.key') matchKey
     , convert(int, json_value(value, '$.score_breakdown.red.autoCargoTotal')) autoCargoTotalRed
     , convert(int, json_value(value, '$.score_breakdown.red.autoCargoLowerBlue')) +
	   convert(int, json_value(value, '$.score_breakdown.red.autoCargoLowerFar')) +
	   convert(int, json_value(value, '$.score_breakdown.red.autoCargoLowerNear')) +
	   convert(int, json_value(value, '$.score_breakdown.red.autoCargoLowerRed')) autoCargoLowerRed
     , convert(int, json_value(value, '$.score_breakdown.red.autoCargoUpperBlue')) +
	   convert(int, json_value(value, '$.score_breakdown.red.autoCargoUpperFar')) +
	   convert(int, json_value(value, '$.score_breakdown.red.autoCargoUpperNear')) +
	   convert(int, json_value(value, '$.score_breakdown.red.autoCargoUpperRed')) autoCargoUpperRed
     , convert(int, json_value(value, '$.score_breakdown.red.autoCargoPoints')) autoCargoPointsRed
     , (convert(int, json_value(value, '$.score_breakdown.red.autoCargoLowerBlue')) +
	    convert(int, json_value(value, '$.score_breakdown.red.autoCargoLowerFar')) +
	    convert(int, json_value(value, '$.score_breakdown.red.autoCargoLowerNear')) +
	    convert(int, json_value(value, '$.score_breakdown.red.autoCargoLowerRed')))
	   * 2 +
       (convert(int, json_value(value, '$.score_breakdown.red.autoCargoUpperBlue')) +
	    convert(int, json_value(value, '$.score_breakdown.red.autoCargoUpperFar')) +
	    convert(int, json_value(value, '$.score_breakdown.red.autoCargoUpperNear')) +
	    convert(int, json_value(value, '$.score_breakdown.red.autoCargoUpperRed')))
	   * 4 autoCargoPointsCalcred
  from openjson(@jsonData)) subquery
 where 1<>1
    or (subquery.autoCargoTotalRed = 0 and subquery.autoCargoPointsRed > 0)
    or subquery.autoCargoTotalRed <> subquery.autoCargoLowerRed + subquery.autoCargoUpperRed
    or subquery.autoCargoPointsRed <> subquery.autoCargoPointsCalcRed

-- Validate Red Teleop Cargo
select *
  from (
select json_value(value, '$.key') matchKey
     , convert(int, json_value(value, '$.score_breakdown.red.teleopCargoTotal')) teleopCargoTotalRed
     , convert(int, json_value(value, '$.score_breakdown.red.teleopCargoLowerBlue')) +
	   convert(int, json_value(value, '$.score_breakdown.red.teleopCargoLowerFar')) +
	   convert(int, json_value(value, '$.score_breakdown.red.teleopCargoLowerNear')) +
	   convert(int, json_value(value, '$.score_breakdown.red.teleopCargoLowerRed')) teleopCargoLowerRed
     , convert(int, json_value(value, '$.score_breakdown.red.teleopCargoUpperBlue')) +
	   convert(int, json_value(value, '$.score_breakdown.red.teleopCargoUpperFar')) +
	   convert(int, json_value(value, '$.score_breakdown.red.teleopCargoUpperNear')) +
	   convert(int, json_value(value, '$.score_breakdown.red.teleopCargoUpperRed')) teleopCargoUpperRed
     , convert(int, json_value(value, '$.score_breakdown.red.teleopCargoPoints')) teleopCargoPointsRed
     , (convert(int, json_value(value, '$.score_breakdown.red.teleopCargoLowerBlue')) +
	    convert(int, json_value(value, '$.score_breakdown.red.teleopCargoLowerFar')) +
	    convert(int, json_value(value, '$.score_breakdown.red.teleopCargoLowerNear')) +
	    convert(int, json_value(value, '$.score_breakdown.red.teleopCargoLowerRed')))
	   * 1 +
       (convert(int, json_value(value, '$.score_breakdown.red.teleopCargoUpperBlue')) +
	    convert(int, json_value(value, '$.score_breakdown.red.teleopCargoUpperFar')) +
	    convert(int, json_value(value, '$.score_breakdown.red.teleopCargoUpperNear')) +
	    convert(int, json_value(value, '$.score_breakdown.red.teleopCargoUpperRed')))
	   * 2 teleopCargoPointsCalcred
  from openjson(@jsonData)) subquery
 where 1<>1
    or (subquery.teleopCargoTotalRed = 0 and subquery.teleopCargoPointsRed > 0)
    or subquery.teleopCargoTotalRed <> subquery.teleopCargoLowerRed + subquery.teleopCargoUpperRed
    or subquery.teleopCargoPointsRed <> subquery.teleopCargoPointsCalcRed


