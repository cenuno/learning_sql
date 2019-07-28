-- Using Table Aliases
/*
    Use table aliases for two reasons:
    1. shorten SQL syntax;
    2. enable multiple uses of the same table within a single SELECT statement

    Table aliases are only used during query execution. Unlike column aliases,
    table aliases are never returned to the client.
*/
SELECT cust_name, cust_contact
FROM customers as c
  INNER JOIN orders as o
    ON  c.cust_id = o.cust_id
  INNER JOIN order_items as oi
    ON o.order_num = oi.order_num
WHERE prod_id = 'RGAN01';

-- Using Different Join Types

-- Self Joins: refer to the same table more than once
/*
  Suppose you wanted to send a mailing to all the customer contacts
  who work for the same company for which Jim Jones works. This query
  requires that you first find out which company Jim Jones work for,
  and next which customers work for that company.
*/
SELECT c1.cust_id, c1.cust_name, c1.cust_contact
FROM customers AS c1
  INNER JOIN customers AS c2
    ON c1.cust_name = c2.cust_name
WHERE c2.cust_contact = 'Jim Jones';

-- Natural Joins
SELECT c.*,
       o.order_num,
       o.order_date,
       oi.prod_id,
       oi.quantity,
       oi.item_price
FROM customers AS c
  INNER JOIN orders as o
    ON c.cust_id = o.cust_id
  INNER JOIN order_items as oi
    ON o.order_num = oi.order_num
WHERE prod_id = 'RGAN01';

-- Outer Joins
-- You want to include rows that have no related rows
SELECT c.cust_id, o.order_num
FROM customers AS c
  INNER JOIN orders AS o
    ON c.cust_id = o.cust_id
ORDER BY c.cust_id;

SELECT c.cust_id, o.order_num
FROM customers AS c
  LEFT OUTER JOIN orders AS o
    ON c.cust_id = o.cust_id
ORDER BY c.cust_id;

/* When using OUTER JOIN syntax, you must use the RIGHT or LEFT keywords to
   specify the table from which to include all rows. */
SELECT c.cust_id, o.order_num
FROM customers AS c
  RIGHT OUTER JOIN orders AS o
    ON c.cust_id = o.cust_id
ORDER BY c.cust_id;

/* the variant is full outer join that retrieves all rows from both tables
   and relates those that can be related */
SELECT c.cust_id, o.order_num
FROM orders AS o
  FULL OUTER JOIN customers AS c
    ON c.cust_id = o.cust_id;

-- Using Joins with Aggregate Functions
SELECT c.cust_id,
       COUNT(o.order_num) AS num_ord
FROM customers AS c
  INNER JOIN orders AS o
    ON c.cust_id = o.cust_id
GROUP BY c.cust_id
ORDER BY c.cust_id;

SELECT c.cust_id,
       COUNT(o.order_num) AS num_ord
FROM customers AS c
  LEFT OUTER JOIN orders AS o
    ON c.cust_id = o.cust_id
GROUP BY c.cust_id
ORDER BY c.cust_id;
