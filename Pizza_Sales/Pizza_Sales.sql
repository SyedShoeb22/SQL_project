/*
PROBLEM STATEMENT

KPI's REQUIREMENT

We need to analyze key indicators for our pizza sales data to gain insights into
our business performance. Specifically, we want to calculate the following metrics:
*/
select * from pizza_sales; 

-- 1. Total Revenue: The sum of the total price of all pizza orders.
select sum(total_price) as revenue from pizza_sales; 

/* 2. Average Order Value: The average amount spent per order, calculated by dividing the
total revenue by the total number of orders.*/
select (sum(total_price)/ count(distinct(order_id))) as average_order from pizza_sales;

-- 3. Total Pizzas Sold: The sum of the quantities of all pizzas sold.
select sum(quantity) as total_pizzas_sold from pizza_sales; 

-- 4. Total Orders: The total number of orders placed.
select count(distinct(order_id)) as total_orders
from pizza_sales;

/*5. Average Pizzas Per Order: The average number of pizzas sold per order, calculated by
dividing the total number of pizzas sold by the total number of orders.*/
select cast(sum(quantity) as decimal (10,2))/count(distinct(order_id)) as Average_Pizzas_Per_Order from pizza_sales

/*We would like to visualize various aspects of our pizza sales data to gain insights
and understand key trends, We have identified the following requirements for
creating charts:

1.Daily Trend for Total Orders:

Create a bar chart that displays the daily trend of total orders over a specific 
time period. This chart will help us identify any patterns or fluctuations 
in order volumes on a daily basis.
*/
ALTER TABLE pizza_sales ALTER COLUMN order_date TYPE DATE 
using to_date(order_date, 'DD-MM-YYYY');

select to_char(order_date, 'day') as day_name, count(distinct(order_id))
from pizza_sales 
group by 1;

/*2.Hourly Trend for Total Orders:

Create a line chart that illustrates the hourly trend of total orders throughout
the day. This chart will allow us to identify peak hours or periods of high order
activity.*/
select to_date('HH24', order_time ) as day_name, count(distinct(order_id))
from pizza_sales 
group by 1;

/*
3.Percentage of Sales by Pizza Category:

Create a pie chart that shows the distribution of sales across different pizza
categories. This chart will provide insights into the popularity of various pizza
categories and their contribution to overall sales.
*/
select pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY 1
ORDER BY 1;


/*PROBLEM STATEMENT

CHARTS REQUIREMENT

4.Percentage of Sales by Pizza Size:

Generate a pie chart that represents the percentage of sales attributed to different pizza sizes. This

chart will help us understand customer preferences for pizza sizes and their impact on sales.
*/
select pizza_size, cast(sum(total_price) as decimal (10, 2)) as rev,
cast(sum(total_price) * 100 / (select sum(total_price) from pizza_sales) as decimal(10, 2))
from pizza_sales 
group by 1
order by 3 desc;


/*5.Total Pizzas Sold by Pizza Category:

Create a funnel chart that presents the total number of pizzas sold
 for each pizza category. This chart will allow us to compare the sales
  performance of different pizza categories.
*/
select pizza_category, sum(quantity) as total_pizzas_sold
from pizza_sales
group by 1
order by 2 desc;

/*
6.Top 5 Best Sellers by Revenue, Total Quantity and Total Orders

Create a bar chart highlighting the top 5 best-selling pizzas based on the Revenue,
Total Quantity. Total Orders. This chart will help us identity the most
popular pizza options.
*/

select pizza_name, sum(total_price) as Revenue 
from pizza_sales
group by 1
order by 1 desc
limit 5;

select pizza_name, sum(quantity) as total_quantity 
from pizza_sales
group by 1
order by 1 desc
limit 5;

select pizza_namecount, (distinct(order_id)) as total_orders
from pizza_sales
group by 1
order by 1 desc
limit 5;


/*
7. Bottom 5 Best Sellers by Revenue, Total Quantity and Total Orders

Create a bar chart showcasing the bottom 5 worst-selling pizzas based on the Revenue,
Total Quantity Total Orders. This chart will enable us to identity underperforming or
less popular pizza options.
*/
select pizza_name, sum(total_price) as Revenue 
from pizza_sales
group by 1
order by 1 asc
limit 5;

select pizza_name, sum(quantity) as total_quantity 
from pizza_sales
group by 1
order by 1 asc
limit 5;

select pizza_name, count(distinct(order_id)) as total_orders
from pizza_sales
group by 1
order by 1 asc
limit 5;



   
   
   
   
   
   
   
   
   
   
   
   
   
