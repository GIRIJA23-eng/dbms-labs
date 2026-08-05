use girija;
show tables;
select t.full_name, i.income_source from taxpayer t 
inner join Income_Record i on t.taxpayer_id=i.taxpayer_id;
select t.full_name, c.category_name from taxpayer t 
inner join Income_Record i on t.taxpayer_id=i.taxpayer_id
inner join income_category c on i.category_id=c.category_id;

select i.income_id,i.income_source,f.year_label from Income_Record i
inner join financial_year f on i.year_id=f.year_id;

select t.full_name,t.annual_income,i.amount from taxpayer t 
inner join Income_Record i on t.taxpayer_id=i.taxpayer_id;

select t.full_name,i.income_source,c.category_name,f.year_label from taxpayer t
inner join Income_Record i on t.taxpayer_id=i.taxpayer_id
inner join income_category c on i.category_id=c.category_id
inner join financial_year f on i.year_id=f.year_id;

select t.full_name,i.income_source from taxpayer t
inner join Income_Record i on t.taxpayer_id=i.taxpayer_id
inner join income_category c on i.category_id=c.category_id
where c.category_name='salary';

select t.full_name,t.occupation,i.income_source from taxpayer t
inner join Income_Record i on t.taxpayer_id=i.taxpayer_id
inner join income_category c on i.category_id=c.category_id
where c.category_name='business';

select t.full_name,t.pan_number,t.occupation,f.start_date,f.end_date from taxpayer t 
inner join Income_record i on t.taxpayer_id=i.taxpayer_id
inner join financial_year f on i.year_id=f.year_id;

select t.full_name,c.category_name,c.description from taxpayer t
inner join Income_Record i on t.taxpayer_id=i.taxpayer_id
inner join income_category c on i.category_id =c.category_id;

select t.full_name,t.pan_number,t.occupation,i.income_source,c.category_name,i.amount,f.year_label from taxpayer t
inner join Income_Record i on t.taxpayer_id=i.taxpayer_id
inner join income_category c on i.category_id=c.category_id
inner join financial_year f on i.year_id=f.year_id;

select t.full_name,i.income_source from taxpayer t
left join Income_Record i on t.taxpayer_id=i.taxpayer_id;

select c.category_name,i.income_source from Income_Record i
right join income_category c on i.category_id=c.category_id;

select t.full_name,i.income_source from taxpayer t 
left join Income_Record i on t.taxpayer_id=i.taxpayer_id
union
select t.full_name,i.income_source from taxpayer t 
right join Income_Record i on t.taxpayer_id=i.taxpayer_id;

select t.full_name,f.year_label from taxpayer t 
cross join financial_year f;

select A.full_name as taxpayer1,
B.full_name as taxpayer2,   
A.occupation
from taxpayer A
inner join taxpayer B
on A.occupation=B.occupation
and A.taxpayer_id < b.taxpayer_id;

select t.full_name,t.pan_number,i.income_source,c.category_name,f.year_label from taxpayer t
inner join  Income_Record i on t.taxpayer_id = i.taxpayer_id
inner join income_category c on i.category_id = c.category_id
inner join financial_year f on i.year_id = f.year_id;

select t.full_name,c.category_name,c.description from taxpayer t
inner join Income_Record i on t.taxpayer_id = i.taxpayer_id
inner join income_category c on i.category_id = c.category_id;

select i.income_source,f.year_label from Income_Record i
inner join financial_year f on i.year_id = f.year_id;

select t.full_name,i.income_source,c.category_name,f.year_label from taxpayer t
inner join Income_Record i on t.taxpayer_id = i.taxpayer_id
inner join income_category c on i.category_id = c.category_id
inner join financial_year f on i.year_id = f.year_id
where c.category_name = 'Business' and f.year_label = '2025-2026';

select t.taxpayer_id,t.full_name,t.pan_number,t.occupation,i.income_source,i.amount,
i.received_date,c.category_name,c.description,f.year_label,f.start_date,f.end_date,f.filling_deadline from taxpayer t
inner join Income_Record i on t.taxpayer_id = i.taxpayer_id
inner join income_category c on i.category_id = c.category_id
inner join financial_year f on i.year_id = f.year_id;

