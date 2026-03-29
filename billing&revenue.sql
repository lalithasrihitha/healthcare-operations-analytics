USE healthcare_project;

-- BILLING & REVENUE ANALYSIS


--  Average Billing Per Condition (with negatives)
WITH condition_billing AS (
    SELECT 
        Medical_condition,
        COUNT(*) AS Total_Patients,
        ROUND(AVG(Billing_amount), 2) AS Avg_Billing,
        ROUND(MIN(Billing_amount), 2) AS Min_Billing,
        ROUND(MAX(Billing_amount), 2) AS Max_Billing,
        ROUND(SUM(Billing_amount), 2) AS Total_Revenue
    FROM patients
    GROUP BY Medical_condition
)
SELECT * FROM condition_billing
ORDER BY Avg_Billing DESC;

-- ------------------------------------------------

-- Clean Billing - Remove Negative Amounts
WITH clean_billing AS (
    SELECT *
    FROM patients
    WHERE Billing_amount > 0
)
SELECT 
    Medical_condition,
    COUNT(*) AS Total_Patients,
    ROUND(AVG(Billing_amount), 2) AS Avg_Billing,
    ROUND(MIN(Billing_amount), 2) AS Min_Billing,
    ROUND(MAX(Billing_amount), 2) AS Max_Billing,
    ROUND(SUM(Billing_amount), 2) AS Total_Revenue
FROM clean_billing
GROUP BY Medical_condition
ORDER BY Avg_Billing DESC;

-- ------------------------------------------------

--  Billing by Insurance Provider
WITH insurance_billing AS (
    SELECT 
        Insurance_provider,
        COUNT(*) AS Total_Patients,
        ROUND(AVG(Billing_amount), 2) AS Avg_Billing,
        ROUND(SUM(Billing_amount), 2) AS Total_Billed
    FROM patients
    WHERE Billing_amount > 0
    GROUP BY Insurance_provider
)
SELECT *,
    ROUND(Total_Billed * 100.0 / SUM(Total_Billed) OVER(), 2) AS Revenue_Percentage
FROM insurance_billing
ORDER BY Avg_Billing DESC;

-- Billing Outlier Detection
-- Patients billed more than 2 standard deviations above average
WITH avg_billing AS (
    SELECT 
        Medical_condition,
        AVG(Billing_amount) AS Condition_Avg,
        STDDEV(Billing_amount) AS Condition_Stddev
    FROM patients
    WHERE Billing_amount > 0
    GROUP BY Medical_condition
),
patient_billing AS (
    SELECT 
        p.Name,
        p.Medical_condition,
        p.Billing_amount,
        p.Insurance_provider,
        a.Condition_Avg,
        ROUND(p.Billing_amount - a.Condition_Avg, 2) AS Difference_From_Avg
    FROM patients p
    JOIN avg_billing a 
        ON p.Medical_condition = a.Medical_condition
    WHERE p.Billing_amount > (a.Condition_Avg + 2 * a.Condition_Stddev)
)
SELECT * FROM patient_billing
ORDER BY Billing_amount DESC
LIMIT 10;


--  Billing by Admission Type
WITH admission_billing AS (
    SELECT 
        Admission_type,
        COUNT(*) AS Total_Patients,
        ROUND(AVG(Billing_amount), 2) AS Avg_Billing,
        ROUND(SUM(Billing_amount), 2) AS Total_Revenue
    FROM patients
    WHERE Billing_amount > 0
    GROUP BY Admission_type
)
SELECT *,
    ROUND(Total_Revenue * 100.0 / SUM(Total_Revenue) OVER(), 2) AS Revenue_Percentage
FROM admission_billing
ORDER BY Avg_Billing DESC;

--  Yearly Revenue Trend with LAG
WITH yearly_revenue AS (
    SELECT 
        YEAR(Date_of_Admission) AS Admission_Year,
        COUNT(*) AS Total_Patients,
        ROUND(SUM(Billing_amount), 2) AS Total_Revenue,
        ROUND(AVG(Billing_amount), 2) AS Avg_Billing
    FROM patients
    WHERE Billing_amount > 0
    GROUP BY Admission_Year
)
SELECT *,
    ROUND(Total_Revenue - LAG(Total_Revenue) OVER(ORDER BY Admission_Year), 2) AS Revenue_Change,
    ROUND((Total_Revenue - LAG(Total_Revenue) OVER(ORDER BY Admission_Year)) 
        * 100.0 / LAG(Total_Revenue) OVER(ORDER BY Admission_Year), 2) AS Growth_Percentage
FROM yearly_revenue
ORDER BY Admission_Year;