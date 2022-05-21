/*
 * ORDER BY **********
 * 
 */


-- Úkol 1: Vypište od všech poskytovatelů zdravotních služeb jméno a typ. 
-- Záznamy seřaďte podle jména vzestupně.
SELECT * FROM healthcare_provider hp;

SELECT 
	name,
	provider_type 
 FROM healthcare_provider hp
 ORDER BY TRIM(name) ASC;
 

-- Úkol 2: Vypište od všech poskytovatelů zdravotních služeb ID, jméno a typ. 
-- Záznamy seřaďte primárně podle kódu kraje a sekundárně podle kódu okresu.
SELECT 
	provider_id,
	name,
	provider_type 
FROM healthcare_provider hp 
ORDER BY region_code, district_code;


-- Úkol 3: Seřaďte na výpisu data z tabulky czechia_district sestupně podle kódu okresu.
SELECT 
	* 
 FROM czechia_district cd
ORDER BY code DESC;


-- Úkol 4: Vypište abacedně pět posledních krajů v ČR.
SELECT 
	* 
 FROM czechia_region cr
ORDER BY name DESC 
LIMIT 5;


-- Úkol 5: Data z tabulky healthcare_provider vypište 
-- seřazena vzestupně dle typu poskytovatele a sestupně dle jména.
SELECT 
	* 
 FROM healthcare_provider hp
ORDER BY provider_type ASC, name DESC;


/*
 * CASE expression *****
 * 
 */

-- Úkol 1: Přidejte na výpisu k tabulce healthcare_provider 
-- nový sloupec is_from_Prague, který bude obsahovat 
-- 1 pro poskytovate z Prahy a 0 pro ty mimo pražské.
SELECT 
	*,
	CASE
		WHEN region_code = 'CZ010' THEN 1
		ELSE 0
	END AS is_from_Prague
FROM healthcare_provider hp;


-- Úkol 2: Upravte dotaz z předchozího příkladu tak, 
-- aby obsahoval záznamy, které spadají jenom do Prahy.
SELECT 
	*,
	CASE
		WHEN region_code = 'CZ010' THEN 1
		ELSE 0
	END AS is_from_Prague
 FROM healthcare_provider hp
WHERE region_code = 'CZ010';


-- Úkol 3: Sestavte dotaz, který na výstupu ukáže název poskytovatele, 
-- město poskytování služeb, zeměpisnou délku a v dynamicky vypočítaném 
-- sloupci slovní informaci, jak moc na západě se poskytovatel nachází – 
-- určete takto čtyři kategorie rozdělení.
SELECT 
	name,
	municipality,
	longitude,
	CASE 
		WHEN longitude < 14 THEN 'nejvice na zapade'
		WHEN longitude < 16 THEN 'mene na zapade'
		WHEN longitude < 18 THEN 'vice na zapade'
		ELSE 'nejvice na vychode'
	END AS czechia_position
FROM healthcare_provider
ORDER BY longitude;


-- Úkol 4: Vypište název a typ poskytovatele a v novém sloupci odlište, 
-- zda jeho typ je Lékárna nebo Výdejna zdravotnických prostředků.
SELECT
	name,
	provider_type,
	CASE 
		WHEN provider_type = 'Lékárna'
		  OR provider_type = 'Výdejna zdravotnických prostředků' THEN 1
		ELSE 0
	END AS lekarna_nebo_vydejna	
FROM healthcare_provider;


/*
 * WHERE, IN, LIKE *****
 * 
 */


-- Úkol 1: Vyberte z tabulky healthcare_provider záznamy o poskytovatelích, kteří mají ve jméně slovo nemocnice.
SELECT 
	*
 FROM healthcare_provider hp 
WHERE `name` LIKE '%nemocnice%';


-- Úkol 2: Vyberte z tabulky healthcare_provider jméno poskytovatelů, 
-- kteří v něm mají slovo lékárna. Vytvořte další dynamicky vypsaný sloupec, 
-- který bude obsahovat 1, pokud slovem lékárna název začíná. V opačném případě bude ve sloupci 0.
SELECT 
	name,
	CASE 
		WHEN name LIKE 'lékárna%' THEN 1
		ELSE 0
	END AS starts_with_lekarna
 FROM healthcare_provider hp 
WHERE name LIKE '%lékárna%'
ORDER BY starts_with_lekarna DESC;

	
-- Úkol 3: Vypište jméno a město poskytovatelů, jejichž název města poskytování má délku čtyři písmena (znaky).
SELECT 
	name,
	municipality
 FROM healthcare_provider hp 
WHERE municipality LIKE '____';


-- Úkol 4: Vypište jméno, město a okres místa poskytování u těch poskytovatelů, 
-- kteří jsou z Brna, Prahy nebo Ostravy nebo z okresů Most nebo Děčín.
SELECT * FROM czechia_district cd;

SELECT 
	name,
	municipality,
	district_code	
FROM healthcare_provider hp
WHERE municipality IN  ('Brno', 'Praha', 'Ostrava')
   OR district_code IN ('CZ0425', 'CZ0421');
  
 
-- Úkol 5: Pomocí vnořeného SELECT vypište kódy krajů 
-- pro Jihomoravský a Středočeský kraj z tabulky czechia_region. 
-- Ty použijte pro vypsání ID, jména a kraje jen těch 
-- vyhovujících poskytovatelů z tabulky healthcare_provider.
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


-- Úkol 6: Z tabulky czechia_district vypište jenom ty okresy, 
-- ve kterých se vyskytuje název města, které má délku čtyři písmena (znaky).
SELECT * FROM czechia_district cd 

SELECT 
	* 
FROM czechia_district cd
WHERE name LIKE '____';


SELECT
    *
FROM czechia_district
WHERE code IN (
    SELECT
        district_code
    FROM healthcare_provider
    WHERE municipality LIKE '____'
);










