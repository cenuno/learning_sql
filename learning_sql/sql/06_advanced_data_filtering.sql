-- Combine WHERE clauses to create powerful and sophistacted search conditions
-- Using the AND operator
/* To filter by more than one column, you use the AND operator to append
conditions to your WHERE clause.

AND instructors the DBMS to return only rows that meet all the conditions */
SELECT prod_id, prod_price, prod_name
FROM products
WHERE vend_id = 'DLL01' AND prod_price <= 4;

-- Using the OR operator
/* The OR operator instructs DBMS to retrieve rows that match either condition
Most DBMS will not even evaluate the second condition in an OR WHERE clause
if the first condition has already been met */
SELECT prod_name, prod_price
FROM products
WHERE vend_id = 'DLL01' OR vend_id = 'BRS01';

-- Understanding Order of Evaluation
/* List all products costing $10 or more made by vendors DLL01 and BRS01 */
SELECT prod_name, prod_price, vend_id
FROM products
WHERE vend_id = 'DLL01' OR vend_id = 'BRS01' AND prod_price >= 10;

/* the rows in the query above returned results with prices less than $10

Why?

SQL (like most languages) processes AND operators before OR operators

It reads the query above like so:

"Any products costing $10 or more made by vendor BRS01
and
any products made by vendor DLL01 regardless or price"

Since AND ranks higher in the order of evaluation, the wrong operators
were joined together.

The solution is to use parentheses to explicitly group related operators
because paranethese have a higher order of evaluation than either
AND or OR oeprators.

The SQL statement then becomes:

"Any products made by either vendor DLL01 or vendor BRS01 costing $10 or more"
*/
SELECT prod_name, prod_price, vend_id
FROM products
WHERE (vend_id = 'DLL01' OR vend_id = 'BRS01') AND prod_price >= 10;

-- Using the IN operator
/* It is used to speicfy a range of conditions, any of which can be matched

IN takes a comma-delimited list of valid values, all enclosed
within paranetheses.
*/
SELECT prod_name, prod_price, vend_id
FROM products
WHERE vend_id IN ('DLL01', 'BRS01')
ORDER BY prod_name;

/*
IN operator accomplishes the same goal as the OR operator

The advantages of using IN are as follows:
    * when you are working with long lists of valid options, the IN
      operator syntas is far cleaner and easier to read
    * the order of evaluation is easier to manage when IN is used in
      conjunction with other AND and OR operators
    * IN operators almost always execute more quickly than lists of OR
      operators (although you'll not see any performance difference
      with very short lists like the ones we're using here)
    * the IN operator can contain another SELECT statement,
      enabling you to build highly dynamic WHERE clauses
      (known as subqueries)
*/

-- Using the NOT operator
/* NOT negates whatever condition comes next

Unlike other operators, the NOT keyword can be used before the column to
filter on, not just after it.

NOT is useful in more complex clauses, using NOT in conjunction with
an IN operator makes it simple to find all rows
that do match a list of criteria */
SELECT prod_name, vend_id
FROM products
WHERE NOT vend_id = 'DLL01'
ORDER BY prod_name;
