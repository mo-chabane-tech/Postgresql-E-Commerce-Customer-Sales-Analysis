# Postgresql E‑Commerce Customer & Sales Analysis

A PostgreSQL project analyzing an E‑Commerce Customer & Sales dataset (Kaggle) to answer business questions about revenue, customer lifetime value, repeat purchases, top products, payment preferences, and delivery performance.

This repository contains the schema, import scripts, analysis queries and views used to load and analyze the dataset. Insights from the analysis are summarized in INSIGHTS.md.

---

## Table of contents

- [Project overview](#project-overview)
- [Repository structure](#repository-structure)
- [Prerequisites](#prerequisites)
- [Dataset](#dataset)
- [Quick setup and reproducibility](#quick-setup-and-reproducibility)
  - [1. Create DB & role](#1-create-db--role)
  - [2. Create schema](#2-create-schema)
  - [3. Import CSV data](#3-import-csv-data)
  - [4. Run analysis and create views](#4-run-analysis-and-create-views)
- [SQL files and purpose](#sql-files-and-purpose)
- [Business questions answered](#business-questions-answered)
- [Results & insights](#results--insights)
- [Troubleshooting & tips](#troubleshooting--tips)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

---

## Project overview

This project uses PostgreSQL to load and analyze an E‑Commerce dataset from Kaggle. The analysis focuses on business-relevant questions such as monthly revenue trends by category, customer lifetime value by state, cohort-based repeat purchase rate, top products by sales, payment method preferences, and delivery performance by state.

All SQL is written to be run with psql against a local PostgreSQL instance. Views are created for easier exploration and to serve as reproducible query artifacts.

---

## Repository structure

- data/
  - contains 8 CSV files used for import (does NOT include a product category name CSV)
- sql/
  - `01_schema_setup.sql` — schema & tables DDL
  - `02_import.sql` — `\copy` commands to import CSVs into tables
  - `03_analysis.sql` — queries answering the business questions
  - `04_view.sql` — view definitions used by the analysis
- .gitignore
- README.md (this file)
- INSIGHTS.md — summary of the findings and high-level takeaways
- LICENSE (MIT)

---

## Prerequisites

- PostgreSQL 12+ (psql client)
- Access to the dataset CSV files (placed in the repository `data/` directory or accessible path)
- Basic familiarity with running `psql` from the command line

---

## Dataset

The dataset used is the "E‑Commerce Customer & Sales Analysis" dataset from Kaggle (not included here). Download the required CSV files from Kaggle and place them in the repository `data/` folder before running the import.

Note: The `data/` folder in this repo contains eight CSVs rather than nine — a product category name / translation CSV is not included.

---

## Quick setup and reproducibility

Below are minimal instructions to reproduce the analysis locally. Adjust user/database names as needed.

1) Start PostgreSQL and create a database & user (example):
```bash
# create DB and role (run as a postgres superuser)
createuser -P ecommerce_user
# when prompted enter a password
createdb -O ecommerce_user ecommerce_db
```

2) Create schema and tables:
```bash
# From the repository root
psql -U ecommerce_user -d ecommerce_db -f sql/01_schema_setup.sql
```

3) Import CSV data:
- The import script uses `\copy` (psql meta-command). Run it from the repo root so the `data/` paths in the script resolve correctly:
```bash
psql -U ecommerce_user -d ecommerce_db -f sql/02_import.sql
```
Important:
- `\copy` runs client-side in psql and reads files from where you run psql. If `02_import.sql` references `data/*.csv`, run the command from the repository root or adjust paths to absolute locations.
- If your CSVs have different separators, encodings, or headers, adapt the `\copy` lines accordingly.

4) Run analysis queries and create views:
```bash
# Create views used by the analysis (optional but recommended)
psql -U ecommerce_user -d ecommerce_db -f sql/04_view.sql

# Run the analysis queries (this file contains the queries used to generate the insights)
psql -U ecommerce_user -d ecommerce_db -f sql/03_analysis.sql
```

You can also open `sql/03_analysis.sql` and run individual queries in your SQL client to explore or export results.

---

## SQL files and purpose

- `sql/01_schema_setup.sql`
  - Creates tables and constraints for customers, orders, order_items, payments, sellers, geolocation, products (and any auxiliary tables).
- `sql/02_import.sql`
  - Uses `\copy` to bulk load the CSV data into tables.
- `sql/03_analysis.sql`
  - Contains the analytic queries that answer the business questions (aggregations, cohort analysis, ranking, etc.). These queries produce the outputs summarized in INSIGHTS.md.
- `sql/04_view.sql`
  - Defines views for common derived tables used throughout the analysis (e.g., order-level aggregations, customer lifetime metrics).

---

## Business questions answered

The analysis addresses the following six business questions. You can find the narrative findings in `INSIGHTS.md`.

1. Revenue by Product Category (Monthly Trend)
   - Monthly revenue time-series broken down by product category to identify seasonal patterns and growth.

2. Customer Lifetime Value (LTV) by State
   - Calculation of customer LTV across states to identify high-value geographies.

3. Repeat Purchase Rate (Cohort Analysis)
   - Cohort-based retention and repeat purchase rates to understand retention over time.

4. Top 10 Products by Sales (with Rank)
   - Top products by revenue and quantity sold, with rank and contribution to total sales.

5. Payment Method Preferences
   - Distribution and trends across payment types (credit card, voucher, boleto, etc.).

6. Delivery Performance by State
   - Delivery lead times and on-time performance by state to identify logistical issues.

---

## Results & insights

All insights and business takeaways are summarized in `INSIGHTS.md`. That file contains the distilled conclusions from the queries in `sql/03_analysis.sql`. For detailed query outputs, run the SQL in `sql/03_analysis.sql` and review the resulting tables or CSV exports.

See: [INSIGHTS.md](INSIGHTS.md)

---

## Troubleshooting & tips

- `\copy` errors:
  - Ensure you run `psql` from the repository root (so relative `data/` paths work) or change the CSV paths to absolute paths.
  - Check CSV encoding and line endings. Use `iconv` to convert encodings if necessary.

- Permission errors:
  - Make sure the DB role used to import has INSERT privileges on target tables.

---

## Contributing

Contributions, fixes, or improvements are welcome. Suggested contribution steps:
1. Fork the repo.
2. Create a branch for your change.
3. Make changes and add or update tests / SQL samples.
4. Open a pull request with a clear description of what you changed and why.

---

## License

This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## Contact

Author: mo-chabane-tech
