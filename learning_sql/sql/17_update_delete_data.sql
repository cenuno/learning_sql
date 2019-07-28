-- Updating Data

/* To update (modify) data in a table the UPDATE statement is used. UPDATE
   can be used in two ways:

   + to update specific rows in a table;

   + to update all rows in a table.


   The UPDATE statement is very easy to use - some would say too easy. The
   basic format of an UPDATE statement is made up of three parts:

   + the table to be updated;

   + the column names and their new values;

   + the filter condition that determines which rows should be updated.

   The UPDATE statement always begins with the name of the table being updated.
   In this example, it is the customers table. The SET command is then used
   to assign the new value to a column. As used here, the SET clause sets
   the cust_email column to the specified value:
*/
UPDATE customers
SET cust_email = 'kim@thetoystore.com'
WHERE cust_id = '1000000005';

/* updating multiple columns requires a slightly different syntax */
UPDATE customers
SET cust_contact = 'Sam Roberts',
    cust_email = 'sam@toyland.com'
WHERE cust_id = '1000000006';

/*
  Foreign Keys are Your Friend

  You can also have the DBMS enforce the relationship by using foreign keys.
  When foreign keys are present, the DBMS uses them to enforce referential
  integrity. For example, if you tried to insert a new product into the
  products table, the DBMS would not allow you to insert it with an unknown
  vendor id because the vend_id column is connected to the vendors table
  as a foreign key.

  So what does this have to do with DELETE?

  Well, a nice side effect of using foreign keys to ensure referential
  integrity is that DBMS usually prevents the deletion of rows that
  are needed for a relationship. For example, if you tried to delete a
  product from products that was used in existing orders in order_items,
  that DELETE statement would throw an error and would be aborted.

  That's another reason to always define your foreign keys.

  DELETE doesn't delete tables; only rows.

  Use TRUNCATE TABLE statement which accomplished the same thing but does it
  much quicker (because data changes are not logged)
*/

/* Guidlines for Updating and Deleting Data

  The UPDATE and DELETE statements used in the previous section all have
  WHERE clauses. If you omit the WHERE clause, the UPDATE or DELETE will be
  applied to every row in the table.

  In other words, if you execute an UPDATE without a WHERE clause, every
  row in the table will be updated with the new values. Similarly if you
  execute DELETE without a WHERE clause, all the contents of the table
  will be deleted.

  Here are some important guidelines that many SQL programmers follow:

  + never execute an UPDATE or a DELETE without a WHERE clause unless you
    really do intend to update and delete every row.

  + make sure every table has a primary key.

  + before you use a WHERE clause with an UPDATE or a DELETE, first
    test it with a SELECT to make sure it is filtering the right records:
    it is far too easy to write incorrect WHERE clauses.

  + use DBMS enforced referential integrity so that the deletion of rows
    that have data in other tables related to them.

  + Some DBMSs allow database administrators to impose restrictions that
    prevent the execution of UPDATE or DELETE without a WHERE clause. If
    your DBMS supports this feature, consider using it.

  The bottom line is that SQL has no undo button. Be very careful using
  UPDATE and DELETE, or you'll find yourself updating and deleting the wrong
  data.
*/
