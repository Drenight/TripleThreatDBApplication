CREATE DATABASE IF NOT EXISTS `TripleThreat` ;
USE `TripleThreat`;
DROP TABLE IF EXISTS `Covid19_Cases_And_Death_By_State`;
CREATE TABLE `Covid19_Cases_And_Death_By_State`(submission_date DATE, state CHAR(3), tot_cases INT,
new_cases INT, tot_death INT, new_death INT);

/* The MySQL server is running with the --secure-file-priv option so it cannot execute this statement */
/* Edit ~/.my.cnf */
/* brew services restart mysql */

/* alter date from xx/xx/xxxx to xxxx-xx-xx */
/* STR_TO_DATE('02-21-2022',  '%m-%d-%Y') */
/* 2022-02-21 */

describe Covid19_Cases_And_Death_By_State;

LOAD DATA INFILE '/Users/liuboyao/Assignments23Spring/DataBase/A2/United_States_COVID-19_Cases_and_Deaths_by_State_over_Time_-_ARCHIVED.csv'
    INTO TABLE `Covid19_Cases_And_Death_By_State`
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (@submission_date, state, tot_cases, @dummy, @dummy, new_cases, @dummy, tot_death, @dummy, @dummy, new_death, @dummy, @dummy, @dummy, @dummy)
    SET `submission_date` = STR_TO_DATE(@submission_date,'%m/%d/%Y')
;

select * from Covid19_Cases_And_Death_By_State
where state = 'DC'
order by submission_date;