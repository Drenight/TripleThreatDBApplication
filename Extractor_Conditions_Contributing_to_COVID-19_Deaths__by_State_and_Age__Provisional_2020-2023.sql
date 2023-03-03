CREATE DATABASE IF NOT EXISTS `TripleThreat` ;
USE `TripleThreat`;
DROP TABLE IF EXISTS `ConditionDeath`;
CREATE TABLE `ConditionDeath`(date DATE, startDate DATE, endDate DATE, groupKnd CHAR(10), year INT, month INT, state CHAR(30),
cond CHAR(100), ageGroup CHAR(20), covidDeath INT);

/* The MySQL server is running with the --secure-file-priv option so it cannot execute this statement */
/* Edit ~/.my.cnf */
/* brew services restart mysql */

/* alter date from xx/xx/xxxx to xxxx-xx-xx */
/* STR_TO_DATE('02-21-2022',  '%m-%d-%Y') */
/* 2022-02-21 */

/* set numberCol=if(@VAL is null, 0, @VAL); */

describe ConditionDeath;

LOAD DATA INFILE '/Users/liuboyao/Assignments23Spring/DataBase/A2/Conditions_Contributing_to_COVID-19_Deaths__by_State_and_Age__Provisional_2020-2023.csv'
    INTO TABLE `ConditionDeath`
    FIELDS TERMINATED BY ','
    OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (@date, @startDate, @endDate, groupKnd, @year, @month, state, @dummy, cond, @dummy, ageGroup, @covidDeath, @dummy, @dummy)
    SET `date` = STR_TO_DATE(@date,'%m/%d/%Y'),
        `startDate` = STR_TO_DATE(@startDate,'%m/%d/%Y'),
        `endDate` = STR_TO_DATE(@endDate,'%m/%d/%Y'),
        year = IF(@year = '', 0, @year),
        month = IF(@month = '', 0, @month),
        covidDeath = IF(@covidDeath = '', 0, @covidDeath)
;

select * from ConditionDeath
;