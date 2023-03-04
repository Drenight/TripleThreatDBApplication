CREATE DATABASE IF NOT EXISTS `TripleThreat` ;
USE `TripleThreat`;
DROP TABLE IF EXISTS `ori_Covid_Death_By_Sex_And_Age`;
CREATE TABLE `ori_Covid_Death_By_Sex_And_Age`(date DATE, startDate DATE, endDate DATE,
groupMode CHAR(10), year INT, month INT, state CHAR(20), sex CHAR (10), ageGroup CHAR(25),
covid19Death INT, totalDeath INT, pneumoniaDeath INT, pneumoniaAndCovid19Death INT, influenzaDeaths INT, tripleThreatTotalDeath INT
);

/* The MySQL server is running with the --secure-file-priv option so it cannot execute this statement */
/* Edit ~/.my.cnf */
/* brew services restart mysql */

/* alter date from xx/xx/xxxx to xxxx-xx-xx */
/* STR_TO_DATE('02-21-2022',  '%m-%d-%Y') */
/* 2022-02-21 */

describe ori_Covid_Death_By_Sex_And_Age;

LOAD DATA INFILE '/Users/liuboyao/Assignments23Spring/DataBase/A2/Provisional_COVID-19_Deaths_by_Sex_and_Age.csv'
    INTO TABLE `ori_Covid_Death_By_Sex_And_Age`
    FIELDS TERMINATED BY ','
    OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (@date, @startDate, @endDate,
     groupMode, @year, @month, state, sex, ageGroup,
     @covid19Death, @totalDeath, @pneumoniaDeath, @pneumoniaAndCovid19Death, @influenzaDeaths, @tripleThreatTotalDeath,
     @dummy)
    SET `date` = STR_TO_DATE(@date,'%m/%d/%Y'),
        `startDate` = STR_TO_DATE(@startDate, '%m/%d/%Y'),
        `endDate` = STR_TO_DATE(@endDate, '%m/%d/%Y'),
        year = IF(@year = '', NULL, @year),
        month = IF(@month = '', NULL, @month),
        covid19Death = IF(@covid19Death = '', NULL, @covid19Death),
        pneumoniaAndCovid19Death = IF(@pneumoniaAndCovid19Death = '', NULL, @pneumoniaAndCovid19Death),
        influenzaDeaths = IF(@influenzaDeaths = '', NULL, @influenzaDeaths),
        pneumoniaDeath = IF(@pneumoniaDeath = '', NULL, @pneumoniaDeath),
        tripleThreatTotalDeath = IF(@tripleThreatTotalDeath = '', NULL, @tripleThreatTotalDeath),
        totalDeath = IF(@totalDeath = '', NULL, @totalDeath)
;

DROP TABLE IF EXISTS `Covid_Death_By_Sex_And_Age`;
CREATE TABLE Covid_Death_By_Sex_And_Age AS
    select endDate, state, sex, ageGroup, covid19Death, totalDeath, pneumoniaDeath, pneumoniaAndCovid19Death, influenzaDeaths, tripleThreatTotalDeath
    from ori_Covid_Death_By_Sex_And_Age
    where groupMode = 'By Total'
        and state != 'United States'
    order by date DESC
;
DROP TABLE IF EXISTS `ori_Covid_Death_By_Sex_And_Age`;

