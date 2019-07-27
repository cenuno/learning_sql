-- Understanding Data Grouping
/* return the number of products offered by vendor DLL01 */
SELECT COUNT(*) AS num_prods
FROM products
WHERE vend_id = 'DLL01';

-- Creating Groups
/* grouping lets you divide data into logical sets so that you can perform
aggregate calculations on each group.


Groups are created using the GROUP BY clause in your SELECT statement.
It instructs the DBMS to group the data and then perform the aggregate
on each group rather than on the entire result set */
SELECT vend_id, COUNT(*) AS num_prods
FROM products
GROUP BY vend_id;

/*
    + GROUP BY clauses can contain as many columns as you want. This enables
      you to nest groups, providing you with more granular control over
      how data is grouped.

    + If you have nested groups in your GROUP BY clause, data is summarized
      at the last specified group. In other words, all the columns specified
      are evaluated together when grouping is established (so you won't get
      data back for each individual column level)

    + Every column listed in GROUP BY must be a retrieved column or a valid
      expression (but not an aggregate function). If an expression is used in
      the SELECT, that same expression must be specified in GROUP BY.
      Aliases cannot be used.

    + Most SQL implementations do not allow GROUP BY columns with variable
      length datatypes (such as text or memo fields)

    + Aside from the aggregate calculations statements, every column in your
      SELECT statement must be present in the GROUP BY clause

    + If the grouping column contains a row with a NULL value, NULL will be
      returned as a group. If there are multiple rows with NULL values,
      they'll all be grouped together.

    + The GROUP BY clause must come after any WHERE clause and before
      any ORDER BY clause
*/

-- Filtering Groups
/* WHERE has no idea what a group is. HAVING filters groups.

   WHERE filters before data is grouped and
   HAVING filters after data is grouped

   Rows that are eliminated by a WHERE clause will not be
   included in the group. This could change the calculated values which
   in turn could affect which groups are filtered based on the use of those
   values in the HAVING clause.

   Use HAVING only in conjunction with GROUP BY clauses.
   Use WHERE for standard row-level filtering.

   The syntas is identical; the keyword is different. */
SELECT cust_id, COUNT(*) AS orders
FROM orders
GROUP BY cust_id
HAVING COUNT(*) >= 2;

-- using WHERE and HAVING
/* HAVING filters groups with a count of 2 or more */
SELECT vend_id, COUNT(*) AS num_prods
FROM products
WHERE prod_price >= 4
GROUP BY vend_id
HAVING COUNT(*) >= 2;

/* note: without the WHERE clause an extra row would have been retrieved
   (vendor DLL01 who sells four products all priced under 4) */
SELECT vend_id, COUNT(*) as num_prods
FROM products
GROUP BY vend_id
HAVING COUNT(*) >= 2;

-- Grouping and Sorting
/* As a rule, anytime you use a GROUP BY clause, you should also
   specify an ORDER BY clause. That is the only way to ensure that data
   will be sorted properly. Never rely on GROUP BY to sort your data. */
SELECT order_num, COUNT(*) AS items
FROM order_items
GROUP BY order_num
HAVING COUNT(*) >= 3;

/* to sort the output by number of items ordered, all you need to do is
   add an ORDER BY clause, as follows: */
SELECT order_num, COUNT(*) AS items
FROM order_items
GROUP BY order_num
HAVING COUNT(*) >= 3
ORDER BY items, order_num;

-- SELECT clause ordering
/*
    clause        description                             required

    SELECT        columns or expressions to be returned   yes

    FROM          table to retrieve data from             only if selecting
                                                          data from a table

    WHERE         row level filtering                     no

    GROUP BY      group specification                     only if calculating
                                                          aggregates by group

    HAVING        group level filtering                   no

    ORDER BY      output sort order                       no
*/
