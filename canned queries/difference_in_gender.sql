/*
 top 10 state has most death people difference between males and females
 for triple threat.
 */
select f.state, abs(m.death-f.death) as difference
from
    (select state,sum(tripleThreatTotalDeath) as death
        from unified_view
        where sex = 'Female'
        group by state) as f
    ,
    (select state,sum(tripleThreatTotalDeath) as death
        from unified_view
        where sex = 'Male'
        group by state) as m
where f.state = m.state
order by difference desc
limit 10;