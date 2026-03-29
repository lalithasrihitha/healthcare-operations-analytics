DELIMITER //

CREATE PROCEDURE get_condition_report(IN condition_name VARCHAR(50))
BEGIN
    SELECT 
        Medical_condition,
        COUNT(*) AS Total_Patients,
        ROUND(AVG(Billing_amount), 2) AS Avg_Billing,
        ROUND(SUM(Billing_amount), 2) AS Total_Revenue,
        ROUND(AVG(DATEDIFF(Discharge_date, Date_of_Admission)), 1) AS Avg_Stay_Days,
        SUM(CASE WHEN Test_results = 'Abnormal' THEN 1 ELSE 0 END) AS Abnormal_Count,
        ROUND(SUM(CASE WHEN Test_results = 'Abnormal' THEN 1 ELSE 0 END) 
            * 100.0 / COUNT(*), 2) AS Abnormal_Percentage
    FROM patients
    WHERE Medical_condition = condition_name
    AND Billing_amount > 0
    GROUP BY Medical_condition;
END //

DELIMITER ;

CALL get_condition_report('Diabetes');

CALL get_condition_report('Cancer');

CALL get_condition_report('Asthma');

CALL get_condition_report('Hypertension');

DELIMITER //

CREATE PROCEDURE get_insurance_report(IN insurance_name VARCHAR(50))
BEGIN
    SELECT 
        Insurance_provider,
        COUNT(*) AS Total_Patients,
        ROUND(AVG(Billing_amount), 2) AS Avg_Billing,
        ROUND(SUM(Billing_amount), 2) AS Total_Revenue,
        SUM(CASE WHEN Test_results = 'Abnormal' THEN 1 ELSE 0 END) AS Abnormal_Count,
        SUM(CASE WHEN Admission_type = 'Emergency' THEN 1 ELSE 0 END) AS Emergency_Count
    FROM patients
    WHERE Insurance_provider = insurance_name
    AND Billing_amount > 0
    GROUP BY Insurance_provider;
END //

DELIMITER ;

CALL get_insurance_report('Medicare');