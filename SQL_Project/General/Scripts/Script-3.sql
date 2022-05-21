SELECT *
FROM healthcare_provider;

SELECT
	name,
	provider_type 
FROM healthcare_provider
LIMIT 10 OFFSET 10;

SELECT *
FROM healthcare_provider
order by region_code ASC;

SELECT  *
FROM  healthcare_provider
order by region_code DESC;

SELECT *
FROM czechia_region

-- Cviceni 5
select
	name,
	region_code,
	district_code 
from healthcare_provider
order by district_code DESC
limit 500;

/*
 * 
 * WHERE
 */

SELECT *
FROM healthcare_provider
WHERE region_code = 'CZ010';


SELECT
	name,
	phone,
	fax,
	email,
	website
from healthcare_provider
WHERE region_code != 'CZ010';


SELECT 
	name,
	region_code,
	residence_region_code
from healthcare_provider
WHERE region_code = residence_region_code 


SELECT 
	name,
	phone 
FROM healthcare_provider hp 
WHERE phone IS NOT NULL;


SELECT *
FROM czechia_district cd 


select
	name,
	district_code 
from healthcare_provider hp 
WHERE district_code = 'CZ0201' OR district_code = 'CZ0202'



CREATE TABLE t_radim_jedlicka_providers_south_moravia AS
	SELECT *
	FROM healthcare_provider
	WHERE region_code = 'CZ064';

SELECT * 
FROM t_radim_jedlicka_providers_south_moravia;

DROP TABLE IF EXISTS t_radim_jedlicka_providers_south_moravia;

CREATE TABLE IF NOT EXISTS t_radim_resume (
	date_start date,
	date_end date,
	education varchar(255),
	job varchar(255)
);

SELECT *
FROM t_radim_resume;

SHOW TABLES

INSERT INTO t_radim_resume
VALUES ('2020-04-20', '2020-05-01', 'FI MUNI', 'Engeto lektor')

ALTER TABLE t_radim_resume 
ADD COLUMN location varchar(255);

UPDATE t_radim_resume SET location = 'Praha'
WHERE education = 'FI MUNI';

DELETE FROM t_radim_resume 
WHERE job = 'Engeto lektor';

DROP TABLE t_radim_resume 






