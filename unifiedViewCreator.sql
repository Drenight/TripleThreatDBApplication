
DROP VIEW IF EXISTS `usr`;

CREATE VIEW usr AS
    SELECT *
    FROM Covid_Death_By_Sex_And_Age AS a
    LEFT JOIN Covid_Vaccination_By_Sex_And_Age AS b
    on a.endDate = b.date

