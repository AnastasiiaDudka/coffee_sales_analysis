# Coffee Sales Analysis

A SQL portfolio project focused on analyzing coffee sales, customer behavior, and product performance using a relational database.
The goal of this project is to answer real business questions through SQL queries and transform raw transactional data into actionable business insights.

---

# Project Overview

This project analyzes coffee sales across multiple countries by exploring customer purchasing behavior, product performance, sales trends, and business opportunities.
The analysis is divided into several logical sections:
- Data exploration
- Sales performance
- Customer analysis
- Product analysis
- Business insights and recommendations

---

# Business Questions

This project answers questions such as:
- Which products generate the highest revenue?
- Which coffee type performs best?
- Which roast type sells the most?
- Which package size should the company prioritize?
- Who are the highest-value customers?
- Does the loyalty program increase customer value?
- Which market generates the highest revenue?
- How concentrated is company revenue among top-selling products?

---

# Dataset

The project uses three relational tables:

| Table | Description |

| **orders** | Customer orders and sales transactions |
| **customers** | Customer information and loyalty status |
| **products** | Coffee product details, prices, and profit |

---

# Tools Used

- SQL
- SQLite
- DBeaver
- 
---

# Project Structure

```
coffee_sales_analysis
│
├── data/
│
├── sql/
│   ├── 01_data_overview.sql
│   ├── 02_sales_analysis.sql
│   ├── 03_customer_analysis.sql
│   ├── 04_product_analysis.sql
│   └── 05_business_insights.sql
│
├── results/
│   └── key_insights.md
│
└── README.md
```

---

# Key Insights

### Best Market

- The United States generated the highest revenue.
- It has the largest customer base and highest order volume.
- The US market should remain the primary marketing focus.

### Product Performance

- Exc coffee generated the highest revenue.
- It also achieved the highest average order value.
- Maintaining inventory and promotional efforts for this product is recommended.

### Roast Performance

- Light Roast produced the highest revenue and average order value.
- Customers purchasing Light Roast tend to spend more per transaction.

### Package Size

- The 2.5 kg package generated the highest revenue.
- Although smaller sizes receive more orders, larger packages produce significantly higher revenue per sale.

### Loyalty Program

- Customers without a loyalty card generated higher revenue and average order value.
- The current loyalty program may require redesign to improve customer engagement.

### Revenue Concentration

- The Top 5 products generate approximately 27% of total company revenue.
- Revenue is well diversified across the product portfolio.

---

# Skills Demonstrated

- SQL Joins
- Aggregate Functions
- GROUP BY
- Common Table Expressions (CTEs)
- Window Functions
- Business KPI Analysis
- Customer Segmentation
- Revenue Analysis
- Profitability Analysis
- Business Recommendations

---

# Author

**Anastasiia Dudka**
