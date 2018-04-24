SQL Notes
=========

SQL --&gt; "Structured Query Language"
SQL is a language for interacting with data stored in relational databases.

Part One: Working within a Table
================================

Terminology
-----------

Relational databases are a collection of tables with relationships to one another. A row is referred to as a "record" and a column is referred to as a "field." A query is a request for data from a database table or combination of tables.

SELECT statements
-----------------

SELECT statements (go figure) select data from a table

``` sql
SELECT name
FROM people;
```

This statement selects the "name" column from the "people" table.

SELECT and FROM are keywords and are not case sensitive. However, it is best practice to capitalize statements to help make SQL code more readable. A semicolon indicates the end of a query.

So the basic structure for selecting a column from a table is:

``` sql
SELECT MyColumnName
FROM MyTableName;
```

You can also select multiple columns from a table at a time, separating each column with a comma.

``` sql
SELECT, MyColumnName1, MyColumnName2
FROM MyTableName;
```

You can also select all columns from a table without typing out all column names.

``` sql
SELECT *
FROM MyTableName;
```

Helpful Keywords
----------------

If you want only a certain number of results (rows) to be returned, use the LIMIT keyword.

``` sql
SELECT *
FROM MyTableName
LIMIT 10;
```

This is similar to the head() function in R and will only return the top 10 rows in a table.

To select all unique values from a column, use the DISTINCT keyword.

``` sql
SELECT DISTINCT MyColumnName FROM MyTableName;
```

This is similar to the unique() function in R.  Another stylistic note: you can also write without creating a new line, like above in the SELECT DISTINCT query.

To learn a count of all rows in a table, use the COUNT keyword.

``` sql
SELECT COUNT(*) FROM MyTableName;
```

This tells how many rows are in the table, but not how many non-missing values in a given column, like this does...

``` sql
SELECT COUNT(MyColumnName) FROM MyTableName;
```

This returns the number of non-missing values in the specified column.

If you want to combine the distinct and count keywords to know the number of distinct values:

``` sql
SELECT COUNT(DISTINCT MyColumnName) FROM MyTableName;
```

Filtering results
-----------------

The WHERE keyword allows you to filter based on text and numeric values in a table.
Comparison operators:
1. = equal
2. &lt;&gt; not equal
3. &lt; less than
4. &gt; greater than
5. &lt;= less than or equal to
6. &gt;= greater than or equal to.

``` sql
SELECT MyColumnName1 FROM MyTableName WHERE MyColumnName1 = x;
```

This query says, select MyColumnName1 from MyTableName while MyColumnName1 equals some given value (x).

If you wanted to get all columns from a table while a certain column equals a given value:

``` sql
SELECT * FROM MyTableName WHERE MyColumnName1 = x;
```
This is similar to the dplyr::filter() function in R.

This gives the value of all columns for each row  in which MyColumnName1 = x as opposed to the previous code that only gives MyColumnName1 values when it is equal to x (which isn't really that useful).

If you want to select data based on multiple conditions, you can build up WHERE queries by combining multiple conditions with the AND keyword.

``` sql
SELECT column1 FROM MyTable WHERE column1 > x AND column 2 < y;
```

Similarly, the OR operator is useful for selecting rows based on multiple conditions where some but not all of the conditions need to be met. This is used the same way as the AND operator. While using the AND operator along with the OR operator, you want to enclose each clause with brackets:

``` sql
SELECT MyColumnName3 FROM MyTableName WHERE (MyColumnName1 = x OR MyColumnName1 = y) AND (MyColumnName2 = a OR MyColumnName2 = b);
```

Selecting by ranges can be done with two and operators (ie with dates)

``` sql
SELECT * FROM MyTableName WHERE year > 1980 AND year < 2015
```

It can also be done more simply with the BETWEEN operator The between operator is inclusive, so...

``` sql
SELECT * FROM MyTableName WHERE year BETWEEN 1980 AND 2015
```

This yields results all rows that have a column "year" value of 1980-2015.  The code chunk above using AND yields rows that have a column "year" value between 1981-2014

You can stack between with other AND/OR/BETWEEN statements:

``` sql
SELECT DoctorName
FROM PhysicianList
WHERE age BETWEEN 30 AND 60
AND TrainingCountry = 'USA';
```

The WHERE operator can get unwieldy. The IN operator helps by allowing to specify multiple OR values.

``` sql
SELECT * FROM MyTableName WHERE MyColumnName1 = 2 OR MyColumnName1 = 4 OR MyColumnName1 = 6...
```

Instead with the IN operator:

``` sql
SELECT * FROM MyTableName WHERE MyColumnName1 IN (2, 4, 6)
```

NULL Values
-----------

In SQL, NULL represents missing or unknown values. You can check for NULL using the expression IS NULL.

``` sql
SELECT COUNT (*) FROM MyTableName WHERE MyColumn1 IS NULL;
```

This would return the number of null values in column1

IS NOT NULL operator will filter out null values

``` sql
SELECT MyColumn1 FROM MyTableName WHERE MyColumn2 IS NOT NULL
```

LIKE and NOT LIKE
-----------------

The LIKE operator can be used in a WHERE clause to search for a pattern. Wildcards are used as a placeholder for some other values. Here are two wildcards that can be used for LIKE: % and \_ NOT LIKE operator is used to find records that don't match the pattern you specify

### % Matches any subsequent characters

``` sql
SELECT name FROM people WHERE name Like 'Pe%';
```

This would return any name that began with Pe--Perry, Penelope, Percy, etc.

### \_ This wildcard matches a single character

``` sql
SELECT name FROM people WHERE name LIKE 'Per_y';
```

This would return any name in the specified column or table in which any letter replaces the underscore--Perry, Percy

Aggregate Functions
-------------------

Functions to help perform some calculations on data in a database. *MIN *MAX *AVG *SUM

``` sql
SELECT SUM(length) FROM videos;
SELECT AVG(length) FROM videos;
SELECT MIN(length) FROM videos;
SELECT MAX(length) FROM videos;
```

Aggregate functions can also be combined with WHERE statements

``` sql
SELECT AVG(cost)
FROM projects
WHERE project_date >= 2015;
```

Arithmetic
----------

Arithmetic can also be done

``` sql
SELECT (3*4)
```

This would return 12.

However, be careful with dividing!

``` sql
SELECT(4/3);
```

This would return 1 because you are dividing an integer by an integer and SQL rounds (down in this case) to provide you with an integer. To fix this:

``` sql
SELECT(4.0/3.0);
```

This would then provide 1.333

The AS Keyword
--------------

When SQL performs a function, it returns a column with the name of the function:

``` sql
SELECT MIN(MyColumn1) FROM MyTableName;
```

This would return the requested field (MyColumn1) as a column with the name "MIN" This could get confusing when making two SELECTs with the same function:

``` sql
SELECT MIN(MyColumn1), MIN(MyColumn2) FROM MyTableName;
```

This returns two columns, each with the name MIN.

Aliasing fixes this--&gt;Assigning a temporary name to something. Use the AS keyword to do this.

``` sql
SELECT MIN(MyColumn1) as Min_MyColumn1,
MIN(MyColumn2) as Min_MyColumn2
FROM MyTableName;
```

Ordering Results
----------------

The ORDER BY keyword is used to sort results in ascending or descending order according to the values of one or more columns. The keywords for descending or ascending: *DESC *ASC

``` sql
SELECT names
FROM presidents
ORDER BY height DESC;
```

In a table called "presidents" this code would sort the names of the presidents based on their height in descending order. Therefore, the President with the oldest age would be returned first--Abraham Lincoln (followed by Lyndon B. Johnson all the way down to the shortest, James Madison)

When applied to text, ORDER BY will sort alphabetically A-Z

Can also order by multiple columns:

``` sql
SELECT names
FROM presidents
ORDER BY height, age DESC;
```

Grouping results
----------------

GROUP BY keyword allows you to group a result by one or more columns:

``` sql
SELECT age, count(*)
FROM students
GROUP BY age;
```

This would provide a count for each age of the students in the "students" table.

You can also combine with order by to have the results returned in a particular order:

``` sql
SELECT age, count(*)
FROM students
GROUP BY age
ORDER BY count DESC;
```

HAVING clause
-------------

In SQL, you cannot use aggregate functions in WHERE clauses. If you want to filter based on the result of an aggregate function (like SUM), you must use the HAVING clause.

``` sql
SELECT AgeGroup
FROM Presidents
GROUP BY AgeGroup
HAVING COUNT(AgeGroup) > 10;
```

This would return all of the presidents, grouped by age, for those age groups that have more than 10 presidents.

``` sql
SELECT country, population, AVG(budget) AS avg_budget, AVG(state_pop) AS avg_state_pop
FROM countries
GROUP BY country
HAVING COUNT(population) > 10000
ORDER BY country
LIMIT 10;
```

This query would return the first 10 countries ordered alphabetically with a population over 10,000 showing the average of different parts of their budget and the average of the state populations in that country.
