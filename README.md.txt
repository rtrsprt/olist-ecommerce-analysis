# Olist E-commerce Analytics Project

End-to-end analytics project based on the public Olist e-commerce dataset, focused on business metrics, customer behavior, and delivery performance.

The project covers the full analytics pipeline:
- data quality checks
- SQL-based business analysis
- Python exploratory data analysis (EDA)
- Excel dashboard
- Power BI interactive dashboard
- cohort retention analysis

---

##  Project Goal

The goal of the project is to analyze key e-commerce business metrics:
- revenue dynamics
- customer behavior
- order structure
- product and seller performance
- customer retention

---

##  Tools & Technologies

- SQL (PostgreSQL)
- Python (pandas, numpy, matplotlib, seaborn)
- Excel
- Power BI
- GitHub

---

##  Dataset

The project uses the **Brazilian E-Commerce Public Dataset by Olist**.

The dataset includes:
- orders
- customers
- order items
- products
- sellers
- delivery information

---

## Project Structure

```text
olist-ecommerce-analysis/
│
├── sql/
├── python/
├── excel/
├── power_bi/
├── images/
└── README.md
```

---

## SQL Analysis

Performed:

- data quality checks (NULLs, duplicates, joins)
- revenue analysis
- sales segmentation
- customer analysis (new vs repeat)
- product and category analysis
- seller performance analysis
- cohort retention analysis

---

## Python (EDA)

Performed:

- data loading and preprocessing
- feature engineering (delivery time)
- distribution analysis
- delay analysis (on-time vs late delivery)
- visualization of delivery patterns
 
---

## Excel Dashboard

Includes:

- KPI metrics (Revenue, Orders, Customers, AOV)
- revenue trend
- customer distribution
- top categories
- top sellers

---

## Power BI Dashboard

Interactive dashboard with:

- KPI cards
- revenue over time
- regional filtering (customer_state)
- dynamic interaction between visuals

---

## Key Insights

- Most orders are delivered within 5–10 days
- Delayed orders take significantly longer (~31 days vs ~10 days)
- The majority of customers make only one purchase
- Customer retention drops sharply after the first month
- Revenue is concentrated in a small number of top categories

---

## Author

Ignat Muhin
Junior Data Analyst