CREATE DATABASE IF NOT EXISTS `TripleThreat` ;
USE `TripleThreat`;
DROP VIEW IF EXISTS `Influenza_and_RSV_hospitalizations_Rate`;

CREATE VIEW Influenza_and_RSV_hospitalizations_Rate AS
	select a.*,b.RSV_hospitalizations,b.RSV_cumulative_rate
	from Influenza_hospitalizations_Rate as a left join RSV_Hospitalizations_Rate as b
		on a.date = b.date and a.sex = b.sex and a.state = b.state
	WHERE Date(date)>'2020-01-01'
	union
	select b.state,b.date,b.sex,a.Influenza_cumulative_rate,a.Influenza_hospitalizations,b.RSV_hospitalizations,b.RSV_cumulative_rate
	from Influenza_hospitalizations_Rate as a right join RSV_Hospitalizations_Rate as b
		on a.date = b.date and a.sex = b.sex and a.state = b.state
    WHERE Date(date)>'2020-01-01'
;

Select * From Influenza_and_RSV_hospitalizations_Rate

;