---
title: SQL Setup, Insert, Update, and Delete
type: lesson
duration: 1.25
creator:
    name: Tony
    city: NYC 
competencies: Relational DBs
---

# Title of the Lesson

### Objectives
*After this lesson, students will be able to:*

- Create a database table
- Insert, retrieve, update, and delete a row or rows into a database table
- Understand and use joins

### Preparation
*Before this lesson, students should already be able to:*

- Install **sqlite3**
- Describe the relationship between tables, rows, and columns
- Draw an ERD diagram
- Explain the difference between table relationships


## We know about Databases, but what is SQL? Intro (10 mins)

Let's review: at it's simplest, a relational database is a mechanism to store and retrieve data in a tabular form.  Spreadsheets are a good analogy!  But how do we interact with our database: inserting data, updating data, retrieving data, and deleting data? That's where SQL comes in!

#### What is SQL?

SQL stands for Structured Query Language, and it is a language universally used and adapted to interact with relational databases.  When you use a SQL client and connect to a relational database that contains tables with data, the scope of what you can do with SQL commands includes:

- Inserting data
- Querying or retrieving data
- Updating or deleting data
- Creating new tables and entire databases
- Control permissions of who can have access to our data

Note that all these actions depend on what the database administrator sets for user permissions: a lot of times, as an analyst, for example, you'll only have access to retrieving company data; but as a developer, you could have access to all these commands and be in charge of setting the database permissions for your web or mobile application.

#### Why is SQL important?

Well, a database is just a repository to store the data and you need to use systems that dictate how the data will be stored and as a client to interact with the data.  We call these systems "Database Management Systems", they come in _many_ forms:

- MySQL
- SQLite (what we'll be using!)
- PostgreSQL 

...and all of these management systems use SQL (or some adaptation of it) as a language to manage data in the system.


## Connect, Create a Database - Codealong (10 mins)

Let's make a database!  First, make sure you have SQLite3 installed.  Once you do, open your terminal and type:

```bash
$ sqlite3 
```

You should see something like:

```bash
SQLite version 3.16.0
sqlite>
```
Great!  You've entered the SQLite equivalent of terminal: now, you can execute SQL commands, or SQLite's version of SQL.

Let's use these commands, but before we can, we must create a database.  Let's call it worldDB:

```sql
$ sqlite3 name_of_db
```


## I DO - Create table and insert (15 mins)

Now that we have a database, let's create a table (think of this like, "hey now that we have a workbook/worksheet, let's block off these cells with a border and labels to show it's a unique set of values"):



```sql
CREATE TABLE contacts (
	contact_id integer PRIMARY KEY,
	first_name text NOT NULL,
	last_name text NOT NULL,
	email text NOT NULL UNIQUE,
	phone text NOT NULL UNIQUE,
	age integer NULL
);
```

Notice the different parts of these commands:

```sql
 CREATE TABLE contacts (
```
This starts our table creation, it tells SQLite to create a table named "contacts"...

```sql
	contact_id integer PRIMARY KEY,
	first_name text NOT NULL,
```
>.tables will show us what has been created

...then, each line after denotes a new column we're going to create for this table, what the column will be called, the data type, whether it's a primary key, and whether the database - when data is added - can allow data without missing values.  In this case, we're not allowing NAME, EMAIL, or PHONE to be blank.

####Insert into:

Now that we saw how to create a table lets get some rows of data inserted. 

```sql
	INSERT INTO contacts
	 (first_name,last_name,email,phone,age)
	VALUES
	('Harry','Potter','pot_h@wizard.com','222-2222',11);
```


## YOU DO - Create a groups table and insert 3 rows of data - Codealong (6 mins)

Now that we've done it to keep track of our contacts, let's create a table for groups that collects information about:

- a group_id as Primary Key
- the groups name that cannot be left blank


Here's what that query should have looked like:

```sql
CREATE TABLE groups (
	group_id integer PRIMARY KEY,
	name text NOT NULL
);
```
Great job! Now let's finally _insert_ some data into that table - remember what cannot be left blank!

We'll insert 3 groups; `Wizards`, `Witches`, `Moguls`. The syntax is as follows:

```psql
INSERT INTO TABLE_NAME (col1,col2) VALUES (value1,value2);
```

Let's do it for Moguls, together:

```sql
	INSERT INTO groups
	 (name)
	VALUES
	('Moguls');
```

## What's in our database? Code Along -  (15 mins)

So now that we have this data saved, we're going to need to access it at some point, right?  We're going to want to _select_ particular datapoints in our dataset provided certain conditions.  The SQL SELECT statement is used to fetch the data from a database table which returns data in the form of result table. These result tables are called result-sets. The syntax is just what you would have guessed:

```sql
SELECT column1, column2
FROM table_name;
```
We can pass in what columns we want to look - like above - at or even get all our table records:

```sql
SELECT * FROM table_name;
```

#### Getting more specific

Just like Ruby or JavaScript, all of our comparison and boolean operators can do work for us to select more specific data.

####The `where` operator

- I want the names of all the contacts who aren't dinosaurs - done:

```sql
 SELECT name FROM contacts WHERE age < 100;
      

```

- How about the names of students orderedby age? Done:

```sql
 SELECT name, age FROM contacts ORDER BY age;
```

- How about reversed? Ok:

```sql
 SELECT name, age FROM contacts ORDER BY age DESC;

```

- How about those who use gmail? We can find strings within strings too!

```sql
SELECT * FROM contacts WHERE email LIKE '%gmail%';
```



## Updates to our database - Codealong (5 mins)

Ok, there are some mistakes we've made to our database, but that's cool, cause we can totally update it or delete information we don't like. Let's start by adding one more contact:

```sql
 INSERT INTO contacts (first_name,last_name,email,phone,age)
 VALUES ('Ron', 'Weasley', 'rw@gmail.com', '111-1111', 181);
```

But oh no, we messed them up - Ron isn't 181 years young, he just graduated hogwarts!, 18 is correct.  Let's fix it:  

```sql
UPDATE contacts SET age = 18 where first_name = 'Ron';
```

But wait, actually, I hate gingers - no big deal!

```sql
DELETE FROM contacts where first_name = 'Ron';
```

## I DO - Join tables anyone? - 10 mins

In relational databases, data is often distributed in many related tables. A table is associated with another table using foreign keys.

To query data from multiple tables, you use INNER JOIN clause. The INNER JOIN clause combines columns from correlated tables.

Suppose you have two tables: A and B.

A has a1, a2, and f columns. B has b1, b2, and f column. The A table links to the B table using a foreign key column named f.

The following illustrates the syntax of the inner join clause:

```sql
SELECT a1, a2, b1, b2
FROM A
INNER JOIN B on B.f = A.f;
```

>Example diagram of how the connect

![](http://www.sqlitetutorial.net/wp-content/uploads/2015/12/SQLite-inner-join-venn-diagram.png)

####Step 1: Create Join Table

>Notice the foreign key and primary key

```sql
CREATE TABLE contact_groups (
	contact_id integer,
	group_id integer,
	PRIMARY KEY (contact_id, group_id),
	FOREIGN KEY (contact_id) REFERENCES contacts (contact_id) 
			ON DELETE CASCADE ON UPDATE NO ACTION,
	FOREIGN KEY ([ group_id ]) REFERENCES groups (group_id) 
			ON DELETE CASCADE ON UPDATE NO ACTION
);
```

####Step 2: Insert the related values


```sql
 INSERT INTO contact_groups (contact_id, group_id)
 VALUES (1,1);
```

####Step 3: Create the inner join
```sql
SELECT * 
FROM contacts 
INNER JOIN contact_groups ON contacts.contact_id = contact_groups.contact_id 
INNER JOIN groups ON groups.group_id = contact_groups.group_id;
```


## Conclusion - 5 minutes

When we finally hook our apps up to databases - especially with Rails - we will have a whole slew of shortcuts we can use to get the data we need? So, wait, why the heck are we practicing SQL?  Well, let's look at what happens when you call for a particular user from a users table - with some nifty methods - in a Rails environment when you're connected to a database:

```ruby  
User.last
  User Load (1.5ms)  SELECT  "users".* FROM "users"   ORDER BY "users"."id" DESC LIMIT 1
=> #<User id: 1, first_name: "jay", last_name: "nappy"...rest of object >
```

There's SQL!!!

```SQL
SELECT  "users".* FROM "users"   ORDER BY "users"."id" DESC LIMIT 1
```

The Ruby/Rails scripts get converted to raw SQL before querying the database.  You'll know the underlying concepts and query language for how the data you ask for gets returned to you.

Answer these questions:

- How does SQL relate to relational databases?
- What kinds of boolean and conditional operators can we use in SQL?
