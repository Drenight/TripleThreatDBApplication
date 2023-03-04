CREATE DATABASE IF NOT EXISTS `TripleThreat` ;
USE `TripleThreat`;
DROP TABLE IF EXISTS `Us_State_Vaccinations`;
CREATE TABLE `Us_State_Vaccinations`(date DATE, state CHAR(30), vaccinationFullRate float4, vaccinationRate float4);

/* The MySQL server is running with the --secure-file-priv option so it cannot execute this statement */
/* Edit ~/.my.cnf */
/* brew services restart mysql */

/* alter date from xx/xx/xxxx to xxxx-xx-xx */
/* STR_TO_DATE('02-21-2022',  '%m-%d-%Y') */
/* 2022-02-21 */

describe Us_State_Vaccinations;

LOAD DATA INFILE '/Users/liuboyao/Assignments23Spring/DataBase/A2/us_state_vaccinations.csv'
    INTO TABLE `Us_State_Vaccinations`
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (@date, state, @dummy, @dummy, @dummy, @vaccinationFullRate, @dummy, @dummy, @vaccinationRate,
     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy)
    SET `date` = STR_TO_DATE(@date,'%Y-%m-%d'),
        `vaccinationFullRate` = 1*@vaccinationFullRate,
        `vaccinationRate` = 1*@vaccinationRate
;

select * from Us_State_Vaccinations
where state = 'District of Columbia'
order by date DESC
;