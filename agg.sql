select sum(poster_qty) from orders;
-- Calculates the sum of the poster_qty column from the orders table. It returns the total quantity of posters across all orders.

select sum(standard_qty) from orders;
-- Calculates the sum of the standard_qty column from the orders table. It returns the total quantity of standard items across all orders.

select sum(total_amt_usd) from orders;
-- Calculates the sum of the total_amt_usd column from the orders table. It returns the total amount in USD across all orders.

select standard_amt_usd + gloss_amt_usd as total_std_gloss_amt from orders;
-- Calculates the sum of the standard_amt_usd and gloss_amt_usd columns from the orders table.
-- It returns the total amount obtained by adding the standard and gloss amounts for each order.

select sum(standard_amt_usd)/sum(standard_qty) as per_unit from orders;
/*Calculates the average price per unit by dividing the sum of standard_amt_usd by the sum of standard_qty from the orders table.
 It provides the average amount in USD for each standard item.*/

select min(occurred_at) from web_events;
-- Retrieves the earliest date (MIN) from the occurred_at column of the web_events table. It returns the earliest occurrence of a web event.

select occurred_at from web_events order by occurred_at asc limit 1;
/*Retrieves the earliest date from the occurred_at column of the web_events table and orders the results in ascending order (ASC).
 It returns the earliest occurrence of a web event.*/

select * from orders;

select avg(standard_qty) as std_qty_avg, avg(gloss_qty) as gls_qty_avg,
avg(poster_qty) as pr_qty_avg, avg(standard_amt_usd) as std_amt_usd_avg,
avg(gloss_amt_usd) as gls_amt_usd_avg ,avg(poster_amt_usd) as pr_amt_usd_avg from orders;
/*Calculates the average values for standard_qty, gloss_qty, poster_qty, standard_amt_usd, gloss_amt_usd, and poster_amt_usd columns from the orders table.
 It provides the average quantity and average amount in USD for each item type.*/

select a.name, o.occurred_at
from accounts a join orders o 
on a.id = o.account_id 
order by o.occurred_at asc
limit 1;
/*Retrieves the name column from the accounts table and the occurred_at column from the orders table.
Joins the accounts and orders tables based on the matching id and account_id columns.
Orders the results by occurred_at in ascending order.
Limits the result to only the first row, giving the earliest occurrence of an order along with the corresponding account name.*/

select a.name, sum(o.total_amt_usd) 
from accounts a join orders o
on a.id = o.account_id
group by a.name;
/*Retrieves the name column from the accounts table and calculates the sum of total_amt_usd column from the orders table for each account.
Joins the accounts and orders tables based on the matching id and account_id columns.
Groups the results by the account names using GROUP BY.
Returns the account name along with the total amount in USD for each account.*/

select we.occurred_at, we.channel, a.name
from accounts a join web_events we
on a.id = we.account_id 
order by we.occurred_at desc
limit 1;
/*Retrieves the occurred_at column from the web_events table, the channel column from the web_events table, and the name column from the accounts table.
Joins the accounts and web_events tables based on the matching id and account_id columns.
Orders the results by occurred_at in descending order (DESC).
Limits the result to only the first row, providing the latest occurrence of a web event along with the corresponding channel and account name.
*/

select channel, count(*) as total_times_used
from web_events 
group by channel;
/*Retrieves the channel column from the web_events table and calculates the count of occurrences for each channel.
Groups the results by the channels using GROUP BY.
Returns the channel name along with the total count of times it was used.*/

select sr.name as sale_rep_name, we.occurred_at from accounts join web_events we
on accounts.id = we.account_id
join sales_reps sr on sr.id = accounts.sales_rep_id
order by we.occurred_at asc;
/*Retrieves the name column from the sales_reps table (renamed as sale_rep_name), and the occurred_at column from the web_events table.
Joins the accounts, web_events, and sales_reps tables based on the corresponding IDs.
Orders the results by occurred_at in ascending order.
Returns the sales representative name along with the occurrence date and time of web events associated with their accounts.*/

select a.name, min(o.total_amt_usd) as smallest_ord
from orders o join accounts a 
on o.account_id = a.id
group by a.name
order by smallest_ord asc;
/*Retrieves the name column from the accounts table and calculates the minimum value of total_amt_usd column from the orders table for each account.
Joins the orders and accounts tables based on the matching account_id and id columns.
Groups the results by account names using GROUP BY.
Orders the results by the minimum order amount (smallest_ord) in ascending order.
Returns the account name along with the smallest order amount for each account.*/















