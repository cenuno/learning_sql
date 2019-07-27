-- Understanding Relational Tables

/*
    Having multiple occurrences of the same data is never a good thing,
    and that principle is the basis for relational database design.

    Relational tables are designed so that information is split into
    multiple tables, one for each data type. The tables are related
    to each other through common values (and thus relational).

    Each table has a primary key, a column which serves as a uniquie identifer.

    Relational data can be stored efficiently and manipulated easily. Because
    of this, relational databases scale far better than non-relational
    databases.

    Scale: able to handle an increasing load without failing. A well-designed
    database or application is said to scale well.
*/

-- Why use Joins?

/* Breaking data into multiple tables enables more efficient storage,
   easier manipulation, and greater scalibility. But these benefits come
   with a price.

   Using a special syntax, multiple tables can be joined so that
   a single set of output is returned, and the join associates the correct
   rows in each table on-the-fly.
*/

-- Creating a Join
/* You must specify all the tables to be included and how they are related
   to each other. */
SELECT vend_name, prod_name, prod_price
FROM vendors, products
WHERE vendors.vend_id = products.vend_id;

-- The importance of the WHERE clause
/*
   It might seem strange to use a WHERE clause to set the join relationship,
   but actually, there is a very good reason for this. Remember, when tables
   are joined in a SELECT statement, that relationship is constructed
   on-the-fly.

   When you join two tables, what you are actually doing is pairing every
   row in the first table with every row in the second table.

   The WHERE clause acts as a filter to only include rows that match the
   specified filter condition - the join condition, in this case.

   Without the WHERE clause, every row in the first table will be paired
   with every row in the second table, regardless of if they logically go
   together or not.
*/

-- Cartesian Product/Cross Joins:
/* results returned by a table relationship without a join condition.
   the number of rows retrieved will be the number of rows in the first
   table multiplied by the number of rows in the second table.
SELECT vend_name, prod_name, prod_price
FROM vendors, products;
*/

-- Inner Joins / Equijoin:
/*
    a join based on the testing of equality between two tables. This kind of
    join is also called an inner join.
*/
SELECT vend_name, prod_name, prod_price
FROM vendors INNER JOIN products
  ON vendors.vend_id = products.vend_id;

/* per ANSI SQL specifications, use of the INNER JOIN syntax is preferred
   over the simple equijoins syntax used previously */

-- Joining Multiple Tables
/*
  The following display the items in order number 20007.

  Order items are stored in the order_items table. Each product is stored
  by its product ID, which refers to a product in the products table.

  The products are linked to the appropriate vendor in the vendors table
  by the vendor ID, which is stored with each product record.

  The FROM clause here lists the three tables, and the WHERE/INNER JOIN
  clause defines both of those join conditions.

  An additional WHERE condition is then used to filter just the items
  for order 20007.
*/
SELECT prod_name, vend_name, prod_price, quantity
FROM order_items, products, vendors
WHERE products.vend_id = vendors.vend_id
  AND order_items.prod_id = products.prod_id
  AND order_num = 20007;

SELECT prod_name, vend_name, prod_price, quantity
FROM order_items
  INNER JOIN products
    ON order_items.prod_id = products.prod_id
  INNER JOIN vendors
    ON products.vend_id = vendors.vend_id
WHERE order_num = 20007;

/*
   Performance considerations:

   DBMS process joins at run-time relating each table as specified.

   This process can become very resource tensenvie so be careful
   not to join tables unnecessarily. The more tables you join the more
   performance will degrade.

   Check in with your DBMS documentation for the max number of tables in
   a join.

   Let's revist the following subquery example from Lesson 11:
   12_subqueries.sql with the three nested subqueries

   There is rarely a definitive right or wrong way to perform a SQL operation.

   DBMS being used, the amount of data in the tables, whether or not indexes
   and keys are present, and a whole slew of other criteria. Therefore, it is
   often worth experimenting with different selection mechanisms to find
   the one that works best for you.
*/
SELECT cust_name, cust_contact
FROM customers
  INNER JOIN orders
    ON customers.cust_id = orders.cust_id
  INNER JOIN order_items
    ON orders.order_num = order_items.order_num
WHERE prod_id = 'RGAN01';
