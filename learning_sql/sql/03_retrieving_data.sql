/* SELECT requires two pieces of information:
      1. what you want to select; and
      2. where you want to select it from. */

-- Retrieving Individual Columns
-- Note: this will return all of the data and it will not be sorted
SELECT prod_name
FROM products;

-- Retrieving Multiple Columns
-- Note: separate columns via comma
SELECT prod_id, prod_name, prod_price
FROM products;

-- Retrieving All Columns
/* Three notes about the use of the wildcard (*):
      1. May save your time and effort needed to list the desired columns; but
      2. Retreiving unnecessary columns usually slows down the performance
         of your retrieval and your application; and
      3. Possible to retrieve columns whose names are unknown. */
SELECT *
FROM products;

-- Retrieving Distinct Rows
/* At the moment, this returns 9 records because there are 9 products
   associated with these 3 vendors */
SELECT vend_id
FROM products;

/* Use DISTINCT to only return unique records from a particular column */
SELECT DISTINCT vend_id
FROM products;

-- Limit Results
SELECT prod_name
FROM products
LIMIT 5;
