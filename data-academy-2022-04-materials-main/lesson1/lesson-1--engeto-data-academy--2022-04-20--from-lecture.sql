/*
 * -------
 * SELECT, ORDER BY a LIMIT
 * -------
 */
 
SELECT *
FROM healthcare_provider;

SELECT
	name,
	provider_type
FROM healthcare_provider;

SELECT
	name,
	provider_type
FROM healthcare_provider
LIMIT 30 OFFSET 60;

SELECT *
FROM healthcare_provider
ORDER BY region_code;

SELECT *
FROM healthcare_provider
ORDER BY region_code ASC;

-- Cvičení 4 - modifikace s DESC
SELECT *
FROM healthcare_provider
ORDER BY region_code DESC;

SELECT * FROM czechia_region;

-- Cvičení 5
SELECT
	name,
	region_code,
	district_code
FROM healthcare_provider
ORDER BY district_code DESC
LIMIT 500;


/*
 * -------
 * WHERE
 * -------
 */

SELECT *
FROM healthcare_provider
WHERE region_code = 'CZ010';

SELECT
	name AS jmeno,
	phone AS telefon,
	fax,
	email,
	website AS webovky
FROM healthcare_provider AS hp
WHERE region_code <> 'CZ010';

SELECT
	name,
	region_code,
	residence_region_code
FROM healthcare_provider
WHERE region_code = residence_region_code;

SELECT
	name,
	phone
FROM healthcare_provider
WHERE phone IS NOT NULL;

SELECT * FROM czechia_district;

SELECT
	name,
	district_code
FROM healthcare_provider
WHERE
	district_code = 'CZ0201' OR
	district_code = 'CZ0202';

-- výlučné použití kódu okresu = prázdná množina jako výsledek
SELECT
	name,
	district_code
FROM healthcare_provider
WHERE
	district_code = 'CZ0201' AND 
	(
		district_code = 'CZ0202' OR 
		district_code = 'CZ0203'
	);


/*
 * -------
 * Tvorba tabulek a úprava záznamů
 * -------
 */

CREATE OR REPLACE TABLE t_engeto_lektor_providers_south_moravia AS
	SELECT *
	FROM healthcare_provider
	WHERE region_code = 'CZ064';			

SELECT *
FROM t_engeto_lektor_providers_south_moravia;

DROP TABLE IF EXISTS t_engeto_lektor_providers_south_moravia;

CREATE TABLE IF NOT EXISTS t_lektor_engeto_resume (
	`date_start` date,
	`date_end` date,
	`education` varchar(255),
	`job` varchar(255)
);

SELECT *
FROM t_lektor_engeto_resume;

INSERT INTO t_lektor_engeto_resume
VALUES ('2020-05-01', '2022-04-20', 'FI MUNI', 'Engeto lektor');

INSERT INTO t_lektor_engeto_resume (date_start, job, education)
VALUES ('2021-05-01', 'Oracle NetSuite', 'FI MUNI');

ALTER TABLE t_lektor_engeto_resume
ADD COLUMN location varchar(255);

UPDATE t_lektor_engeto_resume SET location = 'Brno';

UPDATE t_lektor_engeto_resume SET location = 'Brno'
WHERE education = 'FI MUNI';

DELETE FROM t_lektor_engeto_resume
WHERE job = 'Engeto lektor';

DROP TABLE t_lektor_engeto_resume;
