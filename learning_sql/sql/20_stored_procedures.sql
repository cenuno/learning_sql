-- Understanding Stored Procedures
/*
    Often, multiple statements will be needed to perform a complete operation

    + to process an order, checks must be made to
      ensure that items are in stock;

    + if items are in stock, they need to be reserved so that they are not
      sold to anyone else, and the available quantity must be reduced
      to reflect the correct amount in stock;

    + any items not in stock need to be ordered; this requires some
      interaction with the vendor;

    + the customer needs to be notified as to which items are in stock
      (and can be shipped immediately) and which are back ordered.

    Performing this process requires many SQL statements against many tables.
    In addition, the exact SQL statements that need to be performed and their
    order are not fixed; they can (and will) vary according to which items
    are in stock and which are not.

    Stored procedures are collections of one or more SQL statements saved
    for future use. You can think of them as batch files, although in
    truth they are more than that.
*/

-- Why to Use Stored Procedures

/*
    To simplify complex operations by encapsulating processes into a single
    easy-to-use unit.

    To ensure data consistency by not requiring that a series of steps be
    created over and over. If all developers and applications use the same
    stored procedure, then the same code will be used by all.

    The more steps that need to be performed, the more likely it is that
    errors will be introduced. Preventing errors ensures data consistency.

    To simplify change management. If tables, column names, or business logic
    (or just about anything) changes, then only the stored procedure code needs
    to be updated, and no one else will need even to be aware that changes were
    made.

    An extension of this is security. Restricting access to underlying data
    via stored procedures reduces the chance of data corruption
    (unintentional or otherwise)

    Because stroed procedures are usually stored in a compiled form, the DBMS
    has to do less work to process the command. This results in improved
    performanced.

    There are SQL language elements and features that are available only
    within single requests. Stored procedures can use these to write code
    that is more powerful and flexible.

    Three primary benefits: simplicity, security, and peformance.

    Downsides:

    stored procedure syntax caries dramatically from one DBMS to the next.
    in fact, it is close to impossible to write truly portable stored
    procedures. Having said that, the stored procedure calls themselves
    (their names and how data is passed to them) can be kept relatively
    portable so that if you need to change to another DBMS at least your
    client application code may not need changing.

    Stored procedures tend to be more complex to write than basic SQL
    statements, and writing them requires a greater degree of skill and
    experience. As a result, many database administrators restrict
    stored procedure creation rights as a security measure.

    Remember that stored procedures are executed far more often than they
    are written.
*/

-- Executing Stored Procedures
/* The SQL statement to execute a stored procedure is EXECUTE.

   EXECUTE takes the name of the stored procedure and any parameters that
   need to be passed to it.

   In psql, the command to execute is called CALL

   At the moment, there are no notes on how to recreate the author's
   stored procedure in psql.
*/
