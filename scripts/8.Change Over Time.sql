-- change over time is used to analyze how a measure evolves over time to track trends and identify seasonality in the data
-- like total sales by year or avg cost by month 


-- analyze sales preformance over time
--this query represent the change over years, it's a high level overview insights that helps with strategic decision making

select 
year(order_date) as order_year,
sum(sales_amount) as total_sales,
count(distinct customer_key) as total_customers,
sum(quantity) as total_quantity
from [gold].[fact_sales]
where order_date is not null
group by year(order_date)
order by year(order_date)

--change over time depend oin year and month 
select 
year(order_date) as order_year,
month(order_date) as order_month,
sum(sales_amount) as total_sales,
count(distinct customer_key) as total_customers,
sum(quantity) as total_quantity
from [gold].[fact_sales]
where order_date is not null
group by year(order_date),month(order_date) 
order by year(order_date),month(order_date)

--using datatrunc()

select 
datetrunc(month,order_date) as order_date,
sum(sales_amount) as total_sales,
count(distinct customer_key) as total_customers,
sum(quantity) as total_quantity
from [gold].[fact_sales]
where order_date is not null
group by datetrunc(month,order_date)
order by datetrunc(month,order_date)




--using format()
select 
format(order_date, 'yyyy-MMM') as order_date,
sum(sales_amount) as total_sales,
count(distinct customer_key) as total_customers,
sum(quantity) as total_quantity
from [gold].[fact_sales]
where order_date is not null
group by format(order_date, 'yyyy-MMM')
order by format(order_date, 'yyyy-MMM')








