-- Understanding Functions
/* Functions are operations that are usually performed on data to
faciliate conversion and manipulation.

However, using SQL functions is highly problematic.

Functions tend to be very DBMS specifc. Although all types of functionality
are usually available in each DBMS, the function name or syntax can differ
greatly.

SQL functions are not portable, meaning that the code you write for a specific
SQL implementation might not work on another implementation.

Some SQL programmers opt not to use any implementation-specific features,
which requires them to use other methods to do what the DBMS could have
done more efficiently.

Comment your code well so that at a later date you (or another developer) will
know exaclty what SQL implementation you were writing to.
*/

-- Using Functions
/*
    - Text functions are used to manipulate strings
        + trimming, padding and converting values to lower or UPPER case

    - Numeric functions are used to perform mathematical operations
        + returning absolute numbers and performing algebraic calculations

    - Date and time functions are used to manipulate date and time values
      and to extract specific components from these values
        + returning differences between dates and checking date validity

    - System functions return information specific to the DBMS
        + returning user login information
*/

-- Text Manipulation Functions
SELECT TRIM(vend_name), UPPER(vend_name) AS vend_name_upcase
FROM vendors
ORDER BY vend_name;

/* Commonly Used Text-Manipulation Functions

  function              description

  LEFT() or             returns characters from left of string
  SUBSTRING()

  LENGTH()              returns the length of a string
  (also DATALENGTH()
  or LEN())

  LOWER()               convert string to lowercase

  LTRIM()               trim white space from left of string

  RIGHT()               returns characters from right of string
  or SUBSTRING()

  RTRIM()               trim white space from right of string

  SOUNDEX()             returns a strings SOUNDEX value
                        note: SOUNDEX is an algorithm that converts
                              any string of text into an alphanumeric
                              pattern describing the phonetic representation
                              of that text. It enables strings to be compared
                              by how they sound rather than how they have
                              been typed.

                              It is not supported by PostgreSQL.

  UPPER()                converts string to uppercase
*/

-- Date and Time Manipulation Functions

/*
note: I have have shortened date and time to datetime

datetime values are stored in special formats so that they may sorted
or filtered quickly and efficiently, as well as to save physical storage
space.

datetime functions are used to read, expand, and manipulate these values
in a way that is useful to your application. While no doubt essential,
they tend to be the least consistent and portable functions across DBMS.

Let's retrieve a list of all orders made in 2012
*/

SELECT order_num, order_date, DATE_PART('year', order_date) AS order_date_year
FROM orders
WHERE DATE_PART('year', order_date) = 2012
ORDER BY order_date;

-- Numeric Manipulation Functions

/* They tend to be used primarily for algebraic, trigonometric, or geometric
calculations. Numeric functions are the ones that are most uniform and
consistent.

  function            description

  ABS()               return a number's absolute value

  COS()               returns the trigonometric cosine of a specified angle

  EXP()               returns the exponential value of a specific number

  PI()                returns the value of PI

  SIN()               returns the trigonometric sine of a specified angle

  SQRT()              returns the square root of a specified number

  TAN()               returns the trigonometric tangent of a specified angle
 */

SELECT PI() AS pi,
       SQRT(4) AS sqrt_4,
       EXP(10) AS exp_10,
       ABS(-100) AS abs_neg;
