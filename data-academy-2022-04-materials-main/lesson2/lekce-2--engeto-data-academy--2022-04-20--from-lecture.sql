/*
 * ORDER BY
 */

SELECT 
	name,
	provider_type
FROM healthcare_provider
ORDER BY TRIM(name);

-- trim_name trimName TrimName trim-name

SELECT 
	TRIM(name) AS trim_name,
	provider_type
FROM healthcare_provider
ORDER BY TRIM(name);

SELECT 
	provider_id,
	name,
	provider_type,
	region_code, district_code
FROM healthcare_provider
ORDER BY region_code DESC, district_code;

SELECT
	*
FROM czechia_district
ORDER BY code DESC;

SELECT *
FROM (
	SELECT
		*
	FROM czechia_region
	ORDER BY name DESC
	LIMIT 5
) AS result_table
ORDER BY result_table.name;

SELECT
	*
FROM healthcare_provider
ORDER BY provider_type, name DESC;

/*
 * CASE Expression
 */

SELECT
	*,
	CASE
		WHEN region_code = 'CZ010' THEN 1
		ELSE 0
	END AS is_from_Prague
FROM healthcare_provider;

SELECT
	*,
	CASE
		WHEN region_code = 'CZ010' THEN 1
		ELSE 0
	END AS is_from_Prague
FROM healthcare_provider
WHERE region_code = 'CZ010';

-- min = CCA 12, max = CCA 19

SELECT
	longitude
FROM healthcare_provider
WHERE longitude IS NOT NULL
ORDER BY longitude DESC;

SELECT 
	name, municipality, longitude,
	CASE
		WHEN longitude IS NULL THEN '---není známo---'
		WHEN longitude < 14 THEN 'nejvíce na západì'
		WHEN longitude < 16 THEN 'ménì na západì'
		WHEN longitude < 18 THEN 'více na východì'
		ELSE 'nejvíce na východì'
	END AS czechia_position
FROM healthcare_provider;


SELECT 
	name, provider_type,
	CASE
		WHEN provider_type = 'Lékárna' OR provider_type = 'Výdejna zdravotnických prostøedkù' THEN 1
		ELSE 0
	END AS is_desired_type
FROM healthcare_provider;

SELECT 
	name, provider_type,
	CASE
		WHEN provider_type IN ('Lékárna', 'Výdejna zdravotnických prostøedkù') THEN 1
		ELSE 0
	END AS is_desired_type
FROM healthcare_provider;

SELECT TRUE;
SELECT FALSE;
SELECT 3 + 4 - 2;


/*
 * WHERE, IN a LIKE
 */

SELECT *
FROM healthcare_provider
WHERE name LIKE '%nemocnice%';

SELECT 
	name,
	LOWER(name) lower_name,
	UPPER(name) upper_name,
	CASE
		WHEN name LIKE 'Lékárna%' THEN 1
		ELSE 0
	END AS starts_with_searched_name
FROM healthcare_provider
WHERE name LIKE '%lékárna%';

SELECT 
	name, municipality
FROM healthcare_provider
WHERE municipality LIKE '____';

SELECT 
	DISTINCT municipality
FROM healthcare_provider
WHERE municipality LIKE '____';

SELECT 
	name, municipality,
	CHAR_LENGTH(municipality) AS length_in_chars,
	LENGTH(municipality) AS length_in_bytes
FROM healthcare_provider
WHERE CHAR_LENGTH(municipality) = 4;

SELECT 
	name, municipality
FROM healthcare_provider
WHERE municipality LIKE '____'
EXCEPT
SELECT 
	name, municipality
FROM healthcare_provider
WHERE CHAR_LENGTH(municipality) = 4;

SELECT 'a b c' LIKE '_____';

SELECT *
FROM czechia_district
WHERE name IN ('Most', 'Dìèín');

SELECT 
	name, municipality, district_code
FROM healthcare_provider
WHERE
	municipality IN ('Praha', 'Brno', 'Ostrava') OR
	district_code IN ('CZ0421', 'CZ0425');

SELECT
	provider_id,
	name,
	region_code
FROM healthcare_provider
WHERE region_code IN (
	SELECT code
	FROM czechia_region
	WHERE name IN ('Jihomoravský kraj', 'Støedoèeský kraj')
);


SELECT
	*
FROM czechia_district
WHERE code IN (
	SELECT
		district_code 
	FROM healthcare_provider
	WHERE municipality LIKE '____'	
);

SELECT
	DISTINCT district_code 
FROM healthcare_provider
WHERE municipality LIKE '____';


SELECT DISTINCT
        country
FROM covid19_basic cbd    
WHERE country IN
        (SELECT DISTINCT 
                country 
         FROM covid19_basic_differences cbd2 
         WHERE confirmed>10000
        );
       

/*
 * Integritní omezení
 */
       
DELETE FROM czechia_district WHERE code = 'CZ0421';

SELECT *
FROM healthcare_provider;

UPDATE healthcare_provider SET zip_code = '123456789' WHERE place_id = 44742;

/*
 * VIEWS
 */

CREATE OR REPLACE VIEW v_healthcare_provider_subset AS
	SELECT 
		provider_id, name,
		municipality, district_code
	FROM healthcare_provider
	WHERE municipality IN ('Brno', 'Praha', 'Ostrava');

CREATE TABLE IF NOT EXISTS t_healthcare_provider_subset AS
	SELECT 
		provider_id, name,
		municipality, district_code
	FROM healthcare_provider
	WHERE municipality IN ('Brno', 'Praha', 'Ostrava');

SELECT *
FROM v_healthcare_provider_subset;

SELECT *
FROM healthcare_provider
WHERE provider_id NOT IN (
	SELECT provider_id
	FROM v_healthcare_provider_subset
);


CREATE OR REPLACE VIEW v_testing AS
	SELECT
	        country
	FROM covid19_basic cbd    
	WHERE country IN
	        (SELECT DISTINCT 
	                country 
	         FROM covid19_basic_differences cbd2 
	         WHERE confirmed>10000
	        );

SELECT * FROM v_testing;       

CREATE TABLE IF NOT EXISTS t_testing AS
	SELECT
	        country
	FROM covid19_basic cbd    
	WHERE country IN
	        (SELECT DISTINCT 
	                country 
	         FROM covid19_basic_differences cbd2 
	         WHERE confirmed>10000
	        );

SELECT * FROM t_testing;

DROP VIEW IF EXISTS v_healthcare_provider_subset;
DROP TABLE IF EXISTS t_healthcare_provider_subset;
DROP VIEW IF EXISTS v_testing;
DROP TABLE IF EXISTS t_testing;


