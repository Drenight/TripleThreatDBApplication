/*
 top 10 state has most death people for triple threat.
 */
select state,sum(tripleThreatTotalDeath) as death
from unified_view
group by state
order by death desc
limit 10;