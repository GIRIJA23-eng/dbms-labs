USE taxpayers;
SHOW tables;
SELECT * FROM taxpayer;
SELECT * FROM income_category;
SELECT * FROM financial_year;
SELECT * FROM Income_Record;
/* part-b level-1*/
SELECT UPPER(full_name)
FROM taxpayer;
SELECT LOWER(occupation)
FROM taxpayer;
SELECT full_name,LENGTH(full_name)
FROM taxpayer;
SELECT SUBSTRING(pan_number,1,4)
FROM taxpayer;
SELECT CONCAT(full_name,'-',occupation)
FROM taxpayer;
/* level-2*/
SELECT REPLACE(category_name,'Income','Inc.')
FROM income_category;
SELECT TRIM(full_name)
FROM taxpayer;
SELECT SUBSTRING_INDEX(full_name,' ',1)
FROM taxpayer;
SELECT CONCAT('TAXPAYER : ',full_name,'occupation : ',occupation)
FROM taxpayer;
SELECT *
FROM taxpayer
WHERE pan_number LIKE 'AP%';
SELECT ROUND(annual_income)
FROM taxpayer;
SELECT ABS(annual_income - 500000)
FROM taxpayer;
SELECT POWER(annual_income,2)
FROM taxpayer;
SELECT MOD(annual_income,1000)
FROM taxpayer;
SELECT ROUND(annual_income,2)
FROM taxpayer;
SELECT CEIL(annual_income),FLOOR(annual_income)
FROM taxpayer;
SELECT FLOOR(RAND()*100)+1;
SELECT SQRT(annual_income)
FROM taxpayer;
SELECT annual_income,annual_income*1.10 AS increased_income
FROM taxpayer;
SELECT CURDATE();
SELECT NOW();
SELECT YEAR(start_date)
FROM financial_year;
SELECT MONTH(start_date)
FROM financial_year;
SELECT DAY(start_date)
FROM financial_year;
SELECT DATE_ADD(start_date,INTERVAL 1 year)
FROM financial_year;
SELECT DATE_ADD(start_date,INTERVAL 30 DAY)
FROM financial_year;
SELECT DATE_SUB(start_date, INTERVAL 7 DAY)
FROM financial_year;
SELECT DATEDIFF(CURDATE(),start_date)
FROM financial_year;
SELECT *
FROM financial_year
WHERE YEAR(start_date) = YEAR(CURDATE());
SELECT CAST(annual_income AS SIGNED)
FROM taxpayer;
SELECT CAST(taxpayer_id AS CHAR)
FROM taxpayer;
SELECT CAST(start_date AS DATETIME)
FROM financial_year;
SELECT CAST(annual_income AS DECIMAL(12,2))
FROM taxpayer;
SELECT CAST(annual_income AS CHAR)
FROM taxpayer;
SELECT CAST(annual_income AS DECIMAL(12,2)) * 0.10 AS tax
FROM taxpayer;








