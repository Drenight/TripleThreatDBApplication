CREATE DATABASE IF NOT EXISTS `TripleThreat` ;
USE `TripleThreat`;
DROP VIEW IF EXISTS `Unified_View`;

CREATE VIEW Unified_View AS
    SELECT a.*,
           b.weekly_RSV_hospitalizations_rate, b.cumulative_RSV_hospitalizations_rate,
           b.weekly_Influenza_hospitalizations_rate, b.cumulative_Influenza_rate
    FROM Death_and_Vacc AS a LEFT JOIN influenza_and_rsv_hospitalizations_rate AS b
    ON a.date = b.date and a.state = b.state and a.sex = b.sex
    WHERE a.date >= '2020-12-31'
    UNION
    SELECT b.date, b.state, b.sex, covid19Death, totalDeath, pneumoniaDeath,pneumoniaAndCovid19Death, influenzaDeaths, tripleThreatTotalDeath,
           censusForVaccination, vaccinationStarted, vaccinationSeriesDone, vaccinationBooster,
       b.weekly_RSV_hospitalizations_rate, b.cumulative_RSV_hospitalizations_rate,
       b.weekly_Influenza_hospitalizations_rate, b.cumulative_Influenza_rate
    FROM Death_and_Vacc AS a RIGHT JOIN influenza_and_rsv_hospitalizations_rate AS b
    ON a.date = b.date and a.state = b.state and a.sex = b.sex
    WHERE b.date >= '2020-12-31'
;

Select * From Unified_View;