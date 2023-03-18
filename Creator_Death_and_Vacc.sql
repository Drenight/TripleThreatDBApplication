USE `TripleThreat`;

DROP VIEW IF EXISTS `Death_and_Vacc`;

CREATE VIEW Death_and_Vacc AS
    SELECT a.endDate AS date, a.state AS state, a.sex AS sex, covid19Death, totalDeath, pneumoniaDeath,pneumoniaAndCovid19Death, influenzaDeaths, tripleThreatTotalDeath,
           censusForVaccination, vaccinationStarted, vaccinationSeriesDone, vaccinationBooster
    FROM Covid_Death_By_Sex_And_Age AS a
    LEFT JOIN Covid_Vaccination_By_Sex_And_Age AS b
    on a.endDate = b.date and a.sex = b.demographicCategory and a.state = b.location
    WHERE b.date >= "2020-12-31";