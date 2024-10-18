-- Exercise 1
create table archived_orders (
order_id int auto_increment primary key,
customer_id int, 
order_date date,
total_amount decimal(10,2),
archived_date date);

delimiter //
create event OrdersOlderThanOneYear
on schedule every 1 minute
starts current_timestamp
do
begin
insert into archived_orders (order_id, customer_id, order_date, total_amount, archived_date)
values (new.order_id, new.customer_id, new.order_date, new.total_amount, now());
select order_id , customer_id, order_date, total_amount
from orders
where order_date < curdate() - interval 1 year ;
delete from orders 
where order_date < curdate() - interval 1 year ;
end;
//
delimiter ; 

show events;
drop event OrdersOlderThanOneYear;

-- Exercise 2 

use ecommerce;

DELIMITER //
CREATE TRIGGER UpdateStockAfterOrder
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    UPDATE products p
    JOIN order_items oi ON p.product_id = oi.product_id
    SET p.stock_quantity = p.stock_quantity - oi.quantity
    WHERE oi.order_id = NEW.order_id
      AND p.stock_quantity >= oi.quantity;
      
    INSERT INTO stock_logs (product_id, order_id, current_stock, ordered_quantity, log_time)
    SELECT oi.product_id, NEW.order_id, p.stock_quantity, oi.quantity, NOW()
    FROM products p
    JOIN order_items oi ON p.product_id = oi.product_id
    WHERE oi.order_id = NEW.order_id
      AND p.stock_quantity < oi.quantity;
END;
//
delimiter ; 

-- Exercise 3
create table notifications (
 notification_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    notification_text VARCHAR(255),
    email_sent TINYINT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);


DELIMITER //
CREATE PROCEDURE LowStockNotification ()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE product_id INT;
    DECLARE product_name VARCHAR(255);
    DECLARE stock_quantity INT;
    DECLARE email_subject VARCHAR(255);
    DECLARE email_body TEXT;
    DECLARE email_status VARCHAR(50);
    DECLARE email_error TEXT;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    DECLARE low_stock_cursor CURSOR FOR
        SELECT product_id, product_name, stock_quantity
        FROM products
        WHERE stock_quantity < 10;

    OPEN low_stock_cursor;

    read_loop: LOOP
        FETCH low_stock_cursor INTO product_id, product_name, stock_quantity;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SET email_subject = CONCAT('Low Stock Alert: ', product_name);
        SET email_body = CONCAT('The stock for ', product_name, ' (Product ID: ', product_id, ') is below 10 units. Current stock is: ', stock_quantity, ' units.');

        BEGIN
            DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
            BEGIN
                SET email_status = 'failure';
                SET email_error = 'Email sending failed.';
            END;

            CALL send_email('admin@example.com', email_subject, email_body);
            SET email_status = 'success';
            SET email_error = NULL;
        END;

        INSERT INTO notifications (notofication_id, product_id, notification_text, email_sent, created_at)
        VALUES (product_id, product_name, stock_quantity, email_status, email_error);
    END LOOP;

    CLOSE low_stock_cursor;
END $$

DELIMITER ;








