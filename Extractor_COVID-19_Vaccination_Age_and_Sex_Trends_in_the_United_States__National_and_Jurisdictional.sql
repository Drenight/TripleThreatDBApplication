CREATE DATABASE IF NOT EXISTS `TripleThreat` ;
USE `TripleThreat`;
DROP TABLE IF EXISTS `ori_Covid_Vaccination_By_Sex_And_Age`;
CREATE TABLE `ori_Covid_Vaccination_By_Sex_And_Age`(date DATE, location CHAR(2), demographicCategory char(30),
census INT, vaccinationStarted INT, vaccinationSeriesDone INT, vaccinationBooster INT
);

/* The MySQL server is running with the --secure-file-priv option so it cannot execute this statement */
/* Edit ~/.my.cnf */
/* brew services restart mysql */

/* alter date from xx/xx/xxxx to xxxx-xx-xx */
/* STR_TO_DATE('02-21-2022',  '%m-%d-%Y') */
/* 2022-02-21 */

describe ori_Covid_Vaccination_By_Sex_And_Age;

LOAD DATA INFILE '/Users/liuboyao/Assignments23Spring/DataBase/A2/COVID-19_Vaccination_Age_and_Sex_Trends_in_the_United_States__National_and_Jurisdictional.csv'
    INTO TABLE `ori_Covid_Vaccination_By_Sex_And_Age`
    FIELDS TERMINATED BY ','
    OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (@date, location, demographicCategory,
     @census, @vaccinationStarted, @vaccinationSeriesDone, @vaccinationBooster,
     @dummy, @dummy, @dummy, @dummy, @dummy
    )
    SET `date` = STR_TO_DATE(@date,'%m/%d/%Y %h:%i:%s %p'),
        census = IF(@census = '', NULL, @census),
        vaccinationStarted = IF(@vaccinationStarted = '', NULL, @vaccinationStarted),
        vaccinationSeriesDone = IF(@vaccinationSeriesDone = '', NULL, @vaccinationSeriesDone),
        vaccinationBooster = IF(@vaccinationBooster = '', NULL, @vaccinationBooster)
;

DROP TABLE IF EXISTS `Covid_Vaccination_By_Sex_And_Age`;
CREATE TABLE Covid_Vaccination_By_Sex_And_Age AS
    select *
    from ori_Covid_Vaccination_By_Sex_And_Age
    where location != 'US'
        and demographicCategory like 'Sex%'
        and demographicCategory != 'Sex_Unknown'
;

ALTER TABLE `Covid_Vaccination_By_Sex_And_Age`
    MODIFY COLUMN location CHAR(30) NOT NULL DEFAULT '',
    ADD PRIMARY KEY (date, location, demographicCategory),
    RENAME COLUMN census TO censusForVaccination;

UPDATE Covid_Vaccination_By_Sex_And_Age
    INNER JOIN states ON Covid_Vaccination_By_Sex_And_Age.location = states.code
    SET Covid_Vaccination_By_Sex_And_Age.location = states.name;

UPDATE  Covid_Vaccination_By_Sex_And_Age
    SET demographicCategory = REPLACE(demographicCategory,'Sex_Male','Male'),
        demographicCategory = REPLACE(demographicCategory,'Sex_Female','Female');

DROP TABLE IF EXISTS `ori_Covid_Vaccination_By_Sex_And_Age`;

