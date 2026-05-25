# Supply Chain Analytics — Demand & Inventory Intelligence

> End-to-end data analytics pipeline on 100K+ retail transaction rows — EDA, hypothesis testing, advanced SQL, and a 5-page Power BI executive dashboard covering revenue, shipping delays, regional performance, and sales channel trends. **95%+ data quality post-cleaning.**

[![Python](https://img.shields.io/badge/Python-3.10%2B-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://python.org)
[![Pandas](https://img.shields.io/badge/Pandas-1.5%2B-150458?style=for-the-badge&logo=pandas&logoColor=white)](https://pandas.pydata.org)
[![SQL](https://img.shields.io/badge/SQL-Advanced-4479A1?style=for-the-badge&logo=postgresql&logoColor=white)]()
[![Power BI](https://img.shields.io/badge/Power_BI-Dashboard-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)](https://powerbi.microsoft.com)
[![Status](https://img.shields.io/badge/Status-Shipped-blue?style=for-the-badge)]()

---

## The Problem

Retail operations bleed margin from two failure modes: overstocking slow-moving SKUs and stockouts on high-velocity items. Both are caused by poor demand signal visibility — no real-time inventory intelligence, no statistical validation of what actually drives sales.

---

## What I Built

A full analytics pipeline from raw transactional data to an executive-facing Power BI dashboard, with statistical rigor at every step.

---

## Pipeline

```
Raw CSV (100K+ rows)
        │
        ▼
   DATA CLEANING
   ├── Missing value imputation
   ├── Outlier detection + treatment
   ├── Type normalisation
   └── 95%+ data quality achieved
        │
        ▼
   EXPLORATORY DATA ANALYSIS
   ├── Sales trend analysis (weekly, monthly, seasonal)
   ├── Store performance benchmarking
   ├── Holiday impact quantification
   └── Feature distribution profiling
        │
        ▼
   FEATURE ENGINEERING
   ├── Month, Year, Day-of-Week extraction
   ├── Week-over-week sales delta
   ├── Rolling sales average (trend smoothing)
   └── Lag features for time-series modelling
        │
        ▼
   HYPOTHESIS TESTING
   ├── t-test: holiday vs non-holiday sales significance
   ├── ANOVA: store performance variance
   └── Correlation: CPI, fuel price, temperature vs sales
        │
        ▼
   SQL ANALYTICS LAYER
   ├── CTEs: profit margin by product category
   ├── Window functions: rank stores by revenue
   ├── Shipping delay root cause queries
   └── Regional performance aggregations
        │
        ▼
   PREDICTIVE MODEL
   ├── Linear Regression baseline
   ├── RMSE: 559,623 · MAE: 472,755
   └── Improvement path: Random Forest / Gradient Boosting
        │
        ▼
   POWER BI DASHBOARD (5 pages)
```

---

## Key Findings

| Finding | Statistical Basis |
|---|---|
| Holiday weeks drive **disproportionate** sales uplift | t-test: p < 0.05, confirmed significant |
| Store performance variance is **statistically significant** | One-way ANOVA across store groups |
| CPI and fuel price show **weak correlation** with sales | r < 0.3 across all stores |
| Rolling average smoothing **reduces forecast noise** by ~18% | Compared vs raw weekly signal |
| Top 20% of stores account for **~60% of total revenue** | Pareto analysis via window functions |

---

## Power BI Dashboard (5 Pages)

| Page | Content |
|---|---|
| Revenue Overview | Total revenue KPI, monthly trend, YoY comparison |
| Shipping Delays | Delay distribution, root cause breakdown, carrier analysis |
| Sales Channel Trends | Channel contribution over time, growth rates |
| Regional Performance | Choropleth map, store ranking table, top/bottom performers |
| KPI Summary | All metrics in one view — slicers, cards, variance indicators |

---

## SQL Highlights

```sql
-- Window function: rank stores by cumulative revenue
SELECT
    store_id,
    SUM(weekly_sales) AS total_revenue,
    RANK() OVER (ORDER BY SUM(weekly_sales) DESC) AS revenue_rank
FROM sales
GROUP BY store_id;

-- CTE: profit margin by product category
WITH category_revenue AS (
    SELECT category, SUM(sales) AS revenue, SUM(cost) AS total_cost
    FROM transactions
    GROUP BY category
)
SELECT category,
       revenue,
       total_cost,
       ROUND((revenue - total_cost) / revenue * 100, 2) AS margin_pct
FROM category_revenue
ORDER BY margin_pct DESC;

-- Shipping delay analysis
SELECT
    shipping_carrier,
    AVG(DATEDIFF(actual_delivery, expected_delivery)) AS avg_delay_days,
    COUNT(*) AS total_shipments
FROM orders
GROUP BY shipping_carrier
HAVING avg_delay_days > 2
ORDER BY avg_delay_days DESC;
```

---

## Project Structure

```
supply-chain-analytics/
├── data/
│   └── dataset.csv                    # Retail transactions dataset
├── notebooks/
│   └── supply_chain_analytics.ipynb   # Full EDA + ML pipeline
├── sql/
│   └── analytics_queries.sql          # All SQL queries (CTEs, window fns)
├── dashboard/
│   └── supply_chain_dashboard.pbix    # Power BI dashboard file
├── docs/
│   └── findings_report.md             # Key insights and recommendations
├── requirements.txt
└── README.md
```

---

## Quick Start

```bash
# 1. Clone
git clone https://github.com/jainam-shah-18/supply-chain-analytics.git
cd supply-chain-analytics

# 2. Install dependencies
pip install -r requirements.txt

# 3. Run the notebook
jupyter notebook notebooks/supply_chain_analytics.ipynb

# 4. Open Power BI dashboard
# → Open dashboard/supply_chain_dashboard.pbix in Power BI Desktop
# → Refresh data source to point to data/dataset.csv
```

---

## Tech Stack

| Layer | Technology |
|---|---|
| Data Processing | Python, Pandas, NumPy |
| Statistical Testing | SciPy (t-test, ANOVA, correlation) |
| SQL Analytics | PostgreSQL / SQLite — CTEs, window functions |
| Visualisation | Power BI, Matplotlib, Seaborn |
| Notebook | Jupyter |

---

## Model Performance

| Metric | Value |
|---|---|
| Algorithm | Linear Regression (baseline) |
| RMSE | 559,623 |
| MAE | 472,755 |
| Next step | Random Forest / Gradient Boosting for non-linear patterns |

---

## Author

**Jainam Shah** · Python & AIML Intern @ IndiaNIC Infotech Ltd · Ahmedabad, India 🇮🇳

[![GitHub](https://img.shields.io/badge/GitHub-jainam--shah--18-181717?style=flat-square&logo=github)](https://github.com/jainam-shah-18)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-jainamshah41-0A66C2?style=flat-square&logo=linkedin)](https://linkedin.com/in/jainamshah41)

---

## License

MIT — see [LICENSE](LICENSE) for details.
