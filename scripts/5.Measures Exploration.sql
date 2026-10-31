--calculate the key metric of the business (big numbers) 
--highest level of aggregation and lowest level of details

-- 1 --find total sales
select sum(sales_amount) as total_sales from [gold].[fact_sales]
-- 2 --find how many items are sold
select sum(quantity) as total_quantity from [gold].[fact_sales]
-- 3 --find the average selling price
select avg(price) as avg_price from [gold].[fact_sales]
-- 4 --find the total number of orders
select count(order_number) as  total_orders from [gold].[fact_sales] -- here the customer  can order more than one time, like the customer 1 is order 3 orders, in this query you calculate them as 3 
select count(distinct order_number)  as distinct_total_orders from [gold].[fact_sales] -- in this query you use distinct, so if the customer order 3 orders then it will counts only one time
-- 5 -- when using count always compare the numbers using count and count distinct
-- 6 --find the total number of products
select count(product_key) as total_products from [gold].[dim_products] -- you can use product name insted of product key 
select count(distinct product_key) as total_products from [gold].[dim_products] -- we have no duplicates 

-- 7 --find the total number of customers
select count(customer_key) as total_customers from [gold].[dim_customers]
select count(distinct customer_key) as total_customers from [gold].[dim_customers]

-- 8 --find the total number of customers that has placed an order, placed an order means there are a sale, and because one customer can order multiple time we will use distinct
select count(distinct customer_key) as total_customers from  [gold].[fact_sales]

-- the numbers in 7 and 8 are the same, thats mean that all the regestird customers are placed an order

-- generate the report that shows all key metrics of the business
SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity', SUM(quantity) FROM gold.fact_sales
UNION ALL
SELECT 'Average Price', AVG(price) FROM gold.fact_sales
UNION ALL
SELECT 'Total Orders', COUNT(DISTINCT order_number) FROM gold.fact_sales
UNION ALL
SELECT 'Total Products', COUNT(DISTINCT product_name) FROM gold.dim_products
UNION ALL
SELECT 'Total Customers', COUNT(customer_key) FROM gold.dim_customers;
