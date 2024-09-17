DELIMITER //

create procedure AddCustomerAndOrder(
IN p_customer_id INT,
IN p_first_name varchar(50), 
IN p_last_name varchar(50), 
IN p_email varchar(100), 
IN p_phone_number varchar(15),
IN p_order_id INT,
IN p_order_date date, 
IN p_order_item_id INT,
IN p_product_id int, 
IN p_quantity int)

BEGIN
DECLARE p_total_amount DECIMAL(10, 2);
DECLARE p_product_price DECIMAL(10, 2);
DECLARE p_customer_id INT;

START TRANSACTION;
Insert into customers (customer_id, first_name, last_name, email, phone_number) values
(p_customer_id, p_first_name, p_last_name, p_email, p_phone_number);

SET p_customer_id = customer_id +1 ;
Select price into p_product_price 
from products
where product_id=p_product_id;

IF p_product_price is null then
Select 'Product does not exist';
rollback;

ELSE
SET p_total_amount = p_product_price * p_quantity;

INSERT INTO orders (order_id, customer_id, order_date, total_amount) values
(p_order_id, p_customer_id, p_order_date, p_total_amount);

SET @p_order_id = order_id +1;

INSERT INTO order_items (order_item_id, order_id, product_id, quantity, price) values
(p_order_item_id, p_order_id, p_product_id, p_quantity,p_price);

COMMIT;
END IF;
END //

DELIMITER ;



CALL AddCustomerAndOrder (10, 'Krystian', 'Por', 'krystian.por@mail.com', 801295333, 26, '2024-04-13', 140, 40, 30);

CALL AddCustomerAndOrder (10, 'Krystian', 'Pot', 'krystian.pot@mail.com', 801295303, 26, '2024-04-13', 140, 990, 30);
