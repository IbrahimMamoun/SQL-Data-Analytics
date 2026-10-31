select distinct 
category -- no numeric value so this column is a dimension
from gold.dim_products

select distinct 
sales_amount --it's numeric and make sense to aggregate it so its a measure
from [gold].[fact_sales]

--measure coulumns: sales\ quantity\ age
--dimension coulmns: category\ product\birthday \ID

--ID coulmn is a numeric but it doesn't make any sense to aggregate the coulmn
--the birthday is a dimension but if you calculate the age using datediff then it will be usefull and can aggregate it then it's measure
-- we need dimensions to group  our data, and you need the measures to answer the questions how many and how much















