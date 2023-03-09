CREATE DATABASE IF NOT EXISTS `TripleThreat` ;
USE `TripleThreat`;
DROP VIEW IF EXISTS `Influenza_and_RSV_hospitalizations_Rate`;

CREATE VIEW Influenza_and_RSV_hospitalizations_Rate AS
	select b.date,b.state,b.sex,
	       b.RSV_hospitalizations AS `weekly_RSV_hospitalizations_rate`,
	       b.RSV_cumulative_rate AS `cumulative_RSV_hospitalizations_rate`,
	       a.Influenza_hospitalizations AS `weekly_Influenza_hospitalizations_rate`,
	       a.Influenza_cumulative_rate AS `cumulative_Influenza_rate`
	from Influenza_hospitalizations_Rate as a right join RSV_Hospitalizations_Rate as b
		on a.date = b.date and a.sex = b.sex and a.state = b.state
    WHERE Date(b.date)>'2020-12-01'
;

Select * From Influenza_and_RSV_hospitalizations_Rate

;