CREATE DATABASE IF NOT EXISTS `TripleThreat` ;
USE `TripleThreat`;
DROP TABLE IF EXISTS `Ori_Influenza_Hospitalizations_Rate`;
CREATE TABLE `Ori_Influenza_Hospitalizations_Rate`(state Char(30), year INT, week INT, age Char(20), sex Char(10), race Char(30),
Ori_Influenza_cumulative_rate Char(10), Ori_Influenza_hospitalizations Char(10));


describe Ori_Influenza_Hospitalizations_Rate;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\FluSurveillance.csv'
    INTO TABLE `Ori_Influenza_Hospitalizations_Rate`
    FIELDS TERMINATED BY ','
    OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (state, @dummy, @dummy, year, week, age, sex, race, @Ori_Influenza_cumulative_rate, @Ori_Influenza_hospitalizations)
	SET Ori_Influenza_cumulative_rate = IF(@Ori_Influenza_cumulative_rate = 'null', null, @Ori_Influenza_cumulative_rate),
		Ori_Influenza_hospitalizations = IF(@Ori_Influenza_hospitalizations = 'null\r', null, @Ori_Influenza_hospitalizations)
;

Alter table Ori_Influenza_hospitalizations_Rate
	Add column Influenza_cumulative_rate FLOAT;
SET SQL_SAFE_UPDATES = 0;
Update Ori_Influenza_hospitalizations_Rate SET Influenza_cumulative_rate = convert(Ori_Influenza_cumulative_rate,decimal(32,1));

Alter table Ori_Influenza_hospitalizations_Rate
	Add column Influenza_hospitalizations FLOAT;
Update Ori_Influenza_hospitalizations_Rate SET Influenza_hospitalizations = convert(Ori_Influenza_hospitalizations,decimal(32,1));

Alter table Ori_Influenza_hospitalizations_Rate
	Add column date Date;
Update Ori_Influenza_hospitalizations_Rate SET date = makedate(year,week*7+2023-year);

DROP TABLE IF EXISTS `Influenza_hospitalizations_Rate`;
CREATE TABLE Influenza_hospitalizations_Rate AS
	select state,date,sex,Influenza_cumulative_rate,Influenza_hospitalizations from Ori_Influenza_hospitalizations_Rate
		Where state <>'New York - Albany' and state <>'New York - Rochester' and age = 'Overall' And race = 'Overall' And week>0 And sex<>'Overall' And State<>'Entire Network';
;
alter Table Influenza_hospitalizations_Rate add primary key(State,date,sex);
DROP TABLE IF EXISTS `Ori_Influenza_hospitalizations_Rate`;
Select * From Influenza_hospitalizations_Rate;