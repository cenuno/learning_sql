-- Understanding Subqueries
/* SELECT statements are SQL queries. All the SELECT statements we have
   seen thus far are simple queries: single statements retrieving data from
   individual database tables.

   SQL also enables you to create subqueries: queries that are embedded
   into other queries.
*/

-- Filtering by Subquery

/*
    The databse tables used in all the lessons in this book are relational.

    - orders are stored in two tables:
        + orders table stores a single row for each order containing
          order number, customer ID, and order date.

        + the individual order items are stored
          in the related order_items table

    - customers table stored customer information


    Now suppose you wanted a list of all customers who ordered item RGAN01.

    1. Retrieve the order numbers of all orders containing item RGAN01.

    2. Retrieve the customer ID of all the customers who have orders
       listed in the order numbers returned in the previous step.

    3. Retrieve the customer information for all the customer IDs
       retrieved in the previous step

    Each of these steps can be executed in a separate query. You can also
    use subqueries to combine all three queries into one single statement.
*/
SELECT order_num
FROM order_items
WHERE prod_id = 'RGAN01';

SELECT cust_id
FROM orders
WHERE order_num IN (20007, 20008);

SELECT cust_id
FROM orders
WHERE order_num IN (SELECT order_num
                    FROM order_items
                    WHERE prod_id = 'RGAN01');

SELECT cust_name, cust_contact
FROM customers
WHERE cust_id IN (SELECT cust_id
                  FROM orders
                  WHERE order_num IN (SELECT order_num
                                      FROM order_items
                                      WHERE prod_id = 'RGAN01'));

/* the code shown above works, and it achieves the desired result.
   however, using subqeuries is not always the most efficient way to
   preform this type of data retrieval. More on this in the 'joining tables'.
*/

-- Using Subqueries as Calculated Fields

/* Suppose you want to display the total number of orders placed by every
   customer in your customers table. Orders are stored in the orders table
   along with the appropriate customer ID.

   1. Retrieve the list of customers from the customers table;

   2. For each customer retrieved, count the number of associated
      orders in the orders table.
*/
SELECT cust_name,
       cust_state,
       (SELECT COUNT(*)
        FROM orders
        WHERE orders.cust_id = customers.cust_id) AS orders
FROM customers
ORDER BY cust_name;

/* the syntax table_name.column_name must be used whenever there is
   possible ambiguity about column names.

   Without fully qualifying the column names, the DBMS assumes
   you are comparing the cust_id in the orders table to itself.

   SELECT COUNT(*) FROM orders WHERE cust_id = cust_id

   will always return the total number of orders in the orders table, the
   result will not be what you expected.
*/
SELECT cust_name,
       cust_state,
       (SELECT COUNT(*)
        FROM orders
        WHERE cust_id = cust_id) AS orders
FROM customers
ORDER BY cust_name;

/* A good rule is that if you are ever working with more than one table in
   a SELECT statement, then use fully qualified column names to avoid any and
   all ambiguity
*/
