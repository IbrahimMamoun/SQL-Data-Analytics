--check the objects and columns in database

select * from INFORMATION_SCHEMA.TABLES


select * from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'dim_customers'
