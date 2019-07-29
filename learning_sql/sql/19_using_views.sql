-- Understanding Views
/*
  Views are virtual tables. Unlike tables that contain data, views
  simply contain queries that dynamically retrieve data when used.
*/
SELECT cust_name, cust_contact
FROM customers AS c
  INNER JOIN orders as o
    ON c.cust_id = o.cust_id
  INNER JOIN order_items as oi
    ON o.order_num = oi.order_num
WHERE prod_id = 'RGAN01';

/*
    That query was used to retrieve the customers who had ordered a specific
    product. Anyone needing this data would have to understand the table
    structure, as well as how to create the query and join the tables.

    To retrieve the same data for another product (or for multiple products)
    the last WHERE clause would have to be modified.

    Now imagine that you could wrap that entire query in a virtual table
    called product_customers. You could then simply do the following to
    retrieve the same data:

    SELECT cust_name, cust_contact
    FROM product_customers
    WHERE prod_id = 'RGAN01';
*/

-- Why Use Views
/*
    + reuse SQL statements

    + simply complex SQL operations. After the query is written,
      it can be reused easily, without having to know the details of the
      underlying query itself.

    + to expose parts of a table instead of complete tables.

    + to secure data. users can be given access to specific subsets of tables
      instead of to entire tables.

    + to change data formatting and representation. Views can return
      data formatted and presented differently from their underlying tables.

    + Views contain no data themselves, so the data they return is retrieved
      from other tables. When data is added or changed in those tables, the
      views will return that changed data.

    + Views can be used in the same way as tables. You can perform SELECT
      operations, filter and sort data, join views to ther views or tables,
      and possibly even add and update data.

    + Be wary of using views when deploying applications. They'll need to
      retrieve the underlying data each they they are used.
*/

-- View Rules and Restrictions

/*
    + Like tables, views must be uniquely named (they cannot be named
      with the name of any other table or view)

    + there is no limit to the number of views that can be created.

    + to create views, you must have security access.

    + Views can be nested; that is, a view may be built using a query that
      retrieves data from another view. The exact number of nested levels
      allowed varies amongst DBMS. Note that nesting lowers performance speed.

    + Many DBMSs prohibit the use of the ORDER BY clause in view queries.

    + Some DBMSs require that every column returned be named - this will
      require the use of aliases if columns are calculated fields.

    + Views cannot be indexed nor can they have triggers or default values
      associated with them.

    + Some DBMSs treat views as read-only queries - meaning you can retrieve
      data from views but not write data back to the underlying tables.

    + Some DBMSs allow you to create views that do not allow rows to be
      inserted or updated if that insertion or update will caluse that row to
      no longer be part of the view.
*/

-- Creating Views

/* Views are created using the CREATE VIEW statement. Like CREATE TABLE,
   CREATE VIEW can only be used to create a view that does not exist.

   Renaming Views:

   To remove a view, the DROP statement is used. The syntax is simply
   DROP VIEW viewname;.

   To overwrite (or update) a view you must first DROP it and then
   recreate it.
*/

-- Using Views to Simplify Complex Joins
/* One of the most common uses of views is to hide complex SQL, and this
   often involves joins. */
CREATE VIEW product_customers AS
SELECT cust_name, cust_contact
FROM customers AS c
  INNER JOIN orders as o
    ON c.cust_id = o.cust_id
  INNER JOIN order_items as oi
    ON o.order_num = oi.order_num;

SELECT *
FROM product_customers;

-- Using Views to Reformat Retrieved Data
SELECT RTRIM(vend_name) || ' (' || RTRIM(vend_country) || ')' AS vend_title
FROM vendors
ORDER BY vend_name;

CREATE VIEW vendor_locations AS
SELECT RTRIM(vend_name) || ' (' || RTRIM(vend_country) || ')' AS vend_title
FROM vendors;

SELECT *
FROM vendor_locations;

-- Using Views to Filter Unwanted Data
CREATE VIEW customer_email_list AS
SELECT cust_id, cust_name, cust_email
FROM customers
WHERE cust_email IS NOT NULL;

SELECT *
FROM customer_email_list;

-- Using Views with Calculated Fields
/* Views are exceptionally useful for
   simplifying the use of calculated fields. */
CREATE VIEW order_items_expanded AS
SELECT order_num,
       prod_id,
       quantity,
       item_price,
       quantity * item_price AS expanded_price
FROM order_items;

SELECT *
FROM order_items_expanded
WHERE order_num = 20008;
