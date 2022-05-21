/*
 * SELECT, ORDER BY a LIMIT
 */

-- Úkol 1: Vypište všechna data z tabulky healthcare_provider.
SELECT 
	*
 FROM healthcare_provider;
 
 
-- Úkol 2: Vypište pouze sloupce se jménem a typem poskytovatele 
-- ze stejné tabulky jako v předchozím příkladu.
 
SELECT
	name,
	provider_type 
FROM healthcare_provider hp;


-- Úkol 3: Předchozí dotaz upravte tak, 
-- že vypíše pouze prvních 20 záznamů v tabulce.
SELECT
	name,
	provider_type 
 FROM healthcare_provider hp
LIMIT 20;


-- Úkol 4: Vypište z tabulky healthcare_provider záznamy 
-- seřazené podle kódu kraje vzestupně.
SELECT 
	*
FROM healthcare_provider hp
ORDER BY region_code ASC;


-- Úkol 5: Vypište ze stejné tabulky jako v předchozím příkladě 
-- sloupce se jménem poskytovatele, kódem kraje a kódem okresu. 
-- Data seřaďte podle kódu okresu sestupně. 
-- Nakonec vyberte pouze prvních 500 záznamů.
SELECT 
	name,
	region_code,
	district_code 
  FROM healthcare_provider hp 
 ORDER BY district_code DESC
 LIMIT 500;


/*
 * WHERE
 * 
 */

-- Úkol 1: Vyberte z tabulky healthcare_provider 
-- všechny záznamy poskytovatelů zdravotních služeb, 
-- kteří poskytují služby v Praze (kraj Praha).
SELECT 
	*
 FROM healthcare_provider hp 
WHERE region_code = 'CZ010';


-- Úkol 2: Vyberte ze stejné tabulky název 
-- a kontaktní informace poskytovatelů, 
-- kteří nemají místo poskytování v Praze (kraj Praha).
SELECT 
	name,
	phone,
	website,
	fax,
	email,
	municipality 
FROM healthcare_provider hp 
WHERE region_code != 'CZ010';


-- Úkol 3: Vypište názvy poskytovatelů, kódy krajů místa poskytování 
-- a místa sídla u takových poskytovatelů, 
-- u kterých se tyto hodnoty rovnají.
SELECT 
	name,
	region_code, 
	residence_region_code
 FROM healthcare_provider hp 
WHERE region_code = residence_region_code;


-- Úkol 4: Vypište název a telefon takových 
-- poskytovatelů, kteří svůj telefon vyplnili do registru.
SELECT 
	name,
	phone
 FROM healthcare_provider hp 
WHERE phone IS NOT NULL;


-- Úkol 5: Vypište název poskytovatele a kód okresu 
-- u poskytovatelů, kteří mají místo poskytování služeb 
-- v okresech Benešov a Beroun. 
-- Záznamy seřaďte vzestupně podle kódu okresu.
SELECT * FROM czechia_district cd;

SELECT 
	name,
	district_code 
FROM healthcare_provider
WHERE district_code = 'CZ0201' 
   OR district_code = 'CZ0202'
ORDER BY district_code;


/*
 * Tvorba tabulek
 * 
 */

-- Úkol 1: Vytvořte tabulku 
-- t_{jméno}_{příjmení}_providers_south_moravia 
-- z tabulky healthcare_provider vyberte pouze Jihomoravský kraj.
SELECT * FROM czechia_region cr;

CREATE TABLE t_radim_jedlicka_south_moravia
SELECT 
	*
 FROM healthcare_provider hp
WHERE district_code = 'CZ064';


-- Úkol 2: Vytvořte tabulku t_{jméno}_{příjmení}_resume, 
-- kde budou sloupce date_start, date_end, job, education. 
-- Sloupcům definujte vhodné datové typy.
CREATE TABLE t_radim_jedlicka_resume2 (
	date_start date,
	date_end date,
	education varchar(255),
	job varchar(255)
);


/*
 * Vkládání dat do tabulky
 * 
 */


-- Úkol 1: Vložte do tabulky popis_tabulek 
-- pod svým jménem popis tabulky.
CREATE TABLE popis_tabulek (
	name varchar(255),
	table_type varchar(255),
	description varchar(255)
);

INSERT INTO popis_tabulek
VALUES('Jan Novak', 'lookup_table', 'Tabulka s popisem zemi a poctem obyvatel' );

SELECT * FROM popis_tabulek;


-- Úkol 2: Do tabulky t_{jméno}_{příjmení}_resume, 
-- kterou jste vytvořili v minulé části, 
-- vložte záznam se svým současným zaměstnáním nebo studiem.

-- Nápověda: Pole date_end bude v tomto případě prázdná hodnota. 
-- Tu zaznamenáme jako null.
SELECT * FROM t_radim_jedlicka_resume2 trjr 

INSERT INTO t_radim_jedlicka_resume2 
VALUES ('2022-10-01', NULL, 'PhD', 'Microprobe operator');


-- Úkol 3: Do tabulky t_{jméno}_{příjmení}_resume vložte další záznamy. 
-- Zkuste použít více způsobů vkládání.
-- Poznámka: Pokud nechcete uvádět skutečné informace, 
-- klidně si vytvořte své alter ego :)
SELECT * FROM t_radim_jedlicka_resume2 trjr 

INSERT INTO t_radim_jedlicka_resume2 
VALUES ('2010-10-01', '2018-01-01', 'University', 'student');

INSERT INTO t_radim_jedlicka_resume2 (date_start, education, job, date_end)
VALUES ( '2000-01-01', 'Highschool', 'pupil', '2008-10-10')


/*
 * Úprava tabulek
 * 
 */


-- Úkol 1: K tabulce t_{jméno}_{příjmení}_resume přidejte dva sloupce: 
-- institution a role, které budou typu VARCHAR(255).
ALTER TABLE t_radim_jedlicka_resume2
 ADD COLUMN institution VARCHAR(255);

ALTER TABLE t_radim_jedlicka_resume2
 ADD COLUMN `role`  VARCHAR(255);


-- Úkol 2: Do tabulky t_{jméno}_{příjmení}_resume 
-- doplňte informace o tom, v jaké firmě nebo škole 
-- jste v daný čas působili (sloupec institution) 
-- a na jaké pozici (sloupec role).
UPDATE t_radim_jedlicka_resume2 
   SET institution = 'UK Prague'
 WHERE date_start = '2022-10-01;'
 
UPDATE t_radim_jedlicka_resume2 
   SET institution = 'UK Prague'
 WHERE date_start = '2010-10-01;'

UPDATE t_radim_jedlicka_resume2 
   SET institution = 'GymSOS FM'
 WHERE date_start = '2000-01-01;'
 
UPDATE t_radim_jedlicka_resume2 
   SET `role` = 'porad zak'
 WHERE date_start = '2000-01-01;'
 
UPDATE t_radim_jedlicka_resume2 
   SET `role` = 'porad student'
 WHERE date_start = '2010-10-01;'
 
UPDATE t_radim_jedlicka_resume2 
   SET `role` = 'PhD student'
 WHERE date_start = '2022-10-01;'
 
 SELECT * FROM t_radim_jedlicka_resume2 trjr;


-- Úkol 3: Z tabulky t_{jméno}_{příjmení}_resume 
-- vymažte sloupce education a job.
ALTER TABLE t_radim_jedlicka_resume2 DROP COLUMN `education`;

ALTER TABLE t_radim_jedlicka_resume2 DROP COLUMN `job`;

SELECT * FROM t_radim_jedlicka_resume2 trjr;


/*
 * BONUSOVÁ CVIČENÍ
 * 
 * COVID-19: SELECT, ORDER BY a LIMIT
 * 
 */


-- Úkol 1: Ukažte všechny záznamy z tabulky covid19_basic.
SELECT 
	*
 FROM covid19_basic cb;


-- Úkol 2: Ukažte jen prvních 20 záznamů z tabulky covid19_basic.
SELECT 
	*
 FROM covid19_basic cb
 LIMIT 20;


-- Úkol 3: Seřaďte celou tabulku covid19_basic 
-- vzestupně podle sloupce date.
SELECT 
	*
 FROM covid19_basic cb 
ORDER BY date ASC;

-- Úkol 4: Seřaďte celou tabulku covid19_basic 
-- sestupně podle sloupce date.
SELECT 
	*
 FROM covid19_basic cb 
ORDER BY date DESC;


-- Úkol 5: Vyberte jen sloupec country z tabulky covid19_basic.
SELECT 
	DISTINCT country
 FROM covid19_basic cb 


-- Úkol 6: Vyberte jen sloupce country a date z tabulky covid19_basic.
SELECT 
	country,
	date
 FROM covid19_basic cb 
 

-- Úkol 1: Vyberte z tabulky covid19_basic jen záznamy s Rakouskem (Austria).
SELECT
	*
 FROM covid19_basic cb 
WHERE country = 'Austria';


-- Úkol 2: Vyberte jen sloupce country, date a confirmed pro Rakousko z tabulky covid19_basic.
SELECT
	country,
	date,
	confirmed 
 FROM covid19_basic cb 
WHERE country = 'Austria';


-- Úkol 3: Vyberte všechny sloupce k datu 30. 8. 2020 z tabulky covid19_basic.
SELECT 
	*
 FROM covid19_basic cb 
WHERE date = '2020-08-30';


-- Úkol 4: Vyberte všechny sloupce k datu 30. 8. 2020 v České republice z tabulky covid19_basic.
SELECT 
	*
 FROM covid19_basic cb 
WHERE 1=1
  AND country = 'Czechia'
  AND date = '2020-08-30';

 
-- Úkol 5: Vyberte všechny sloupce pro Českou republiku a Rakousko z tabulky covid19_basic.
SELECT 
	*
 FROM covid19_basic cb 
WHERE 1=1
  AND country = 'Czechia'
   OR country = 'Austria';
  
  
-- Úkol 6: Vyberte všechny sloupce z covid19_basic, 
-- kde počet nakažených je roven 1 000, nebo 100 000.
SELECT 
	*
 FROM covid19_basic cb
WHERE confirmed = 1000
   OR confirmed = 100000;
  
  
-- Úkol 7: Vyberte všechny sloupce z tabulky covid19_basic, 
-- kde počet nakažených je mezi 10 a 20 v den 30. 8. 2020.
SELECT 
	*
 FROM covid19_basic cb 
WHERE confirmed BETWEEN 10 AND 20
  AND date = '2020-08-30';
 
-- nebo druha varianta:

SELECT 
	* 
 FROM covid19_basic 
WHERE confirmed >= 10 
  AND confirmed <= 20 
  AND `date` = '2020-08-30';
 

-- Úkol 8: Vyberte všechny sloupce z covid19_basic, 
-- u kterých je počet nakažených větší než jeden milion dne 15. 8. 2020.
SELECT 
	*
 FROM covid19_basic cb 
WHERE confirmed > 1000000
  AND date = '2020-08-15';
 
 
-- Úkol 9: Vyberte sloupce date, country a confirmed v Anglii a Francii 
-- z tabulky covid19_basic a seřaďte je sestupně podle data.
SELECT 
	date,
	country,
	confirmed 
 FROM covid19_basic cb
WHERE country = 'United Kingdom'
   OR country = 'France'
ORDER BY date DESC;


-- Úkol 10: Vyberte z tabuky covid19_basic_differences 
-- přírůstky nakažených v České republice v září 2020.
SELECT * FROM covid19_basic_differences cbd;

SELECT 
	confirmed 
 FROM covid19_basic_differences cbd
WHERE country = 'Czechia'
  AND date BETWEEN '2020-09-01' 
               AND '2020-09-30';
              
-- nebo druha varianta:              

SELECT 
	confirmed 
 FROM covid19_basic_differences
WHERE country='Czechia'
      and date>='2020-09-01'
      and date<='2020-09-30';
     
     
-- Úkol 11: Z tabulky lookup_table zjistěte počet obyvatel Rakouska.
SELECT * FROM lookup_table lt; 

SELECT 
	population 
 FROM lookup_table lt
WHERE country = 'Austria';


-- Úkol 12: Z tabulky lookup_table vyberte jen země, 
-- které mají počet obyvatel větší než 500 milionů.
SELECT 
	country,
	population	
 FROM lookup_table lt
WHERE population >= 500000000;


-- Úkol 13: Zjistěte počet nakažených v Indii 
-- dne 30. srpna 2020 z tabulky covid19_basic.
SELECT
	date,
	country,
	confirmed 
 FROM covid19_basic cb
WHERE country = 'India'
  AND date = '2020-08-30';
 
 
-- Úkol 14: Zjistěte počet nakažených na Floridě 
-- z tabulky covid19_detail_us dne 30. srpna 2020.
SELECT * FROM covid19_detail_us cdu;

SELECT
	province,
	admin2,
	confirmed
 FROM covid19_detail_us
WHERE `province` = 'Florida'
  AND `date` = '2020-08-30';
