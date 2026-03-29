# 🏥 Healthcare Operations & Revenue Cycle Analytics — MySQL

![MySQL](https://img.shields.io/badge/MySQL-8.0-blue) ![SQL](https://img.shields.io/badge/SQL-Advanced-green) ![Healthcare](https://img.shields.io/badge/Domain-Healthcare%20Analytics-red) ![Status](https://img.shields.io/badge/Status-Complete-brightgreen)

---

## 📌 Project Overview

This project is a comprehensive, end-to-end SQL analytics case study built on a healthcare dataset of **55,500 patient records** using MySQL and MySQL Workbench. The goal was to simulate the real-world analytical workflow of a Health Data Analyst working within a hospital operations and revenue cycle environment — starting from raw data ingestion and quality assessment, through to advanced reporting infrastructure using views and stored procedures.

The project is structured across **7 focused SQL files**, each targeting a distinct analytical domain and introducing progressively advanced SQL concepts — from foundational SELECT and GROUP BY queries, through subqueries, CTEs, and multi-table JOINs, to window functions, views, and parameterized stored procedures. Every module answers specific healthcare business questions, mirroring the kinds of ad-hoc and recurring analytical requests that health data analysts receive from clinical leadership, operations teams, and finance departments in real healthcare organizations.

---

## 📂 Repository Structure

```
healthcare-operations-analytics-sql-powerbi/
│
├── TABLE.sql                                    → Database setup & table schema creation
├── DATA.sql                                     → Patient demographics analysis
├── DATA_CLEANING.sql                            → Data cleaning & date analytics
├── Hospital_Doctor_Performance_Analysis.sql     → Hospital quality & doctor workload
├── billing_revenue.sql                          → Billing & revenue cycle analytics
├── patient_ranking.sql                          → Patient ranking & window functions
├── Clinical_reporting_views.sql                 → Clinical reporting views
├── automated_reports.sql                        → Stored procedures & automated reports
└── README.md
```

---

## 📊 Dataset

| Attribute | Details |
|---|---|
| Source | Kaggle — Healthcare Dataset by Prasad Patil |
| Records | 55,500 patient encounters |
| Columns | 15 |
| Time Period | May 2019 — May 2024 |
| License | CC0 Public Domain |
| Link | https://www.kaggle.com/datasets/prasad22/healthcare-dataset |

**Columns:** Name, Age, Gender, Blood Type, Medical Condition, Date of Admission, Doctor, Hospital, Insurance Provider, Billing Amount, Room Number, Admission Type, Discharge Date, Medication, Test Results

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|---|---|
| MySQL 8.0 | Database engine |
| MySQL Workbench | SQL IDE and query execution |
| Power BI | Dashboard visualization *(coming soon)* |
| GitHub | Version control and project documentation |

---

## 🧠 SQL Skills Demonstrated

| Category | Skills |
|---|---|
| Foundations | SELECT, WHERE, GROUP BY, ORDER BY, HAVING, DISTINCT, AS aliases |
| Aggregations | COUNT, SUM, AVG, MIN, MAX, ROUND, STDDEV |
| Conditionals | CASE WHEN, BETWEEN, IN, IS NULL |
| String Functions | UPPER, LOWER, SUBSTRING, SUBSTRING_INDEX, CONCAT |
| Date Functions | DATEDIFF, YEAR(), MONTH() |
| Joins | INNER JOIN, LEFT JOIN, table aliases |
| Subqueries | Correlated subqueries in SELECT, WHERE, HAVING |
| CTEs | WITH clause, multiple chained CTEs |
| Window Functions | ROW_NUMBER, RANK, DENSE_RANK, NTILE, PARTITION BY, SUM OVER, LAG, LEAD |
| Views | CREATE VIEW, querying views |
| Stored Procedures | DELIMITER, CREATE PROCEDURE, IN parameters, BEGIN/END, CALL, DROP PROCEDURE |
| Data Manipulation | UPDATE, DELETE, TRUNCATE, INSERT INTO, ALTER TABLE |
| Schema Design | CREATE TABLE, PRIMARY KEY, AUTO_INCREMENT, data types |

---

## 📋 Module Summary

### 📁 TABLE.sql — Database Setup
Created the `healthcare_project` database and `patients` table with appropriate data types — VARCHAR, INT, DATE, DECIMAL — for all 15 columns. Data loaded via MySQL Workbench Table Data Import Wizard.

---

### 📁 DATA.sql — Patient Demographics Analysis
**Business Question:** Who are our patients?

Analyzed patient demographics across gender, age groups, medical conditions, blood types, insurance providers, and admission types using SELECT, GROUP BY, COUNT, ROUND, CASE WHEN, BETWEEN, and window function-based percentage calculations.

**Key Findings:**
- 55,500 total patient records validated
- Near-equal gender split — Male 50.04% vs Female 49.96%
- Elderly patients (65+) are the largest group at **29.28%** — strong geriatric care demand indicated
- Children (0-18) represent only **1.60%** — facility is not pediatric-focused
- Arthritis (16.77%) and Diabetes (16.76%) are the most common conditions
- Cigna is the largest insurance provider at **20.27%**
- Elective admissions are highest at **33.61%**

---

### 📁 DATA_CLEANING.sql — Data Cleaning & Date Analytics
**Business Question:** How do we fix data quality issues and extract time-based insights?

Identified and corrected inconsistent patient name capitalization across all 55,500 records using UPPER, LOWER, SUBSTRING, SUBSTRING_INDEX, CONCAT, and UPDATE. Calculated length of stay using DATEDIFF, analyzed admission trends using YEAR(), and performed clinical risk stratification using CASE WHEN with IN operator.

**Key Findings:**
- 55,500 patient names with random capitalization permanently corrected using string functions
- Average length of stay is **~15.5 days** across all conditions; Asthma patients stay longest at **15.7 days**
- Admissions are consistent at approximately **11,000 per year** from 2020–2023
- Risk stratification identified **9,298 High Risk patients (16.75%)** requiring urgent clinical attention
- **18,356 patients (33.07%)** flagged as Needs Review due to inconclusive test results
- **18,517 patients (33.36%)** classified as Low Risk

---

### 📁 Hospital_Doctor_Performance_Analysis.sql — Hospital & Doctor Performance
**Business Question:** Which hospitals and doctors are performing well and where are the quality concerns?

Analyzed hospital patient volume and abnormal test result rates using conditional aggregation (SUM CASE WHEN) and HAVING for minimum sample size filtering. Performed doctor workload analysis, above-average billing detection using correlated subqueries, and practiced INNER JOIN and LEFT JOIN with a secondary doctors table.

**Key Findings:**
- One hospital flagged with a **52.94% abnormal test result rate** — warrants quality review investigation
- Without HAVING filtering, hospitals with only 1 patient showed misleading 100% abnormal rates — minimum 20 patient threshold applied for statistical validity
- The busiest doctor handles **27 patients** across all 6 medical conditions
- One doctor identified as billing **$27,224 above the hospital average** per patient — potential audit flag
- Hospital average billing across all facilities is **$25,539 per encounter**
- LEFT JOIN identified patients whose doctors are not registered in the system — critical data gap discovered

---

### 📁 billing_revenue.sql — Billing & Revenue Cycle Analysis
**Business Question:** Where is revenue coming from and are there billing anomalies?

Used CTEs (WITH clause) and multiple chained CTEs to analyze billing by condition, insurance provider, and admission type. Detected negative billing anomalies as data quality flags, performed statistical outlier detection using STDDEV, and analyzed year-over-year revenue trends using the LAG window function.

**Key Findings:**
- **Negative billing amounts detected** ranging from -$2,008 to -$1,130 — flagged as data quality anomalies requiring investigation
- After cleaning, **Obesity has the highest average billing** at $25,860 per patient
- **Medicare generates the highest average billing** at $25,667 per patient
- **Cigna generates the most total revenue** at $287M across all providers
- **Elective admissions generate the most revenue** at $477M (33.70%) — planned procedures are most profitable
- Revenue grew **50.93% from 2019 to 2020**, then stabilized at approximately $281M annually through 2023
- Cumulative total revenue across the full dataset period exceeds **$1.4 Billion**

---

### 📁 patient_ranking.sql — Patient Ranking Analysis
**Business Question:** How do patients rank across billing and what are the revenue trends over time?

Applied all major window functions — ROW_NUMBER, RANK, DENSE_RANK, NTILE, PARTITION BY, SUM OVER for running totals, and LEAD for sequential billing comparisons — to analyze patient billing rankings and monthly revenue trends.

**Key Findings:**
- Highest billed patient in the dataset was charged **$52,764** for Hypertension treatment
- RANK vs DENSE_RANK comparison demonstrates how ties are handled differently — RANK skips numbers, DENSE_RANK does not
- PARTITION BY enables ranking patients within each medical condition separately for condition-specific benchmarking
- NTILE(4) segments all patients into billing quartiles — Top 25%, Upper Middle, Lower Middle, Bottom 25%
- Monthly revenue is consistently **$22–26M per month** across the full dataset period
- Running total reached **$357M by mid-2020** and grew consistently through 2024
- LEAD function reveals high billing variability between consecutive patient encounters

---

### 📁 Clinical_reporting_views.sql — Clinical Reporting Views
**Business Question:** How do we build reusable reporting layers for clinical and operational stakeholders?

Created two persistent views — `patient_summary` and `hospital_performance` — that encapsulate complex queries into reusable virtual tables accessible by any reporting tool or Power BI connection.

- **patient_summary view** — combines all 15 patient columns with calculated Length_of_Stay and Risk_Level fields, filtered to positive billing records only
- **hospital_performance view** — aggregates hospital-level metrics including total patients, average billing, total revenue, abnormal count, abnormal percentage, and average length of stay

---

### 📁 automated_reports.sql — Stored Procedures & Automated Reports
**Business Question:** How do we build on-demand reporting infrastructure that any stakeholder can use?

Built two parameterized stored procedures using DELIMITER, CREATE PROCEDURE, IN parameters, BEGIN/END blocks, and CALL statements — enabling dynamic reports for any condition or insurance provider without writing new SQL each time.

- **get_condition_report(condition_name)** — returns total patients, average billing, total revenue, average length of stay, abnormal count, and abnormal percentage for any medical condition
- **get_insurance_report(insurance_name)** — returns total patients, average billing, total revenue, abnormal count, and emergency admission count for any insurance provider

**Example outputs:**

| Condition | Patients | Avg Billing | Total Revenue | Abnormal % |
|---|---|---|---|---|
| Diabetes | 9,284 | $25,694 | $238M | 34.05% |
| Cancer | 9,208 | $25,214 | $232M | 33.77% |
| Asthma | 9,167 | $25,686 | $235M | 32.74% |
| Hypertension | 9,224 | $25,556 | $235M | 32.58% |

| Insurance | Patients | Avg Billing | Total Revenue | Emergency Count |
|---|---|---|---|---|
| Medicare | 11,132 | $25,667 | $285M | 3,666 |

---

## 📈 Summary of Key Findings

| Area | Finding |
|---|---|
| Demographics | Elderly (65+) are the largest patient group at 29.28% |
| Data Quality | 55,500 names cleaned; negative billing amounts detected and flagged |
| Length of Stay | Average 15.5 days across all conditions; Asthma patients stay longest |
| Risk Stratification | 9,298 High Risk patients (16.75%) identified for urgent attention |
| Hospital Quality | One hospital flagged at 52.94% abnormal test result rate |
| Billing | Obesity has highest average billing at $25,860 per patient |
| Revenue | Cumulative revenue exceeds $1.4 Billion across dataset period |
| Trends | Revenue stable at ~$281M per year from 2020–2023 |
| Billing Anomaly | One doctor identified billing $27,224 above hospital average |

---
