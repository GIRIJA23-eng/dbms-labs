use girija;
show tables;
select * from income_record
where amount=(
select max(amount) from income_record);
select * from income_record
where amount=(
select min(amount) from income_record);
select * from income_record
where amount >(
select avg(amount) from income_record);
select * from income_record
where amount=(
select max(amount) from income_record);
select * from taxpayer 
where taxpayer_id in (
select taxpayer_id from taxpayer
where occupation='business owner');
/*level2 */
select * from taxpayer
where taxpayer_id in (
select taxpayer_id from income_record);
select * from taxpayer
where taxpayer_id in (
select taxpayer_id from income_record
where category_id=(
select category_id from income_category 
where category_name='business')
);
select * from income_record
where year_id in (
select year_id from financial_year
where year_label='2025-2026');
select * from income_record
where amount > (
select min(amount) from income_record
where category_id=(
select category_id from income_category
where category_name='Business')
);
select * from income_record 
where amount < (
select max(amount) from income_record
where category_id=(
select category_id from income_category
where category_name='salary')
);
select * from taxpayer
where taxpayer_id in (
select taxpayer_id from income_record
where amount > (
select avg(amount) from income_record)
);
select * from income_category
where category_id in (
select category_id from income_record);
select * from taxpayer
where taxpayer_id not in (
select taxpayer_id from income_record
where category_id = 3);
select * from taxpayer 
where taxpayer_id in (
select taxpayer_id from income_record
where amount=(
select max(amount) from income_record)
);
select * from income_record 
where amount > (
select avg(amount) from income_record
where category_id=2);
select * from taxpayer
where annual_income > (
select avg(annual_income) from taxpayer);
select * from income_record
where amount > any (
select amount from income_record
where category_id=3 );
select * from income_record
where amount > all (
select amount from income_record 
where category_id=3);
select * from income_category
where category_id in (
select category_id from income_record
where amount=(
select max(amount) from income_record)
);
select * from financial_year
where year_id=( 
select year_id from income_record 
group by year_id
order by sum(amount) desc
limit 1);
select taxpayer_id,sum(amount) as total_income from income_record
group by taxpayer_id
having sum(amount) > (
select avg(total_income) from (
select sum(amount) as total_income
from income_record
group by taxpayer_id)as taxpayer_totals);
select * from taxpayer
where taxpayer_id in (
select taxpayer_id from income_record
where amount = (
select max(amount) from income_record)
);
select * from taxpayer
where annual_income > (
select avg(annual_income) from taxpayer );
select * from income_category
where category_id = (
select category_id from income_record
where amount = (
select max(amount) from income_record)
);
select * from taxpayer
where taxpayer_id in (
select taxpayer_id from income_record
where category_id = 2
)
and taxpayer_id not in (
select taxpayer_id from income_record
where category_id = 3
);
select * from income_record
where amount > all (
select amount from income_record
where category_id = 3
);
select * from income_record
where amount > any (
select amount from income_record
where category_id = 3
);
select taxpayer_id, sum(amount) as total_income
from income_record
group by taxpayer_id
having sum(amount) = (
select max(total_income)
from (
select sum(amount) as total_income from income_record
group by taxpayer_id) as taxpayer_totals);
select i.* from income_record i
join (
select category_id, avg(amount) as average_income
from income_record group by category_id) 
c on i.category_id = c.category_id
where i.amount > c.average_income;