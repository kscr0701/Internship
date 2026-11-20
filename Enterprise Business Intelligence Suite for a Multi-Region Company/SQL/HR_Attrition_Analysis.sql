/* =====================================================================
   HR ANALYTICS — EMPLOYEE ATTRITION
   Dataset : IBM HR Analytics Employee Attrition & Performance
   Database: hr_analytics        Table: epa
   Engine  : MySQL 8.0+

   Script flow
   -----------
   PART 1  Data import & loading
           1.1 Create and select the database
           1.2 Confirm the imported table
           1.3 Standardise column names (CamelCase → snake_case)
   PART 2  Data validation
           2.1 Row and employee counts
           2.2 Attrition values
           2.3 Missing values
           2.4 Duplicate employees
   PART 3  Attrition analysis
           3.1 Overall attrition rate
           3.2 Attrition by department
           3.3 Overtime comparison
           3.4 Leavers vs stayers (salary, tenure, satisfaction)
   ===================================================================== */


/* =====================================================================
   PART 1 — DATA IMPORT & LOADING
   ===================================================================== */

-- ---------------------------------------------------------------------
-- 1.1 Create and select the database
-- IF NOT EXISTS lets the script be re-run without an error.
-- ---------------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS hr_analytics;

USE hr_analytics;

-- ---------------------------------------------------------------------
-- NOTE: Import the CSV before continuing.
-- In MySQL Workbench: right-click hr_analytics → Table Data Import Wizard
-- → choose "IBM HR Analytics Employee Attrition & Performance.csv"
-- → create a new table named `epa`.
-- ---------------------------------------------------------------------

-- ---------------------------------------------------------------------
-- 1.2 Confirm the imported table
-- ---------------------------------------------------------------------

-- The table `epa` should appear in the list
SHOW TABLES;

-- Preview the first 10 rows
SELECT *
FROM epa
LIMIT 10;

-- Expected: 1,470 rows
SELECT COUNT(*) AS row_count
FROM epa;

-- ---------------------------------------------------------------------
-- 1.3 Standardise column names (CamelCase → snake_case)
-- Makes names consistent with the Python notebook and easier to type.
--
-- `ï»¿Age`: the CSV was saved with a hidden UTF-8 BOM (byte-order mark),
-- which the import attached to the first column name. The backticks let
-- MySQL read this unusual name.
--
-- ⚠️ Run this block ONCE. Running it again fails because the old
--    column names no longer exist.
-- ---------------------------------------------------------------------
ALTER TABLE epa
    RENAME COLUMN `ï»¿Age`                  TO age,
    RENAME COLUMN Attrition                 TO attrition,
    RENAME COLUMN BusinessTravel            TO business_travel,
    RENAME COLUMN DailyRate                 TO daily_rate,
    RENAME COLUMN Department                TO department,
    RENAME COLUMN DistanceFromHome          TO distance_from_home,
    RENAME COLUMN Education                 TO education,
    RENAME COLUMN EducationField            TO education_field,
    RENAME COLUMN EmployeeCount             TO employee_count,
    RENAME COLUMN EmployeeNumber            TO employee_number,
    RENAME COLUMN EnvironmentSatisfaction   TO environment_satisfaction,
    RENAME COLUMN Gender                    TO gender,
    RENAME COLUMN HourlyRate                TO hourly_rate,
    RENAME COLUMN JobInvolvement            TO job_involvement,
    RENAME COLUMN JobLevel                  TO job_level,
    RENAME COLUMN JobRole                   TO job_role,
    RENAME COLUMN JobSatisfaction           TO job_satisfaction,
    RENAME COLUMN MaritalStatus             TO marital_status,
    RENAME COLUMN MonthlyIncome             TO monthly_income,
    RENAME COLUMN MonthlyRate               TO monthly_rate,
    RENAME COLUMN NumCompaniesWorked        TO num_companies_worked,
    RENAME COLUMN Over18                    TO over_18,
    RENAME COLUMN OverTime                  TO over_time,
    RENAME COLUMN PercentSalaryHike         TO percent_salary_hike,
    RENAME COLUMN PerformanceRating         TO performance_rating,
    RENAME COLUMN RelationshipSatisfaction  TO relationship_satisfaction,
    RENAME COLUMN StandardHours             TO standard_hours,
    RENAME COLUMN StockOptionLevel          TO stock_option_level,
    RENAME COLUMN TotalWorkingYears         TO total_working_years,
    RENAME COLUMN TrainingTimesLastYear     TO training_times_last_year,
    RENAME COLUMN WorkLifeBalance           TO work_life_balance,
    RENAME COLUMN YearsAtCompany            TO years_at_company,
    RENAME COLUMN YearsInCurrentRole        TO years_in_current_role,
    RENAME COLUMN YearsSinceLastPromotion   TO years_since_last_promotion,
    RENAME COLUMN YearsWithCurrManager      TO years_with_curr_manager;

-- Check the new column names and their data types
DESCRIBE epa;


/* =====================================================================
   PART 2 — DATA VALIDATION
   Confirm the data is complete and has no duplicates before analysing it.
   ===================================================================== */

-- ---------------------------------------------------------------------
-- 2.1 Row and employee counts
-- If both numbers match, each employee appears exactly once.
-- ---------------------------------------------------------------------
SELECT COUNT(*) AS total_employees
FROM epa;

SELECT COUNT(DISTINCT employee_number) AS unique_employees
FROM epa;

-- ---------------------------------------------------------------------
-- 2.2 Attrition values
-- Should return only 'Yes' and 'No' (no blanks or misspellings).
-- ---------------------------------------------------------------------
SELECT
    attrition,
    COUNT(*) AS employee_count
FROM epa
GROUP BY attrition;

-- ---------------------------------------------------------------------
-- 2.3 Missing values in key columns
-- In MySQL, a TRUE/FALSE condition counts as 1/0, so
-- SUM(column IS NULL) counts the missing rows. Expected: all 0.
-- ---------------------------------------------------------------------
SELECT
    SUM(attrition       IS NULL) AS missing_attrition,
    SUM(employee_number IS NULL) AS missing_employee_id,
    SUM(monthly_income  IS NULL) AS missing_monthly_income
FROM epa;

-- ---------------------------------------------------------------------
-- 2.4 Duplicate employees
-- Lists any employee_number that appears more than once.
-- Expected: no rows returned.
-- ---------------------------------------------------------------------
SELECT
    employee_number,
    COUNT(*) AS occurrences
FROM epa
GROUP BY employee_number
HAVING COUNT(*) > 1;


/* =====================================================================
   PART 3 — ATTRITION ANALYSIS
   Attrition rate (%) = employees who left / total employees × 100
   (100.0 makes MySQL keep the decimals in the division.)
   ===================================================================== */

-- ---------------------------------------------------------------------
-- 3.1 Overall attrition rate
-- The baseline that every group below is compared against.
-- ---------------------------------------------------------------------
SELECT
    COUNT(*)                AS total_employees,
    SUM(attrition = 'Yes')  AS employees_left,
    SUM(attrition = 'No')   AS employees_retained,
    ROUND(100.0 * SUM(attrition = 'Yes') / COUNT(*), 2) AS attrition_rate_pct
FROM epa;

-- ---------------------------------------------------------------------
-- 3.2 Attrition by department
-- Which departments lose the most staff? Sorted highest rate first.
-- ---------------------------------------------------------------------
SELECT
    department,
    COUNT(*)                AS employee_count,
    SUM(attrition = 'Yes')  AS employees_left,
    ROUND(100.0 * SUM(attrition = 'Yes') / COUNT(*), 2) AS attrition_rate_pct
FROM epa
GROUP BY department
ORDER BY attrition_rate_pct DESC;

-- ---------------------------------------------------------------------
-- 3.3 Overtime comparison
-- Do employees who work overtime leave more often?
-- ---------------------------------------------------------------------
SELECT
    over_time,
    COUNT(*)                AS employee_count,
    SUM(attrition = 'Yes')  AS employees_left,
    ROUND(100.0 * SUM(attrition = 'Yes') / COUNT(*), 2) AS attrition_rate_pct
FROM epa
GROUP BY over_time
ORDER BY attrition_rate_pct DESC;

-- ---------------------------------------------------------------------
-- 3.4 Leavers vs stayers — salary gap, tenure, satisfaction
-- Compares the average profile of employees who left ('Yes')
-- with those who stayed ('No').
-- ---------------------------------------------------------------------
SELECT
    attrition,
    COUNT(*)                         AS employee_count,
    ROUND(AVG(monthly_income), 2)    AS avg_monthly_income,
    ROUND(AVG(years_at_company), 2)  AS avg_tenure,
    ROUND(AVG(job_satisfaction), 2)  AS avg_job_satisfaction   -- scale 1 (low) to 4 (high)
FROM epa
GROUP BY attrition;

/* ======================== END OF SCRIPT ======================== */
