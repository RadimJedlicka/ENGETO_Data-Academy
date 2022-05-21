-- zobrazeni aktualnich databazi
SHOW DATABASES;


-- vytvoreni nove databaze s nazvem ENGETO
CREATE DATABASE engeto;

SHOW DATABASES;


-- zacatek prace s novou databazi
USE engeto;


-- zobrazeni tabulek v databazi
SHOW TABLES;

-- vytvoreni tabulky se sloupci
CREATE TABLE customers (
id INT NOT NULL AUTO_INCREMENT,
firstName VARCHAR(255),
lastName VARCHAR(255),
email VARCHAR(255),
address VARCHAR(255),
city VARCHAR(255),
state VARCHAR(255),
PRIMARY KEY(id)
);


-- ukaz strukturu tabulky customers
DESCRIBE customers;


-- vytvoreni tabulky products
CREATE TABLE products (
id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(255),
price INT,
PRIMARY KEY(id)
);


-- vypsani tabulek
SHOW TABLES;


-- upraveni stavajici tabulky a pridani sloupce
ALTER TABLE customers
 ADD COLUMN testcol VARCHAR(255);
 
 
-- ukaz upravenou tabulku (novy sloupec)
DESCRIBE customers; 


-- pridani dalsiho sloupce do tabulky customers
ALTER TABLE customers 
 ADD COLUMN age INT;

DESCRIBE customers;


-- smazani sloupce testcol z tabulky customers
ALTER TABLE customers DROP COLUMN testcol;

DESCRIBE customers;


-- vytvoreni nove tabulky, abychom ji hned smazali :-)
CREATE TABLE testtable (
id INT,
name VARCHAR(255)
);

SHOW tables


-- smazani nove tabulky

DROP TABLE testtable;

SHOW tables;

-- vytvoreni a smazani databaze
CREATE DATABASE testdb;

SHOW DATABASES;


-- a konecne smazani te databaze
DROP DATABASE testdb;

SHOW DATABASES;



-- CVICENI na konci lekce:

-- vytvoreni databaze reviews:
CREATE DATABASE reviews;

-- presuneme se do teto tabulky:
USE reviews;

-- vytvorime dva tabulky:
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

-- pridani pole place do tabulek:
ALTER TABLE courses
 ADD COLUMN place VARCHAR(255);

DESCRIBE courses; 


-- pro smazani sloupcu a databayi jsou tyto prikazy:
-- ALTER TABLE courses
-- DROP COLUMN place;
-- 
-- DROP TABLE courses;
-- 
-- DROP DATABASE reviews;














