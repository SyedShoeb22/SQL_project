select * from orders o join accounts a on o.id = a.id;
-- Retrieves all columns from the orders table and the accounts table where the id matches between the two tables.

select o.standard_qty, o.gloss_qty, o.poster_qty,
a.primary_poc, a.website
from orders o join accounts a on o.id = a.id;
/*Retrieves the standard_qty, gloss_qty, poster_qty, primary_poc,
 and website columns from the orders table and the accounts table where the id matches between the two tables.*/

select a.name, a.primary_poc, we.occurred_at, we.channel
from accounts a join web_events we 
on a.id = we.account_id
where a.name like 'Walmart';
/*Retrieves the name, primary_poc, occurred_at, and channel columns from the accounts table 
 and the web_events table where the id matches between the two tables, and the name in the accounts table is 'Walmart'.*/

select r.name as r_name,
sr.name as sr_name,
a.name as a_name
from region r join sales_reps sr on r.id = sr.region_id
join accounts a on sr.id = a.sales_rep_id
order by a_name asc;
/*Retrieves the name column from the region table (aliased as r_name), the name column from
 the sales_reps table (aliased as sr_name), and the name column from the accounts table (aliased as a_name) where the region_id 
 in the sales_reps table matches the id in the region table and the sales_rep_id in the
 accounts table matches the id in the sales_reps table, ordering the results by a_name in ascending order*/

select r.name as r_name, a.name as a_name,
round(o.total_amt_usd/o.total+0.01) as unit_price
from accounts a join orders o 
on a.id = o.account_id 
join sales_reps sr on sr.id = a.sales_rep_id
join region r on r.id = sr.region_id;
/*Retrieves the name column from the region table (aliased as r_name), the name column from the accounts table (aliased as a_name),
 and calculates the unit_price by dividing total_amt_usd in the orders table by total and rounding it (plus 0.01) from the
 accounts table, where the account_id in the orders table matches the id in the accounts table, the sales_rep_id in the accounts table
 matches the id in the sales_reps table, and the region_id in the sales_reps table matches the id in the region table,
 and the standard_qty in the orders table is greater than 100.*/

select r.name as reg_name, a.name as acc_name, sr.name as sales_rep_name
from region r join sales_reps sr on r.id = sr.region_id
join accounts a on a.sales_rep_id = sr.id
where r.name like 'Midwest'
order by a.name asc;
/*Retrieves the name column from the region table (aliased as reg_name), the name column from the accounts table (aliased as acc_name),
and the name column from the sales_reps table (aliased as sales_rep_name).
Joins the region, sales_reps, and accounts tables based on the matching id and region_id columns.
Filters the results to include only rows where the name in the region table matches 'Midwest'.
Orders the results by acc_name (account name) in ascending order.*/

select r.name as reg_name, a.name as acc_name, sr.name as sales_rep_name
from region r join sales_reps sr on r.id =sr.region_id 
join accounts a on a.sales_rep_id = sr.id 
where lower(sr.name) like 's%' and r.name like 'Midwest'
order by a.name asc;
/*Similar to the previous query but with additional conditions in the WHERE clause.
Filters the results to include only rows where the name in the sales_reps table starts with 's' (case-insensitive) and the name in the region table matches 'Midwest'.
Orders the results by acc_name (account name) in ascending order.*/

select r.name as reg_name, sr.name as sales_rep_name, a.name as acc_name
from region r join sales_reps sr on r.id = sr.region_id 
join accounts a on a.sales_rep_id = sr.id
where sr.name like '% K%' and r.name like 'Midwest'
order by a.name asc;
/*Similar to the previous queries but with different conditions in the WHERE clause.
Filters the results to include only rows where the name in the sales_reps table contains ' K' (case-sensitive) and the name in the region table matches 'Midwest'.
Orders the results by acc_name (account name) in ascending order.*/

select r.name as r_name, a.name as a_name,
round(o.total_amt_usd/total + 0.01) as unit_price
from accounts a join orders o on o.account_id = a.id 
join sales_reps sr on sr.id = a.sales_rep_id 
join region r on r.id = sr.region_id
where o.standard_qty > 100;
/*Retrieves the name column from the region table (aliased as r_name), the name column from the accounts table (aliased as a_name), and calculates the unit_price by dividing total_amt_usd in the orders table by total and rounding it (plus 0.01) from the accounts table.
Joins the accounts, orders, sales_reps, and region tables based on the matching account_id, id, sales_rep_id, and region_id columns.
Filters the results to include only rows where the standard_qty in the orders table is greater than 100.*/

select r.name as r_name, a.name as a_name, 
round(o.total_amt_usd/o.total+0.01) as unit_price
from accounts a join orders o on a.id = o.account_id 
join sales_reps sr on sr.id = a.sales_rep_id 
join region r on r.id = sr.region_id 
where o.standard_qty > 100 and o.poster_qty > 50;

select r.name as r_name, a.name as a_name,
round(o.total_amt_usd/o.total+0.01) as unit_price
from accounts a join orders o on a.id = o.account_id 
join sales_reps sr on sr.id = a.sales_rep_id
join region r on r.id = sr.region_id 
where o.standard_qty > 100 and o.poster_qty > 50
order by unit_price desc;

select distinct a.name as a_name, we.channel
from accounts a join web_events we on a.id = we.account_id
where a.id = 1001;

select we.occurred_at, a.name as a_name, o.total, o.total_amt_usd
from accounts a join orders o on a.id = o.account_id 
join web_events we on we.account_id =a.id
where we.occurred_at between '2015-01-01' and '2015-12-31';











