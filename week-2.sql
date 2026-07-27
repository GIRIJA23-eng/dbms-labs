/*CREATE DATABASE girija;*/
USE girija;
CREATE TABLE taxpayer(
taxpayer_id INT PRIMARY KEY,pan_number VARCHAR(10) NOT NULL UNIQUE,
full_name VARCHAR(50) NOT NULL,date_of_birth DATE NOT NULL,
occupation VARCHAR(50) NOT NULL,annual_income DECIMAL(12,2) NOT NULL,
email VARCHAR(100) UNIQUE, is_active BOOLEAN);
INSERT IGNORE INTO taxpayer
(taxpayer_id, pan_number, full_name, date_of_birth, occupation, annual_income, email, is_active)
VALUES
(101, 'ABCDE1234F', 'Ravi Kumar', '1995-06-15', 'Software Engineer', 850000.00, 'ravi.kumar@example.com', TRUE),
(102, 'BCDEF2345G', 'Priya Sharma', '1992-11-22', 'Doctor', 1200000.00, 'priya.sharma@example.com', TRUE),
(103, 'CDEFG3456H', 'Arjun Reddy', '1988-03-10', 'Business Owner', 1800000.00, 'arjun.reddy@example.com', TRUE),
(104, 'DEFGH4567J', 'Sneha Patel', '1998-08-05', 'Teacher', 620000.00, 'sneha.patel@example.com', TRUE),
(105, 'EFGHJ5678K', 'Kiran Rao', '1990-01-18', 'Chartered Accountant', 950000.00, 'kiran.rao@example.com', TRUE),
(106, 'FGHJK6789L', 'Meera Singh', '1985-12-30', 'Lawyer', 1450000.00, 'meera.singh@example.com', TRUE);
SELECT * FROM taxpayer;

CREATE TABLE income_category(
category_id INT PRIMARY KEY,
category_name VARCHAR(50) NOT NULL UNIQUE,
description VARCHAR(200) NOT NULL,
taxable BOOLEAN NOT NULL);
INSERT IGNORE INTO income_category
(category_id, category_name, description, taxable)
VALUES
(1, 'Salary', 'Income received from employment', TRUE),
(2, 'Business', 'Income earned from business activities', TRUE),
(3, 'House Property', 'Income received from property or rent', TRUE),
(4, 'Capital Gains', 'Income from transfer of eligible assets', TRUE),
(5, 'Other Sources', 'Income such as bank interest', TRUE),
(6, 'Agricultural Income', 'Income from eligible agricultural activities', FALSE);
SELECT * FROM income_category;

CREATE TABLE financial_year(
year_id INT PRIMARY KEY,
year_label VARCHAR(9) NOT NULL UNIQUE,
start_date DATE NOT NULL,
end_date DATE NOT NULL,
filling_deadline DATE,
is_current BOOLEAN NOT NULL);
INSERT IGNORE INTO Financial_Year
(year_id, year_label, start_date, end_date, filling_deadline, is_current)
VALUES
(1, '2020-2021', '2020-04-01', '2021-03-31', '2021-07-31', FALSE),
(2, '2021-2022', '2021-04-01', '2022-03-31', '2022-07-31', FALSE),
(3, '2022-2023', '2022-04-01', '2023-03-31', '2023-07-31', FALSE),
(4, '2023-2024', '2023-04-01', '2024-03-31', '2024-07-31', FALSE),
(5, '2024-2025', '2024-04-01', '2025-03-31', '2025-07-31', FALSE),
(6, '2025-2026', '2025-04-01', '2026-03-31', '2026-07-31', TRUE);
SELECT * FROM financial_year;

CREATE TABLE Income_Record (
    income_id INT PRIMARY KEY,
    taxpayer_id INT NOT NULL,
    income_source VARCHAR(100) NOT NULL,
    category_name VARCHAR(50) NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    
    received_date DATE NOT NULL,
    financial_year VARCHAR(9) NOT NULL
);
INSERT IGNORE INTO Income_Record (income_id,taxpayer_id,income_source,category_name,amount,received_date,financial_year
)
VALUES
(1001, 101, 'TechNova Solutions', 'Salary', 850000.00, '2026-03-31', '2025-2026'),
(1002, 102, 'City Care Hospital', 'Salary', 1200000.00, '2026-03-31', '2025-2026'),
(1003, 103, 'Reddy Enterprises', 'Business', 1800000.00, '2026-03-31', '2025-2026'),
(1004, 104, 'Sunrise School', 'Salary', 620000.00, '2026-03-31', '2025-2026'),
(1005, 105, 'Web Design Projects', 'Business', 750000.00, '2026-03-31', '2025-2026'),
(1006, 106, 'Professional Consulting', 'Business', 1500000.00, '2026-03-31', '2025-2026');
SELECT * FROM Income_Record;

INSERT INTO taxpayer
(taxpayer_id,pan_number,full_name,date_of_birth,occupation,annual_income,email,is_active
)
VALUES(
107,'GHJKL7890M','Amit Sharma','1996-04-12','Engineer',700000.00,'amit.sharma@example.com',TRUE
);

SET SQL_SAFE_UPDATES = 0;
UPDATE taxpayer
SET annual_income = 950000.00
WHERE full_name = 'Ravi Kumar';
SELECT * FROM taxpayer
WHERE full_name = 'Ravi Kumar';

UPDATE taxpayer
SET occupation='sofyware consultant'
WHERE full_name='Kiran Rao';
SELECT * FROM taxpayer
WHERE full_name='Kiran Rao';
UPDATE taxpayer
SET is_active = TRUE
WHERE full_name='Meera Singh';
SELECT * FROM taxpayer
WHERE full_name='Meera Singh';
DELETE FROM taxpayer
WHERE taxpayer_id=107;

INSERT INTO income_category
(category_id,category_name,description,taxable)
VALUES(7,'Rental Income','Income earned from renting residential or commercial properties',TRUE);
ALTER TABLE taxpayer
ADD phone_number VARCHAR(15);
ALTER TABLE Income_Record
ADD remarks VARCHAR(255);
ALTER TABLE taxpayer
MODIFY occupation VARCHAR(100) NOT NULL;
DESC taxpayer;
CREATE TABLE Tax_Office (office_id INT PRIMARY KEY,
office_name VARCHAR(100) NOT NULL,city VARCHAR(100) NOT NULL);
INSERT IGNORE INTO Tax_Office (office_id, office_name, city)
VALUES
(1, 'Hyderabad Tax Office', 'Hyderabad'),
(2, 'Vijayawada Tax Office', 'Vijayawada');
SELECT * FROM Tax_Office;
TRUNCATE TABLE Tax_Office;
DROP TABLE Tax_Office;
SHOW TABLES;
ALTER TABLE Income_Record
DROP COLUMN category_name;
ALTER TABLE Income_Record
DROP COLUMN financial_year;
ALTER TABLE Income_Record
ADD category_id INT,
ADD year_id INT;
UPDATE Income_Record
SET category_id = 1,year_id=6
WHERE income_id=1001;
UPDATE Income_Record
SET category_id = 1,year_id=6
WHERE income_id=1002;
UPDATE Income_Record
SET category_id = 2,year_id=6
WHERE income_id=1003;
UPDATE Income_Record
SET category_id = 1,year_id=6
WHERE income_id=1004;
UPDATE Income_Record
SET category_id = 2,year_id=6
WHERE income_id=1005;
UPDATE Income_Record
SET category_id = 2,year_id=6
WHERE income_id=1006;
ALTER TABLE Income_Record
ADD CONSTRAINT fk_taxpayer
FOREIGN KEY (taxpayer_id)
REFERENCES taxpayer(taxpayer_id);
ALTER TABLE Income_Record
ADD CONSTRAINT fk_category
FOREIGN KEY (category_id)
REFERENCES income_category(category_id);
ALTER TABLE Income_Record
ADD CONSTRAINT fk_year
FOREIGN KEY (year_id)
REFERENCES financial_year(year_id);
/*PART-B*/
INSERT INTO Income_Record
(income_id,taxpayer_id,income_source,amount,received_data,remarks,category_id,year_id)
VALUES
(1007,999,'ABC COMPANY',5000000.00,'2026-03-31','TEST RECORD',1,6);
INSERT INTO Income_Record
(income_id,taxpayer_id,income_source,amount,received_data,remarks,category_id,year_id)
VALUES
(1008,101,'ABC COMPANY',6000000.00,'2026-03-31','TEST RECORD',20,6);
INSERT INTO Income_Record
(income_id,taxpayer_id,income_source,amount,received_data,remarks,category_id,year_id)
VALUES
(1009,101,'ABC COMPANY',6000000.00,'2026-03-31','TEST RECORD',20,15);
/*PART-C*/
SELECT DISTINCT occupation 
FROM taxpayer;
SELECT DISTINCT category_name
FROM income_category;
SELECT DISTINCT year_label
FROM financial_year;
SELECT DISTINCT income_source
FROM Income_Record;
SELECT taxpayer_id
FROM Income_Record
WHERE category_id=1
UNION
SELECT taxpayer_id
FROM Income_Record
WHERE category_id=2;
/*PART-4
UNION TEACHER ,SOFTWARE ENGINEER*/
SELECT full_name 
FROM taxpayer
WHERE occupation='Teacher'
UNION
SELECT full_name
FROM taxpayer
WHERE occupation='Software Engineer';
/* part e wont work
1. in income category both have same do no output
2. we have only year_id 6 so it is also wont work*/
SELECT taxpayer_id
FROM Income_Record
WHERE category_id = 1
AND taxpayer_id IN
(
    SELECT taxpayer_id
    FROM Income_Record
    WHERE category_id = 2
);
/* part f 
it wont support exceot so we use NOT IN */
SELECT full_name
FROM taxpayer
WHERE taxpayer_id IN 
(
SELECT taxpayer_id
FROM Income_Record
WHERE category_id=1
AND taxpayer_id NOT IN 
(
SELECT taxpayer_id
FROM Income_Record
WHERE category_id=2
)
);
/*part_g*/
SELECT full_name
FROM taxpayer
WHERE taxpayer_id IN 
(
SELECT taxpayer_id
FROM Income_Record
);
SELECT full_name
FROM taxpayer
WHERE occupation IN 
(
SELECT occupation
FROM taxpayer
WHERE taxpayer_id IN 
(
SELECT taxpayer_id
FROM Income_Record
WHERE category_id=2
)
);
SELECT full_name
FROM taxpayer
WHERE taxpayer_id NOT IN 
(
SELECT taxpayer_id
FROM Income_Record
);
SELECT DISTINCT occupation
FROM taxpayer
WHERE taxpayer_id NOT IN
(
SELECT taxpayer_id
FROM Income_Record
);
/*part i*/
SELECT full_name
FROM taxpayer t 
WHERE EXISTS
(
SELECT *
FROM Income_Record i 
WHERE t.taxpayer_id=i.taxpayer_id
);
SELECT year_label
FROM financial_year f
WHERE EXISTS
(
SELECT *
FROM Income_Record i
WHERE f.year_id =i.year_id
);
SELECT full_name
FROM taxpayer t
WHERE NOT EXISTS
(
SELECT *
FROM Income_Record i
WHERE t.taxpayer_id = i.taxpayer_id
);
SELECT category_name
FROM income_category c
WHERE NOT EXISTS
(
SELECT *
FROM Income_Record i
WHERE c.category_id = i.category_id
);
SELECT full_name, annual_income
FROM taxpayer
WHERE annual_income > ANY
(
SELECT annual_income
FROM taxpayer
WHERE occupation = 'Teacher'
);
SELECT full_name, annual_income
FROM taxpayer
WHERE annual_income > ANY
(
SELECT annual_income
FROM taxpayer
WHERE taxpayer_id IN
(
SELECT taxpayer_id
FROM Income_Record
WHERE category_id = 2
)
);
SELECT *
FROM taxpayer
ORDER BY full_name ASC;
SELECT *
FROM taxpayer
WHERE annual_income > 800000;
SELECT *
FROM Income_Record
WHERE category_id = 2;
SELECT *
FROM Income_Record
WHERE amount BETWEEN 500000 AND 1000000;
SELECT *
FROM taxpayer
WHERE full_name LIKE 'A%';
SELECT *
FROM taxpayer
WHERE is_active = TRUE;
SELECT COUNT(*) AS total_taxpayers
FROM taxpayer;
SELECT MAX(annual_income) AS highest_income
FROM taxpayer;
SELECT full_name, annual_income
FROM taxpayer
WHERE annual_income =
(
SELECT MAX(annual_income)
FROM taxpayer
);
/*SELECT category_id, COUNT(*) AS total_records
FROM Income_Record
GROUP BY category_id
ORDER BY total_records DESC
LIMIT 1;*/
SELECT occupation, COUNT(*) AS total_taxpayers
FROM taxpayer
GROUP BY occupation;
SELECT COUNT(*) AS active_taxpayers
FROM taxpayer
WHERE is_active = TRUE;
SELECT year_id, COUNT(*) AS total_records
FROM Income_Record
GROUP BY year_id
ORDER BY total_records DESC
LIMIT 1;











