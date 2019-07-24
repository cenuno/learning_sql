-- Explicitly sort data retrieved using a SELECT statement by using the
-- ORDER BY clause.
-- Note: the default is ascending order (i.e. A-Z, 1-infinity)
-- Note: be sure that ORDER BY clause is the last clause
-- Note: it is valid to sort data by a column that is not retreived
SELECT prod_name
FROM products
ORDER BY prod_name;

-- Sorting by Multiple Columns
SELECT prod_id, prod_price, prod_name
FROM products
ORDER BY prod_price, prod_name;

-- Sorting by Column Position
-- Note: not recommended to do this at all given that column position
--       is never guaranteed to be the same during the lifespan of a table
SELECT prod_id, prod_price, prod_name
FROM products
ORDER BY 2, 3;

-- Specifying Sort Direction
-- Requires the use of the keyword DESC (i.e. Z-A, infinity-1)
SELECT prod_id, prod_price, prod_name
FROM products
ORDER BY prod_price DESC;

-- But what if we wish to sort by multiple columns?
-- Note: only those columns that end with the DESC keyword will be sorted
--       from Z-A; without DESC, they will be sorted from A-Z
SELECT prod_id, prod_price, prod_name
FROM products
ORDER BY prod_price DESC, prod_name;