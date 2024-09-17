

-- Task 1
use kurs_sql;

create table Sales (
sales_id int primary key AUTO_INCREMENT,
product_id int not null,
product_name varchar(50) not null,
date_of_sales date,
quantity int,
costs int,
sales_total int);

-- Task 2
Insert into Sales (sales_id, product_id, product_name, date_of_sales, quantity, costs, sales_total) value
(01, 1, 'Koszula', '2024-08-01', 2, 100.00, 200.00),
(02, 2, 'Tshirt', '2024-07-20', 3, 40.00, 120.00),
(03, 3, 'Spodenki', '2024-07-01', 1, 110.00, 110.00),
(04, 4, 'Sukienka', '2024-05-15', 1, 199.00, 199.00),
(05, 5, 'Skarpetki', '2024-01-28', 5, 20.00, 100.00),
(06, 2, 'Tshirt', '2023-07-20', 3, 35.00, 105.00),
(07, 5, 'Skarpetki', '2024-01-18', 5, 20.00, 100.00),
(08, 1, 'Koszula', '2023-08-01', 2, 110.00, 220.00),
(09, 4, 'Sukienka', '2024-08-15', 1, 189.00, 189.00),
(10, 3, 'Spodenki', '2024-07-02', 1, 110.00, 110.00),
(11, 6, 'Klapki', '2024-07-10', 2, 99.00, 198.00),
(12, 7, 'Bluza', '2023-12-31', 3, 100.00, 300.00),
(13, 6, 'Klapki', '2024-02-10', 1, 55.00, 110.00),
(14, 7, 'Bluza', '2023-11-16', 1, 95.00, 95.00);

-- Task 3 Display a ranking of products based on total sales in descending order
Select distinct product_name, sum(quantity) as sold_quantity
from sales
group by product_name
order by sum(quantity) desc;

-- Task 4 Display sales data along with the sales difference between the current and previous transaction.
select product_name, costs, lag(costs) over (partition by product_name order by date_of_sales) as costs_difference
from sales
order by product_name;

-- zapytać o to ziomka
select product_name, row_num(1) - row_num(2) as costs_difference
from (select product_name, costs, row_number() over(partition by product_name order by costs) as row_num
from sales) as a
order by product_name;

-- Task 5 Calculate the average monthly sales for each product.
select product_name, month(date_of_sales) as sales_month, year(date_of_sales) as sales_year, avg(sales_total) as avg_sales
from sales
group by product_name, year(date_of_sales), month(date_of_sales)
order by month(date_of_sales);

-- Task 6 Write an SQL query that will find the best sales day for each product, i.e., the day with the highest sales value.
Select product_name, date_of_sales, max(sales_total)
from sales
group by product_name, date_of_sales;

-- Task 7 Calculate the cumulative sum of sales for each product to see how total sales change over time.
select product_name, month(date_of_sales) as sales_month, year(date_of_sales) as sales_year, sum(sales_total) as sum_sales
from sales
group by product_name, year(date_of_sales), month(date_of_sales)
order by product_name;

-- Task 8 Find the products that had the largest and smallest differences in sales between consecutive transactions.
select product_name, max_sales - min_sales as sales_difference
from (select product_name, max(sales_total) as max_sales, min(sales_total) as min_sales
from sales
group by product_name) as a
order by max_sales - min_sales desc;

