select we.channel, date_part('day', we.occurred_at) as day_no, count(*) as no_of_events
from web_events we 
group by we.channel, date_part('day', we.occurred_at)
order by 3 desc;

select * from (
 select channel, date_part('day', occurred_at) as day_no, count(*) as no_of_events
 from web_events group by channel, date_part('day', occurred_at)
 order by 3 desc
) sub;

/*find the average number of events for each channel. Average per day*/
select round(avg(no_of_events), 0) as avg_no_of_events, channel
from ( select channel, date_part('day', occurred_at) as day_no,
count(*) as no_of_events from web_events
group by 1, 2
) sub 
group by 2
order by 1 desc;

/*list of orders happended at the first month in P&P history , ordered by occurred_at */
select * from orders 
where date_part('month', occurred_at) = (
select  date_part('month',min(occurred_at)) from orders)
order by occurred_at;

/*average of paper quantity happended at the first month in P&P history*/
select avg(poster_qty) as poster_avg,
avg(gloss_qty) as gloss_avg,
avg(standard_qty) as standard_avg,
sum(total_amt_usd) as total_sales
from
orders where date_part('month', occurred_at) = (select
		date_part('month', min(occurred_at)) from orders
);

/*1) Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.*/
select region_name. sales_rep_name, total_sales
	from (select sr.name as sales_rep_name, sr.id as sales_rep_id,
	r.name as region_name, r.id as reg_id, sum(o.total_amt_usd) as total_sales 
		from accounts a 
		join orders o on a.id = o.account_id
		join sales_reps sr on sr.id = a.sales_rep_id
		join region r on r.id = sr.region_id
		group by 1, 2, 3, 4
		order by 2, 3) table_reg_n_salesRep_w_total_sales
		join ( select table_req_n_salesRep_w_total_sales.reg_id, max( total_sales) as max_total_sales
				from ( select r.id as reg_id , r.name as region_name,
				)); -- uncomplete


/*largest sales region*/
select r.name as reg_name, r.id as reg_id , sum(o.total_amt_usd) as total_sales 
from orders o join accounts a 
on a.id = o.account_id 
join sales_reps sr on sr.id = a.sales_rep_id 
join region r on r.id = sr.region_id 
group by 1, 2
order by 3;

/*total numbers of orders per region */
select r.name as reg_name, r.id as reg_id , count(*) as tot_no_orders
from orders o join accounts a
on o.account_id = a.id
join sales_reps sr on a.sales_rep_id = sr.id
join region r on sr.region_id = r.id 
group by 1, 2
order by 3;

select table1.reg_id, table1.reg_name, total_number_of_orders
from (select r.name as reg_name, r.id as reg_id, sum(o.total_amt_usd) as total_sales
	  from orders o join accounts a on a.id = o.account_id
	  join sales_reps sr on sr.id = a.sales_rep_id 
	  join region r on r.id = sr.region_id 
	  group by 1, 2
	  order by 3) table1
join (	select r.name as reg_name, r.id as reg_id , count(*) as total_number_of_orders
		from orders o join accounts a
		on o.account_id = a.id
		join sales_reps sr on a.sales_rep_id = sr.id
		join region r on sr.region_id = r.id 
		group by 1, 2
		order by 3 ) table2 
on table1.reg_id = table2.reg_id;
	  

















