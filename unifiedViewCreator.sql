USE `TripleThreat`;

DROP VIEW IF EXISTS `usr`;

CREATE VIEW usr AS
    SELECT b.date AS date, b.location AS state, b.demographicCategory AS sex, covid19Death, totalDeath, pneumoniaDeath,pneumoniaAndCovid19Death, influenzaDeaths, tripleThreatTotalDeath,
           censusForVaccination, vaccinationStarted, vaccinationSeriesDone, vaccinationBooster
    FROM Covid_Death_By_Sex_And_Age AS a
    LEFT JOIN Covid_Vaccination_By_Sex_And_Age AS b
    on a.endDate = b.date and a.sex = b.demographicCategory and a.state = b.location
    UNION
    SELECT b.date AS date, b.location AS state, b.demographicCategory AS sex, covid19Death, totalDeath, pneumoniaDeath,pneumoniaAndCovid19Death, influenzaDeaths, tripleThreatTotalDeath,
           censusForVaccination, vaccinationStarted, vaccinationSeriesDone, vaccinationBooster
    FROM Covid_Death_By_Sex_And_Age AS a
    RIGHT JOIN Covid_Vaccination_By_Sex_And_Age AS b
    on a.endDate = b.date and a.sex = b.demographicCategory and a.state = b.location;

DESCRIBE usr;

select * from usr;