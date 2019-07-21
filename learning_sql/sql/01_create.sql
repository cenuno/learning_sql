-----------------------------------------------
-- Sams Teach Yourself SQL in 10 Minutes
-- http://forta.com/books/0672336073/
-- Example table creation scripts for PostgreSQL.
-------------------------------------------------

-------------------------
-- Create customers table
-------------------------
CREATE TABLE customers
(
  cust_id      char(10)  NOT NULL ,
  cust_name    char(50)  NOT NULL ,
  cust_address char(50)  ,
  cust_city    char(50)  ,
  cust_state   char(5)   ,
  cust_zip     char(10)  ,
  cust_country char(50)  ,
  cust_contact char(50)  ,
  cust_email   char(255)
);

--------------------------
-- Create order_items table
--------------------------
CREATE TABLE order_items
(
  order_num  int          NOT NULL ,
  order_item int          NOT NULL ,
  prod_id    char(10)     NOT NULL ,
  quantity   int          NOT NULL ,
  item_price decimal(8,2) NOT NULL
);

----------------------
-- Create orders table
----------------------
CREATE TABLE orders
(
  order_num  int      NOT NULL ,
  order_date date     NOT NULL ,
  cust_id    char(10) NOT NULL
);

------------------------
-- Create products table
------------------------
CREATE TABLE products
(
  prod_id    char(10)      NOT NULL ,
  vend_id    char(10)      NOT NULL ,
  prod_name  char(255)     NOT NULL ,
  prod_price decimal(8,2)  NOT NULL ,
  prod_desc  varchar(1000) NULL
);

-----------------------
-- Create vendors table
-----------------------
CREATE TABLE vendors
(
  vend_id      char(10) NOT NULL ,
  vend_name    char(50) NOT NULL ,
  vend_address char(50) NULL ,
  vend_city    char(50) NULL ,
  vend_state   char(5)  NULL ,
  vend_zip     char(10) NULL ,
  vend_country char(50) NULL
);


----------------------
-- Define primary keys
----------------------
ALTER TABLE customers ADD PRIMARY KEY (cust_id);
ALTER TABLE order_items ADD PRIMARY KEY (order_num, order_item);
ALTER TABLE orders ADD PRIMARY KEY (order_num);
ALTER TABLE products ADD PRIMARY KEY (prod_id);
ALTER TABLE vendors ADD PRIMARY KEY (vend_id);


----------------------
-- Define foreign keys
----------------------
ALTER TABLE order_items ADD CONSTRAINT FK_order_items_orders FOREIGN KEY (order_num) REFERENCES orders (order_num);
ALTER TABLE order_items ADD CONSTRAINT FK_order_items_products FOREIGN KEY (prod_id) REFERENCES products (prod_id);
ALTER TABLE orders ADD CONSTRAINT FK_orders_customers FOREIGN KEY (cust_id) REFERENCES customers (cust_id);
ALTER TABLE products ADD CONSTRAINT FK_products_vendors FOREIGN KEY (vend_id) REFERENCES vendors (vend_id);