SQL Cheatsheet
--------
__SQL__ aka _Stuctured Query Language_ is de-facto standard for rational databases queries. Although there many SQL databases (__MS-SQL__, __MySql__, __Postgresql__, __SQLite__ and such) exists, most of them adds functionality on top of base __SQL__ listed below.

## Tables
Tables is one of the __SQL__ fundamentals. Tables are 2-dimentional data structure. They consists of _rows_ and _columns_.

__HR_DATA__

ID | Name | Age | DepartmentId
---|------|-----|--------------
1 | Fred | 22 | 2
2 | Daria | 24 | 2
3 | Greg | 32 | 1
4 | Boris | 51 | 3

Here we have table HR_DATA with 4 columns (ID, Name, Age, DepartmentID) with 4 rows (each representing different person info).

```sql
-- Create table <t_name> with columns (<col_name> of type <col_type>) per column.
-- with optional default value <def_val>
CREATE TABLE t_name (col_name col_type [DEFAULT def_val],...)

-- Delete <t_name>. Use with extreme caution! All your data in table <t-name> will be lost!
DROP TABLE t_name;
```

## Basic Querying
One of the most fundamental operation upon table - query (besides other members of __CRUD__ (Create/Read/Update/Delete) family, we will talk later on rest of them later, I promise). Qurying is a process of getting exactly data what your need (either some columns (\<fields\>) or filtering rows for some condition (__WHERE__) or sometimes - both). Also, it is one of the safest operations - it don't change any data.
```sql
-- Selects selected fields (or all fields if __*__ is selected) from <t_name> table
-- Optionally, select only records where condition __WHERE__ is met/
-- Optionally, orders records by __ORDER BY__ field.
SELECT [DISTINCT] fields|*, FROM [ONLY] t_name [WHERE cond (operators - =, >, <, LIKE, etc) target_val], [ORDER BY col], [GROUP BY col [HAVING cond]]
- SELECT exp AS exp_name
-- Insert new row into <t_name> table. Optional list of column names may be present. Otherwise __VALUES__ list will be compared to table scheme.
INSERT INTO t_name [(col_name,...)] VALUES (col_value,...)
-- Update each record with <col_1> = <new_val> whenever WHERE condition is TRUE.
-- Be caution about __WHERE__ condition. If used poorly it may change unwanted records.
UPDATE t_name SET col_1 = new_val,... [WHERE cond]
-- Deletes each record from table when <cond> expression is TRUE.
-- Be caution, without WHERE statement (or when this statement will be always TRUE) thid command will delete all you rows!
DELETE FROM t_name [WHERE cond]
```

## Joins
Joins is one of the __SQL__ hardest and misunderstood part (but mostly asked in ...). In a nutshell it is a union of one table with other table (usually on some condition.)

```SQL
JOIN ([LEFT] INNER) join_t_name ON cond, OUTER [(LEFT, RIGHT, CROSS)]
```

## Aggregates (min, max, rank()...)

## Views
```SQL
CREATE VIEW v_name AS select_query;
```

## Functions
```SQL
CREATE FUNCTION f_name(arg1 arg1_type,...) RETURNS ret_type AS fn_body LANGUAGE lang;
```

## Keys
Foreign Keys (primary, secondary)

## Transactions
```SQL
BEGIN;
...query...
COMMIT [ROLLBACK];

SAVEPOINT s_name
ROLLBACK TO s_name
```

## Window functions
```SQL
SELECT fields, [part_field OVER (PARTITION BY field [ORDER BY field])] FROM t_name
```

## Inheritance
```SQL
CREATE t_name (...) INHERITS (t_parent);
```
## Indexes
```SQL
CREATE INDEX i_name [USING i_type] ON t_name (f_name) [WHERE cond];
DROP INDEX i_name;
```
