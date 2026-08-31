use taxpayers;
create view highest_income_view as
select * from income_record
where amount=(
select max(amount) from income_record);
select * from highest_income_view;
create view lowest_income_view as
select*from income_record 
where amount=(
select min(amount) from income_record);
select * from lowest_income_view;
create view above_average_income as
select*from income_record
where amount > (
select avg (amount) from income_record);
select * from above_average_income;
create view highest_recorded_income as 
select * from income_record 
where amount=(
select max(amount) from income_record);
select * from highest_recorded_income;
create view business_owners as
select taxpayer_id,full_name,occupation 
from taxpayer
where occupation= 'Business Owner';
select * from business_owners;
/*level2*/
create view taxpayer_income as
select * from taxpayer 
where taxpayer_id in(
select taxpayer_id from income_record);
select * from taxpayer_income;
create view taxpayer_business_income as
select * from taxpayer
where taxpayer_id in(
select taxpayer_id from income_record
where category_id=(
select category_id from income_category
where category_name='Business')
);
select * from taxpayer_business_income;
create view income_25_26 as
select * from income_record
where year_id=(
select year_id from financial_year
where year_label='2025-2026');
select * from income_25_26;
create view above_min_business_income as
select * from income_record
where amount > (
select min(amount) from income_record
where category_id=(
select category_id from income_category 
where category_name='Business')
);
select * from above_min_business_income;
create view below_max_salary_income as
select * from income_record
where amount < (
select max(amount) from income_record
where category_id = (
select category_id from income_category
where category_name = 'Salary')
);
select * from below_max_salary_income;
create view taxpayers_above_average_income as
select * from taxpayer
where taxpayer_id in (
select taxpayer_id from income_record
where amount > (
select avg(amount) from income_record)
);
select * from taxpayers_above_average_income;
create view categories_with_income as
select * from income_category
where category_id in (
select category_id from income_record
);
select * from categories_with_income;
create view taxpayers_without_investment as
select * from taxpayer
where taxpayer_id not in (
select taxpayer_id from income_record
where category_id = (
select category_id from income_category
where category_name = 'Investment')
);
select * from taxpayers_without_investment;
/*level3*/
create view highest_income_taxpayer as
select * from taxpayer
where taxpayer_id in (
select taxpayer_id from income_record
where amount = (
select max(amount) from income_record)
);
select * from highest_income_taxpayer;
create view above_average_business_income as
select * from income_record
where amount > (
select avg(amount) from income_record
where category_id = (
select category_id from income_category
where category_name = 'Business')
);
select * from above_average_business_income;
create view taxpayers_above_average_total as
select taxpayer_id, sum(amount) as total_income
from income_record
group by taxpayer_id
having sum(amount) > (
select avg(total_income)
from (
select sum(amount) as total_income
from income_record
group by taxpayer_id) as taxpayer_totals
);
select *
from taxpayers_above_average_total;
select * from taxpayers_above_average_total;
create view greater_than_any_investment as
select * from income_record
where amount > any (
select amount from income_record
where category_id = (
select category_id from income_category
where category_name = 'Investment')
);
select * from greater_than_any_investment;
create view category_highest_income as
select * from income_category
where category_id = (
select category_id from income_record
where amount = (
select max(amount) from income_record)
);
select * from category_highest_income;
create view highest_income_year as
select * from financial_year
where year_id = (
select year_id from income_record
group by year_id order by sum(amount) desc
limit 1
);
select * from highest_income_year;
create view taxpayers_above_average_total_income as
select taxpayer_id, sum(amount) as total_income
from income_record
group by taxpayer_id
having sum(amount) > (
select avg(total_income)
from (
select sum(amount) as total_income
from income_record
group by taxpayer_id) as taxpayer_totals
);
select * from taxpayers_above_average_total_income;
/*real world taxation*/
create view highest_income_taxpayer as
select * from taxpayer
where taxpayer_id in (
select taxpayer_id from income_record
where amount = (
select max(amount) from income_record)
);
select *
from highest_income_taxpayer;
create view taxpayers_above_average as
select * from taxpayer
where taxpayer_id in (
select taxpayer_id from income_record
where amount > (
select avg(amount) from income_record)
);
select * from taxpayers_above_average;
create view category_highest_income as
select * from income_category
where category_id = (
select category_id from income_record
where amount = (
select max(amount) from income_record)
);
select * from category_highest_income;
create view business_no_investment as
select * from taxpayer
where taxpayer_id in (
select taxpayer_id from income_record
where category_id = (
select category_id from income_category
where category_name = 'Business')
)
and taxpayer_id not in (
select taxpayer_id from income_record
where category_id = (
select category_id from income_category
where category_name = 'Investment')
);
select * from business_no_investment;
create view greater_than_all_investment as
select * from income_record
where amount > all (
select amount from income_record
    where category_id = (
        select category_id
        from income_category
        where category_name = 'Investment'
    )
);

select *
from greater_than_all_investment;
create view greater_than_any_investment as
select *
from income_record
where amount > any (
    select amount
    from income_record
    where category_id = (
        select category_id
        from income_category
        where category_name = 'Investment'
    )
);

select *
from greater_than_any_investment;
create view highest_total_income_taxpayer as
select taxpayer_id, sum(amount) as total_income
from income_record
group by taxpayer_id
having sum(amount) = (
select max(total_income)
from (
select sum(amount) as total_income from income_record
group by taxpayer_id ) as taxpayer_totals
);
select * from highest_total_income_taxpayer;
create view above_category_average as
select i.* from income_record i
join (
select category_id, avg(amount) as average_income from income_record
group by category_id ) as c
on i.category_id = c.category_id
where i.amount > c.average_income;
select * from above_category_average;
