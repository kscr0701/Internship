# 📊 Nexvia Technologies Internship — Data Analytics Projects

![Python](https://img.shields.io/badge/Python-3.13-blue?logo=python&logoColor=white)
![pandas](https://img.shields.io/badge/pandas-data%20analysis-150458?logo=pandas)
![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?logo=mysql&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-dashboards-F2C811?logo=powerbi&logoColor=black)
![Status](https://img.shields.io/badge/status-completed-success)

Two end-to-end analytics projects completed during my **Data Analyst Internship at Nexvia Technologies**.
Each one goes from **raw data → cleaning & EDA → summary tables → interactive Power BI dashboard**.

| # | Project | Dataset | Tools | Focus |
|---|---------|---------|-------|-------|
| 1 | [**Enterprise Business Intelligence Suite**: HR Attrition](#-project-1--enterprise-business-intelligence-suite-hr-attrition) | IBM HR Analytics (1,470 employees) | Python · MySQL · Power BI | Why employees leave |
| 2 | [**Customer 360 & Marketing Attribution Platform**](#-project-2--customer-360--marketing-attribution-platform) | Olist Brazilian E-Commerce (~99K orders) | Python · Excel · Power BI | Delivery performance |

---

## 📑 Table of Contents
- [Repository Structure](#-repository-structure)
- [Tech Stack](#-tech-stack)
- **Project 1 — HR Attrition**
  - [Objective](#-objective) · [Dataset](#-dataset) · [Workflow](#-workflow) · [Notebook](#-notebook-walkthrough) · [SQL](#-sql-analysis) · [Dashboard](#-power-bi-dashboard) · [Findings](#-key-findings) · [How to Run](#️-how-to-run)
- **Project 2 — Customer 360**
  - [Objective](#-objective-1) · [Dataset](#-dataset-1) · [Workflow](#-workflow-1) · [Notebook](#-notebook-walkthrough-1) · [Dashboard](#-power-bi-dashboard-1) · [Findings](#-key-findings-1) · [How to Run](#️-how-to-run-1)
- [Skills Demonstrated](#-skills-demonstrated)
- [Author](#-author)

---

## 📁 Repository Structure

```
Nexvia-Technologies-Internship/
│
├── 1. Enterprise Business Intelligence Suite/
│   ├── Raw Data/
│   │   └── IBM HR Analytics Employee Attrition & Performance.csv
│   ├── Summary/
│   │   ├── employee_clean.csv              # Cleaned employee-level data
│   │   ├── summary.csv                     # Department × job role summary
│   │   └── HR_Attrition_Report.xlsx        # 5-sheet Excel report
│   ├── HR_Attrition_EDA_and_Summary.ipynb  # Python: EDA + summary pipeline
│   ├── HR_Attrition_Analysis.sql           # MySQL: import, validation, analysis
│   ├── IBM_HR_Analytics_Dashboard.pbix     # Power BI dashboard
│   └── Screenshots/
│
├── 2. Customer 360 and Marketing Attribution Platform/
│   └── Brazilian E-Commerce Public Dataset by Olist/
│       ├── Raw Data/                        # 9 original CSV files
│       ├── Summary Data/
│       │   └── order_summary.csv            # Clean, delivered orders only
│       ├── Olist_EDA_and_Order_Summary.ipynb
│       ├── Olist_Order_Summary_Report.xlsx  # 4-sheet Excel report
│       ├── E_Commerce_Dashboard.pbix        # Power BI dashboard
│       └── Screenshots/
│
└── README.md
```

---

## 🧰 Tech Stack

| Tool | Used for |
|------|----------|
| **Python 3.13** (pandas, pathlib) | Data loading, cleaning, feature engineering, summaries |
| **Jupyter Notebook** | Documented, re-runnable analysis |
| **openpyxl** | Multi-sheet Excel reports |
| **MySQL 8.0** | SQL validation and attrition analysis (Project 1) |
| **Power BI Desktop** | Interactive dashboards |

---
---

# 👥 Project 1 — Enterprise Business Intelligence Suite: HR Attrition

### IBM HR Analytics — Employee Attrition & Performance

## 🎯 Objective

Find out **which employees leave, where, and why**, and turn the results into a dashboard HR can act on.

Key questions:
1. What is the overall attrition rate?
2. Which **departments and job roles** lose the most people?
3. How do **pay**, **tenure**, **overtime** and **satisfaction** relate to attrition?
4. Is the data complete and reliable?

---

## 📦 Dataset

**Source:** [IBM HR Analytics Employee Attrition & Performance (Kaggle)](https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset)
**Size:** 1,470 employees × 35 columns · **Target:** `Attrition` (Yes / No)

| Category | Example columns |
|----------|-----------------|
| Demographics | `Age`, `Gender`, `MaritalStatus`, `DistanceFromHome` |
| Job | `Department`, `JobRole`, `JobLevel`, `OverTime`, `BusinessTravel` |
| Pay | `MonthlyIncome`, `PercentSalaryHike`, `StockOptionLevel` |
| Tenure | `YearsAtCompany`, `YearsInCurrentRole`, `YearsSinceLastPromotion` |
| Satisfaction (1–4) | `JobSatisfaction`, `EnvironmentSatisfaction`, `WorkLifeBalance` |

---

## 🔄 Workflow

```
 Raw CSV ──► EDA & quality checks ──► snake_case + features ──► Clean CSV ──► Breakdowns ──► Summary
    │                                                                                        │
    └──► MySQL: import → rename → validate → analyse                     Power BI dashboard ◄┘
```

---

## 📓 Notebook Walkthrough

`HR_Attrition_EDA_and_Summary.ipynb` has 12 sections in three parts:

| Part | Sections | What happens |
|------|----------|--------------|
| **A. Explore** | 1–5 | Setup, load data, structure & types, statistics, quality checks (missing, duplicates, constant columns, target balance) |
| **B. Prepare** | 6–8 | snake_case column names, feature engineering, drop constant columns, export clean data |
| **C. Summarise** | 9–12 | Attrition breakdowns, department × role summary, CSV + Excel export, key findings |

### Engineered features
| Column | Logic |
|--------|-------|
| `attrition_flag` | 1 if `attrition == "Yes"`, else 0 |
| `age_group` | 18-25 · 26-35 · 36-45 · 46-55 · 56+ |
| `tenure_group` | 0-1 · 2-5 · 6-10 · 11+ years at company |
| `income_band` | Monthly income in 4 equal-sized groups (Low → Very High) |
| `experience_gap` | Total working years − years at company |

### Excel report: `HR_Attrition_Report.xlsx`
**Role Summary** · **Department Summary** · **Attrition Drivers** · **Stay vs Leave** · **Clean Data**

---

## 🗄️ SQL Analysis

`HR_Attrition_Analysis.sql` (MySQL) runs the same checks in SQL:

| Part | Content |
|------|---------|
| **1. Import & loading** | Create `hr_analytics` database, confirm import, rename columns to snake_case (including the BOM-affected `ï»¿Age`) |
| **2. Validation** | Row vs unique employee counts, attrition values, missing values, duplicate IDs |
| **3. Analysis** | Overall attrition rate, by department, by overtime, leavers vs stayers (income, tenure, satisfaction) |

---

## 📊 Power BI Dashboard

![HR Dashboard](1.%20Enterprise%20Business%20Intelligence%20Suite/Screenshots/hr_dashboard.png)
<sub>Update the image path to match your screenshot file.</sub>

| Row | Content |
|-----|---------|
| Header | Title, data scope, **Job Role** dropdown filter |
| KPIs | Total Employees · Total Exits · Highest Role Attrition (%) · Departments · Job Roles |
| Detail | Attrition by Department & Job Role (table) · Exits by Department |
| Drivers | Pay vs Attrition · Tenure vs Attrition · Headcount vs Exits by Job Role |

> **Data accuracy:** the dashboard uses the role-level summary table, so averages and percentages are **never added together**. Each chart uses fields that add up correctly (headcount, exits) or shows one row per department-role group.

---

## 💡 Key Findings

### Headline numbers
| Metric | Value |
|--------|------:|
| Employees | **1,470** |
| Employees who left | **237** |
| Overall attrition rate | **16.12%** |
| Exits by department | R&D **133** · Sales **92** · HR **12** |

### Attrition by job role (highest first)
| Department | Job Role | Employees | Exits | Attrition % | Avg Monthly Income | Avg Tenure (yrs) |
|------------|----------|----------:|------:|------------:|-------------------:|-----------------:|
| Sales | Sales Representative | 83 | 33 | **39.76** | 2,626 | 2.92 |
| R&D | Laboratory Technician | 259 | 62 | **23.94** | 3,237 | 5.02 |
| HR | Human Resources | 52 | 12 | **23.08** | 4,236 | 5.33 |
| Sales | Sales Executive | 326 | 57 | 17.48 | 6,924 | 7.50 |
| R&D | Research Scientist | 292 | 47 | 16.10 | 3,240 | 5.11 |
| R&D | Manufacturing Director | 145 | 10 | 6.90 | 7,295 | 7.60 |
| R&D | Healthcare Representative | 131 | 9 | 6.87 | 7,529 | 8.37 |
| R&D | Manager | 54 | 3 | 5.56 | 17,130 | 13.52 |
| Sales | Manager | 37 | 2 | 5.41 | 16,987 | 15.22 |
| R&D | Research Director | 80 | 2 | 2.50 | 16,034 | 10.94 |
| HR | Manager | 11 | 0 | 0.00 | 18,089 | 16.27 |

### Insights
- 🔴 **Sales Representatives are the highest-risk role.** About **4 in 10** leave, more than double the company average.
- 💰 **Pay matters.** The four lowest-paid roles (Sales Representatives, Laboratory Technicians, Research Scientists and HR staff) earn about **2.6K–4.2K** a month and lose **16–40%** of their people. Managers and directors earn **16K–18K** and rarely leave (**0–5.6%**).
- ⏳ **Early-tenure roles lose more people.** High-attrition roles average **3–5 years** at the company, against **11–16 years** for the roles that rarely leave.
- 🏢 **R&D has the most exits (133)** because it is the largest department. Within it, **Laboratory Technicians** and **Research Scientists** account for 109 of those exits.

### Data quality
- ✅ No missing values and no duplicate employees.
- 🗑️ `EmployeeCount`, `Over18` and `StandardHours` are constant, so they were removed.
- ⚖️ The target is imbalanced (~16% left), which matters for any future prediction model.

---

## ▶️ How to Run

```bash
# 1. Install dependencies
pip install pandas openpyxl jupyter

# 2. Put the CSV in:  1. Enterprise Business Intelligence Suite/Raw Data/

# 3. Run the notebook (Kernel → Restart & Run All)
jupyter notebook HR_Attrition_EDA_and_Summary.ipynb
```
- **SQL:** open `HR_Attrition_Analysis.sql` in MySQL Workbench. Run Part 1, import the CSV into a table named `epa` with the Table Data Import Wizard, then run the rest. Run the column-rename block **only once**.
- **Power BI:** open `IBM_HR_Analytics_Dashboard.pbix`, point the data source to `Summary/summary.csv` if asked, then click **Refresh**.

---
---

# 🛒 Project 2 — Customer 360 & Marketing Attribution Platform

### Olist Brazilian E-Commerce — Delivery Performance Analysis

## 🎯 Objective

Understand **how fast and how reliably orders reach customers**, and turn raw marketplace data into a clean, analysis-ready foundation for a Customer 360 view.

Key questions:
1. How long does delivery take, and how does it change over the year?
2. What share of orders arrive **later than promised**?
3. Are there patterns by **weekday** or **hour of purchase**?
4. What data-quality issues must be fixed before joining the tables?

---

## 📦 Dataset

**Source:** [Brazilian E-Commerce Public Dataset by Olist (Kaggle)](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
**Period:** Sep 2016 – Aug 2018 · **~99K orders** · 9 CSV files

| File | Rows | Description |
|------|-----:|-------------|
| `olist_orders_dataset.csv` | 99,441 | Order status and timeline (core table) |
| `olist_customers_dataset.csv` | 99,441 | Customer IDs and location |
| `olist_order_items_dataset.csv` | 112,650 | Products, sellers, price, freight |
| `olist_order_payments_dataset.csv` | 103,886 | Payment type, installments, value |
| `olist_order_reviews_dataset.csv` | 99,224 | Review scores and comments |
| `olist_products_dataset.csv` | 32,951 | Product category and dimensions |
| `olist_sellers_dataset.csv` | 3,095 | Seller location |
| `olist_geolocation_dataset.csv` | 1,000,163 | ZIP prefix → latitude / longitude |
| `product_category_name_translation.csv` | 71 | Portuguese → English category names |

---

## 🔄 Workflow

```
 Raw CSVs ──► EDA (health check) ──► Parse dates ──► Feature engineering ──► Order summary
                                                                                  │
   Power BI dashboard ◄── order_summary.csv ◄── Clean & validate ◄── Excel report ◄┘
```

---

## 📓 Notebook Walkthrough

`Olist_EDA_and_Order_Summary.ipynb` runs top to bottom in 12 sections:

### Part A — Exploratory Data Analysis
| # | Section | What it does |
|---|---------|--------------|
| 1 | Setup | Libraries, folder paths, constants |
| 2 | Customers | Compares `customer_id` vs `customer_unique_id` to spot repeat buyers |
| 3 | Health Check | Shape, duplicates, missing values and data types for all 9 files |
| 4 | Geolocation | Investigates and quantifies the duplicate rows |

### Part B — Order Summary Report
| # | Section | What it does |
|---|---------|--------------|
| 5 | Load & Parse | Converts 5 timestamp columns from text to datetime |
| 6 | Feature Engineering | Creates time, approval and delivery metrics |
| 7 | Summary Table | Selects 16 business-relevant columns |
| 8 | Report Sheets | Dataset overview, column dictionary, data-quality report |
| 9 | Excel Export | Writes the 4-sheet workbook |
| 10 | Clean & Validate | Keeps complete (delivered) orders and checks them automatically |
| 11 | CSV Export | Saves `order_summary.csv` for Power BI |
| 12 | Findings | Summary and next steps |

### Engineered features
| Column | Logic |
|--------|-------|
| `purchase_year`, `purchase_month`, `purchase_day` | Extracted from the purchase timestamp |
| `approval_hours` | Approval time − purchase time (hours) |
| `delivery_days` | Customer delivery − purchase (days) |
| `delivery_variance_days` | Actual − estimated delivery (days); **positive = late** |
| `is_delivered` | `order_status == "delivered"` |
| `delivery_performance` | **Early / On Time / Late** (by calendar day) or **Not Delivered** |

### Excel report: `Olist_Order_Summary_Report.xlsx`
**Order Summary** · **Dataset Overview** · **Column Dictionary** · **Data Quality**

---

## 📊 Power BI Dashboard

![E-Commerce Dashboard](2.%20Customer%20360%20and%20Marketing%20Attribution%20Platform/Screenshots/ecommerce_dashboard.png)
<sub>Update the image path to match your screenshot file.</sub>

| Row | Content |
|-----|---------|
| Header | Title, data scope, **Year** filter (2016 / 2017 / 2018) |
| KPIs | Delivered Orders · Avg Delivery Days · Median Delivery Days · Late % · Avg Approval (hrs) |
| Trends | Monthly Orders vs Late Rate · Average Delivery Time by Month |
| Breakdowns | Delivery Outcome · Late Orders by Delivery Time · Weekday Pattern · Orders by Hour |

---

## 💡 Key Findings

### Headline KPIs (delivered orders)
| Metric | Value |
|--------|------:|
| Delivered orders analysed | **96,461** |
| Average delivery time | **12.56 days** |
| Median delivery time | **10.22 days** |
| Late delivery rate | **8.11%** |
| Average payment approval time | **10.28 hours** |
| Average delivery vs estimate | **~11 days early** |

### Insights
- 🚚 **Delivery estimates are conservative.** On average orders arrive about 11 days before the promised date, so more than 9 in 10 orders arrive early.
- ⏳ **Late orders are very late.** Among late orders, most took **22+ days** in total, so problems pile up in the longest deliveries.
- 📅 **Seasonality matters.** Delivery times are longest in **Feb–Mar** and **Nov–Dec** and shortest in mid-year (around **Aug**). Late rates rise in the same peak periods.
- 🕐 **Customers shop during the day.** Orders are low overnight and stay high from about **10:00 to 22:00**.
- ⚡ **Approval is mostly instant.** The median approval time is under 30 minutes, but some orders wait much longer, which pulls the average up to ~10 hours.

### Data quality
- **Geolocation:** 261,831 exact duplicate rows. They need removing, plus one row per ZIP prefix, before joining.
- **Reviews:** most comment titles and messages are empty. This is expected because comments are optional.
- **Products:** 610 products have no category.
- **Orders:** missing delivery dates belong to orders that were never delivered (canceled, unavailable, in transit).
- **All date columns are stored as text** and must be converted.

---

## ▶️ How to Run

```bash
# 1. Install dependencies
pip install pandas openpyxl jupyter

# 2. Put the 9 Olist CSV files in:  Raw Data/

# 3. Run the notebook (Kernel → Restart & Run All)
jupyter notebook Olist_EDA_and_Order_Summary.ipynb
```
- **Power BI:** open `E_Commerce_Dashboard.pbix`, point the data source to `Summary Data/order_summary.csv` if asked, then click **Refresh**.

---
---

## 🧠 Skills Demonstrated

| Area | Project 1: HR | Project 2: E-Commerce |
|------|:-------------:|:---------------------:|
| Data cleaning & validation | ✅ | ✅ |
| Exploratory data analysis | ✅ | ✅ |
| Feature engineering | ✅ | ✅ |
| Date / time analysis | — | ✅ |
| SQL (MySQL) | ✅ | — |
| Excel reporting | ✅ | ✅ |
| Power BI dashboard design | ✅ | ✅ |
| Business insight & storytelling | ✅ | ✅ |

### ⚠️ Limitations & next steps
| Project | Next step |
|---------|-----------|
| HR | Add a DAX measure for the overall attrition rate · build a prediction model (e.g. logistic regression) · add overtime and satisfaction pages |
| E-Commerce | Join customers, payments and reviews · RFM segmentation with `customer_unique_id` · marketing attribution analysis |

---

**Karthik S**
Data Analyst Intern — Nexvia Technologies

---

<sub>Datasets: IBM HR Analytics Employee Attrition & Performance and Olist Brazilian E-Commerce, both public on Kaggle (see each dataset page for license terms). This repository is for educational purposes.</sub>
