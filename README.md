
# SekiroSpeedrun.com Database

This repository contains the database used by [SekiroSpeedrun.com](https://sekirospeedrun.com/).
This repository is a extension of the [Website and Infrastructure Repository](https://github.com/ryufps/SekiroSpeedrun.com/) which is currently held private until the end of the Beta.

This guide explains how to access and retrieve data from the database using DB Browser for SQLite.

## Requirements

- A computer running Windows, macOS, or Linux.
- [DB Browser for SQLite](https://sqlitebrowser.org/).
- A local copy of `wiki.db`.

## 1. Download the Database

Clone the repository or download it as a ZIP file from GitHub.

### Using Git

```bash
git clone https://github.com/ryufps/SekiroSpeedrun.com-Database.git
```

### Using GitHub

1. Open the [SekiroSpeedrun.com-Database repository](https://github.com/ryufps/SekiroSpeedrun.com-Database).
2. Click the green `Code` button.
3. Select `Download ZIP`.
4. Extract the downloaded ZIP file.

The database file is named `wiki.db`.

## 2. Install DB Browser for SQLite

Download DB Browser for SQLite from the [official website](https://sqlitebrowser.org/).

Install and launch the application.

## 3. Open the Database

1. Start DB Browser for SQLite.
2. Click `Open Database`.
3. Navigate to the folder containing `wiki.db`.
4. Select `wiki.db`.
5. Click `Open`.

The database is now ready to browse.

## 4. Browse the Database

Open the `Browse Data` tab.

Select a table from the table dropdown to view its contents.

You can inspect records, browse columns, and search through the database without writing SQL.

## 5. Find Available Tables

To see all tables in the database, open the `Execute SQL` tab and run:

```sql
SELECT name
FROM sqlite_master
WHERE type = 'table';
```

This returns the names of all tables in `wiki.db`.

## 6. Retrieve Data Using SQL

You can use SQL queries to retrieve specific records from the database.

### Select all records from a table

```sql
SELECT *
FROM your_table;
```

Replace `your_table` with the name of the table you want to access.

### Select specific columns

```sql
SELECT your_column_1, your_column_2
FROM your_table;
```

Replace the column names with the fields you want to retrieve.

### Filter records

```sql
SELECT *
FROM your_table
WHERE your_column = 'Your Value';
```

Replace `your_column` and `Your Value` with the field and value you want to search for.

### Limit the number of results

```sql
SELECT *
FROM your_table
LIMIT 100;
```

This retrieves the first 100 records from the selected table.

## 7. Export Data

To export data from the database:

1. Open the `Execute SQL` tab.
2. Enter your SQL query.
3. Click `Execute`.
4. Export the query results as CSV using the available export option.

The exported CSV file can be opened in spreadsheet applications like [Google Spreadsheets](https://docs.google.com/spreadsheets/) or imported into another project.

## 8. Database Backup

Before making changes to `wiki.db`, create a backup of the original file.

You can also use the database backup or export options in DB Browser for SQLite to save a copy of the database.

## 9. Read-Only Access

If you only want to retrieve data, use `SELECT` queries.

Avoid running `UPDATE`, `DELETE`, `INSERT`, or other modifying queries unless you intentionally want to change the database.

## 10. Additional Information

The database schema, including the available tables and columns, can be inspected directly in DB Browser for SQLite.

Replace the SQL placeholders in this guide with the actual table and column names from `wiki.db`.
