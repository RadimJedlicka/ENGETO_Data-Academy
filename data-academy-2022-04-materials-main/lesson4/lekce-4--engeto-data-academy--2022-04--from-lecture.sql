/*
 * JOIN
 * 
 */

SELECT *
FROM czechia_price
INNER JOIN czechia_price_category
	ON czechia_price.category_code = czechia_price_category.code;
	
SELECT
	cp.id, cpc.name, cp.value
FROM czechia_price cp
INNER JOIN czechia_price_category cpc
	ON cp.category_code = cpc.code;
	
SELECT * FROM czechia_price cp;

SELECT
	cp.*, cr.name
FROM czechia_price cp
JOIN czechia_region cr
	ON cp.region_code = cr.code;
	
SELECT
	count(1)
FROM czechia_price cp
INNER JOIN czechia_region cr
	ON cp.region_code = cr.code;

SELECT
	count(1)
FROM czechia_price cp
LEFT JOIN czechia_region cr
	ON cp.region_code = cr.code;

SELECT
	cp.*, cr.name
FROM czechia_price cp
RIGHT JOIN czechia_region cr
	ON cp.region_code = cr.code;


SELECT *
FROM czechia_payroll cp
LEFT JOIN czechia_payroll_calculation cpc
	ON cp.calculation_code = cpc.code
LEFT JOIN czechia_payroll_industry_branch cpib
	ON cp.industry_branch_code = cpib.code
LEFT JOIN czechia_payroll_unit cpu
	ON cp.unit_code = cpu.code
LEFT JOIN czechia_payroll_value_type cpvt
	ON cp.value_type_code = cpvt.code;


SELECT
    *
FROM czechia_payroll_industry_branch
WHERE code IN (
    SELECT
        industry_branch_code
    FROM czechia_payroll
    WHERE value IN (
        SELECT
            MAX(value)
        FROM czechia_payroll
        WHERE value_type_code = 5958
    )
);

SELECT cpib.*
FROM czechia_payroll_industry_branch cpib
JOIN czechia_payroll cp
	ON cpib.code = cp.industry_branch_code
WHERE cp.value_type_code = 5958 #Prùmìrná hrubá mzda na zamìstnance
ORDER BY cp.value DESC
LIMIT 1;

SELECT cpib.*
FROM czechia_payroll_industry_branch cpib
JOIN czechia_payroll cp
	ON cpib.code = cp.industry_branch_code
JOIN czechia_payroll_value_type cpvt
	ON cp.value_type_code = cpvt.code 
WHERE cpvt.name = 'Prùmìrná hrubá mzda na zamìstnance'
ORDER BY cp.value DESC
LIMIT 1;



SELECT MONTH(date_from), date_from FROM czechia_price cp;

SELECT
    cpc.name AS food_category, cp.value AS price,
    cpib.name AS industry, cpay.value AS average_wages,
    DATE_FORMAT(cp.date_from, '%e. %M %Y') AS price_measured_from,
    DATE_FORMAT(cp.date_to, '%d.%m.%Y') AS price_measured_to,
    cpay.payroll_year
FROM czechia_price AS cp
JOIN czechia_payroll AS cpay
    ON YEAR(cp.date_from) = cpay.payroll_year AND
    cpay.value_type_code = 5958 AND
    cp.region_code IS NULL
JOIN czechia_price_category cpc
    ON cp.category_code = cpc.code
JOIN czechia_payroll_industry_branch cpib
    ON cpay.industry_branch_code = cpib.code;
   
   
SELECT
    hp.name,
    cr.name AS region_name,
    cr2.name AS residence_region_name,
    cd.name AS district_name,
    cd2.name AS residence_district_name
FROM healthcare_provider hp
LEFT JOIN czechia_region cr
    ON hp.region_code = cr.code
LEFT JOIN czechia_region cr2
    ON hp.residence_region_code = cr2.code
LEFT JOIN czechia_district cd
    ON hp.district_code = cd.code
LEFT JOIN czechia_district cd2
    ON hp.residence_district_code = cd2.code;
   
SELECT *
FROM healthcare_provider
WHERE district_code IS NULL;


SELECT
    DISTINCT hp.place_id, hp.name
FROM healthcare_provider hp
LEFT JOIN czechia_region cr
    ON hp.region_code = cr.code
LEFT JOIN czechia_region cr2
    ON hp.residence_region_code = cr2.code
LEFT JOIN czechia_district cd
    ON hp.district_code = cd.code
LEFT JOIN czechia_district cd2
    ON hp.residence_district_code = cd2.code
WHERE
	hp.region_code != hp.residence_region_code AND 
	hp.district_code != hp.residence_district_code;
   
/*
 * CROSS JOIN a Kartézský souèin
 * 
 */

SELECT *
FROM czechia_price, czechia_price_category;

SELECT *
FROM czechia_price cp, czechia_price_category cpc
WHERE cp.category_code = cpc.code;


SELECT *
FROM czechia_price cp
CROSS JOIN czechia_price_category cpc
	ON cp.category_code = cpc.code;

SELECT
	cr.name AS first_name,
	cr2.name AS second_name
FROM czechia_region cr
CROSS JOIN czechia_region cr2
WHERE cr.code != cr2.code;


/*
 * Množinové operace
 * 
 */

SELECT category_code, value
FROM czechia_price
WHERE region_code IN ('CZ064', 'CZ010');
#ekvivalentni
SELECT category_code, value
FROM czechia_price
WHERE region_code ='CZ064'
UNION ALL
SELECT category_code, value
FROM czechia_price
WHERE region_code ='CZ010';


SELECT DISTINCT category_code, value
FROM czechia_price
WHERE region_code IN ('CZ064', 'CZ010');
#ekvivalentni
SELECT category_code, value
FROM czechia_price
WHERE region_code ='CZ064'
UNION
SELECT category_code, value
FROM czechia_price
WHERE region_code ='CZ010';

SELECT *
FROM (
	SELECT code, name, 'region' AS country_part
	FROM czechia_region
	UNION
	SELECT code, name, 'district' AS country_part
	FROM czechia_district
) AS country_parts
ORDER BY code;



SELECT cp.category_code, value
FROM czechia_price cp
WHERE region_code = 'CZ010'
INTERSECT
SELECT cp.category_code, value
FROM czechia_price cp
WHERE region_code = 'CZ064';


SELECT
	cpib.*, cp.id, cp.value
FROM czechia_payroll cp
JOIN czechia_payroll_industry_branch cpib
	ON cp.industry_branch_code = cpib.code
WHERE value IN (
	SELECT value
	FROM czechia_payroll
	WHERE industry_branch_code = 'A'
	INTERSECT
	SELECT value
	FROM czechia_payroll
	WHERE industry_branch_code = 'B'
);

CREATE OR REPLACE INDEX czechia_payroll__value__index ON czechia_payroll(value);
DROP INDEX czechia_payroll__value__index ON czechia_payroll;





