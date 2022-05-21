/* ***********************************************************************************************************
 * V první řadě tabulka address. Tato tabulka nezávisí na žádné další, je tedy vhodné ji vybudovat jako první:
 * ***********************************************************************************************************
 */

CREATE TABLE address (
	id serial,
	street varchar(255),
	street_number int,
	city varchar(255),
	zip_code varchar(6)
);

INSERT INTO address(street,street_number,city,zip_code) VALUES ('Doktorská', 1, 'Engetov', '123 00');

INSERT INTO address(street,street_number,city,zip_code) VALUES ('Pacientská', 1, 'Engetov', '111 11');

INSERT INTO address(street,street_number,city,zip_code) VALUES ('Pacientská', 2, 'Engetov', '567 89');


/* **************************************
 * Následně vytvoříme tabulku pro lékaře:
 * **************************************
 */

CREATE TABLE doctor (
	id serial,
	name varchar(255),
	surname varchar(255),
	address_id int,
	phone_number varchar(20),
	email varchar(255)
);

INSERT INTO doctor(name,surname,address_id,phone_number,email) VALUES ('Jan', 'Doktor', 1, '+420 123 456 789', 'doktor@engeto.cz');


/* ***********************
 * I tabulku pro pacienty:
 * ***********************
 */

CREATE TABLE patient (
	id serial,
	name varchar(255),
	surname varchar(255),
	address_id int,
	insurance_company varchar(255)
);

INSERT INTO patient(name,surname,address_id,insurance_company) VALUES ('Petr', 'Pacient', 2, 'Engeto insurance');

INSERT INTO patient(name,surname,address_id,insurance_company) VALUES ('Libor', 'Pacient', 3, 'Engeto insurance');

INSERT INTO patient(name,surname,address_id,insurance_company) VALUES ('Stanislav', 'Pacient', 3, 'State insurance');


/* ****************************************************************************************
 * Nyní se přesuneme k datovému podkladu pro samotné léky, které mohou lékaři předepisovat:
 * ****************************************************************************************
 */

CREATE TABLE medicament (
	id serial,
	name varchar(255),
	price_insurance float,
	price_patient float,
	unit varchar(10)
);

INSERT INTO medicament(name,price_insurance,price_patient,unit) VALUES ('Super Pills', 10.5, 4, 'package');

INSERT INTO medicament(name,price_insurance,price_patient,unit) VALUES ('Extra Pills', 18.1, 8.2, 'package');

INSERT INTO medicament(name,price_insurance,price_patient,unit) VALUES ('Common Pills', 5, 6.1, 'package');

INSERT INTO medicament(name,price_insurance,price_patient,unit) VALUES ('Super Sirup', 12, 8, 'milliliter');

INSERT INTO medicament(name,price_insurance,price_patient,unit) VALUES ('Extra Sirup', 16.3, 10.3, 'milliliter');


/* *****************************************************************************************************************
 * Tabulka, která nám bude říkat, jaký lékař vytvořil recept pro jakého pacienta, nám prozradí tabulka prescription. 
 * Její definice vypadá následovně:
 * ********************************
 */


CREATE TABLE prescription (
	id serial,
	doctor_id int,
	patient_id int,
	valid_from datetime,
	valid_to datetime,
	is_released boolean
);

INSERT INTO prescription(doctor_id,patient_id,valid_from,valid_to,is_released) VALUES (1, 1, '2019-10-06 11:35:12', '2019-10-16 11:35:12', true);

INSERT INTO prescription(doctor_id,patient_id,valid_from,valid_to,is_released) VALUES (1, 2, '2019-10-06 12:00:06', '2019-10-16 12:00:06', false);

INSERT INTO prescription(doctor_id,patient_id,valid_from,valid_to,is_released) VALUES (1, 3, '2019-10-06 14:04:53', '2019-10-16 14:04:53', true);

INSERT INTO prescription(doctor_id,patient_id,valid_from,valid_to,is_released) VALUES (1, 1, '2019-10-08 08:05:40', '2019-10-18 08:05:40', true);

INSERT INTO prescription(doctor_id,patient_id,valid_from,valid_to,is_released) VALUES (1, 1, '2019-11-11 09:12:42', '2019-11-21 09:12:42', false);

INSERT INTO prescription(doctor_id,patient_id,valid_from,valid_to,is_released) VALUES (1, 2, '2019-11-11 10:07:35', '2019-11-21 10:07:35', false);


/* **************************************************************************************************
 * Konečně potřebujeme do každého receptu přidat léky, které lékař předepsal a také v jakém množství. 
 * Na to nám poslouží tato vazební tabulka s názvem list_of_medicaments. 
 * Skrze ni vyjádříme vztah M:N (tedy, že recept může obsahovat více léků 
 * a lék může být součástí několika receptů):
 * ******************************************
 */

CREATE TABLE list_of_medicaments (
  prescription_id int,
  medicament_id int,
  amount int
);

INSERT INTO list_of_medicaments(prescription_id,medicament_id,amount) VALUES (1, 1, 2);

INSERT INTO list_of_medicaments(prescription_id,medicament_id,amount) VALUES (1, 4, 100);

INSERT INTO list_of_medicaments(prescription_id,medicament_id,amount) VALUES (2, 3, 2);

INSERT INTO list_of_medicaments(prescription_id,medicament_id,amount) VALUES (2, 4, 250);

INSERT INTO list_of_medicaments(prescription_id,medicament_id,amount) VALUES (3, 1, 1);

INSERT INTO list_of_medicaments(prescription_id,medicament_id,amount) VALUES (3, 2, 3);

INSERT INTO list_of_medicaments(prescription_id,medicament_id,amount) VALUES (3, 3, 2);

INSERT INTO list_of_medicaments(prescription_id,medicament_id,amount) VALUES (4, 3, 1);

INSERT INTO list_of_medicaments(prescription_id,medicament_id,amount) VALUES (4, 4, 150);

INSERT INTO list_of_medicaments(prescription_id,medicament_id,amount) VALUES (5, 1, 3);

INSERT INTO list_of_medicaments(prescription_id,medicament_id,amount) VALUES (5, 2, 1);

INSERT INTO list_of_medicaments(prescription_id,medicament_id,amount) VALUES (5, 4, 300);

INSERT INTO list_of_medicaments(prescription_id,medicament_id,amount) VALUES (5, 5, 300);

INSERT INTO list_of_medicaments(prescription_id,medicament_id,amount) VALUES (6, 2, 4);

INSERT INTO list_of_medicaments(prescription_id,medicament_id,amount) VALUES (6, 5, 400);


/* ***************************************************
 * vypsání počtu pacientů v jednotlivých pojišťovnách:
 * ***************************************************
 */

SELECT 
	insurance_company AS 'Pojištovna',
	count(id) AS 'pocet pojistencu' 
 FROM patient p 
GROUP BY insurance_company
ORDER BY insurance_company;


/* ******************************************************************************************
 * Mírně komplexnější dotaz může být, když se budeme snažit seskupovat napříč více tabulkami. 
 * Chceme například získat počet pacientů žijících na konkrétní ulici a čísle orientačním
 * **************************************************************************************
 */

SELECT 
	concat(a.street, ' ', a.street_number) AS "ulice",
	count(p.id) AS "pocet pacientu" 
 FROM patient AS p 
 JOIN address AS a ON p.address_id = a.id 
GROUP BY a.street, a.street_number 
ORDER BY a.street, a.street_number;


/* *****************
 * Praktický příklad
 * *****************
 */

-- Získej počet léků v kategoriích rozdělených dle jejich jednotky (atribut unit).
SELECT 
	unit AS "Jednotky",
	count(id) AS "Pocet"
FROM medicament m 
GROUP BY unit
ORDER BY unit; 


-- Seřaď pacienty (jméno a příjmení) sestupně podle vydaných receptů společně s vypsaným počtem těchto receptů.
SELECT 
	concat(pat.name, ' ', pat.surname) AS "Pacient",
	count(pres.id) AS "Pocet receptu" 
FROM prescription pres 
JOIN patient pat ON pres.patient_id = pat.id 
GROUP BY pat.id
ORDER BY pat.name, pat.surname DESC;


-- Vypiš počty léků, které byly předepsány pacientům a prodávají se v balíčcích (ne v mililitrech). 
-- Prodané léky chceme seskupit podle jejich identifikátoru a také pojišťovny, do které pacient spadá. 
-- Na výstupu budou tedy tři sloupce – pojišťovna, lék a počet prodaných balíčků.
SELECT 
	p.insurance_company AS "pojišťovna", 
	m.name AS "lék", 
	SUM(lm.amount) AS "prodaných balíčků"
FROM prescription AS pre
JOIN patient AS p ON pre.patient_id = p.id
JOIN list_of_medicaments AS lm ON pre.id = lm.prescription_id
JOIN medicament AS m ON lm.medicament_id = m.id
WHERE m.unit = 'package'
GROUP BY p.insurance_company, m.id
ORDER BY p.insurance_company;


/* ***************
 * klauzule HAVING
 * ***************
 */

-- Příkladem může být následující dotaz. Uvažujme, že bychom chtěli pro analýzu podrobněji 
-- sledovat pouze léky v určitých jednotkách. Jelikož se obecně může jednotek v databázi 
-- nacházet více, a nás nezajímají okrajové případy, chceme pouze ty, které překračují 
-- určitou peněžní hranici. Použijeme následující dotaz:
SELECT unit AS "sledované typy jednotky"
FROM medicament
GROUP BY unit
HAVING SUM(price_insurance + price_patient) > 50;


-- Můžeme se také databáze zeptat, na identifikátory lékařů, kteří vydali více než 5 receptů:
SELECT d.id AS "identifikátor lékaře", COUNT(pre.id) AS "počet vydaných receptů"
FROM prescription AS pre
INNER JOIN doctor AS d ON pre.doctor_id = d.id
GROUP BY d.id
HAVING COUNT(pre.id) > 5;


/* *****************
 * Praktický příklad
 * *****************
 */

-- Vypiš pouze ty pojišťovny, které mají jednoho a více registrovaných pacientů.
SELECT
	insurance_company 
FROM patient p 
GROUP BY insurance_company
HAVING count(id) >= 1;


-- Vyzkoušej předchozí dotaz obohatit o seřazení výsledků od nejpočetnější pojišťovny po tu nejméně početnou.
SELECT
	insurance_company 
FROM patient p 
GROUP BY insurance_company
HAVING count(id) >= 1
ORDER BY count(id) DESC;


-- Zjisti, zda pacienti, jejichž křestní jméno je Petr nebo Libor měli alespoň jednou vystavený recept. 
-- Pokud ano, vypiš jejich jméno, příjmení a počet receptů.
SELECT 
	name,
	surname,
	count(pres.id) AS pocet_receptu
FROM prescription AS pres 
JOIN  patient AS p ON p.id = pres.patient_id 
WHERE name = 'Petr' OR name = 'Libor'
GROUP BY name, surname
HAVING count(pres.id)  >= 1;























