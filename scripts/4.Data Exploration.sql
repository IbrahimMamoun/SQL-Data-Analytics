-- identify the earliest and latest dates (boundaries) to understand the scope of data and the timespan

-- find the date of the first and last order (boundaries of the order date)
-- how many years of sales are available

select 
min(order_date) first_order_date,
max(order_date) last_order_date,
datediff(year, min(order_date), max(order_date)) as order_range_year,
datediff(MONTH, min(order_date), max(order_date)) as order_range_month
from [gold].[fact_sales]

--find youngest and oldest customers

select 
min(birthdate) as oldest_birthdate,
datediff(year, min(birthdate), getdate()) as oldest_age,
max(birthdate) as youngest_birthdate,
datediff(year, max(birthdate), getdate()) as youngest_age
from [gold].[dim_customers]







