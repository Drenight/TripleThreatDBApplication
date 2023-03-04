CREATE DATABASE IF NOT EXISTS `TripleThreat` ;
USE `TripleThreat`;
DROP TABLE IF EXISTS `US_States_Covid19_Death_And_Cases`;
CREATE TABLE `US_States_Covid19_Death_And_Cases`(date DATE, state CHAR(30), fips INT, cases INT, deaths INT);

/* The MySQL server is running with the --secure-file-priv option so it cannot execute this statement */
/* Edit ~/.my.cnf */
/* brew services restart mysql */

/* alter date from xx/xx/xxxx to xxxx-xx-xx */
/* STR_TO_DATE('02-21-2022',  '%m-%d-%Y') */
/* 2022-02-21 */

describe US_States_Covid19_Death_And_Cases;

LOAD DATA INFILE '/Users/liuboyao/Assignments23Spring/DataBase/A2/us-states.csv'
    INTO TABLE `US_States_Covid19_Death_And_Cases`
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (@date, state, fips, cases, deaths)
    SET `date` = STR_TO_DATE(@date,'%Y-%m-%d')
;

select * from US_States_Covid19_Death_And_Cases
where state = 'District of Columbia'
order by date DESC
;