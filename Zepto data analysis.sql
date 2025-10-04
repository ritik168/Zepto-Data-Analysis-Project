-- Zepto Data Analysis project


drop table if exists zepto;

-- Create table

create table zepto
(
 sku_id serial primary key,
 Category varchar(120),
 name varchar(150) not null,
 mrp numeric(8,2),
 discountPercent numeric(5,2),
 availableQuantity int,
 discountedSellingPrice numeric(8,2),
 weightInGms int,
 outOfStock boolean,
 quantity int

);
drop table zepto


select * from zepto

-- Load the Datasets

select * from zepto

--Data Explorations

--Count of rows 

select count(*) from zepto

--Sample Data

select * from zepto
limit 10;

--Null values 
select * from zepto
where
Category is null
or
name is null
or
mrp	is null
or
discountPercent is null
or
availableQuantity is null
or
discountedSellingPrice is null
or
weightInGms is null
or
outOfStock	 is null
or
quantity is null;

--Different product category

select distinct (category)
from zepto
order by category;

--products in stock vs out of stock

select outofstock,count(sku_id)
from zepto
group by outOfStock;

--products names present multiple times 

select name,count(sku_id) as "Number od SKUs"
from zepto
group by name
having count(sku_id)>1
order by count(sku_id) desc;

--Data cleanings
--products with price=0

select * from zepto
where mrp=0 or discountedSellingPrice=0;

select * from zepto

delete from zepto
where mrp=0;

--convert paise to rupees 

update zepto
set mrp=mrp/100.0,
discountedSellingPrice = discountedSellingPrice/100.0;


select mrp,discountedSellingPrice from zepto


-- Solve some Business problem

-- 	Q.1 Found top 10 best-value products based on discount percentage
select * from zepto
select  distinct name,mrp,discountPercent
from zepto
order by discountPercent
limit 10;

-- Q.2 Identified high-MRP products that are currently out of stock

select * from zepto
select distinct name,mrp
from zepto
where outofstock = True and mrp>300
order by mrp desc;

-- Q.3 Estimated potential revenue for each product category

select * from zepto
select category,
sum(discountedSellingprice * availablequantity) as total_revenue
group by category
order by total_revenue;
SELECT category,
SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto
GROUP BY category
ORDER BY total_revenue;

-- Q.4 Filtered expensive products (MRP > ₹500) with minimal discount is less than 10%.

select * from zepto

select * from zepto
where mrp>500 and discountpercent<10
order by mrp desc,discountpercent desc;

-- Q.5 Ranked top 5 categories offering highest average discounts

select * from zepto
select category,round(avg(discountpercent),2) as avg_discount
from zepto
group by category
order by avg_discount desc
limit 5;


-- Q.6 Calculated price per gram for products above 100g and sort to identify value-for-money products

select * from zepto
select distinct name,weightInGms,discountedSellingPrice,
round(discountedSellingPrice/weigthInGms,2) as price_per_gram
from zepto
where weightInGms>=100
order by price_per_gram;

-- Q.7 Grouped products based on weight into Low, Medium, and Bulk categories

select distinct name ,weightingms,
case when weightingms<1000 then 'Low'
     when weightingms<5000 then 'Medium'
     else 'Bulk'
	 end as weight_category
from zepto;


-- Q.8 what is the total inventory weight per product category

select * from zepto
select category,
sum(weightingms*availablequantity) as total_weight
from zepto
group by category
order by total_weight

-- Let's End this project
-- Thank you









