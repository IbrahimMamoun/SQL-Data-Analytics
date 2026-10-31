-- identifying the unique values(or categories) in each dimension, to recongnizing how data might be grouoed or segmented, which is usefyl for later analysis
-- you need to use distinct[dimension] 

--explore all the countries our customers come from 
select distinct country from [gold].[dim_customers]

--explore all the product categories 'the major divisions'
select distinct category, subcategory, product_name from [gold].[dim_products]
order by 1,2,3
-- if you aggregated category you will get 4 values, if subcategory you will get 36, if you use product you will get 295