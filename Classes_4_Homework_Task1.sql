create database ecommerce; 
use ecommerce;
create table customers (
customer_id int auto_increment primary key unique, 
first_name varchar(50), 
last_name varchar(50), 
email varchar(100) unique, 
phone_number varchar(15));

insert into customers (customer_id, first_name, last_name, email, phone_number) value
(1, 'Anna', 'Kowalska', 'anna.kowalska@mail.com', '111222333'),
(2, 'Krzysztof', 'Ott', 'krzysztof.ott@mail.com', '222333444'),
(3, 'Piotr', 'Nowak', 'piotr.nowak@mail.com', '333444555'),
(4, 'Krystyna', 'Lesniewska', 'krystyna.lesniewska@mail.com','444555666'),
(5, 'Zofia', 'Zdunska', 'zofia.zdunska@mail.com', '555666777');

create table products (
product_id int auto_increment primary key, 
product_name varchar(100), 
price decimal(10,2), 
stock_quantity INT);

insert into products (product_id, product_name, price, stock_quantity) value
(10, 'Zeszyt', 5.0, 100),
(20, 'Dlugopis_czarny', 2.5, 200),
(30, 'Dlugopis_niebieski', 2.5, 200),
(40, 'Blok_ryskunkowy', 6.0, 300),
(50, 'Blok_techniczny', 6.5, 250),
(60, 'Farby', 15.0, 150),
(70, 'Plastelina', 12.0, 180),
(80, 'Kredki', 20.0, 210);

create table orders (
order_id int auto_increment primary key, 
customer_id int, 
order_date date, 
total_amount decimal(10,2),
constraint fk_customer foreign key(customer_id) references customers(customer_id));

insert into orders (order_id, customer_id, order_date, total_amount) values
(11, 5, '2024-08-08', 10),
(12, 5, '2024-07-08', 15),
(13, 4, '2024-01-20', 20),
(14, 4, '2024-08-01', 25),
(15, 3, '2024-08-07', 30),
(16, 3, '2024-08-08', 5),
(17, 2, '2024-02-20', 15),
(18, 2, '2024-02-21', 18),
(19, 1, '2024-03-03', 7),
(20,1, '2024-03-03', 30),
(21,1, '2024-08-06', 14);

create table order_items (
order_item_id int auto_increment primary key unique, 
order_id int, 
product_id int, 
quantity int, 
price decimal(10,2),
constraint fk_orders foreign key(order_id) references orders(order_id),
constraint fk_products foreign key(product_id) references products(product_id));

insert into order_items (order_item_id, order_id, product_id, quantity, price) values
(22, 11, 10, 10, 5.0),
(33, 12, 20, 20, 2.5),
(44, 13, 30, 30, 2.5),
(55, 14, 40, 35, 6.0),
(66, 15, 50, 50, 250),
(77, 16, 60, 18, 15.0),
(88, 17, 70, 25, 12.0),
(99, 18, 80, 130, 20.0),
(100, 19, 10, 33, 5.0),
(110, 20, 20, 40, 2.5),
(120, 21, 30, 10, 2.5);

start transaction;
insert into customers (customer_id, first_name, last_name, email, phone_number) values
(6, 'Joanna', 'Kowalczyk', 'joanna.kowalczyk@mail.com', 999000222);
insert into products (product_id, product_name, price, stock_quantity) value
(90, 'mazaki', 13.5, 170);
insert into orders (order_id, customer_id, order_date, total_amount) values
(22, 6, '2023-12-13', 10);
insert into order_items (order_item_id, order_id, product_id, quantity, price) values
(130, 22, 90, 10, 13.5);
commit;


