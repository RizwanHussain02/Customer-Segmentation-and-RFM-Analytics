# 📊 Customer Segmentation and RFM Analytics

An end-to-end customer analytics project focused on **Customer Segmentation** and **RFM (Recency, Frequency, Monetary) Analysis** to understand customer behavior, improve targeting, and support data-driven business decisions.

This project combines **PostgreSQL**, **SQL-based warehousing**, **Python**, **Machine Learning**, and **Power BI** to analyze sales, customer patterns, product trends, and regional performance.

---

## ✨ Project Summary

Understanding customers is essential for sustainable growth. This project builds a complete analytics workflow that:

- Collects and structures customer and sales data
- Transforms raw data into an analysis-ready warehouse
- Computes RFM metrics for each customer
- Segments customers into actionable groups
- Visualizes performance through interactive business intelligence reports

The final outputs help answer questions like:

- Who are the most valuable customers?
- Which customer groups are at risk of churn?
- Which regions/products generate the highest revenue?
- How can retention and marketing campaigns be optimized?

---

## 🖼️ Reports Preview

> Add your report screenshots in this section (Power BI dashboards, KPI pages, segmentation charts, etc.)

### Example placeholders (replace with your image paths)

```md
![Executive Dashboard](Executive_Overview.jpg)
![Customer Segmentation Dashboard](Segmentation_RFM.jpg)
![Regional Performance Dashboard](./images/Product_and_RegionalPerformance.jpg)
```

---

## 🏗️ Project Architecture

> Add your architecture diagram after placing it in the repository.

### Example placeholder (replace with your architecture image path)

```md
![Project Architecture](./images/project-architecture.png)
```

### Typical architecture flow in this project

1. **Data Source Layer**  
   Raw customer, orders, sales, and product datasets

2. **Data Warehouse Layer (PostgreSQL + SQL)**  
   - Data cleaning  
   - Transformation  
   - Fact & dimension modeling  
   - Analytical views

3. **Analytics & Modeling Layer (Python + ML)**  
   - RFM metric generation  
   - Segmentation logic  
   - Optional clustering/classification models

4. **Visualization Layer (Power BI)**  
   - KPIs and trends  
   - Segment-wise analysis  
   - Product and regional performance reporting

---

## 🧰 Tech Stack

- **Database:** PostgreSQL  
- **Query Language:** SQL  
- **Programming:** Python  
- **Notebook Environment:** Jupyter Notebook  
- **Visualization:** Power BI  
- **Analytics Methods:** RFM Analysis, Customer Segmentation, Exploratory Data Analysis, ML-assisted insights

---

## 🔍 Core Analytics Covered

- **Customer Analytics**
  - Segment-wise behavior tracking
  - Repeat vs one-time customer analysis
  - Retention opportunity identification

- **RFM Analytics**
  - Recency scoring (latest engagement)
  - Frequency scoring (purchase repetition)
  - Monetary scoring (customer value)

- **Sales & Product Analytics**
  - Product-wise contribution
  - Revenue trend analysis
  - High/low performing category insights

- **Regional Analytics**
  - Region-wise sales distribution
  - Location performance benchmarking

---

## 📁Repository Structure

customer-segmentation-and-rfm-analytics/

├── README.md
├── LICENSE
├── .gitignore
│
├── architecture/
│   └── customer_segmentation_architecture.png
│
├── data/
│   ├── raw/
│   │   └── online_retail_II.xlsx
│   │
│   └── processed/
│       └── customer_segments.csv
│
├── sql/
│   ├── 01_staging_setup_and_load.sql
│   ├── 02_create_dimensions.sql
│   ├── 03_load_dimensions.sql
│   ├── 04_create_fact_table.sql
│   ├── 05_load_fact_table.sql
│   ├── 06_warehouse_validation.sql
│   ├── 07_business_analysis.sql
│   └── 08_rfm_analysis.sql
│
├── python/
│   ├── 01_data_loading_and_eda.ipynb
│   ├── 02_rfm_analysis.ipynb
│   ├── 03_feature_scaling.ipynb
│   ├── 04_kmeans_clustering.ipynb
│   ├── 05_cluster_evaluation.ipynb
│   └── 06_customer_segmentation_export.ipynb
│
├── powerbi/
│   ├── customer_segmentation_dashboard.pbix
│   └── screenshots/
│       ├── executive_overview.png
│       ├── customer_segmentation.png
│       └── product_regional_performance.png
│
├── docs/
│   ├── 01_business_requirements.md
│   ├── 02_business_questions.md
│   ├── 03_data_dictionary.md
│   ├── 04_data_quality_report.md
│   ├── 05_rfm_methodology.md
│   ├── 06_machine_learning_report.md
│   ├── 07_powerbi_dashboard_guide.md
│   ├── 08_business_recommendations.md
│   ├── 09_project_report.md
│   └── 10_decision_log.md
│
└── assets/
    ├── rfm_distribution.png
    ├── elbow_curve.png
    ├── silhouette_scores.png
    ├── pca_clusters.png
    └── customer_segment_summary.png

```

---

## ⚙️ Workflow

1. Data ingestion from transactional/business datasets  
2. Data cleaning and transformation using SQL  
3. Warehouse modeling in PostgreSQL  
4. RFM feature engineering  
5. Customer segmentation and analytical modeling in Python  
6. KPI/dashboard development in Power BI  
7. Insight extraction for decision-making

---

## 📈 Business Impact

This project enables organizations to:

- Improve campaign targeting using segment-based strategies
- Identify high-value and at-risk customers faster
- Drive retention through data-backed engagement plans
- Track product and regional performance in one analytics view
- Support strategic planning with interactive dashboards

---

## 🚀 How to Use

1. Clone the repository
2. Set up PostgreSQL and execute SQL scripts
3. Run notebooks for feature engineering and segmentation
4. Open Power BI dashboard/report files
5. Replace image placeholders in this README with your actual visuals

---

## 🔮 Future Enhancements

- Automated ELT/ETL pipeline scheduling
- Real-time customer scoring
- Advanced clustering and recommendation models
- Segment-wise campaign simulation
- Cloud deployment for scalable analytics

---

## 👤 Author

**Rizwan Hussain**  
GitHub: [@RizwanHussain02](https://github.com/RizwanHussain02)

---
