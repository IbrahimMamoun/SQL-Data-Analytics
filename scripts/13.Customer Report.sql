/*
===============================================================================
Customer Report
===============================================================================
Purpose:
    - This report consolidates key customer metrics and behaviors

Highlights:
    1. Gathers essential fields such as names, ages, and transaction details.
	2. Segments customers into categories (VIP, Regular, New) and age groups.
    3. Aggregates customer-level metrics:
	   - total orders
	   - total sales
	   - total quantity purchased
	   - total products
	   - lifespan (in months)
    4. Calculates valuable KPIs:
	    - recency (months since last order)
		- average order value
		- average monthly spend
===============================================================================
*/
IF OBJECT_ID('gold.report_customers', 'V') IS NOT NULL
    DROP VIEW gold.report_customers;
GO

create view gold.report_customers as
/*---------------------------------------------------------------------------
1) Base Query: Retrieves core columns from tables
---------------------------------------------------------------------------*/
with base_query as(
select 
f.order_number,
f.product_key,
f.order_date,
f.sales_amount,
f.quantity,
c.customer_key,
c.customer_number,
concat(c.first_name,' ', c.last_name) as customer_name,
datediff(year,c.birthdate, getdate()) age
from [gold].[fact_sales] f
left join [gold].[dim_customers] c
on c.customer_key = f.customer_key
where order_date is not null)


/*---------------------------------------------------------------------------
2) Customer Aggregations: Summarizes key metrics at the customer level
---------------------------------------------------------------------------*/
, customer_aggregation as (
select 
customer_key,
customer_number,
customer_name,
age,
count(distinct order_number) as total_orders,
sum(sales_amount) as total_sales,
sum(quantity) as total_quantity,
count(distinct product_key) as total_products,
max(order_date) as last_order_date,
datediff(month, min(order_date) , max(order_date)) as lifespan
from base_query
group by 
customer_key,
customer_number,
customer_name,
age
 )

 select 
customer_key,
customer_number,
customer_name,
age,
case when age <20 then 'Under 20'
	 when age between 20 and 29 then '20-29'
	 when age between 30 and 39 then '30-39'
	 when age between 40 and 49 then '40-49'
     else '50 and above'
end as age_group,
case when lifespan >= 12 and total_sales >5000 then 'VIP'
	 when lifespan >= 12 and total_sales <= 5000 then 'Regular'
	 else 'New'
end as customer_segment,
last_order_date,
datediff(month, last_order_date, getdate()) as recency,
total_orders,
total_sales,
total_quantity,
total_products,
lifespan,
--compuate average order value (AVO) 
case when total_orders = 0 then 0 --to avoid divide by zero
	 else total_sales / total_orders 
end as avg_order_value,

--compuate average monthly spend ( total sales / number of months) monnths here are the active months for each customer and it's lifespan
case when lifespan = 0 then total_sales -- there is no zero for lifespan, the zero means that the custoemr only exist for one month 
     else total_sales / lifespan
end as avg_monthly_spend
from customer_aggregation

--after buliding the report you need to put it as a view in the database to share it with others

select * from gold.report_customers