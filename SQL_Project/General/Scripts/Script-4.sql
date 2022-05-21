SELECT 
	name,
	provider_type
FROM healthcare_provider
ORDER BY TRIM(name);


SELECT 
	provider_id 
	name,
	provider_type,
	region_code,
	district_code
FROM healthcare_provider
ORDER BY region_code ASC, district_code ASC;


SELECT *
FROM czechia_district
ORDER BY code DESC;

SELECT *
FROM (
	SELECT *
	FROM czechia_region
	ORDER BY name DESC
	LIMIT 5
) AS result_table
ORDER BY result_table.name ASC;


SELECT *
FROM healthcare_provider
ORDER BY provider_type, name DESC;


SELECT *,
	CASE
		WHEN region_code = 'CZ010' THEN 1
		ELSE 0
	END AS is_from_Prague
FROM healthcare_provider



SELECT *,
	CASE
		WHEN region_code = 'CZ010' THEN 1
		ELSE 0
	END AS is_from_Prague
FROM healthcare_provider
WHERE region_code = 'CZ010';


SELECT 
	longitude
FROM healthcare_provider
WHERE longitude IS NOT NULL 
ORDER BY longitude DESC;


SELECT 
	name, municipality, longitude,
	CASE 
		WHEN longitude IS NULL THEN '---není známo---'
		WHEN longitude < 14 THEN 'nejvíce na západě'
		WHEN longitude < 16 THEN 'méně na západě'
		WHEN longitude < 18 THEN 'více na východě'
		ELSE 'nejvíce na východě'
	END AS czechia_position
FROM healthcare_provider;
	

SELECT 
	name, provider_type,
	CASE
		WHEN provider_type = 'Lékárna' OR provider_type = 'Výdejna zdravotnických prostředků' THEN 1
		ELSE 0
	END AS is_desired_type
FROM healthcare_provider;


SELECT 
	name, provider_type,
	CASE
		WHEN provider_type IN ('Lékárna', 'Výdejna zdravotnických prostředků') THEN 1
		ELSE 0
	END AS is_desired_type
FROM healthcare_provider;


SELECT *
FROM healthcare_provider
WHERE name LIKE '%nemocnice%';



SELECT 
	name,
	CASE 
		WHEN name LIKE 'lékárna%' THEN 1
		ELSE 0
	END AS starts_with_searched_name
FROM healthcare_provider
WHERE name LIKE '%lékárna%'



SELECT 
	name, municipality 
FROM healthcare_provider
WHERE municipality LIKE '____';


SELECT 
	DISTINCT municipality 
FROM healthcare_provider
WHERE municipality LIKE '____';


SELECT 
	name, municipality 
FROM healthcare_provider
WHERE CHAR_LENGTH(municipality) = 4;


SELECT *
FROM czechia_district
WHERE name IN ('Most', 'Děčín');



SELECT 
	name, municipality, district_code 
FROM healthcare_provider hp 
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
	WHERE name IN ('Jihomoravský kraj', 'Středočeský kraj')
);



SELECT *
FROM czechia_district cd 
WHERE code IN (
	SELECT 
		district_code 
	FROM healthcare_provider hp 
	WHERE municipality LIKE '____'
);




/*
 * VIEWS
 */


CREATE OR REPLACE VIEW v_healthcare_provider_subset AS 
	SELECT 
		provider_id,
		municipality,
		district_code 
	FROM healthcare_provider hp 
	WHERE municipality IN ('Brno', 'Praha', 'Ostrava');


SELECT *


















