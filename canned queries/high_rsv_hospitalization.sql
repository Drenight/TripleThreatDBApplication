/*
 top 10 weeks in 2022 where has the highest hospitalizations rate for RSV
 */
select date, avg(weekly_RSV_hospitalizations_rate) as RSV_hospitalizations_rate
from unified_view
where date >= '2022-01-01' and date <= '2022-12-31'
group by date
order by RSV_hospitalizations_rate desc
limit 10;