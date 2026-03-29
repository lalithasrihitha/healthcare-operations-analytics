SELECT 
    Name,
    Medical_condition,
    Billing_amount,
    ROW_NUMBER() OVER(ORDER BY Billing_amount DESC) AS Row_Num
FROM patients
LIMIT 10;
SELECT 
    Name,
    Medical_condition,
    Billing_amount,
    ROW_NUMBER() OVER(ORDER BY Billing_amount DESC) AS Row_Num,
    RANK() OVER(ORDER BY Billing_amount DESC) AS Rank_Num,
    DENSE_RANK() OVER(ORDER BY Billing_amount DESC) AS Dense_Rank_Num
FROM patients
LIMIT 10;
SELECT 
    Name,
    Medical_condition,
    Billing_amount,
    RANK() OVER(
        PARTITION BY Medical_condition 
        ORDER BY Billing_amount DESC
    ) AS Rank_Within_Condition
FROM patients
ORDER BY Medical_condition, Rank_Within_Condition
LIMIT 15;
SELECT 
    Name,
    Medical_condition,
    Billing_amount,
    NTILE(4) OVER(ORDER BY Billing_amount DESC) AS Billing_Quartile,
    CASE NTILE(4) OVER(ORDER BY Billing_amount DESC)
        WHEN 1 THEN 'Top 25% High Billing'
        WHEN 2 THEN 'Upper Middle 25%'
        WHEN 3 THEN 'Lower Middle 25%'
        WHEN 4 THEN 'Bottom 25% Low Billing'
    END AS Billing_Category
FROM patients
WHERE Billing_amount > 0
LIMIT 15;
SELECT 
    YEAR(Date_of_Admission) AS Year,
    MONTH(Date_of_Admission) AS Month,
    ROUND(SUM(Billing_amount), 2) AS Monthly_Revenue,
    ROUND(SUM(SUM(Billing_amount)) OVER(
        ORDER BY YEAR(Date_of_Admission), 
        MONTH(Date_of_Admission)
    ), 2) AS Running_Total
FROM patients
WHERE Billing_amount > 0
GROUP BY Year, Month
ORDER BY Year, Month
LIMIT 15;
SELECT 
    Name,
    Medical_condition,
    Date_of_Admission,
    Billing_amount,
    LEAD(Billing_amount) OVER(
        ORDER BY Date_of_Admission
    ) AS Next_Patient_Billing,
    ROUND(LEAD(Billing_amount) OVER(
        ORDER BY Date_of_Admission) 
        - Billing_amount, 2) AS Billing_Difference
FROM patients
LIMIT 15;