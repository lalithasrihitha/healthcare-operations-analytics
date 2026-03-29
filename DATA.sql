USE healthcare_project;

SELECT COUNT(*) AS Total_Patients
FROM patients;

#GENDER DISTRIBUTION
SELECT Gender, 
       COUNT(*) AS Total_Patients
FROM patients
GROUP BY Gender;

select gender,
       count(*) as Total_Patients,
       Round(Count(*) * 100.0 / SUM 4(COUNT(*)) OVER (), 2) AS PERCENTAGE 
FROM Patients
Group by Gender;

#AGE DISTRIBUTION
SELECT 
       CASE
            WHEN Age Between 0 and 18 then '0-18 Children'
            WHEN Age Between 19 and 35 then '19-35 Young Adults'
            WHEN Age Between 36 and 50 then '36-50 Middle Aged'
            WHEN Age between 51 and 65 then '51-65 Senior Adults'
            ELSE '65+ Elderly'
            
	  END AS Age_Group, 
      COUNT(*) AS Total_Patients, 
      ROUND (COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS Percentage
FROM patients
GROUP BY Age_Group
ORDER BY Total_Patients DESC;

#MEDICAL CONDITION DISTRIBUTION
Select Medical_condition, 
       COUNT(*) AS Total_Patients,
       ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() , 2) AS Percentage 
FROM patients
Group by Medical_condition
Order by Total_Patients DESC;

#BLOOD TYPE DISTRIBUTION
SELECT Blood_Type, 
       COUNT(*) AS Total_Patients,
       ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS Percentage
FROM patients 
Group by Blood_Type 
Order by Total_Patients DESC;

#INSURANCE PROVIDER DISTRIBUTION
SELECT Insurance_Provider, 
COUNT(*) AS Total_Patients, 
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS Percentage 
from patients 
Group by Insurance_Provider 
Order by Total_Patients DESC;

#ADMISSION TYPE BREAKDOWN
SELECT Admission_type,
       COUNT(*) AS Total_Patients,
       ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS Percentage
FROM patients
GROUP BY Admission_type
ORDER BY Total_Patients DESC;
      