USE taxpayers;
SHOW TABLES;
SELECT * FROM Taxpayer;
SELECT * FROM Income_Category;
SELECT * FROM Financial_Year;
SELECT * FROM Income_Record;
SET AUTOCOMMIT = 0;
SELECT @@AUTOCOMMIT;
DELETE FROM Income_Record WHERE income_id IN
(1007, 1008, 1009, 1010, 1015, 1016, 1017, 1018, 1019, 1020);
COMMIT;
START TRANSACTION;
UPDATE Income_Record SET amount = 850000 WHERE income_id = 1003;
SELECT * FROM Income_Record WHERE income_id = 1003;
COMMIT;
START TRANSACTION;
UPDATE Income_Record SET amount = 900000 WHERE income_id = 1004;
SELECT * FROM Income_Record WHERE income_id = 1004;
COMMIT;
START TRANSACTION;
UPDATE Income_Record SET amount = 999999 WHERE income_id = 1004;
SELECT * FROM Income_Record WHERE income_id = 1004;
ROLLBACK;
SELECT * FROM Income_Record WHERE income_id = 1004;
START TRANSACTION;
INSERT INTO Income_Record
(income_id, taxpayer_id, income_source, amount, received_date, remarks, category_id, year_id)
VALUES
(1007, 101, 'TCL Test Income', 50000.00,'2026-03-31', 'Test', 5, 6);
SELECT * FROM Income_Record WHERE income_id = 1007;
ROLLBACK;
SELECT * FROM Income_Record WHERE income_id = 1007;
START TRANSACTION;
DELETE FROM Income_Record WHERE income_id = 1006;
SELECT * FROM Income_Record WHERE income_id = 1006;
ROLLBACK;
SELECT * FROM Income_Record WHERE income_id = 1006; START TRANSACTION;
UPDATE Income_Record SET amount = 120000 WHERE income_id = 1004;
INSERT INTO Income_Record
(income_id, taxpayer_id, income_source, amount, received_date, remarks, category_id, year_id)
VALUES
(1007, 101, 'Additional Income', 60000.00,'2026-03-31', 'Combined Test', 5, 6);
SELECT * FROM Income_Record WHERE income_id IN (1004, 1007);
COMMIT;
START TRANSACTION;
UPDATE Income_Record SET amount = 130000 WHERE income_id = 1004;
SAVEPOINT sp1;
UPDATE Income_Record SET amount = 1600000 WHERE income_id = 1006;
SELECT * FROM Income_Record WHERE income_id IN (1004, 1006);
ROLLBACK TO SAVEPOINT sp1;
SELECT * FROM Income_Record WHERE income_id IN (1004, 1006);
COMMIT;
START TRANSACTION;
INSERT INTO Income_Record
(income_id, taxpayer_id, income_source, amount, received_date, remarks, category_id, year_id)
VALUES
(1008, 102, 'Temporary Income', 70000.00,'2026-03-31', 'SP Test', 5, 6);
SAVEPOINT sp2;
UPDATE Income_Record SET amount = 1700000 WHERE income_id = 1006;
ROLLBACK TO SAVEPOINT sp2;
SELECT * FROM Income_Record WHERE income_id IN (1006, 1008);
COMMIT;
START TRANSACTION;
UPDATE Income_Record SET amount = 140000 WHERE income_id = 1004;
SAVEPOINT sp1;
UPDATE Income_Record SET amount = 1600000 WHERE income_id = 1006;
SAVEPOINT sp2;
UPDATE Income_Record SET amount = 800000 WHERE income_id = 1005;
ROLLBACK TO SAVEPOINT sp1;
SELECT * FROM Income_Record WHERE income_id IN (1004, 1005, 1006);
COMMIT;
START TRANSACTION;
INSERT INTO Income_Record
(income_id, taxpayer_id, income_source, amount, received_date, remarks, category_id, year_id)
VALUES
(1009, 103, 'Temporary Business Income', 100000.00,
'2026-03-31', 'Combined Test', 2, 6);
UPDATE Income_Record SET amount = 125000 WHERE income_id = 1004;
SAVEPOINT before_delete;
DELETE FROM Income_Record WHERE income_id = 1006;
ROLLBACK TO SAVEPOINT before_delete;
SELECT * FROM Income_Record WHERE income_id IN (1004, 1006, 1009);
COMMIT;
START TRANSACTION;
UPDATE Income_Record SET amount = 130000 WHERE income_id = 1004;
SAVEPOINT sp_release;
UPDATE Income_Record SET amount = 1550000 WHERE income_id = 1006;
ROLLBACK TO SAVEPOINT sp_release;
SELECT * FROM Income_Record WHERE income_id IN (1004, 1006);
COMMIT;
START TRANSACTION;
UPDATE Income_Record SET amount = 140000 WHERE income_id = 1004; 
SAVEPOINT sp_test;
UPDATE Income_Record SET amount = 1600000 WHERE income_id = 1006;
ROLLBACK TO SAVEPOINT sp_test;
SELECT * FROM Income_Record WHERE income_id IN (1004, 1006);
COMMIT;
DROP USER IF EXISTS 'tax_clerk1'@'localhost';
DROP USER IF EXISTS 'tax_data_entry'@'localhost';
DROP USER IF EXISTS 'tax_officer'@'localhost';
CREATE USER 'tax_clerk1'@'localhost'
IDENTIFIED BY 'Tax@123';
SHOW GRANTS FOR 'tax_clerk1'@'localhost';
SELECT CURRENT_USER();
GRANT SELECT ON taxpayers.Taxpayer TO 'tax_clerk1'@'localhost';
SHOW GRANTS FOR 'tax_clerk1'@'localhost';
SELECT *
FROM Taxpayer; 
GRANT INSERT ON taxpayers.Income_Record TO 'tax_clerk1'@'localhost';
SHOW GRANTS FOR 'tax_clerk1'@'localhost';
INSERT INTO Income_Record
(income_id, taxpayer_id, income_source, amount, received_date, remarks, category_id, year_id)
VALUES
(1010, 101, 'DCL Test Income', 50000.00,
'2026-03-31', 'DCL Test', 5, 6);
DROP VIEW IF EXISTS Taxpayer_Income_Summary;
CREATE VIEW Taxpayer_Income_Summary AS
SELECT
    t.taxpayer_id,t.full_name,ic.category_name,fy.year_label,ir.income_source,ir.amount
FROM Taxpayer t
JOIN Income_Record ir ON t.taxpayer_id = ir.taxpayer_id
JOIN Income_Category ic ON ir.category_id = ic.category_id
JOIN Financial_Year fy ON ir.year_id = fy.year_id;
SHOW FULL TABLES WHERE Table_type = 'VIEW';
GRANT SELECT ON taxpayers.Taxpayer_Income_Summary TO 'tax_clerk1'@'localhost';
SHOW GRANTS FOR 'tax_clerk1'@'localhost';
SELECT * FROM Taxpayer_Income_Summary;
CREATE USER 'tax_data_entry'@'localhost' IDENTIFIED BY 'Entry@123';
GRANT SELECT, INSERT ON taxpayers.Income_Record TO 'tax_data_entry'@'localhost';
SHOW GRANTS FOR 'tax_data_entry'@'localhost';
SELECT CURRENT_USER();
SELECT * FROM Income_Record;
INSERT INTO Income_Record
(income_id, taxpayer_id, income_source, amount, received_date, remarks, category_id, year_id)
VALUES
(1015, 101, 'Data Entry Test', 55000.00,
'2026-03-31', 'Entry Test', 5, 6);
CREATE USER 'tax_officer'@'localhost'
IDENTIFIED BY 'Officer@123';
GRANT SELECT, INSERT, UPDATE ON taxpayers.Income_Record TO 'tax_officer'@'localhost';
SHOW GRANTS FOR 'tax_officer'@'localhost';
INSERT INTO Income_Record
(income_id, taxpayer_id, income_source, amount, received_date, remarks, category_id, year_id)
VALUES
(1016, 102, 'Officer Test Income', 65000.00,
'2026-03-31', 'Officer Insert Test', 5, 6);
UPDATE Income_Record SET amount = 70000.00 WHERE income_id = 1016;
GRANT SELECT ON taxpayers.Taxpayer_Income_Summary TO 'tax_officer'@'localhost';
SHOW GRANTS FOR 'tax_officer'@'localhost';
SELECT * FROM Taxpayer_Income_Summary;
GRANT SELECT, INSERT, UPDATE ON girija.Income_Record TO 'tax_officer'@'localhost';
SHOW GRANTS FOR 'tax_officer'@'localhost';
REVOKE UPDATE ON taxpayers.Income_Record FROM 'tax_officer'@'localhost';
SHOW GRANTS FOR 'tax_officer'@'localhost';
SELECT * FROM Income_Record;
INSERT INTO Income_Record
(income_id, taxpayer_id, income_source, amount, received_date, remarks, category_id, year_id)
VALUES
(1017, 103, 'Task 4 Test', 45000.00,'2026-03-31', 'Task 4 Insert', 5, 6);
GRANT SELECT ON taxpayers.Taxpayer_Income_Summary TO 'tax_data_entry'@'localhost';
SHOW GRANTS FOR 'tax_data_entry'@'localhost';
SHOW GRANTS FOR 'tax_officer'@'localhost';
SELECT * FROM Taxpayer_Income_Summary;
SELECT * FROM Taxpayer;
SELECT * FROM Income_Record;
INSERT INTO Income_Record
(income_id, taxpayer_id, income_source, amount, received_date, remarks, category_id, year_id)
VALUES
(1018, 104, 'Final Task Test', 40000.00,'2026-03-31', NULL, 5, 6);
GRANT UPDATE ON taxpayers.Income_Record TO 'tax_data_entry'@'localhost';
UPDATE Income_Record SET amount = 45000 WHERE income_id = 1018;
REVOKE UPDATE ON taxpayers.Income_Record FROM 'tax_data_entry'@'localhost';
SHOW GRANTS FOR 'tax_data_entry'@'localhost';
START TRANSACTION;
INSERT INTO Income_Record
(income_id, taxpayer_id, income_source, amount, received_date, remarks, category_id, year_id)
VALUES
(1019, 101, 'Annual Income Submission', 95000.00,'2026-03-31', NULL, 5, 6);
SELECT * FROM Income_Record WHERE income_id = 1019;
COMMIT;
SELECT * FROM Income_Record WHERE income_id = 1019;
SELECT income_id, amount FROM Income_Record WHERE income_id = 1001;
START TRANSACTION;
UPDATE Income_Record SET amount = 999999.00 WHERE income_id = 1001;
SELECT income_id, amount FROM Income_Record WHERE income_id = 1001;
ROLLBACK;
SELECT income_id, amount FROM Income_Record WHERE income_id = 1001;
START TRANSACTION;
UPDATE Income_Record
SET amount = 860000.00 WHERE income_id = 1001;
SAVEPOINT valid_change;
UPDATE Income_Record SET amount = 999999.00 WHERE income_id = 1002;
SELECT income_id, amount FROM Income_Record WHERE income_id IN (1001, 1002);
ROLLBACK TO SAVEPOINT valid_change;
SELECT income_id, amount FROM Income_Record WHERE income_id IN (1001, 1002);
COMMIT;
GRANT SELECT, INSERT ON girija.Income_Record TO 'tax_data_entry'@'localhost';
SHOW GRANTS FOR 'tax_data_entry'@'localhost';
INSERT INTO Income_Record
(income_id, taxpayer_id, income_source, amount, received_date, remarks, category_id, year_id)
VALUES
(1020, 105, 'Part F Entry Test', 50000.00,
'2026-03-31', NULL, 5, 6);
GRANT UPDATE ON taxpayers.Income_Record
TO 'tax_data_entry'@'localhost';
UPDATE Income_Record SET amount = 55000 WHERE income_id = 1020;
REVOKE UPDATE ON taxpayers.Income_Record FROM 'tax_data_entry'@'localhost';
SHOW GRANTS FOR 'tax_data_entry'@'localhost';
