# Module 7. Database Administration

## TASK 7.1

### PART 1

1. Download MySQL server for your OS on VM.

2. Install MySQL server on VM.

SSH to MySQL server installed on VM:

![7.2-install-mysql-on-vm](images/7.2-install-mysql-on-vm.png)

3. Select a subject area and describe the database schema, (minimum 3 tables)

Database schema in Workbench:

![7.3-blog-schema](images/7.3-blog-schema.png)

4. Create a database on the server through the console.

Create database blog: `CREATE DATABASE blog;`

Shift to the created database: `USE blog;`

Example of table creation:

```
CREATE TABLE authors (
id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(50) NOT NULL,
PRIMARY KEY (id)
);
```

Create database blog and tables authors, posts, and comments:

![7.4-create-database-through-console](images/7.4-create-database-through-console.png)

5. Fill in tables.

Examples:

`INSERT INTO authors (name) VALUES (Tom), (Lola), (Bob), (Alice);`

```
INSERT INTO posts (title, body, author_id)
VALUES ("Big Deal", "Elon Musk acquired Twitter", 3),
("Devops", "EPAM continued devops lectures after a break in March", 4),
("Lend Lease", "USA implement lend lease program for Ukraine", 1),
("Python", "Python course started two weeks ago", 4);
```

Some data are randomly generated at [https://www.mockaroo.com/](https://www.mockaroo.com/), saved as [authors.sql](authors.sql), [posts.sql](posts.sql) and [comments.sql](comments.sql) files and inserted into tables with 'source' command:

`source /home/gm/windowsshare/m7/authors.sql`

`source /home/gm/windowsshare/m7/posts.sql`

`source /home/gm/windowsshare/m7/comments.sql`

Screenshot showing filled in tables:

![7.5-insert-records-into-tables](images/7.5-insert-records-into-tables.png)

6. Construct and execute SELECT operator with WHERE, GROUP BY and ORDER BY.

Example 1: show information (post id, title, and creation time) of all posts of Alice

```
SELECT authors.name AS author, posts.id AS post_id, posts.title, posts.created_at
FROM posts INNER JOIN authors
ON posts.author_id = authors.id
WHERE authors.name="Alice";
```

Example 2: show total number of comments for each author (annotation) and sort the list by comments number in descending order

```
SELECT authors.name AS author, COUNT(comments.id) AS total_comments
FROM authors
INNER JOIN comments
ON comments.user_id = authors.id
GROUP BY author
ORDER BY total_comments DESC;
```

Screenshot:

![7.6-select-queries](images/7.6-select-queries.png)

7. Execute other different SQL queries DDL, DML, DCL.

DDL means **Data Definition Language**. The Sql Server DDL commands are used to create and modify the structure of a database and database objects (database, table, index, functions, etc.).

CREATE – create an object (database, table, etc)

DROP – delete an object (database, table, etc)

ALTER – alter the existing database or its object structures

TRUNCATE – remove records from tables

RENAME – rename an object

![7.7-ddl-commands](images/7.7-ddl-commands.png)

DML means **Data Manipulation Language**.

CRUD operations: SELECT, INSERT, UPDATE, DELETE

![7.7-dml-commands](images/7.7-dml-commands.png)

DCL means **Data Control Language**. DCL commands control the Data access permission.

GRANT – permit user to access the database.

REVOKE – withdraw the permission given by GRANT.

_See relevant screenshots in section 8 below._

TCL means **Transaction Control Language**. TCL commands control the Transactions.

COMMIT – commit the running transaction

ROLLBACK – rollback the current transaction

SAVEPOINT – set a save point so that, next time it will start from here

SET TRANSACTION – set characteristics of the transaction

8. Create a database of new users with different privileges. Connect to the database as a new user and verify that the privileges allow or deny certain actions.

**Create two new users with different privileges**

```
CREATE USER 'developer'@'localhost' IDENTIFIED BY 'developer';
CREATE USER 'devops'@'localhost' IDENTIFIED BY 'devops';
GRANT SELECT ON songs.* TO 'developer'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON songs.* TO 'devops'@'localhost';
SHOW GRANTS FOR 'developer'@'localhost';
SHOW GRANTS FOR 'devops'@'localhost';
FLUSH PRIVILEGES;
```

![7.8-create-users-privileges](images/7.8-create-users-privileges.png)

**Login to mysql as developer and play with priviledges**

![7.8-developer-privileges](images/7.8-developer-privileges.png)

**Login to mysql as devops and play with priviledges**

![7.8-devops-privileges](images/7.8-devops-privileges.png)

**Revoke some priviledges for devops and play with reduced scope of priviledges**

```
REVOKE INSERT, DELETE ON songs.* FROM 'devops'@'localhost';
```

![7.8-devops-reduced-privileges](images/7.8-devops-reduced-privileges.png)

**Login to mysql as root and delete users developer and devops**

```
DROP USER 'developer'@'localhost';
DROP USER 'devops'@'localhost';
```

![7.8-drop-users](images/7.8-drop-users.png)

9. Make a selection from the main table DB MySQL.

```
SELECT * FROM mysql.db\G
```

![7.9-select-from-db-mysql](images/7.9-select-from-db-mysql.png)

### PART 2

10. Make backup of your database.

Command for backup:

`mysqldump -u gam -p blog > $HOME/windowsshare/blog_db_backup.sql`

Restore from backup:

`mysql -u gam -p blog < $HOME/windowsshare/blog_db_backup.sql`

![7.10-db-dump](images/7.10-db-dump.png)

11. Delete the table and/or part of the data in the table.

In table 'comments' of database 'blog' from 100 records last 50 records are deleted('lost') with the command:

`DELETE FROM comments WHERE id > 50;`

![7.11-delete-50-rows-in-table-comments](images/7.11-delete-50-rows-in-table-comments.png)

12. Restore your database.

When database 'blog' is restored from backup, all 'lost' records in table 'comments' are recovered:

`mysql -u gam -p blog < $HOME/windowsshare/blog_db_backup.sql`

![7.12-restore-db-blog](images/7.12-restore-db-blog.png)

13. Transfer your local database to RDS AWS.

Transfer/import of locally backed up 'blog' database to Amazon RDS and remote connection to Amazon RDS:

![7.13-restore-db-blog-on-amazon-rds](images/7.13-restore-db-blog-on-amazon-rds.png)

14. Connect to your database.

Connection to Amazon RDS through Workbench:

![7.14-connect-to-amazon-rds](images/7.14-connect-to-amazon-rds.png)

15. Execute SELECT operator similar step 6.

On below screenshot SELECT query. This time Amazon RDS is connected through CLI.

![7.15-select-query-on-amazon-rds](images/7.15-select-query-on-amazon-rds.png)

16. Create the dump of your database.

Export(dump) with Workbench:

![7.16-export-from-remote-server-amazon-rds-to-local-machine](images/7.16-export-from-remote-server-amazon-rds-to-local-machine.png)

Export(dump) with CLI:

![7.16-dump-from-remote-server-to-local-machine-with-cli](images/7.16-dump-from-remote-server-to-local-machine-with-cli.png)

### PART 3 – MongoDB

17. Create a database. Use the use command to connect to a new database (If it doesn't exist, Mongo will create it when you write to it).

`use petlovers;`

18. Create a collection. Use db.createCollection to create a collection. I'll leave the subject up to you. Run show dbs and show collections to view your database and collections.

`db.createCollection("people");`

![7.18-mongo-connect-create-db-collection](images/7.18-mongo-connect-create-db-collection.png)

19. Create some documents. Insert a couple of documents into your collection. I'll leave the subject matter up to you, perhaps cars or hats.

Create documents:

```
db.people.insertOne({
name: "Tony Stark", age: 30, dog: { name: "Funtik", age: 10 }
});
```

```
db.people.insertMany([
{ name: "Spyderman", age: 23, spyder: { name: "Black Widow", age: 1 } },
{ name: "Batman", age: 28, cat: { name: "Master", age: 4 } },
{ name: "Captain America", age: 35, dog: { name: "Strong", age: 5 } },
]);
```

![7.19-mongo-create-documents](images/7.19-mongo-create-documents.png)

20. Use find() to list documents out.

Retreive all documents:

`db.people.find()`

Retreive filtered documents and format output:

`db.people.find({ dog: {$exists: true}}, {_id: false})`

![7.20-mongo-find-documents](images/7.20-mongo-find-documents.png)
