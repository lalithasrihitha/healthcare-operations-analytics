USE healthcare_project;
#hospitals seeing most patients

SELECT 
    Hospital,
    COUNT(*) AS Total_Patients,
    SUM(CASE WHEN Test_results = 'Abnormal' THEN 1 ELSE 0 END) AS Abnormal_Count,
    ROUND(SUM(CASE WHEN Test_results = 'Abnormal' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Abnormal_Percentage
FROM patients
GROUP BY Hospital
HAVING Total_Patients >= 20
ORDER BY Abnormal_Percentage DESC
LIMIT 10;

#Doctor Workload Analysis 
SELECT 
    Doctor,
    COUNT(*) AS Total_Patients,
    COUNT(DISTINCT Medical_condition) AS Conditions_Treated,
    ROUND(AVG(Billing_amount), 2) AS Avg_Billing
FROM patients
GROUP BY Doctor
ORDER BY Total_Patients DESC
LIMIT 10;

#Which doctors bill ABOVE the hospital average

SELECT 
    Doctor,
    ROUND(AVG(Billing_amount), 2) AS Doctor_Avg_Billing,
    (SELECT ROUND(AVG(Billing_amount), 2) 
     FROM patients) AS Hospital_Avg_Billing,
    ROUND(AVG(Billing_amount) - 
        (SELECT AVG(Billing_amount) FROM patients), 2) AS Difference
FROM patients
GROUP BY Doctor
HAVING Doctor_Avg_Billing > (SELECT AVG(Billing_amount) FROM patients)
ORDER BY Doctor_Avg_Billing DESC
LIMIT 10;

CREATE TABLE doctors (
    Doctor_ID INT AUTO_INCREMENT PRIMARY KEY,
    Doctor_Name VARCHAR(100),
    Specialty VARCHAR(50),
    Experience_Years INT,
    Department VARCHAR(50)
);

INSERT INTO doctors (Doctor_Name, Specialty, Experience_Years, Department)
VALUES 
('Michael Smith', 'Cardiology', 15, 'Cardiac Care'),
('John Smith', 'Oncology', 12, 'Cancer Center'),
('Robert Smith', 'Endocrinology', 10, 'Diabetes Care'),
('Michael Johnson', 'Pulmonology', 8, 'Respiratory'),
('James Smith', 'Rheumatology', 20, 'Arthritis Clinic'),
('Robert Johnson', 'Nephrology', 14, 'Kidney Care'),
('David Smith', 'Cardiology', 11, 'Cardiac Care'),
('Michael Williams', 'Oncology', 9, 'Cancer Center'),
('Christopher Smith', 'Endocrinology', 7, 'Diabetes Care'),
('Matthew Smith', 'Pulmonology', 16, 'Respiratory');

SELECT 
    p.Name AS Patient_Name,
    p.Medical_condition,
    p.Billing_amount,
    d.Doctor_Name,
    d.Specialty,
    d.Department,
    d.Experience_Years
FROM patients p
INNER JOIN doctors d 
    ON p.Doctor = d.Doctor_Name
LIMIT 10;

SELECT * FROM doctors;

DELETE FROM doctors;
ALTER TABLE doctors AUTO_INCREMENT = 1;
INSERT INTO doctors (Doctor_Name, Specialty, Experience_Years, Department)
VALUES 
('Michael Smith', 'Cardiology', 15, 'Cardiac Care'),
('John Smith', 'Oncology', 12, 'Cancer Center'),
('Robert Smith', 'Endocrinology', 10, 'Diabetes Care'),
('Michael Johnson', 'Pulmonology', 8, 'Respiratory'),
('James Smith', 'Rheumatology', 20, 'Arthritis Clinic'),
('Robert Johnson', 'Nephrology', 14, 'Kidney Care'),
('David Smith', 'Cardiology', 11, 'Cardiac Care'),
('Michael Williams', 'Oncology', 9, 'Cancer Center'),
('Christopher Smith', 'Endocrinology', 7, 'Diabetes Care'),
('Matthew Smith', 'Pulmonology', 16, 'Respiratory');

DELETE FROM doctors 
WHERE Doctor_Name IS NULL;

SELECT * FROM doctors;

TRUNCATE TABLE doctors;

INSERT INTO doctors (Doctor_Name, Specialty, Experience_Years, Department)
VALUES 
('Michael Smith', 'Cardiology', 15, 'Cardiac Care'),
('John Smith', 'Oncology', 12, 'Cancer Center'),
('Robert Smith', 'Endocrinology', 10, 'Diabetes Care'),
('Michael Johnson', 'Pulmonology', 8, 'Respiratory'),
('James Smith', 'Rheumatology', 20, 'Arthritis Clinic'),
('Robert Johnson', 'Nephrology', 14, 'Kidney Care'),
('David Smith', 'Cardiology', 11, 'Cardiac Care'),
('Michael Williams', 'Oncology', 9, 'Cancer Center'),
('Christopher Smith', 'Endocrinology', 7, 'Diabetes Care'),
('Matthew Smith', 'Pulmonology', 16, 'Respiratory');

SELECT * FROM doctors;

SELECT COUNT(*) AS Total_Doctors 
FROM doctors;

SELECT 
    p.Name AS Patient_Name,
    p.Medical_condition,
    p.Billing_amount,
    d.Doctor_Name,
    d.Specialty,
    d.Department,
    d.Experience_Years
FROM patients p
INNER JOIN doctors d 
    ON p.Doctor = d.Doctor_Name
LIMIT 10;

#ALL patients even if their doctor is not in our doctors table
SELECT 
    p.Name AS Patient_Name,
    p.Medical_condition,
    p.Doctor,
    d.Specialty,
    d.Department
FROM patients p
LEFT JOIN doctors d 
    ON p.Doctor = d.Doctor_Name
WHERE d.Doctor_Name IS NULL
LIMIT 10;