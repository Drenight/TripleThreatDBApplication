CREATE DATABASE IF NOT EXISTS `TripleThreat` ;
USE `TripleThreat`;
DROP TABLE IF EXISTS `Covid19_Cases_And_Death_By_State`;
CREATE TABLE `Covid19_Cases_And_Death_By_State`(data_updated DATE, state CHAR(3), start_date DATE, end_date DATE,
tot_cases INT, new_cases INT, tot_deaths INT, new_deaths INT, new_historic_cases INT, new_historic_deaths INT
);

/* The MySQL server is running with the --secure-file-priv option so it cannot execute this statement */
/* Edit ~/.my.cnf */
/* brew services restart mysql */

/* alter date from xx/xx/xxxx to xxxx-xx-xx */
/* STR_TO_DATE('02-21-2022',  '%m-%d-%Y') */
/* 2022-02-21 */
LOAD DATA INFILE '/Users/liuboyao/Assignments23Spring/DataBase/A2/Weekly_United_States_COVID-19_Cases_and_Deaths_by_State.csv'
    INTO TABLE `Covid19_Cases_And_Death_By_State`
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (@data_updated, state, @start_date, @end_date, tot_cases, new_cases, tot_deaths, new_deaths, new_historic_cases, new_historic_deaths)
    SET `data_updated` = STR_TO_DATE(@data_updated,'%m/%d/%Y'),
    `start_date` = STR_TO_DATE(@start_date,'%m/%d/%Y'),
    `end_date` = STR_TO_DATE(@end_date,'%m/%d/%Y')
;

select * from Covid19_Cases_And_Death_By_State
where state = 'DC'
order by start_date;