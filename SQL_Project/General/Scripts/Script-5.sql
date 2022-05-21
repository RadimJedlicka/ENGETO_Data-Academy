SELECT 
	count(DISTINCT name) AS poskytovatelu_zdravotni_pece,
	count(DISTINCT CASE WHEN district_code = 'CZ0805' 
						THEN name END) AS pzp_CZ0805
 FROM healthcare_provider
WHERE 1=1
  AND region_code ='CZ080'
--   AND district_code = 'CZ0805'
  
  
-- unikatni hodnoty v podmnozine
  
SELECT 
	count(DISTINCT name) AS poskytovatelu_zdravotni_pece,
	count(DISTINCT CASE WHEN district_code = 'CZ0805' 
						THEN name END) AS pzp_CZ0805
 FROM healthcare_provider
WHERE 1=1
  AND region_code ='CZ080'
--   AND district_code = 'CZ0805'
  
  
-- WITH 
WITH base AS (
	SELECT 
		count(DISTINCT name) AS poskytovatelu_zdravotni_pece,
		count(DISTINCT CASE WHEN district_code = 'CZ0805' 
							THEN name END) AS pzp_CZ0805
	 FROM healthcare_provider
	WHERE 1=1
	  AND region_code ='CZ080'
	--   AND district_code = 'CZ0805'
)

-- SELECT
-- 	pzp,
-- 	pzp_CZ0805,
-- 	pzp_CZ0805/pzp AS prc 
-- FROM base

-- dalsi WHERE 
SELECT
	*
	FROM healthcare_provider hp 
-- 	WHERE 1=1 
	AND region_code IN ('CZ032','CZ080')
	
	
-- name, ktery obsahuje slovo nemocnice
SELECT
	*
	FROM healthcare_provider hp 
	WHERE name like '%nemocnice%'
	ORDER BY name DESC
	
	
  
  
  
  
  
  
  
  