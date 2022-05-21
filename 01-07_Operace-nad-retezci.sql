-- Budeme chtít vypsat seznam zákazníků pro naše manažery. 
-- Tento výpis bude velice jednoduchý: jméno, příjmení 
-- a jejich e-mail v závorce. Každý zákazník bude v samostatné buňce.

SELECT CONCAT( 
	firstName, ' ',
	lastName, 
	' (', email, ')'
) AS 'Zakaznici'
FROM customers;


SELECT group_concat(concat( 
					firstName, ' ',
					lastName, 
					' (', email, ')'
		) SEPARATOR '; ')
		AS 'Vsichni Zakaznici'
FROM customers;


/*
 * Prakticke cviceni ***
 * 
 */


-- Vyzkoušíme, zda neexistuje kurz, který se jmenuje totožně jako místo, na kterém se učí. 
-- Pokud ano, vypíšeme jeho ID.

SELECT * FROM courses;

SELECT 
	id AS "stejně pojmenovaný kurz jako místo" 
FROM courses 
WHERE STRCMP(coursename,place) = 0;


-- Získáme ID a jména studentů, kteří studují obor Information Technology nebo Mechanical Engineering;
SELECT * FROM students s;

SELECT 
	id,
	name
	FROM students s  
	WHERE `field` = 'Information Technology'
	   OR `field` = 'Mechanical Engineering';
	  
-- ekvivalent
	  
SELECT 
	id, 
	name AS "jméno" 
 FROM students 
WHERE `field` IN ('Information Technology', 'Mechanical Engineering');


-- Vybereme kurzy, které začínají na řetězec „Linux“.
SELECT
	coursename 
 FROM courses c 
WHERE coursename LIKE 'Linux%';


-- Kolik studentů má první písmeno „A“ ve svém jménu?
SELECT 
	COUNT(name) AS 'Počet lidí na A'   # nebo *
 FROM students s 
WHERE name LIKE 'A%';


-- Vypíšeme dohromady jméno a obor v závorce u všech studentů, jejichž obor začíná písmeny „Me“.
SELECT CONCAT(
	name, ' (', field, ')'
	) AS 'jmeno a obor'
FROM students s 
WHERE field LIKE 'Me%';


-- Chceme sumu bitových délek všech textových atributů u všech studentů.
SELECT sum(bit_length(CONCAT(name, field))) 
	AS 'Bitova delka'
  FROM students s;













