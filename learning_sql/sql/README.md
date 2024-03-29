# SQL

This directory contains the necessary `.sql` files related to this project.

## Use of PostgreSQL and `psql`

Ben Forta's book allows the user to choose the database management system they would like to use to practice SQL. I chose [PostgreSQL](https://www.postgresql.org/about/).

To install PostgreSQL on your Mac OSX machine, follow this excellent [tutorial](https://medium.com/@viviennediegoencarnacion/getting-started-with-postgresql-on-mac-e6a5f48ee399). For futher reading, I highly recommend you familiarize yourself with [`psql`](https://www.postgresql.org/docs/11/app-psql.html), the PostgreSQL interactive terminal:

> psql is a terminal-based front-end to PostgreSQL. It enables you to type in queries interactively, issue them to PostgreSQL, and see the query results. Alternatively, input can be from a file or from command line arguments. In addition, psql provides a number of meta-commands and various shell-like features to facilitate writing scripts and automating a wide variety of tasks.

## `tysql` database

All tables created and populated in the `01_create.sql` and `02_populate.sql` live inside the `tysql` - an abbreviation of the title of Ben's book - database. To create the `tysql` database, follow these steps:

```bash
brew services start postgresql
psql postgres
```

Once inside the `postgres` database - the default database - you can create `tysql` by running the following command within `psql`:

```sql
CREATE DATABASE tysql;
```

After `tysql` is created, you must connect to it using the following `psql` command:

```bash
\connect tysql
```

## Creating and populating tables inside the `tysql` database

To create and populate the data inside the tables, you'll need to execute two `.sql` scripts after you've connected to the `tysql` database.

```bash
\i 01_create.sql
\i 02_populate.sql
```

Once complete, you'll type `\dt` to print out all the tables available to you in the `tysql` database. It should look like this:

```
              List of relations
 Schema |    Name     | Type  |    Owner     
--------+-------------+-------+--------------
 public | customers   | table | <username>
 public | order_items | table | <username>
 public | orders      | table | <username>
 public | products    | table | <username>
 public | vendors     | table | <username>
(5 rows)
```

## Expanded Mode for Easy-to-See Terminal Output

I highly recommend setting [expanded mode](https://stackoverflow.com/a/16108898/7954106) to auto to make reading the `psql` output easier to see.

> When expanded mode is enabled, query results are displayed in two columns, with the column name on the left and the data on the right. This mode is useful if the data wouldn't fit on the screen in the normal “horizontal” mode. In the auto setting, the expanded mode is used whenever the query output has more than one column and is wider than the screen; otherwise, the regular mode is used.

To set expanded mode as your default setting, edit the `.psqlrc` file in your home directory so that it contains `\x auto` and reset `psql`. 

