/*
 top 10 weeks in 2022 where has the highest hospitalizations rate for flu
 */
select date, avg(weekly_Influenza_hospitalizations_rate) as RSV_Influenza_rate
from unified_view
where date >= '2022-01-01' and date <= '2022-12-31'
group by date
order by RSV_Influenza_rate desc
limit 10;