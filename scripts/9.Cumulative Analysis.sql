--aggregate the data progressively over time, it helps to understand whether our business is growing or declining
--like running toal of sales by year or moving average of sales by month 



--calculate the total sales per month and the running total of sales over time
select 
order_date,
total_sales,
sum(total_sales) over (order by order_date) as running_total_sales --the frame here is between unbounded preceding and current row
from
(
select 
datetrunc(month,order_date) as order_date,
sum(sales_amount) as total_sales
from [gold].[fact_sales]
where order_date is not null
group by datetrunc(month,order_date)
) t

 --another way to write the query
SELECT
    DATETRUNC(MONTH, order_date) AS order_date,
    SUM(sales_amount) AS total_sales,
    SUM(SUM(sales_amount)) OVER (
        ORDER BY DATETRUNC(MONTH, order_date)
    ) AS running_total_sales
FROM [gold].[fact_sales]
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH, order_date);


--partition the data by order date 

select 
order_date,
total_sales,
sum(total_sales) over (partition by year(order_Date) order by order_date) as running_total_sales --the frame here is between unbounded preceding and current row
from
(
select 
datetrunc(month,order_date) as order_date,
sum(sales_amount) as total_sales
from [gold].[fact_sales]
where order_date is not null
group by datetrunc(month,order_date)
) t

-- find the moving avg of the price 

select 
order_date,
total_sales,
avg_price,
sum(total_sales) over (order by order_date) as running_total_sales,
avg(avg_price) over (order by order_date) as moving_avg_price
from
(
select 
datetrunc(month,order_date) as order_date,
sum(sales_amount) as total_sales,
avg(price) as avg_price
from [gold].[fact_sales]
where order_date is not null
group by datetrunc(month,order_date)
) t









