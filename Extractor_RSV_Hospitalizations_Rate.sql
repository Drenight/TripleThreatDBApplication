CREATE DATABASE IF NOT EXISTS `TripleThreat` ;
USE `TripleThreat`;
DROP TABLE IF EXISTS `Ori_RSV_Hospitalizations_Rate`;
CREATE TABLE `Ori_RSV_Hospitalizations_Rate`(state Char(30), season Char(10), week INT, date DATE, age Char(20), sex Char(10), race Char(30), RSV_hospitalizations FLOAT, RSV_cumulative_rate FLOAT);


describe Ori_RSV_Hospitalizations_Rate;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\RSV_Rates_of_Laboratory-Confirmed.csv'
    INTO TABLE `Ori_RSV_Hospitalizations_Rate`
    FIELDS TERMINATED BY ','
    OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (state, season, @week, @date, age, sex, race, RSV_hospitalizations, @RSV_cumulative_rate)
    SET `date` = IF(@date = '', null, STR_TO_DATE(@date,'%m/%d/%Y %h:%i:%s %p')),
        week = IF(@week = 'Overall', 0, @week),
        RSV_cumulative_rate = IF(@RSV_cumulative_rate = '', null, @RSV_cumulative_rate)
;
DROP TABLE IF EXISTS `RSV_Hospitalizations_Rate`;
CREATE TABLE RSV_hospitalizations_Rate AS
	select state,date,sex,RSV_hospitalizations,RSV_cumulative_rate from Ori_RSV_hospitalizations_Rate
		Where age = 'Overall' And race = 'Overall' And week>0 And sex<>'Overall' And State<>'Entire Network (RSV-NET)' And Date(date)>'2020-12-01'
;
alter Table RSV_Hospitalizations_Rate add primary key(State,date,sex);
DROP TABLE IF EXISTS `Ori_RSV_Hospitalizations_Rate`;
Select * From RSV_Hospitalizations_Rate;