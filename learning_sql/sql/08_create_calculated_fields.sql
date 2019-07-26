-- Understanding Calculated Feilds

/* data stored in the table is not exactly what your application needs.

Rather than retrieve the data as it is, and then reformt it within your
client application or report, what you really want is to retrieve
converted, calculated, or reformmated data directly from the database.

As a rule, it is far quicker to perform these operations on the database
server than it is to perform them within the client */

-- Concatenating Fields
/* create a title that is made up of two columns

The vendors table contains vendor name and address information so that
it was retrieved like so: name (location).

Note: depending on the DBMS, you'll use + or || */
SELECT vend_name || ' (' || vend_country || ')'
FROM vendors
ORDER BY vend_name;

/* Two two columns that are incorporated into the calculated field
are padded with spaces.

To return the data formatted properly, you must trim those padded spaces.

RTRIM = right trim;
LTRIM = left trim;
TRIM = left + right trim */
SELECT RTRIM(vend_name) || ' (' || RTRIM(vend_country) || ')'
FROM vendors
ORDER BY vend_name;

-- Using Aliases
/* an alias is just an alterate name for a field or value, assigned with the
AS operator.

While it is optional, using it is considered best practice! */
SELECT RTRIM(vend_name) || ' (' || RTRIM(vend_country) || ')' AS vend_title
FROM vendors
ORDER BY vend_name;

-- Performing mathematical calculations
SELECT prod_id, quantity, item_price
FROM order_items
WHERE order_num = 20008;

/* item_price contains the per unit price for each item in an order.

To expand the item price such that it multiples the price by quantity,
you do the following: */
SELECT prod_id,
       quantity,
       item_price,
       quantity * item_price AS expanded_price
FROM order_items
WHERE order_num = 20008;

/* SQL math operators:

operator      description
  +             addition
  -             subtraction
  *             multiplication
  /             division

  SELECT provides a great way to test and experiment with functions
  and calculations. The FROM clause may be omitted to simply access and
  work with expressions. */
SELECT 3 * 2 AS calculation;  -- returns 6
SELECT TRIM('   abc   ') AS clean_text;  -- returns 'abc'
SELECT NOW() AS time_stamp;  -- returns the current date and time

/*  Use SELECT to experiment as needed! */
