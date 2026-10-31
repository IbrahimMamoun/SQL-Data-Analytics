--comparing the current value to a target value, it helps to measure success and compare performance 
--like compare curretn sales - average sales \ current year sales - previous year sales (YoY Analysis)


/* Analyze the yearly performance of products by comparing each product's sales 
to both the average sales performance of the product and the previous year's sales */


with yearly_product_Sales as (
select 
year(f.order_date) as order_year,
p.product_name,
sum(f.sales_amount) as current_sales
from [gold].[fact_sales] f 
left join [gold].[dim_products] p 
on f.product_key = p.product_key
where f.order_date is not null
group by year(f.order_date),p.product_name
)

select 
order_year,
product_name,
current_sales,
avg(current_sales) over (partition by product_name) avg_sales,
current_sales -  avg(current_sales) over (partition by product_name) as diff_avg,
case when current_sales -  avg(current_sales) over (partition by product_name) >0 then 'Above Avg'
	 when  current_sales -  avg(current_sales) over (partition by product_name) < 0 then 'Below Avg'
     else 'Avg'
	 end avg_change,
--year over year analysis
lag(current_sales)over (partition by product_name  order by order_year) previous_year_sales,
current_sales - lag(current_sales)over (partition by product_name  order by order_year) as diff_py,
case when current_sales -  lag(current_sales)over (partition by product_name  order by order_year) >0 then 'Incresding'
	 when  current_sales -  lag(current_sales)over (partition by product_name  order by order_year) < 0 then 'Decrease'
     else 'No Change'
	 end Previous_Year_Change
from yearly_product_Sales
order by product_name, order_year



with monthly_product_Sales as (
select 
month(f.order_date) as order_month,
p.product_name,
sum(f.sales_amount) as current_sales
from [gold].[fact_sales] f 
left join [gold].[dim_products] p 
on f.product_key = p.product_key
where f.order_date is not null
group by month(f.order_date),p.product_name
)

select 
order_month,
product_name,
current_sales,
avg(current_sales) over (partition by product_name) avg_sales,
current_sales -  avg(current_sales) over (partition by product_name) as diff_avg,
case when current_sales -  avg(current_sales) over (partition by product_name) >0 then 'Above Avg'
	 when  current_sales -  avg(current_sales) over (partition by product_name) < 0 then 'Below Avg'
     else 'Avg'
	 end avg_change,
--month over month analysis
lag(current_sales)over (partition by product_name  order by order_month) previous_year_sales,
current_sales - lag(current_sales)over (partition by product_name  order by order_month) as diff_py,
case when current_sales -  lag(current_sales)over (partition by product_name  order by order_month) >0 then 'Incresding'
	 when  current_sales -  lag(current_sales)over (partition by product_name  order by order_month) < 0 then 'Decrease'
     else 'No Change'
	 end Previous_Year_Change
from monthly_product_Sales
order by product_name, order_month











































