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



select r.name, count(*) as no_of_sales_rep
from region r join sales_reps sr 
on r.id = sr.region_id 
group by r.name
order by no_of_sales_rep asc;




select a.name as acc_name, avg(o.standard_qty) as avg_std_qty,
avg(o.gloss_qty) as gls_qty, avg(o.poster_qty) as pr_qty
from accounts a join orders o 
on a.id = o.account_id
group by acc_name;
/*retrieves the average standard quantity, gloss quantity, 
and poster quantity from the orders table for each account, along with the account name.*/


select sr.name as sales_rep_name, we.channel
, count(*) as no_of_occurances from
accounts a join web_events we 
on a.id = we.account_id
join sales_reps sr on sr.id = a.sales_rep_id
group by sales_rep_name , we.channel 
order by no_of_occurances desc
/*counts the occurrences of web events for each sales representative and channel, sorting the results in descending order based on the count.*/


select sr.name as sales_rep_name,
count(*) as no_of_acc from sales_reps sr 
join accounts a on sr.id = a.sales_rep_id
group by sales_rep_name, sr.id
order by no_of_acc;
/*counts the number of accounts associated with each sales representative, sorting the results by the count.*/


select sr.name as sales_rep_name, count(sr.name) as no_of_acc
from sales_reps sr join accounts a 
on sr.id = a.sales_rep_id
group by sales_rep_name
having count(sr.name) > 5
order by 2 asc;
/* query counts the number of accounts for each sales representative,
only including sales representatives with more than five accounts.
The results are sorted in ascending order based on the count.*/


select a.name as a_name, count(*) as orders_more_than_20
from orders o join accounts a
on o.account_id = a.id
group by a_name
having count(*) > 20
order by 2 asc;
/*query counts the number of orders for each account and filters out accounts with fewer than 20 orders.
The results are sorted in ascending order based on the count.*/


select a.name as a_name, count(*) as most_orders
from orders o join accounts a 
on o.account_id = a.id
group by a_name
order by 2 desc;
/*query counts the number of orders for each account and displays the accounts with the highest 
number of orders at the top. The results are sorted in descending order based on the count.*/


select a.name as a_name, sum(o.total_amt_usd) as total_amt
from orders o join accounts a 
on a.id = o.account_id 
group by a_name
having sum(o.total_amt_usd) > 30000
order by total_amt desc;
/*query calculates the total amount in USD for each account and filters out accounts with a total amount greater than 30,000.
The results are sorted in descending order based on the total amount.*/


select a.name as a_name, we.channel , count(*) as times
from web_events we join accounts a 
on we.account_id = a.id 
where we.channel like 'facebook' 
group by a.name, we.channel 
having count(*) > 6
order by times asc;
/*query counts the occurrences of web events for each account and channel, only including events from the "facebook" channel.
 Accounts with more than six occurrences are included, and the results are sorted in ascending order based on the count.*/


select we.channel, count(*) as most_freq
from web_events we join accounts a 
on we.account_id = a.id 
group by  we.channel
order by most_freq desc;
/*query counts the occurrences of web events for each channel and sorts the results in descending order based on the count.*/


select sum(total_amt_usd), date_part('year',occurred_at) AS sales_year from orders
group by sales_year
order by 1 desc;
/* query calculates the total amount in USD for each year and displays the results in descending order based on the total amount.*/


select sum(total_amt_usd), date_part('month', occurred_at) as sales_month
from orders group by sales_month
order by 1 desc;
/*query calculates the total amount in USD for each month and displays the results in descending order based on the total amount.*/


select date_trunc('month', o.occurred_at) as sales_month, sum(o.gloss_amt_usd)
from orders o join accounts a 
on o.account_id = a.id
where a.name like 'Walmart'
group by sales_month
order by 2 desc;
/*query calculates the total gloss amount in USD for each month, considering only the orders associated with the "Walmart" account.
The results are grouped by sales month and sorted in descending order based on the total gloss amount.*/


select account_id, total_amt_usd,
case
	when total_amt_usd > 3000 then 'Large'
	else 'Small'
end
from orders;
/*query retrieves the account ID, total amount in USD, and categorizes the orders as "Large" if the total amount is greater than 3000, otherwise as "Small".*/


select case when total >= 2000 then 'At least 2000'
			when total >= 1000 AND total < 2000 then 'Between 1000 and 2000'
			else 'Less than 1000'
		end as order_category,
		count(*) as number_of_orders
from orders
group by 1;
/*query categorizes the number of orders into ranges: "At least 2000," "Between 1000 and 2000," and "Less than 1000".
 *  The results include the number of orders in each category.*/


select a.name as a_name, sum(o.total_amt_usd) as total_amt,
case when sum(o.total_amt_usd) >= 200000 then 'Top level'
when sum(o.total_amt_usd) >= 100000 and sum(o.total_amt_usd) < 200000 then 'second level'
else 'Lowest level' 
end as levels_of_customers
from orders o join accounts a 
on o.account_id = a.id
group by a_name
order by 2 desc;
/* query calculates the total amount in USD for each account and categorizes the accounts as "Top level" if the total amount is greater than or equal to 200,000, 
 "second level" if between 100,000 and 200,000, and "Lowest level" otherwise. The results are sorted in descending order based on the total amount.*/


select a.name as a_name, sum(o.total_amt_usd), date_part('year', o.occurred_at) as date_in_year,
case 
	when sum(o.total_amt_usd) >= 200000 then 'Top level'
	when sum(o.total_amt_usd) > 100000 and sum(o.total_amt_usd) < 200000 then 'second level'
	else 'Lowest level'
end as levels_of_customers
from orders o join accounts a
on o.account_id = a.id
where date_part('year', o.occurred_at) between 2016 and 2017
group by a_name, date_part('year', o.occurred_at)
order by 2 desc;
/*query calculates the total amount in USD for each account in a specific year range (2016-2017). The accounts are categorized into 
"Top level," "second level," or "Lowest level" based on the total amount. The results are sorted in descending order based on the total amount.*/


select sr.name as sales_rep_name, count(*) as total_orders,
case 
	when sum(o.total) > 200 then 'Top'
	else 'Low'
end as sales_rep_performance
from accounts a  join sales_reps sr 
on a.sales_rep_id = sr.id
join orders o on a.id = o.account_id
group by sales_rep_name
order by total_orders desc;
/*query calculates the total number of orders for each sales representative, 
along with their performance level categorized as "Top" or "Low" based on the total order value. The results are sorted in descending order based on the total number of orders.*/



select sr.name as sales_rep_name, count(*) as total_orders, sum(o.total_amt_usd),
case 
	when count(*) >= 200 or sum(o.total_amt_usd) > 750000 then 'Top'
	when count(*)  >= 150 or sum(o.total_amt_usd) > 500000 then 'Middle'  
	else 'Low'
end as sales_rep_performance
from accounts a  join sales_reps sr 
on a.sales_rep_id = sr.id
join orders o on a.id = o.account_id
group by sales_rep_name
order by total_orders desc;
/* query calculates the total number of orders, total amount in USD, 
and performance level for each sales representative. The performance level is categorized as "Top," "Middle," or "Low" */
