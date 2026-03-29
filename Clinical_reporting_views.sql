USE healthcare_project;
CREATE VIEW patient_summary AS
SELECT 
    Name,
    Age,
    Gender,
    Blood_type,
    Medical_condition,
    Date_of_Admission,
    Discharge_date,
    DATEDIFF(Discharge_date, Date_of_Admission) AS Length_of_Stay,
    Doctor,
    Hospital,
    Insurance_provider,
    ROUND(Billing_amount, 2) AS Billing_amount,
    Admission_type,
    Medication,
    Test_results,
    CASE
        WHEN Test_results = 'Abnormal' 
             AND Medical_condition IN ('Cancer', 'Diabetes', 'Hypertension') 
             THEN 'High Risk'
        WHEN Test_results = 'Abnormal' 
             THEN 'Medium Risk'
        WHEN Test_results = 'Inconclusive' 
             THEN 'Needs Review'
        ELSE 'Low Risk'
    END AS Risk_Level
FROM patients
WHERE Billing_amount > 0;

SELECT * FROM patient_summary
LIMIT 10;

CREATE VIEW hospital_performance AS
SELECT 
    Hospital,
    COUNT(*) AS Total_Patients,
    ROUND(AVG(Billing_amount), 2) AS Avg_Billing,
    ROUND(SUM(Billing_amount), 2) AS Total_Revenue,
    SUM(CASE WHEN Test_results = 'Abnormal' THEN 1 ELSE 0 END) AS Abnormal_Count,
    ROUND(SUM(CASE WHEN Test_results = 'Abnormal' THEN 1 ELSE 0 END) 
        * 100.0 / COUNT(*), 2) AS Abnormal_Percentage,
    ROUND(AVG(DATEDIFF(Discharge_date, Date_of_Admission)), 1) AS Avg_Length_of_Stay
FROM patients
WHERE Billing_amount > 0
GROUP BY Hospital;

SELECT * FROM hospital_performance
ORDER BY Total_Revenue DESC
LIMIT 10;

