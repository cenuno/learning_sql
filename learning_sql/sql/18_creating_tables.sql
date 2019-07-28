-- Creating Tables

/* SQL can be used to perform all database and table operations, including
   the creation and manipulation of tables themselves.

   Two ways to create database tables:

   1. most DBMSs come with an administration tool that can be used to create
      and manage database tables interactively;

   2. tables may also be manipulated directly with SQL statements.

*/

-- Basic Table Creation

/* to create a table using CREATE TABLE, you must specify the following
   information:

   + the name of the new table specified after the keywords CREATE TABLE.

   + the name and definition of the table columns separated by commas.

   + Some DBMSs require that you also specify the table location.

   When creating a new table, be sure to use multiple lines,
   with column definitions indented for easier reading and editing.
*/

-- Updating Tables

/*
    Ideally, tables should never be altered after they contain data.
    You should spend sufficient time anticipating future needs during
    the table design process so that extensive changes are not required
    later on.

    All DBMSs allow you to add columns to existing tables, although some
    restrict the datatypes that may be added (as well as NULL
    and DEFAULT usage).

    Many DBMSs do not allow you to remove or change columns in a table.

    Most DBMSs allow you to rename columns.

    Many DBMSs restricts the kinds of change you can make on columns
    that are populated and enforce fewer restrictions on unpopulated columns.

    To change a table using ALTER TABLE, you must specify the following
    information:

      * the name of the table to be altered after the keywords ALTER TABLE.
        (the table must exist or an error will be generated)

      * the list of changes to be made
*/
ALTER TABLE vendors
ADD vend_phone CHAR(20);

SELECT * FROM vendors;

ALTER TABLE vendors
DROP COLUMN vend_phone;

SELECT * FROM vendors;

/*
  Complex table structure changes usually require a manual move process
  involving these steps:

  1. Create a new table with the new column layout.

  2. Use the INSERT SELECT statement to copy the data from the old table
     to the new table. Use conversion functions and calculated fields,
     if needed.

  3. Verify that the new table contains the desired data.

  4. Rename the old table (or delete it, if you are really brave).

  5. Rename the new table with the name previously used by the old table.

  6. Recreate any triggers, stored procedures, indexes, and foreign keys
     as needed.
*/

-- Deleting Tables
/* Tables are deleted using the DROP TABLE statement: */
DROP TABLE cust_copy;
