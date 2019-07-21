# SQL

This directory contains the necessary `.sql` files related to this project.

## Use of PostgreSQL

Ben Forta's book allows the user to choose the database management system they would like to use to practice SQL. I chose [PostgreSQL](https://www.postgresql.org/about/).

To install PostgreSQL on your Mac OSX machine, follow this excellent [tutorial](https://medium.com/@viviennediegoencarnacion/getting-started-with-postgresql-on-mac-e6a5f48ee399).

## `tysql` database

All tables created and populated in the `01_create.sql` and `02_populate.sql` live inside the `tysql` - an abbreviation of the title of Ben's book - database. To create the `tysql` database, follow these steps:

```bash
brew services start postgresql
psql postgres
```

Once inside the `postgres` database - the default database - you can create `tysql` by running the following command within `psql`:

```sql
CREATE DATABASE tysql;
\connect tysql
```

## Creating and populating tables inside the `tysql` database

To create and populate the data inside the tables, you'll need to execute two `.sql` scripts after you've connected to the `tysql` database.

```bash
\i 01_create.sql
\i 02_populate.sql
```

Once complete, you'll type `\dt` to print out all the tables available to you in the `tysql` database. It should look like this:

              List of relations
 Schema |    Name     | Type  |    Owner     
--------+-------------+-------+--------------
 public | customers   | table | <username>
 public | order_items | table | <username>
 public | orders      | table | <username>
 public | products    | table | <username>
 public | vendors     | table | <username>
(5 rows)

