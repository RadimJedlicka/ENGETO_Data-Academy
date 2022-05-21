/*
 * vytvoreni nove tabulky `employees` v databazi engeto
 * 
 */

CREATE TABLE employees (
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(127),
	POSITION VARCHAR(127),
	dept VARCHAR(127),
	salary INT,
	PRIMARY KEY(id)
);


/*
 * naplneni tabulky datama
 *
 */

INSERT INTO employees (name, position, dept, salary) VALUES
("Elon Musk", "CEO", "Executive", 1),
("Mike Panza", "CEO", "Engineering", 80000),
("Michaela von Rossum", "CEO", "HR", 30000),
("Janette Random", "CEO", "HR", 32000),
("Jürgen Münche", "CEO", "Engineering", 60000),
("Mark Suttlework", "CEO", "Engineering", 70000),
("Vojta Rock", "CEO", "Engineering", 75000);

SELECT * FROM employees e 


/*
 * GROUP BY *********
 * seskupovani hodnot
 * 
 */

SELECT 
	dept,
	MAX(salary) 
 FROM employees e
GROUP BY dept;


/*
 * 
 * AGREGACNI FUNKCE *****************
 * 
 */

/*
 * COUNT ****************************
 * zjištění počtu záznamů v rámci jedné skupiny řádků
 * 
 */

SELECT 
	count(*) AS 'Pocet lidi v Engineering department'
  FROM employees
 WHERE dept = 'Engineering';


SELECT 
	count(*) AS 'Pocet lidi',
	dept AS 'Oddeleni'
  FROM employees
 GROUP BY dept;


/*
 * AVG prumerna hodnota ******
 * 
 */

SELECT 
	avg(salary) AS 'Prumerny plat'
  FROM employees;
 
 
 SELECT 
 	dept AS 'Oddeleni',
	avg(salary) AS 'Prumerny plat'
  FROM employees
 GROUP BY dept;


/*
 * MIN a MAX -> minimum a maximum ***
 * 
 */

SELECT 
	min(salary) AS 'Minimalni plat'
  FROM employees;
 
 
 SELECT
 	dept AS 'oddeleni',
	min(salary) AS 'Minimalni plat'
  FROM employees
 GROUP BY dept;


SELECT 
	max(salary) AS 'nejvyssi plat'
  FROM employees;
 
 
 SELECT
 	dept AS 'oddeleni',
	max(salary) AS 'Nejvyssi plat'
  FROM employees
 GROUP BY dept;


/*
 * SUM() -> soucet hodnot ***
 * 
 */

SELECT sum(salary) FROM employees;

SELECT 
	dept AS 'Oddeleni',
	sum(salary) AS 'celkove naklady na platy'
 FROM employees
GROUP BY dept; 



















-- Praktické cvičení --
-- jdeme zase do databaze review --

SELECT * FROM courses;

SELECT * FROM students s;


-- Vyberte nejvyšší počet kreditů:

SELECT max(credits) FROM students;


-- Vyberte nejvyšší počet kreditů 
-- podle odvětví/fakulty:

SELECT 
	field,
	max(credits) 
 FROM students
GROUP BY field;


-- Kolik má student průměrně kreditů?
SELECT avg(credits) FROM students; 


-- Kolik má student průměrně kreditů 
-- na každém oddělení/fakultě?
SELECT 
	field,	
	avg(credits) 
 FROM students
GROUP BY field;


-- Jaká je nejmenší kapacita kurzu?
SELECT 
	coursename,
	min(capacity)
 FROM courses;


-- Jaké je jméno kurzu s nejmenší kapacitou?
SELECT 
	coursename
 FROM courses
WHERE capacity = 80;


-- Kolik kreditů získali všichni studenti?
SELECT sum(credits) FROM students;


-- Kolik kreditů získali studenti podle fakulty?
SELECT
	field,
	sum(credits) AS 'celkem kreditu'
 FROM students
GROUP BY field;










