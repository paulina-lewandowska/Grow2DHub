-- Exercise 1

use ecommerce;

DELIMITER //
create trigger AutomaticUpdateTotalOrderAmount
after insert on orders
for each row 
begin
insert into orders (order_id, customer_id, order_date, total_amount)
values (new.order_id, new.customer_id, new.order_date, new.total_amount);
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
after insert on orders
for each row
begin
insert into audit_log (order_id, customer_id, order_date, total_amount, change_date, change_type)
values (new.order_id, new.customer_id, new.order_date, new.total_amount, now(), 'Insert');
end;
//
DELIMITER ;

delimiter //
create trigger DataAuditingUpdate
after update on orders
for each row
begin
insert into audit_log (order_id, customer_id, order_date, total_amount, change_date, change_type)
values (new.order_id, new.customer_id, new.order_date, new.total_amount, now(), 'Update');
end;
//
DELIMITER ;

delimiter //
create trigger DataAuditingDelete
after delete on orders
for each row
begin
insert into audit_log (order_id, customer_id, order_date, total_amount, change_date, change_type)
values (old.order_id, old.customer_id, old.order_date, old.total_amount, now(), 'Delete');
end;
//
DELIMITER ;
