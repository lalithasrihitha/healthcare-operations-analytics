#Data cleaning 

USE healthcare_project;

select Name 
From Patients 
LIMIT 20;

SELECT 
    Name AS Original_Name,
    CONCAT(
        UPPER(SUBSTRING(SUBSTRING_INDEX(Name, ' ', 1), 1, 1)),
        LOWER(SUBSTRING(SUBSTRING_INDEX(Name, ' ', 1), 2)),
        ' ',
        UPPER(SUBSTRING(SUBSTRING_INDEX(Name, ' ', -1), 1, 1)),
        LOWER(SUBSTRING(SUBSTRING_INDEX(Name, ' ', -1), 2))
    ) AS Clean_Name
FROM patients
LIMIT 20;

#Updating table with these names:
UPDATE patients
SET Name = CONCAT(
        UPPER(SUBSTRING(SUBSTRING_INDEX(Name, ' ', 1), 1, 1)),
        LOWER(SUBSTRING(SUBSTRING_INDEX(Name, ' ', 1), 2)),
        ' ',
        UPPER(SUBSTRING(SUBSTRING_INDEX(Name, ' ', -1), 1, 1)),
        LOWER(SUBSTRING(SUBSTRING_INDEX(Name, ' ', -1), 2))
    );
    
SELECT Name 
FROM patients 
LIMIT 20;

#stay of patients 
SELECT 
    Name,
    Medical_condition,
    Date_of_Admission,
    Discharge_date,
    DATEDIFF(Discharge_date, Date_of_Admission) AS Length_of_Stay
FROM patients
LIMIT 20;

#average length of stay per condition
SELECT 
    Medical_condition,
    ROUND(AVG(DATEDIFF(Discharge_date, Date_of_Admission)), 1) AS Avg_Stay_Days,
    MIN(DATEDIFF(Discharge_date, Date_of_Admission)) AS Min_Stay,
    MAX(DATEDIFF(Discharge_date, Date_of_Admission)) AS Max_Stay
FROM patients
GROUP BY Medical_condition
ORDER BY Avg_Stay_Days DESC;

#how many patients were admitted each year
SELECT 
    YEAR(Date_of_Admission) AS Admission_Year,
    COUNT(*) AS Total_Patients
FROM patients
GROUP BY Admission_Year
ORDER BY Admission_Year ASC;

#high risk patients 
SELECT 
    Name,
    Medical_condition,
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
LIMIT 20;

#risk level for all patients 
SELECT 
    CASE
        WHEN Test_results = 'Abnormal' 
             AND Medical_condition IN ('Cancer', 'Diabetes', 'Hypertension') 
             THEN 'High Risk'
        WHEN Test_results = 'Abnormal' 
             THEN 'Medium Risk'
        WHEN Test_results = 'Inconclusive' 
             THEN 'Needs Review'
        ELSE 'Low Risk'
    END AS Risk_Level,
    COUNT(*) AS Total_Patients,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS Percentage
FROM patients
GROUP BY Risk_Level
ORDER BY Total_Patients DESC;