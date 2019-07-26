-- Using the LIKE predicate
/* Sometimes we wish to filter for values that we don't know explicitly

This is where wildcard searching comes into play. Using wildcards,
you can create search patterns that can be compared against your data.

SQL supports several different wildcard types, each must be used with LIKE.

LIKE instructs the DBMS that the following search pattern is to be compared
using a wildcard match rather than a straight equality match.

Wildcard searching can only be used with text fields (strings);
you can't use wildcards to search filds of non-text datatypes */

-- The Percent Sign (%) Wildcard
/* % means match any number of occurences of any character */
SELECT prod_id, prod_name
FROM products
WHERE prod_name LIKE 'Fish%';

/* Any row with a prod_name value that starts with 'Fish' will be retrieved.

The % tells the DBMS to accept any characters after the word 'Fish',
regardless of how many characters there are.

Note that searches may be case-sensitive (i.e. 'fish%' and 'Fish%') and
there may be multiple wildcards used at once.
*/
SELECT prod_id, prod_name
FROM products
WHERE prod_name LIKE '%bean bag%';

/* '%bean bag%' matches any value that contains the text 'bean bag'
anywhere within it, regardless of any characters before or after that text.

It is also possible to search for things in the middle.
note: the following query returnings 0 rows */
SELECT prod_name
FROM products
WHERE prod_name LIKE 'F%y';

/* Many DBMS pad field contents with spaces which will affect SQL queries
using wildcard matching. Note the second % after 'y' to retrieve the
prod_name value of 'Fish bean bag toy'.

A better solution would be to trim the spaces using functions */
SELECT prod_name
FROM products
WHERE prod_name LIKE 'F%y%';

/* Note that LIKE '%' will never match NULL values */

-- The Underscore '_' Wildcard
/* The underscore is used like % but instead of matching multiple characters
the underscore matches just a single characters

Note: the use of two underscores '__' filters prod_name values
      to those that have two characters before ' inch teddy bear'.

      Since 8 inch teddy bear only has one character before the
      text, it will not be returned. */
SELECT prod_id, prod_name
FROM products
WHERE prod_name LIKE '__ inch teddy bear%';

-- SIMILAR TO operator
/* operator returns true or false depending on whether its pattern
matches the given string. It is similar to LIKE, except that it interprets
the pattern using the SQL standard's definition of a regular expression.
SQL regular expressions are a curious cross between LIKE notation and
common regular expression notation.

For more detail, see here:
https://www.postgresql.org/docs/9.3/functions-matching.html */
SELECT cust_contact
FROM customers
WHERE cust_contact SIMILAR TO '(J|M)%'
ORDER BY cust_contact;

/* Tips for using wildcards:

  Wildcard searchs typically take far longer to process than any other
  search types discussed previously. Here are some rules to keep in mind:

  1. Don't overuse wildcards;

  2. Search patterns that begin with wildcards are the slowest to process;

  3. Pay attention to the placement of the wildcard symbols.

