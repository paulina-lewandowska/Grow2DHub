use ecommerce;

DELIMITER //
start transaction;
insert into customers (customer_id, first_name, last_name, email, phone_number) values
(10, 'Katarzyna', 'Sus', 'katarzyna@mail.com', 222555888);
savepoint before_order;
insert into orders (order_id, customer_id, order_date, total_amount) values
(23, 7, '2023-10-19', 10);
insert into order_items (order_item_id, order_id, product_id, quantity, price) values
(140, 27, 18, 15, 10.0);
if product_id = 18 then
	select 'Product does not exist'; 
	rollback;
else
	release savepoint before_order;
commit;
end;
//
DELIMITER ;

