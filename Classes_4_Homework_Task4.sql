-- Exercise 1

use ecommerce;

DELIMITER //
create trigger AutomaticUpdateTotalOrderAmount
after update on orders
for each row 
begin
	UPDATE orders 
    SET total_amount=(
		select sum(p.price * o.total_amount)
		from orders as o
		join order_items as oi on oi.order_id = o.order_id
		join products as p on oi.product_id = p.product_id
		WHERE oi.order_id = new.order_id)
	where order_id = new.order_id;
end;
//
DELIMITER ;

-- Exercise 2

DELIMITER //
create trigger EnsureSufficientStock
before insert on order_items
for each row
begin
declare stock_quantitity_available int;
select stock_quantity into stock_quantitity_available
from products
where product_id= new.product_id;

if stock_quantitity_available < new.quantity then
signal sqlstate '45000'
SET MESSAGE_TEXT = 'Insufficient Stock';
end if;
end;
// delimiter ;

-- Exercise 3

create table audit_log (
audit_id int auto_increment primary key,
order_id int,
customer_id int,
order_date date, 
total_amount decimal(10,2),
change_date date,
change_type varchar(50));

delimiter //
create trigger DataAuditingInsert
after insert or update or delete on orders
for each row
begin
if (new.order_id is not null and old.order_id is null) then
insert into audit_log (order_id, customer_id, order_date, total_amount, change_date, change_type)
values (new.order_id, new.customer_id, new.order_date, new.total_amount, now(), 'Insert');
end if;
if (new.order_id is not null and old.order_id is not null) then
insert into audit_log (order_id, customer_id, order_date, total_amount, change_date, change_type)
values (new.order_id, new.customer_id, new.order_date, new.total_amount, now(), 'Update');
end if;
if (old.order_id is not null and new.order_id is null) then
insert into audit_log (order_id, customer_id, order_date, total_amount, change_date, change_type)
values (new.order_id, new.customer_id, new.order_date, new.total_amount, now(), 'Delete');
end if;
end;
//
DELIMITER ;

