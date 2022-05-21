USE engeto;

SHOW tables;

DESCRIBE customers;

ALTER TABLE customers ADD COLUMN age INT; 


/*
 * pridani noveho zaznamu do tabulky customers
 */

ALTER TABLE customers ADD COLUMN age INT;

DESCRIBE customers 

INSERT INTO customers (
firstName,
lastName,
email,
address,
city,
state,
age
)
VALUES (
'John',
'Smith',
'john@engeto.com',
'Cyrilska 7',
'Brno',
'Czech Republic',
 25
);


/* zkraceny zapis, ale musime dodrzovat poradi
 * 
 */

INSERT INTO customers (
1, 'John', 'Smith', 'john@engeto.com', 'Cyrilska 7', 'Brno', 'Czech Republic'
);


/* vlozeni radku s nekterymi nulovymi hodnotami
 * 
 */

INSERT INTO customers (
firstName, 
lastName, 
email
)
VALUES (
'John', 
'Doe', 
'jdoe@gmail.com'
);


/* seskupeni vkladani vice radku najednou
 * 
 */

INSERT INTO customers (firstName, lastName, email, address, city, state) VALUES
('Mike', 'Smith', 'msmith@gmail.com', '22 Birch lane', 'Amesbury', 'Massachusetts'),
('Kathy', 'Morris', 'kmorris@gmail.com', '40 Williow st', 'Haverhill', 'Massachusetts'),
('Steven', 'Samson', 'ssamson@gmail.com', '12 Gills Rd', 'Exeter', 'New Hampshire'),
('Lilian', 'Davidson', 'liliand@gmail.com', '7 Whittier st', 'Brooklyn', 'New York'),
('Derek', 'Williams', 'dwill@gmail.com', '445 Madison ct', 'Yonkers', 'New York');


/* SELECT = vyber dat
 * 
 */
SELECT
	*
 FROM customers c;


/* vyber pouze jmeno a prijmeni z tabulky
 * 
 */

SELECT 
	firstName,
	lastName
 FROM customers;


/*
 * vyber data. ktera vyhuvuji pouze urcite podmince:
 * napr.: vyber pouze zakazniky z Haverhill ->
 */

SELECT 
	*
 FROM customers
WHERE city = 'Haverhill';


/*
 * napr.: vyber vsechny zakazniky, kteri se jmenuji 'John' ->
 * 
 */

SELECT 
	*
 FROM customers c 
WHERE firstName = 'John';


/*
 * vice podminek najednou ->
 * 
 */

SELECT 
	*
 FROM customers c 
WHERE 1=1
  AND city = 'Brno' 
  AND firstName = 'John'; 
 
 
/*
 * OR podminka
 * 
 */
 
SELECT 
 	*
 FROM customers c 
WHERE firstName = 'John'
   OR city = 'Brooklyn';
  
  
/*
 * ORDER BY *************
 * serazeni vybranych dat
 */

SELECT 
	id,
	firstName,
	lastName 
 FROM customers c
WHERE state = 'Massachusetts'
ORDER BY lastName ASC;

-- Jak vidíme, ORDER BY se píše po klauzuli WHERE.--


/*
 * LIMIT *******************************
 * omezi nas vyber na urceny pocet radku
 */

SELECT 
	*
	FROM customers c 
	WHERE age < 30
	AND city = 'Brno'
	LIMIT 10;


/*
 * ALIAS *****
 * 
 */

SELECT 
	firstName AS jmeno,
	lastName AS prijmeni
 FROM customers AS zakaznici;


/*
 * ALIAS slozeny ze sloupcu:
 * 
 */

SELECT 
	firstName ,
	concat(address, ', ', city, ', ', state) AS Address 
 FROM customers c; 
 
 
/*
 * vyber pouze unikatnich hodnot
 * 
 */
 
SELECT
	DISTINCT state 
 FROM customers c;
 
 
/*
 * UPDATE ****************************************
 * upraveni radku v tabulce a pridani nove hodnoty
 * 
 */
 
UPDATE customers 
   SET city = 'Prague'
 WHERE email = 'ondrej@engeto.com';

/*
 * editace vice poli najednou
 * 
 */

UPDATE customers 
   SET city = 'Bratislava', 
       state = 'Slovakia' 
 WHERE city = 'Pressburg';
 
 
/*
 * A nyní doplníme věk našim zákazníkům, které máme aktuálně v databázi:
 * 
 */
 
UPDATE customers SET age = 23 WHERE id = 1;
UPDATE customers SET age = 45 WHERE id = 2;
UPDATE customers SET age = 51 WHERE id = 3;
UPDATE customers SET age = 33 WHERE id = 4;
UPDATE customers SET age = 20 WHERE id = 5;
UPDATE customers SET age = 64 WHERE id = 6;

SELECT 
	*
 FROM customers c 
 
 
/*
 * A nakonec doplnění informací o adrese prvnímu člověku:
 * 
 */
 
UPDATE customers 
   SET address = '55 Main st',
       city = 'Boston',
       state = 'Massachusetts'
 WHERE email = 'jdoe@gmail.com';


/*
 * DELETE ***************
 * mazani zaznamu (radku)
 * nebudeme to spoustet, jen ukazka zapisu ;-)
 * 
 */

DELETE 
  FROM customers 
 WHERE city = 'Bratislava';


/*
 * Praktické úkoly ***************************
 * budeme si hrat s databazi REVIEW **********
 * 
 */

CREATE DATABASE review;

USE review;

CREATE TABLE courses (
id INT NOT NULL AUTO_INCREMENT,
coursename VARCHAR(127),
capacity INT,
PRIMARY KEY(id)
);

CREATE TABLE students (
id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(127),
field VARCHAR(127),
PRIMARY KEY(id)
);

SHOW tables;

ALTER TABLE courses
 ADD COLUMN place VARCHAR(255);

DESCRIBE courses;

-- ------------------------------------------

ALTER TABLE students 
 ADD COLUMN credits INT;

INSERT INTO courses (
			coursename, 
			capacity) 
	VALUES (
			'Computer Security', 
			100);
		
INSERT INTO courses (coursename, capacity) VALUES ('Linux I.', 200),
('Software Engineering', 150),
('Mathematics I.', 250),
('Linux II.', 120),
('Theoretical Informatics', 400),
('Computer Hardware', 180),
('Linux III.', 75),
('Windows Server Administration', 125),
('Mathematics II', 220),
('Python', 250),
('Networks', 210),
('Databases', 180),
('Information Systems', 130);

INSERT INTO students (name, field, credits) VALUES
('Mill Reaman', 'Medicine', 80),
('Curcio MacCaffery','Information Technology', 18),
('Neale McLeese','Mechanical Engineering', 221),
('Lilias Woodberry','Information Technology', 78),
('Novelia Bentley','Medicine', 174),
('Robbie Salisbury','Information Technology', 187),
('Conway Galley','Mechanical Engineering', 64),
('Scarlett Brayson','Information Technology', 132),
('Ailbert Sylvaine','Information Technology', 100),
('Angelita Vidloc','Information Technology', 2),
('Linn Ucchino','Mechanical Engineering', 87),
('Willy Strachan','Medicine', 154),
('Cosette Truter','Information Technology', 200),
('Lelah Athey','Mechanical Engineering', 18),
('Joanna Stroton','Information Technology', 27),
('Bennie Musprat','Information Technology', 48),
('Filip Eckah','Information Technology', 99),
('Klement Bettenay','Information Technology', 52),
('Adolf Burgoyne','Mechanical Engineering', 39),
('Blanca Sissel','Mechanical Engineering', 197),
('Zelma Newiss','Medicine', 128),
('Fedora Aries','Mechanical Engineering', 6),
('Ed Rowsell','Information Technology', 78),
('Umberto Starbuck','Information Technology', 31),
('Mair McGurk','Information Technology', 83);


SELECT 
	*
 FROM `students`;

SELECT 
	*
 FROM `courses`;


/*
 * v table courses doplnime pro vsechny zaznamy place = IT Faculty:
 * 
 */

UPDATE courses 
   SET place = 'IT Faculty'
   
   
 /*
  * Opakovani je matka moudrosti :-)
  * SELECT *************************
  */
   
-- Vyber všechna jména kurzů z courses.
 SELECT 
 	coursename
 	FROM courses c;
 
 
 -- Vyber jméno prvních 5 studentů, 
 -- kteří mají více než 100 kreditů.
 SELECT
 	name
  FROM students s 
 WHERE credits > 100
 LIMIT 5;


-- Vyber jméno a kapacitu kurzů, 
-- které mají kapacitu mezi 100 a 200 studenty.
SELECT 
	coursename, 
	capacity 
 FROM courses c
WHERE capacity BETWEEN 100 AND 200;


-- Vyber názvy studijních oborů z tabulky students.
SELECT
	DISTINCT field
 FROM students s;


-- Vyber všechna data o studentech, 
-- kteří jsou z Mechanical Engineering 
-- a mají méně než 100 kreditů
SELECT 
	*
 FROM students s
WHERE field = 'Mechanical Engineering'
  AND credits < 100;
 
 
-- Vyber všechna data o studentech 
-- seřazená podle počtu kreditů 
-- od největšího po nejmenší
SELECT 
	*
 FROM students s 
ORDER BY credits DESC;


-- Vyber jméno kurzu jako „Jméno kurzu“, 
-- kapacitu jako „Kapacita“ z tabulky courses, 
-- které mají kapacitu menší než 250
SELECT
	coursename AS 'Jmeno kurzu',
	capacity AS 'Kapacita'
FROM courses c 
WHERE capacity < 250;


-- Upravme kapacitu lidí na kurzu 
-- „Theoretical Informatics“ na 320 lidí.
UPDATE courses
   SET capacity = 320
 WHERE coursename = 'Theoretical Informatics';


-- Člověk jménem Umberto Starbuck přešel 
-- z IT na medicínu — změňme mu obor 
-- na „Medicine“.

UPDATE students
   SET field = 'Medicine'
 WHERE name = 'Umberto Starbuck';


-- Pro velký zájem byla kapacita 
-- kurzu Python zvětšena na 280.
UPDATE courses 
   SET capacity = 280
 WHERE coursename = 'Python';


-- Kurz Linux III. se tento rok otevírat 
-- nebude — vymažme ho z databáze.
DELETE FROM courses 
      WHERE coursename = 'Linux III.';
     
SELECT * FROM courses

-- Místo něj se bude vyučovat tento rok 
-- kurz „Functional programming“ 
-- s kapacitou 80 studentů.
INSERT INTO courses (coursename, capacity)
     VALUES('Functional programming', 80);
    

-- Přidejme člověka jménem „Morty Sanchez“ 
-- do tabulky students, studuje „Mechanical 
-- Engineering“ a má 25 kreditů.
INSERT INTO students
			  (name,             field,                    credits)
		VALUES('Morty Sanchez', 'Mechanical Enginneering', 25);

SELECT * FROM students s 

-- Student Neale McLeese úspěšně ukončil studium — 
-- vymažme ho z tabulky students.
  
DELETE FROM students
WHERE name = 'Neale McLeese';


  
  
  







