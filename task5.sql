USE girija;
SHOW TABLES;
SELECT * FROM taxpayer;
SELECT * FROM income_category;
SELECT * FROM financial_year;
SELECT * FROM Income_Record;

INSERT INTO Income_Record
(income_id, taxpayer_id, income_source, amount, received_date, remarks, category_id, year_id)
VALUES
(1007, 101, 'TechNova Solutions', 800000.00, '2025-03-31', 'Annual salary', 1, 5),
(1008, 102, 'City Care Hospital', 1100000.00, '2025-03-31', 'Annual salary', 1, 5),
(1009, 103, 'Reddy Enterprises', 1600000.00, '2025-03-31', 'Business income', 2, 5),
(1010, 104, 'Sunrise School', 600000.00, '2025-03-31', 'Annual salary', 1, 5),
(1011, 105, 'Rao Rental Property', 500000.00, '2025-03-31', 'Rental income', 3, 5),
(1012, 106, 'Rao Rental Property', 700000.00, '2026-03-31', 'Rental income', 3, 6),
(1013, 105, 'Share Investments', 900000.00, '2025-03-31', 'Capital gains', 4, 5),
(1014, 106, 'Share Investments', 1200000.00, '2026-03-31', 'Capital gains', 4, 6);

SELECT year_id, COUNT(*) AS total_records
FROM Income_Record
GROUP BY year_id;

SELECT category_id, COUNT(*) AS total_records
FROM Income_Record
GROUP BY category_id;

/*part b*/
select count(*) as total_income_records
from income_record;
select sum(amount) as total_income
from income_record;
select avg(amount) as average_income
from income_record;
select max(amount) as highest_income
from income_record;
select min(amount) as lowest_income
from income_record;

/*level2*/
select category_id, count(*) as total_records
from income_record
group by category_id;
select category_id, sum(amount) as total_income
from income_record
group by category_id;
select category_id, avg(amount) as average_income
from income_record
group by category_id;
select category_id, max(amount) as highest_income
from income_record
group by category_id;
select category_id, min(amount) as lowest_income
from income_record
group by category_id;
select year_id, sum(amount) as total_income
from income_record
group by year_id;
select year_id, count(*) as total_records
from income_record
group by year_id;

/*level3*/
select category_id, sum(amount) as total_income
from income_record
group by category_id
having sum(amount) > 1000000;
select category_id, avg(amount) as average_income
from income_record
group by category_id
having avg(amount) > 500000;
select year_id, count(*) as total_records
from income_record
group by year_id
having count(*) > 3;
select category_id, sum(amount) as total_income
from income_record
group by category_id
having sum(amount) > 1000000
order by total_income desc;
select category_id,
sum(amount) as total_income,
avg(amount) as average_income
from income_record
group by category_id;
select category_id, year_id, sum(amount) as total_income
from income_record
group by category_id, year_id
order by total_income desc
limit 1;
select i.year_id,
count(distinct t.taxpayer_id) as total_taxpayers
from income_record i
join taxpayer t
on i.taxpayer_id = t.taxpayer_id
group by i.year_id;
select category_id, sum(amount) as total_income
from income_record
group by category_id;
select category_id,
count(distinct taxpayer_id) as total_taxpayers
from income_record
group by category_id;
select category_id, avg(amount) as average_income
from income_record
group by category_id;
select year_id, sum(amount) as total_income
from income_record
group by year_id
order by total_income desc
limit 1;
select category_id, sum(amount) as total_income
from income_record
group by category_id
order by total_income desc
limit 1;
select taxpayer_id, sum(amount) as total_income
from income_record
group by taxpayer_id
having sum(amount) > 1000000;
select taxpayer_id, sum(amount) as total_income
from income_record
group by taxpayer_id
order by total_income desc
limit 1;
select taxpayer_id,
sum(amount) as total_income,
avg(amount) as average_income
from income_record
group by taxpayer_id;
select category_id, sum(amount) as total_income
from income_record
group by category_id
order by total_income desc
limit 1;
select year_id, sum(amount) as total_income
from income_record
group by year_id
order by total_income desc
limit 1;
select category_id, avg(amount) as average_income
from income_record
group by category_id
order by average_income desc
limit 1;
select category_id, count(*) as total_records
from income_record
group by category_id
having count(*) > 2;
select year_id, sum(amount) as total_income
from income_record
group by year_id
having sum(amount) > 1000000;
select category_id,
count(*) as number_of_records,
sum(amount) as total_income,
avg(amount) as average_income,
max(amount) as highest_income,
min(amount) as lowest_income
from income_record
group by category_id;