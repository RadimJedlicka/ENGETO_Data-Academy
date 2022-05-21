-- Pojďme si nyní vytvořit tabulky v databázi engeto, se kterými budeme pracovat. 
-- Nejdříve vytvoříme tabulku products, abychom ji mohli následně referencovat v tabulce orders.
CREATE TABLE products (
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(255),
	price INT NOT NULL,
	PRIMARY KEY(id)
);

-- Nyní vytvoříme tabulku orders:

CREATE TABLE orders (
	id INT NOT NULL AUTO_INCREMENT,
	customer_id INT NOT NULL,
	product_id INT NOT NULL,
	status VARCHAR(255),
	order_date TIMESTAMP default CURRENT_TIMESTAMP,
	PRIMARY KEY(id)
);

INSERT INTO customers (firstName, lastName, email, address, city, state, age) VALUES
('Mike', 'Smith', 'msmith@gmail.com', '22 Birch lane', 'Amesbury', 'Massachusetts', 23),
('Kathy', 'Morris', 'kmorris@gmail.com', '40 Williow st', 'Haverhill', 'Massachusetts', 45),
('Steven', 'Samson', 'ssamson@gmail.com', '12 Gills Rd', 'Exeter', 'New Hampshire', 33),
('Lilian', 'Davidson', 'liliand@gmail.com', '7 Whittier st', 'Brooklyn', 'New York', 20),
('Derek', 'Williams', 'dwill@gmail.com', '445 Madison ct', 'Yonkers', 'New York', 64);

INSERT INTO products(name, price) VALUES 
('Product One', 10),
('Product Two', 5),
('Product Three', 65),
('Product Four', 45),
('Product Five', 100);

INSERT INTO orders(product_id, customer_id, status) VALUES 
(1, 4, 'Created'),
(3, 1, 'Paid'),
(1, 1, 'Canceled'),
(1, 2, 'Paid'),
(1, 1, 'Completed'),
(4, 5, 'Created'),
(4, 4, 'Created'),
(2, 5, 'Paid');

INSERT INTO orders (product_id, customer_id, status, order_date) VALUES
(2, 5, 'Created', CURRENT_TIMESTAMP), 
(1, 5, 'Created', CURRENT_TIMESTAMP);


-- Pojďme si udělat dotaz přes dvě tabulky — customers a orders. 
-- Získáme tím výpis objednávek pro každého uživatele:
SELECT c.firstName, c.lastName, o.product_id, o.status
	FROM customers AS c
	JOIN orders AS o 
		ON c.id = o.customer_id
ORDER BY c.id;


-- Nyní spojme products a orders:
SELECT p.name, o.customer_id, o.status
	FROM products AS p
	JOIN orders AS o 
		ON p.id = o.product_id
ORDER BY p.id;


-- Nakonec spojme všechny tabulky do jedné. Tím získáme všechna data v jediném dotazu:
SELECT c.firstName, c.lastName, p.name, o.status
	FROM orders AS o
		JOIN products AS p ON p.id = product_id
		JOIN customers AS c ON c.id = customer_id;
	

INSERT INTO orders(product_id, customer_id, status) VALUES (5, 105, 'Invalid');


SELECT o.product_id, o.customer_id, o.status, c.firstName, c.lastName
	FROM orders AS o
	INNER JOIN customers AS c 
		ON o.customer_id = c.id;


SELECT o.product_id, o.customer_id, o.status, c.firstName, c.lastName
FROM orders AS o
LEFT JOIN customers AS c ON o.customer_id = c.id;


SELECT o.product_id, o.customer_id, o.status, c.firstName, c.lastName
FROM orders AS o
RIGHT JOIN customers AS c ON o.customer_id = c.id;


/*
 * 
 * 
 * 
 */

USE world;

SHOW tables;

DESCRIBE city;

DESCRIBE country;

DESCRIBE countrylanguage;


-- Vyberme pět zemí s nejvíce obyvateli a vypíšeme jejich jména a počty obyvatel.
SELECT 
	Name,
	Population 
 FROM country c
ORDER BY Population DESC 
LIMIT 5;


-- Vyberme počet států s jejich vládní formou (GovernmentForm), 
-- které mají očekávanou délku života vyšší než 76 let.
SELECT 
	GovernmentForm AS 'Vladni forma', 
	COUNT(GovernmentForm) AS Počet,
	AVG(LifeExpectancy) AS "Průměrná délka života"
 FROM country
WHERE LifeExpectancy > 78
GROUP BY GovernmentForm;


-- Zjistíme jméno státu a kraj (District), ve kterém se nachází město 'Serravalle' (tabulky city a country).
SELECT co.Name AS Stát, c.District AS Kraj
 FROM city AS c
 JOIN country AS co ON c.CountryCode = co.Code
WHERE c.Name = 'Serravalle';


-- Dalším úkolem bude vypsat města ve státech začínajících na písmeno „Z“.
SELECT 
	country.name AS Stát, 
	city.Name AS Město
 FROM city
 JOIN country ON city.CountryCode = country.Code
WHERE country.Name LIKE 'Z%';


-- Dále zobrazíme všechny jazyky, kterými se mluví v Africe.
SELECT 
	DISTINCT `Language` 
 FROM country 
 JOIN countrylanguage ON country.Code = countrylanguage.CountryCode 
WHERE continent = 'Africa';


-- Dokážeme zjistit, přibližně kolik lidí mluví španělsky v USA?
SELECT Name AS Stát,
Population * (
  SELECT Percentage FROM countrylanguage WHERE CountryCode = 'USA' AND Language = 'Spanish') / 100
  AS "Populace se španělštinou"
FROM country
WHERE Code = 'USA';
























