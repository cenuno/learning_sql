-- Using aggregate functions
/*
    - Determining the number of rows in a table (or the number of rows
      that meet some conditions or contain a specific value)

    - Obtaining the sum of a set of rows in a table

    - Finding the highest, lowest, and average values in a table column

Each of these tasks requires a summary of the data in a table, not the
actual data itself. SQL has five aggregate functions which enable you
to perform all the types of retrieval just enumerated.

Fortunately, SQL's aggregate functions are portable.

  function      description

  AVG()         return a column's average value

  COUNT()       returns the number of rows in a column

  MAX()         returns a column's highest value

  MIN()         returns a column's lowest value

  SUM()         returns the sum of a column's value
*/

-- The AVG() function
/* return the average price of all the products in the products table */
SELECT AVG(prod_price) AS avg_price
FROM products;

/* returns the average price of products offered by a specific vendor */
SELECT AVG(prod_price) AS avg_price
FROM products
WHERE vend_id = 'DLL01';

/* AVG() may only be used to determine the average of a specific
   numeric column. To obtain the average value of multiple columns,
   multiple AVG() functions must be used.

   The exception to this is when returning a single value that is
   calculated from multiple columns
*/

-- The COUNT() function
/* use COUNT() to determine the number of rows in a table or the number
   of rows in a table or the number of rows that match a specific
   criterion.

    + use COUNT(*) to the count the number of rows in a table,
      whether columns contain values or NULL values

    + use COUNT(column) to count the number of rows that have values
      in a specific column, ignoring NULL values
*/
SELECT COUNT(*) as num_cust
FROM customers;  -- returns all rows, regardless of values

SELECT COUNT(cust_email) AS num_cust
FROM customers;  -- returns only non NULL values

-- The MAX() function
SELECT MAX(prod_price) AS max_price
FROM products;

-- The MIN() function
SELECT MIN(prod_price) AS min_price
FROM products;

-- The SUM() function
SELECT SUM(quantity) AS items_ordered
FROM order_items
WHERE order_num = 20005;

SELECT SUM(item_price * quantity) AS total_price
FROM order_items
WHERE order_num = 20005;

-- Aggregates on Distinct Values
SELECT AVG(DISTINCT prod_price) AS avg_price
FROM products
WHERE vend_id = 'DLL01';

-- Combining Aggregate Functions
SELECT COUNT(*) AS num_items,
       MIN(prod_price) AS price_min,
       MAX(prod_price) AS price_max,
       AVG(prod_price) AS price_avg
FROM products;
