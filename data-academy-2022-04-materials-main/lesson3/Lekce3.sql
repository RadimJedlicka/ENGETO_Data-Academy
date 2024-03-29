-- unikatni hodnoty 
SELECT 
	count(DISTINCT name) AS poskytovatelu_zdravotni_pece
 FROM healthcare_provider hp 
WHERE 1=1
--   AND district_code = 'CZ0805'
  AND region_code   = 'CZ080'
  
  
-- unikatni hodnoty v podmnozine
SELECT 
	count(DISTINCT name) AS poskytovatelu_zdravotni_pece,
	count(DISTINCT CASE WHEN district_code = 'CZ0805' 
	                    THEN name END) AS pzp_CZ0805                                 
 FROM healthcare_provider hp 
WHERE 1=1
--   AND district_code = 'CZ0805'
  AND region_code   = 'CZ080'


-- WITH 
WITH base AS (
	SELECT 
		count(DISTINCT name) AS pzp,
		count(DISTINCT CASE WHEN district_code = 'CZ0805' 
		                    THEN name END) AS pzp_CZ0805                                 
	 FROM healthcare_provider hp 
	WHERE 1=1
	  AND region_code   = 'CZ080'
)
SELECT 
	pzp, 
	pzp_CZ0805,
	pzp_CZ0805/pzp AS prc  
FROM base  


-- dalsi where 
SELECT DISTINCT
	region_code                              
 FROM healthcare_provider hp 
WHERE 1=1
  AND region_code IN ('CZ032','CZ080')

-- name, ktery obsahuje slovo nemocnice 
SELECT 
	* 
 FROM healthcare_provider
WHERE name like '%emocnice%' 
ORDER BY name DESC

-- -------------------------------------------
-- agregacni funkce 
-- count nahore

-- suma prirustku 
SELECT
	sum(confirmed) as suma_prirustku
 FROM covid19_basic_differences cb 
WHERE 1=1
  AND country = 'Czechia'
  AND date >= '2021-03-01'
  AND date <= '2021-03-31'

-- nejvyssi prustek
SELECT
	max(confirmed) as max_prirustku
 FROM covid19_basic_differences cb 
WHERE 1=1
  AND country = 'Czechia'
  AND date >= '2021-01-01'
  AND date <= '2021-12-31'
  
-- nejmensi prustek
SELECT
	min(confirmed) as min_prirustku
 FROM covid19_basic_differences cb 
WHERE 1=1
  AND country = 'Czechia'
  AND date >= '2021-01-01'
  AND date <= '2021-12-31'  
  
-- prumenry denni prustek
SELECT
	avg(confirmed) as prumer_prirustku
 FROM covid19_basic_differences cb 
WHERE 1=1
  AND country = 'Czechia'
  AND date >= '2021-01-01'
  AND date <= '2021-12-31'  
  
  
-- kombinovani 
SELECT
	max(confirmed) as max_prirustku,
	min(confirmed) as min_prirustku,
	max(confirmed) - min(confirmed) AS range_prirustku, 
	avg(confirmed) as prumer_prirustku
 FROM covid19_basic_differences cb 
WHERE 1=1
  AND country = 'Czechia'
  AND date   >= '2021-03-01'
  AND date   <= '2021-03-31'
  
  
-- max czechia vs slovakia
SELECT
	country,
	max(confirmed) as max_prirustku
 FROM covid19_basic_differences cb   
WHERE 1=1
  AND country IN ('Czechia','Slovakia')
  AND date   >= '2021-03-01'
  AND date   <= '2021-03-31'  
GROUP BY
	country
	
	
-- jiny priklad	
SELECT 
	category_code,
	region_code, 
	max(value) as max_value,
	sum(value) as sum_value
FROM czechia_price cp 
WHERE category_code = 117103
GROUP BY 
	category_code,
	region_code
ORDER BY 	
	region_code DESC

	
-- us covid data
SELECT
	province, 
-- 	admin2,
	max(confirmed)
FROM covid19_detail_us_differences cdud 
GROUP BY
	province,
-- 	admin2,
	null
	
-- -----------------------------------
-- window functions

-- cumulative window function	
SELECT 	
	date,
	country,
	confirmed,
	sum(confirmed) OVER (PARTITION BY country 
	                     ORDER BY date 
	                     ROWS BETWEEN UNBOUNDED PRECEDING 
	                     AND CURRENT ROW) as cumulative_sum,
	avg(confirmed) OVER (PARTITION BY country 
	                     ORDER BY date 
	                     ROWS BETWEEN 6 PRECEDING 
	                     AND CURRENT ROW) as average_last_seven_days,    
	avg(confirmed) OVER (PARTITION BY country 
	                     ORDER BY date 
	                     ROWS BETWEEN 3 PRECEDING 
	                     AND 3 FOLLOWING) as average_ss                          
FROM covid19_basic_differences cbd 	
WHERE 1=1
  AND country IN ('Czechia','Slovakia')
  AND date   >= '2021-03-01'
  AND date   <= '2021-03-31' 	

	
-- from cumulative to diff window function		
SELECT 
	date,
	country,
	confirmed,
	confirmed - lag(confirmed) OVER (PARTITION BY country ORDER BY date) as denni_prirustek,
	FIRST_VALUE(confirmed)	OVER (PARTITION BY country ORDER BY date) 
-- 	lag(confirmed) OVER (PARTITION BY country ORDER BY date) as predchozi_confirmed
-- 	lead(confirmed) OVER (PARTITION BY country ORDER BY date) as nasledujici_confirmed
-- 	sum(confirmed) OVER (PARTITION BY country 
-- 	                     ORDER BY date 
-- 	                     ROWS BETWEEN 7 PRECEDING 
-- 	                     AND 7 PRECEDING) as predchozi_confirmed
FROM covid19_basic cb 
WHERE 1=1
  AND country IN ('Czechia','Slovakia')
  AND date   >= '2021-03-01'
  AND date   <= '2021-03-31' 
	
  
-- vnoreny select
SELECT 
	country,
	sum(denni_prirustek)
FROM 
(
	SELECT 
		date,
		country,
		confirmed - predchozi_confirmed AS denni_prirustek
	FROM 
	(
		SELECT 
			date,
			country,
			confirmed,
			lag(confirmed) OVER (PARTITION BY country ORDER BY date) as predchozi_confirmed
		FROM covid19_basic cb 
		WHERE 1=1
		  AND country IN ('Czechia','Slovakia')
		  AND date   >= '2021-03-01'
		  AND date   <= '2021-03-31'   
	) base
) a 
WHERE country = 'Czechia'
GROUP BY 
	country

	
	
-- to stejne s klauzili WITH
WITH table_predchozi_confirmed AS (
	SELECT 
		date,
		country,
		confirmed,
		lag(confirmed) OVER (PARTITION BY country ORDER BY date) as predchozi_confirmed
	FROM covid19_basic cb 
	WHERE 1=1
	  AND country IN ('Czechia','Slovakia')
	  AND date   >= '2021-03-01'
	  AND date   <= '2021-03-31'   
),
table_novy_slopec AS (
	SELECT 
		date,
		country,
		confirmed - predchozi_confirmed AS denni_prirustek
	FROM table_predchozi_confirmed
)  
SELECT 
	country,
	sum(denni_prirustek)
FROM table_novy_slopec	
WHERE country = 'Czechia'
GROUP BY 
	country
	
	
-- rychly priklad
WITH seznam_countries AS (
	SELECT 
		country
	FROM covid19_basic cb 
	WHERE 1=1
	  AND country IN ('Czechia','Slovakia','Germany')
	GROUP BY 
		country
),
prirustky AS (
	SELECT 
		date,
		country,
		confirmed,
		lag(confirmed) OVER (PARTITION BY country ORDER BY date) as predchozi_confirmed
	FROM covid19_basic cb 
	WHERE 1=1
	  AND country IN (SELECT country FROM seznam_countries)
	  AND date   >= '2021-03-01'
	  AND date   <= '2021-03-31'   
),
kumulativni AS (
	SELECT 
		date,
		country,
		confirmed
	FROM covid19_basic_differences cb 
	WHERE 1=1
	  AND country IN (SELECT country FROM seznam_countries)
	  AND date   >= '2021-03-01'
	  AND date   <= '2021-03-31'  
)
SELECT 
	* 
FROM kumulativni


-- -----------
-- k-MEAN

--           lat     lon	
-- praha     50.0755 14.4378
-- prostejov 49.4724 17.1068

WITH base AS (
	SELECT
		name,
		latitude,
		longitude,
		sqrt(power(latitude - 50.0755,2)* 111.38 
		   + power(longitude - 14.4378,2)* 70) AS distance_prague,
		sqrt(power(latitude - 49.4724,2)* 111.38 
		   + power(longitude - 17.1068,2)* 70) AS distance_prostejov
	FROM healthcare_provider hp 
)
SELECT 
	name,
	latitude,
	longitude,
	CASE WHEN distance_prague < distance_prostejov THEN 'Prague region'
	     ELSE 'Prostejov region' END AS kmean
FROM base

pavel.fryblik@gmail.com
	