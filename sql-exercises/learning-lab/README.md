# Learning Lab 📚

My study repository for data engineering. Here I practice the fundamentals behind my portfolio projects and keep a record of what I am learning.

> I update this repository as I study. It is a learning log, not a finished project.

## Current focus: SQL

The SQL exercises use a small practice dataset of a **fictional metal parts manufacturer** (customers, products, orders and order items). Each exercise starts with a business question in a comment, followed by the query that answers it.

### Dataset

```
customers ──< orders ──< order_items >── products
```

| Table | Description |
|---|---|
| `customers` | Who buys: name, city and segment (Industrial, Construction, Agro) |
| `products` | What is sold: category, unit price and unit cost |
| `orders` | When it was bought and the order status |
| `order_items` | Which products and how many units in each order |

The data includes a few "imperfections" on purpose (a customer without a city, a product never sold, a cancelled order) to practice `NULL` handling and joins.

### Progress

| # | Topic | File | Status |
|---|---|---|---|
| 01 | SELECT, WHERE, ORDER BY, NULL | [01_select_and_filter.sql](sql/01-fundamentals/01_select_and_filter.sql) | ✅ |
| 02 | Aggregations, GROUP BY, HAVING | [02_aggregations.sql](sql/01-fundamentals/02_aggregations.sql) | ✅ |
| 03 | INNER JOIN, LEFT JOIN, anti-join | [03_joins.sql](sql/01-fundamentals/03_joins.sql) | ✅ |
| 04 | CASE WHEN, subqueries, CTEs | [04_ctes_and_case.sql](sql/01-fundamentals/04_ctes_and_case.sql) | ✅ |
| 05 | Window functions | [05_window_functions.sql](sql/01-fundamentals/05_window_functions.sql) | ✅ |
| 06 | Data cleaning (duplicates, types, text) | [06_data_cleaning.sql](sql/01-fundamentals/06_data_cleaning.sql) | ✅ |
| 07 | Data modeling (star schema) | [07_star_schema.sql](sql/01-fundamentals/07_star_schema.sql) | ✅ |
| 08 | INSERT, UPDATE, DELETE and views | [08_dml_and_views.sql](sql/01-fundamentals/08_dml_and_views.sql) | ✅ |
| 09 | UNION, INTERSECT, EXCEPT | [09_set_operations.sql](sql/01-fundamentals/09_set_operations.sql) | ✅ |
| 10 | IN, EXISTS and correlated subqueries | [10_exists_and_subqueries.sql](sql/01-fundamentals/10_exists_and_subqueries.sql) | ✅ |
| 11 | Incremental load (upsert) | [11_incremental_load.sql](sql/01-fundamentals/11_incremental_load.sql) | ✅ |
| 12 | String functions | [12_string_functions.sql](sql/01-fundamentals/12_string_functions.sql) | ✅ |
| 13 | Date functions | [13_date_functions.sql](sql/01-fundamentals/13_date_functions.sql) | ✅ |
| 14 | ROW_NUMBER, RANK, DENSE_RANK | [14_ranking_functions.sql](sql/01-fundamentals/14_ranking_functions.sql) | ✅ |
| 15 | Running totals and moving averages | [15_running_totals.sql](sql/01-fundamentals/15_running_totals.sql) | ✅ |

### Key takeaways

- `WHERE` filters rows **before** grouping, `HAVING` filters groups **after** grouping.
- `NULL` means "unknown": compare with `IS NULL`, never `= NULL`. `COUNT(column)` ignores NULLs, `COUNT(*)` does not.
- `LEFT JOIN` + `WHERE right_table.key IS NULL` finds records with no match (anti-join).
- CTEs (`WITH`) make long queries readable, as a sequence of named steps.
- Window functions calculate across rows **without collapsing them**. `ROW_NUMBER()` + filter is the standard way to keep the latest record per key.

## How to run

The scripts use standard SQL and run on **PostgreSQL** or **SQLite**.

1. Create an empty database.
2. Run `sql/dataset/schema_and_data.sql` to create the tables and load the data.
3. Open any exercise file and run the queries one by one.

Online option with no installation: paste the scripts into [DB Fiddle](https://www.db-fiddle.com/) (PostgreSQL).

## Repository structure

```
learning-lab/
├── sql/
│   ├── dataset/
│   │   └── schema_and_data.sql   # tables + sample data
│   └── 01-fundamentals/          # exercises by topic
└── README.md
```

## Next topics

- More SQL: query plans, transactions and cohort analysis
- Python for data (pandas)
- Cloud fundamentals (Azure)

## Author

**Lucas Fernandes Nunes**: [GitHub](https://github.com/lucasnunesf) · [LinkedIn](https://linkedin.com/in/lucasfernandesnunes)
