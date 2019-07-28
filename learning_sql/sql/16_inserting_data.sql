-- Understanding Data Insertion
DELETE FROM customers
where cust_id = '1000000006';
/*
    INSERT is used to insert (add) rows to a database table. It can be used
    in several ways:
      + inserting a single complete row;
      + inserting a single partial row;
      + inserting the results of a query.

    Note: the INTO keyword following INSERT is optional.
          However, it is good practice to provide this keyword even if
          it is not needed. Doing so will ensure that your SQL code is
          portable between DBMSs.
*/
INSERT INTO customers
VALUES ('1000000006',
        'Toy Land',
        '123 Any Street',
        'New York',
        'NY',
        '11111',
        'USA',
        NULL,
        NULL);

/*
    The above SQL statement is highly dependent on the order in which the
    columns are defined in the table. It also depends on information about
    that order being readily available. Even if it is available, there is
    no guarantee that the columns will be in the exact same order the next
    time the table is reconstructed. Therefore, writing SQL statements that
    depend on specific column ordering is very unsafe. If you do so, something
    will inevitably break at some point.

    As a rule, **never** use INSERT without explicitly specifying the column list.
    This will greatly increase the probability that your SQL will continue
    to function in the event that table changes occur.
*/
DELETE FROM customers
where cust_id = '1000000006';

INSERT INTO customers(cust_id,
                      cust_name,
                      cust_address,
                      cust_city,
                      cust_state,
                      cust_zip,
                      cust_country,
                      cust_contact,
                      cust_email)
VALUES ('1000000006',
        'Toy Land',
        '123 Any Street',
        'New York',
        'NY',
        '11111',
        'USA',
        NULL,
        NULL);

/*
  Copying from one table to another
*/
CREATE TABLE cust_copy AS
SELECT * FROM customers;

SELECT * FROM cust_copy;
