SQL Notes
=========


Part One: Working within a Table
================================

Terminology
-----------


SELECT statements
-----------------

SELECT statements (go figure) select data from a table

``` sql
SELECT name
FROM people;
```



So the basic structure for selecting a column from a table is:

``` sql
```


``` sql
```

You can also select all columns from a table without typing out all column names.

``` sql
SELECT *
```

Helpful Keywords
----------------


``` sql
SELECT *
LIMIT 10;
```


To select all unique values from a column, use the DISTINCT keyword.

``` sql
```

This is similar to the unique() function in R.  Another stylistic note: you can also write without creating a new line, like above in the SELECT DISTINCT query.

To learn a count of all rows in a table, use the COUNT keyword.

``` sql
```

This tells how many rows are in the table, but not how many non-missing values in a given column, like this does...

``` sql
```

This returns the number of non-missing values in the specified column.

If you want to combine the distinct and count keywords to know the number of distinct values:

``` sql
```

Filtering results
-----------------


``` sql
```


If you wanted to get all columns from a table while a certain column equals a given value:

``` sql
```



``` sql
SELECT column1 FROM MyTable WHERE column1 > x AND column 2 < y;
```


``` sql
```

Selecting by ranges can be done with two and operators (ie with dates)

``` sql
```

It can also be done more simply with the BETWEEN operator The between operator is inclusive, so...

``` sql
```


You can stack between with other AND/OR/BETWEEN statements:

``` sql
```

The WHERE operator can get unwieldy. The IN operator helps by allowing to specify multiple OR values.

``` sql
```

Instead with the IN operator:

``` sql
```

NULL Values
-----------

In SQL, NULL represents missing or unknown values. You can check for NULL using the expression IS NULL.

``` sql
```

This would return the number of null values in column1

IS NOT NULL operator will filter out null values

``` sql
```

LIKE and NOT LIKE
-----------------



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


``` sql
SELECT(4.0/3.0);
```

This would then provide 1.333

The AS Keyword
--------------

When SQL performs a function, it returns a column with the name of the function:

``` sql
```


``` sql
```

This returns two columns, each with the name MIN.

Aliasing fixes this--&gt;Assigning a temporary name to something. Use the AS keyword to do this.

``` sql
```

Ordering Results
----------------


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


``` sql
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

