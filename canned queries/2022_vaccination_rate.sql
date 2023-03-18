/*
 top 10 state has most vaccine rate for covid-19 till 2022-12-31
 */
select state, sum(vaccinationSeriesDone)/sum(censusForVaccination) as vaccination_rate
from unified_view
where date = '2022-12-31'
group by state
order by vaccination_rate desc
limit 10;