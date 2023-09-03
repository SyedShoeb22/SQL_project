select id, account_id, occurred_at from orders;
-- Retrieves the id, account_id, and occurred_at columns from the orders table.

select occurred_at, account_id, channel
from web_events limit 15;
-- Retrieves the occurred_at, account_id, and channel columns from the web_events table, limiting the results to 15 rows.

select id, total_amt_usd, occurred_at from orders
order by occurred_at limit 15;
-- Retrieves the id, total_amt_usd, and occurred_at columns from the orders table, ordering the results by occurred_at and limiting to 15 rows.

select * from web_events 
where channel in ('organic', 'adwords');
-- Retrieves all columns from the web_events table where the channel is either 'organic' or 'adwords'.

select id, account_id, total_amt_usd from orders
order by total_amt_usd desc limit 5;
-- Retrieves the id, account_id, and total_amt_usd columns from the orders table, ordering the results by total_amt_usd in descending order and limiting to 5 rows.

select id, account_id, total_amt_usd from orders
order by total_amt_usd asc limit 20;
-- Retrieves the id, account_id, and total_amt_usd columns from the orders table, ordering the results by total_amt_usd in ascending order and limiting to 20 rows.

select id, account_id, total_amt_usd from orders
order by account_id asc , total_amt_usd desc;
/* Retrieves the id, account_id, and total_amt_usd columns from the orders table,
ordering the results first by account_id in ascending order, and then by total_amt_usd in descending order.*/

select id, account_id, total_amt_usd from orders
order by total_amt_usd desc, account_id asc;
/* Retrieves the id, account_id, and total_amt_usd columns from the orders table,
 * 
  ordering the results first by total_amt_usd in descending order, and then by account_id in ascending order.*/

select * from orders
where gloss_amt_usd > 1000 limit 5;
-- Retrieves all columns from the orders table where the gloss_amt_usd is greater than 1000, limiting the results to 5 rows.

select name, website, primary_poc
from accounts where name like 'Exxon Mobil';
-- Retrieves the name, website, and primary_poc columns from the accounts table where the name is exactly 'Exxon Mobil'.

select id,account_id, round(standard_amt_usd/standard_qty, 2) as unit_price
from orders limit 10;

select id, account_id,
poster_amt_usd/(standard_amt_usd + gloss_amt_usd + poster_amt_usd) as post_paper
from orders limit 10;
/* Retrieves the id, account_id, and calculates the unit_price
 by dividing standard_amt_usd by standard_qty (rounded to 2 decimal places) from the orders table, limiting the results to 10 rows.*/

select * from accounts where name like 'C%';
/*Retrieves the id, account_id, and calculates the post_paper ratio
by dividing poster_amt_usd by the sum of standard_amt_usd, gloss_amt_usd,
and poster_amt_usd from the orders table, limiting the results to 10 rows. */

select * from accounts where name like '%one%'
-- Retrieves all columns from the accounts table where the name starts with 'C'.

select name as n, primary_poc, sales_rep_id
from accounts
where name
in('Walmart', 'Target', 'Nordstorm');
/* Retrieves all columns from the accounts table where the name contains 'one' anywhere in the string.*/

select * from orders
where standard_qty > 1000
and poster_qty = 0
and gloss_qty = 0;
/* Retrieves the name column (aliased as n), primary_poc, and sales_rep_id
columns from the accounts table where the name matches 'Walmart', 'Target', or 'Nordstorm'.*/

select name
from accounts
where name not like 'C%' and name like '%s';
/* Retrieves all columns from the orders table where standard_qty is greater than 1000, poster_qty is 0, and gloss_qty is 0.*/

select * from orders 
where gloss_qty between 24 and 29;

select * from web_events 
where channel in('organic', 'adwords') and occurred_at
between '2016-01-01' and '2016-12-31'
order by occurred_at desc;
/*Retrieves all columns from the web_events table where the channel is
either 'organic' or 'adwords' and the occurred_at is between '2016-01-01' and '2016-12-31' (inclusive),
ordering the results by occurred_at in descending order.*/