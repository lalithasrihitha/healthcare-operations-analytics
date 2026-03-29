USE healthcare_project ;

Create table patients(
             Name varchar(100),
             Age Int, 
             Gender Varchar(10), 
             Blood_type varchar (5),
             Medical_condition Varchar(50),
             Date_of_Admission date ,
             Doctor varchar(100),
             Hospital varchar(200), 
             Insurance_provider varchar(100),
             Billing_amount decimal(20,2),
             Room_number int,
             Admission_type varchar(20),
             Discharge_date DATE,
             Medication varchar(100),
             Test_results varchar(50)
             );
             