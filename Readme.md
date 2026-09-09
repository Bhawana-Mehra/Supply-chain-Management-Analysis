# Supply Chain Management Analysis

An end-to-end **Supply Chain Analytics** project using **SQL Server, Python, and Power BI** to analyze sales, profitability, delivery performance, and customer behavior.

## Business Problem

This project focuses on answering key business questions:

- Which product categories and markets drive sales and profit?
- Does discounting have a meaningful relationship with profitability?
- Which shipping modes and markets have delivery-performance issues?
- Which customers and customer segments contribute most to sales?

## Dataset

The project uses the **DataCo Supply Chain Dataset** from Kaggle.

- **180,519** order-item records
- **65,752** unique orders
- **20,652** customers
- **118** products
- Source data spans **January 2015 – December 2018**, though records after January 2018 are sparse (see Data Quality Findings below).


### Data Quality Findings

During the SQL audit and Python EDA, several data-quality issues were identified:

- Approximately **32,927 rows (18%)** have a shipping date earlier than the order date.
- These records were **not deleted**; an `Is_Date_Anomaly` flag was created so the records can be retained while timeline-based analysis can exclude anomalies when appropriate.
- 2018 contains substantially fewer records than previous years, indicating incomplete source capture rather than a genuine business decline.
- Several columns contain high levels of missing data or limited analytical value.
- PII and unnecessary fields were excluded from the cleaned analytical dataset.

## Analytics Workflow

```text
Raw CSV
   ↓
SQL Server — Audit & Cleaning
   ↓
Clean Analytical Table + SQL Views
   ↓
Python — Exploratory Data Analysis
   ↓
Power BI — Data Model & Interactive Dashboard
   ↓
Business Insights & Recommendations
```

## SQL Server — Data Audit & Cleaning

SQL Server was used to:

- Audit row counts, unique IDs, NULLs, duplicates, categorical values, and invalid values.
- Investigate date inconsistencies and other data-quality issues.
- Create an `Is_Date_Anomaly` flag for invalid shipping-date sequences.
- Remove PII and unnecessary fields from the analytical dataset.
- Create calculated fields such as shipping delay and shipping performance.
- Create analytical views for the Power BI model.

### SQL Scripts

The SQL workflow is organized into five scripts:

```text
02_SQL/
├── 01_Data_Audit.sql
├── 02_Add_Data.sql
├── 03_Data_Cleaning.sql
├── 04_Creating_View.sql
└── 05_Data_Validation.sql
```

## Python — Exploratory Data Analysis

Python was used for exploratory analysis and validation using **Pandas, NumPy, Matplotlib, and Seaborn**.

Key analyses included:

- Sales and profit by product category
- Discount rate vs. profit relationship
- Extreme loss-making orders
- Shipping performance by shipping mode
- Delivery risk by market
- Customer and city-level analysis
- Customer segment AOV
- Monthly and yearly sales/order trends
- Investigation of the incomplete 2018 data

## Power BI — Interactive Dashboard

The Power BI report contains five analytical pages:

### 1. Overview

Provides a high-level view of:

- Total Sales
- Total Profit
- Total Orders
- Profit Margin
- Late Delivery %
- Sales and Profit trends
- Category performance
- Market contribution

### 2. Sales & Profitability

Focuses on:

- Profit by category
- Profit margin by category
- Discount and profitability analysis
- Product/order-level details

### 3. Shipping & Delivery

Analyzes:

- Late delivery %
- Delivery status
- Shipping-mode performance
- Scheduled vs. actual shipping days
- Market-level delivery performance

### 4. Customer Insights

Analyzes:

- Customer count
- Average Order Value
- Customer segments
- Top customer cities
- Customer-level sales and order activity

### 5. Findings & Recommendations

Summarizes the major business findings and translates them into actionable recommendations.

### Power BI Features

- Star-schema data model
- DAX measures and KPIs
- Synchronized slicers
- Interactive cross-filtering
- Secondary-axis trend analysis
- Business-focused insights and recommendations

## Dashboard Preview

![Overview](screenshots/Overview.png)
![Sales & Profitability](screenshots/Sales&Profitability.png)
![Shipping & Delivery](screenshots/Shipping&Delivery.png)
![Customer Insights](screenshots/Customer_Insights.png)

## Key Findings & Recommendations

| Finding | Business Recommendation |
|---|---|
| **54.8% of orders are classified as late**, with First Class showing approximately **95% late-delivery risk**. | Review the First Class SLA and evaluate whether the promised delivery time is realistic for the current operational capacity. |
| Late-delivery risk is relatively consistent across markets. | Focus on systemic delivery-process improvements rather than treating one market as the sole cause. |
| Discount rate shows a very weak linear correlation with profit (**r ≈ -0.02**). | Do not assume discounts directly cause profit decline; evaluate discounting alongside product, margin, customer, and order context. |
| Computers has a healthy category-level margin, while individual high-value orders can generate significant losses. | Investigate extreme loss-making Computers orders for discounting, pricing, or order-level cost issues. |
| Caguas shows unusually high order concentration compared with other cities. | Validate whether the concentration reflects genuine demand or a geographic/data artifact before making operational decisions. |
| 2018 has approximately **97% fewer records** than the preceding full years. | Treat 2018 as incomplete source capture and avoid interpreting it as a business-performance decline. |

## How to Reproduce

1. Load `DataCoSupplyChainDataset.csv` into SQL Server.
2. Run the SQL scripts in the following order:
   - `01_Data_Audit.sql`
   - `02_Add_Data.sql`
   - `03_Data_Cleaning.sql`
   - `04_Creating_View.sql`
   - `05_Data_Validation.sql`
3. Export the cleaned `clean_DataCo` dataset for Python EDA.
4. Open and run `EDA.ipynb` in Jupyter Notebook or a compatible environment.
5. Open `Report_SCM_Analysis.pbix` in Power BI Desktop and refresh the model.

## Repository Structure

```text
Supply-Chain-Management-Analysis/
│
├── 01_Data/
│   └── DataCoSupplyChainDataset.csv
│
├── 02_SQL/
│   ├── 01_Data_Audit.sql
│   ├── 02_Add_Data.sql
│   ├── 03_Data_Cleaning.sql
│   ├── 04_Creating_View.sql
│   
│
├── 03_Python/
│   └── EDA.ipynb
│
├── 04_PowerBI/
│   └── Report_SCM_Analysis.pbix
│
├── screenshots/
│   ├── Overview.png
│   ├── Sales&Profitability.png
│   ├── Shipping&Delivery.png
│   └── Customer_Insights.png
│
└── README.md
```

## Skills Demonstrated

- SQL Server
- Data Quality Auditing
- Data Cleaning & Transformation
- Exploratory Data Analysis
- Pandas & NumPy
- Matplotlib & Seaborn
- Power BI
- Data Modeling & Star Schema
- DAX & KPI Development
- Interactive Dashboard Design
- Business Analysis & Data Storytelling

## Author

**Bhawana Mehra**  
 Data Analystics | SQL | Python | Power BI

- [GitHub]:(https://github.com/Bhawana-Mehra)

