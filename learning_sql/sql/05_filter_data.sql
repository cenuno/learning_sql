-- Using the WHERE clause
-- Retrieving just the data you want involves specifying search criteria
-- which is also known as a filter condition
-- Note: when using both ORDER BY and WHERE clauses, make sure that
--       ORDER BY comes after WHERE, otherwise an error will appear
SELECT prod_name, prod_price
FROM products
WHERE prod_price = 3.49;

-- The WHERE clause operators
-- Note: some operators are redudnant and not supported by all DBMS
/* operator     description
    =           equality
    <>          non-equality
    !=          non-equality
    <           less than
    <=          less than or equal to
    !<          not less than
    >           greater than
    >=          greater than or equal to
    !>          not greater than
    BETWEEN     between two specified values
    IS NULL     is a NULL value */

-- Checking Against a Single Value
-- all products that cost less than $10
SELECT prod_name, prod_price
FROM products
WHERE prod_price < 10;

-- Checking for Nonmatches
-- all products not made by vendor DLL01
-- Note: the use of single quotes ('') to capture text is a requirement
SELECT vend_id, prod_name
FROM products
WHERE vend_id <> 'DLL01';

-- Checking for a Range of Values
-- Note: BETWEEN requires a beginning and end range (inclusive)
--       separated by the AND keyword
SELECT prod_name, prod_price
FROM products
WHERE prod_price BETWEEN 5 AND 10;

-- Checking for No Value (i.e NULL)
-- Note: NULL is literally no value, as opposed to a field containing 0,
--       an empty string ('') or just spaces ('     ')
SELECT prod_name
FROM products
WHERE prod_price IS NULL;

SELECT cust_name
FROM customers
WHERE cust_email IS NULL;
