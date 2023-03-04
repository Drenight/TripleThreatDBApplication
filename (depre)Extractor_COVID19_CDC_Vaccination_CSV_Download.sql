CREATE DATABASE IF NOT EXISTS `TripleThreat` ;
USE `TripleThreat`;
DROP TABLE IF EXISTS `Vaccination`;
CREATE TABLE `Vaccination`(date DATE, geographyLevel CHAR(10), geographyName char(30),
 demographicGroup CHAR(15), demographicCategory CHAR(30),vaccinatedPerson char(15),
    fullyVaccinatedPerson char(15), population char(15));

/* The MySQL server is running with the --secure-file-priv option so it cannot execute this statement */
/* Edit ~/.my.cnf */
/* brew services restart mysql */

/* alter date from xx/xx/xxxx to xxxx-xx-xx */
/* STR_TO_DATE('02-21-2022',  '%m-%d-%Y') */
/* 2022-02-21 */

describe Vaccination;

LOAD DATA INFILE '/Users/liuboyao/Assignments23Spring/DataBase/A2/COVID19_CDC_Vaccination_CSV_Download.csv'
    INTO TABLE `Vaccination`
    FIELDS TERMINATED BY ','
    OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES
    (@date, geographyLevel, geographyName, demographicGroup,
     demographicCategory, vaccinatedPerson, fullyVaccinatedPerson, population,
     @dummy,@dummy,@dummy,@dummy,@dummy,@dummy)
    SET `date` = STR_TO_DATE(@date,'%Y-%m-%d')
;

select * from Vaccination
where geographyName = 'District of Columbia'
order by date DESC
;

drop table Vaccination;
