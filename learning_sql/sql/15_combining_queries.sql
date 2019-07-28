-- Understanding Combined Queries

/* SQL enables you to perform mutliple queries (multiple SELECT statements)
   and retun the results as a single query result set. These combined queries
   are usually known as unions or compound queries.

   1. Return similarly structured data from different tables in a single query

   2. Perform multiple queries against a single table returning the data
      as one query.
*/

-- Creating Combined Queries
/* SQL queries are combined using the UNION operator. Using UNION, multiple
   SELECT statements can be specified, and their results can be combined
   into a single result set.
*/

-- Using UNION
/* Need a report on all customers in IL, IN, and MI. You also want to include
   all Fun4All locations, regardless of state. Of course, you can create a
   WHERE clause that will do this, but this time you'll use a UNION instead
*/
SELECT cust_name, cust_contact, cust_email
FROM customers
WHERE cust_state IN ('IL', 'IN', 'MI');

SELECT cust_name, cust_contact, cust_email
FROM customers
WHERE cust_name = 'Fun4All';

/* the first SELECT retrieves all rows in IL, IN, and MI by passing those
   state abbreviations to the IN clause. The second SELECT uses a simple
   equality test to find all Fun4All locations.

   To combine these two statements, do the following:
*/
SELECT cust_name, cust_contact, cust_email
FROM customers
WHERE cust_state IN ('IL', 'IN', 'MI')
UNION
SELECT cust_name, cust_contact, cust_email
FROM customers
WHERE cust_name = 'Fun4All';

/* additionally, here is the same query using multiple WHERE clauses instead
   of a UNION */
SELECT cust_name, cust_contact, cust_email
FROM customers
WHERE cust_state IN ('IL', 'IN', 'MI')
  OR cust_name = 'Fun4All';

/*
    + A UNION must be composed of two or mroe SELECT statements,
      each separated by the keyword UNION
      (4 SELECT statements = 3 UNION keywords)

    + Each query in a UNION must contain the same columns, expressions,
      or aggregate functions (and some DBMSs even require that columns
      be listed in the same order)

    + Column datatypes must be compatible: they need to be the exact same
      type, but they must of a type that the DBMS can implictly convert
      (for example, different numeric types or different datetypes)


    The UNION automatically removes any duplicate rows from the query
    result set (in other words, it behaves just as do multiple WHERE
    clause conditions in a single SELECT would).

    If you would like to retain duplicates, you must use UNION ALL
*/
SELECT cust_name, cust_contact, cust_email
FROM customers
WHERE cust_state IN ('IL', 'IN', 'MI')
UNION ALL
SELECT cust_name, cust_contact, cust_email
FROM customers
WHERE cust_name = 'Fun4All';

-- Sorting Combined Query Results
/*
   When combining queries with a UNION only one ORDER BY clause may be used,
   and it must occur after the final SELECT statement.
*/
SELECT cust_name, cust_contact, cust_email
FROM customers
WHERE cust_state IN ('IL', 'IN', 'MI')
UNION
SELECT cust_name, cust_contact, cust_email
FROM customers
WHERE cust_name = 'Fun4All'
ORDER BY cust_name, cust_contact;
