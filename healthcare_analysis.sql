CREATE DATABASE healthcare_db;
USE healthcare_db;

USE healthcare_db;

CREATE TABLE Patients (
    Patient_ID INT PRIMARY KEY,
    Patient_Name VARCHAR(100),
    Age INT,
    Gender VARCHAR(20),
    City VARCHAR(50),
    Blood_Group VARCHAR(10),
    Primary_Diagnosis VARCHAR(100)
);

SELECT COUNT(*) 
FROM Patients;

SELECT *
FROM Patients
LIMIT 10;

SELECT
    COUNT(*) AS Total_Rows,
    SUM(Patient_Name IS NULL) AS Null_Name,
    SUM(Age IS NULL) AS Null_Age,
    SUM(Gender IS NULL) AS Null_Gender,
    SUM(City IS NULL) AS Null_City,
    SUM(Blood_Group IS NULL) AS Null_Blood_Group,
    SUM(Primary_Diagnosis IS NULL) AS Null_Diagnosis
FROM Patients;


SELECT Patient_ID, COUNT(*) AS Count_ID
FROM Patients
GROUP BY Patient_ID
HAVING COUNT(*) > 1;

SELECT Patient_ID, COUNT(*) AS Count_ID
FROM Patients
GROUP BY Patient_ID
HAVING COUNT(*) > 1;

SELECT Patient_ID, COUNT(*) AS Count_ID
FROM Patients
GROUP BY Patient_ID
HAVING COUNT(*) > 1;

SELECT COUNT(*) AS Total_Patients
FROM Patients;

SELECT COUNT(*) AS Null_Patient_ID
FROM Patients
WHERE Patient_ID IS NULL;

SELECT *
FROM Patients
WHERE Age < 0 OR Age > 100;

SELECT COUNT(*) AS Invalid_Age
FROM Patients
WHERE Age < 0 OR Age > 100;

UPDATE Patients
SET Age = NULL
WHERE Patient_ID IS NOT NULL
  AND (Age < 0 OR Age > 100);
  
  SET SQL_SAFE_UPDATES = 0;
  
  UPDATE Patients
SET Age = NULL
WHERE Age < 0 OR Age > 100;

SELECT COUNT(*) AS Invalid_Age
FROM Patients
WHERE Age < 0 OR Age > 100;

SELECT Gender, COUNT(*) AS Count_Gender
FROM Patients
GROUP BY Gender;


UPDATE Patients
SET Gender = 'Male'
WHERE TRIM(LOWER(Gender)) = 'male';

SELECT COUNT(*) AS Blank_Gender
FROM Patients
WHERE Gender IS NULL OR TRIM(Gender) = '';

UPDATE Patients
SET Gender = 'Unknown'
WHERE Gender IS NULL OR TRIM(Gender) = '';

SELECT Blood_Group, COUNT(*) AS Count_Blood_Group
FROM Patients
GROUP BY Blood_Group;

UPDATE Patients
SET Blood_Group = TRIM(Blood_Group)
WHERE Blood_Group IS NOT NULL;

UPDATE Patients
SET Blood_Group = 'Unknown'
WHERE Blood_Group IS NULL OR TRIM(Blood_Group) = '';

SELECT City, COUNT(*) AS Count_City
FROM Patients
GROUP BY City;

UPDATE Patients
SET City = TRIM(City)
WHERE City IS NOT NULL;

UPDATE Patients
SET City = 'Unknown'
WHERE City IS NULL OR TRIM(City) = '';

SELECT Primary_Diagnosis, COUNT(*) AS Count_Diagnosis
FROM Patients
GROUP BY Primary_Diagnosis;

UPDATE Patients
SET Primary_Diagnosis = TRIM(Primary_Diagnosis)
WHERE Primary_Diagnosis IS NOT NULL;

SELECT COUNT(*) AS Blank_Diagnosis
FROM Patients
WHERE Primary_Diagnosis IS NULL
   OR TRIM(Primary_Diagnosis) = '';
   
   UPDATE Patients
SET Primary_Diagnosis = 'Unknown'
WHERE Primary_Diagnosis IS NULL
   OR TRIM(Primary_Diagnosis) = '';
   
   SELECT Patient_ID, COUNT(*) AS Count_ID
FROM Patients
GROUP BY Patient_ID
HAVING COUNT(*) > 1;

SELECT COUNT(*) AS Blank_Name
FROM Patients
WHERE Patient_Name IS NULL
   OR TRIM(Patient_Name) = '';
   
   
   UPDATE Patients
SET Patient_Name = 'Unknown'
WHERE Patient_Name IS NULL
   OR TRIM(Patient_Name) = '';
   
   SELECT Patient_Name
FROM Patients
WHERE Patient_Name <> TRIM(Patient_Name);

UPDATE Patients
SET Patient_Name = TRIM(Patient_Name)
WHERE Patient_Name IS NOT NULL;

SELECT Patient_Name, COUNT(*) AS Name_Count
FROM Patients
GROUP BY Patient_Name
HAVING COUNT(*) > 1;

SELECT MIN(Patient_ID) AS Min_ID,
       MAX(Patient_ID) AS Max_ID,
       COUNT(DISTINCT Patient_ID) AS Unique_IDs
FROM Patients;

-- Doctors

CREATE TABLE Doctors (
    Doctor_ID INT PRIMARY KEY,
    Doctor_Name VARCHAR(100),
    Specialization VARCHAR(100),
    Experience_Years INT,
    Hospital VARCHAR(100)
);


SELECT COUNT(*) AS Total_Doctors
FROM Doctors;

SELECT Doctor_ID, COUNT(*) AS Count_ID
FROM Doctors
GROUP BY Doctor_ID
HAVING COUNT(*) > 1;

SELECT COUNT(*) AS Blank_Doctor_Name
FROM Doctors
WHERE Doctor_Name IS NULL
   OR TRIM(Doctor_Name) = '';
   
   SELECT Specialization, COUNT(*) AS Count_Specialization
FROM Doctors
GROUP BY Specialization;

SELECT *
FROM Doctors
WHERE Experience_Years < 0
   OR Experience_Years > 50;
   
   SELECT COUNT(*) AS Blank_Experience
FROM Doctors
WHERE Experience_Years IS NULL;

UPDATE Doctors
SET Experience_Years = 0
WHERE Experience_Years IS NULL;

SELECT Hospital, COUNT(*) AS Count_Hospital
FROM Doctors
GROUP BY Hospital;


UPDATE Doctors
SET Hospital = 'Unknown'
WHERE Hospital IS NULL OR TRIM(Hospital) = '';

-- Appointments

CREATE TABLE Appointments (
    Appointment_ID INT PRIMARY KEY,
    Patient_ID INT,
    Doctor_ID INT,
    Appointment_Date DATE,
    Appointment_Status VARCHAR(50),
    Reason varchar(100)
);

SELECT COUNT(*) AS Total_Appointments
FROM Appointments;

SELECT Appointment_ID, COUNT(*) AS Count_ID
FROM Appointments
GROUP BY Appointment_ID
HAVING COUNT(*) > 1;

SELECT COUNT(*) AS Invalid_Patient_ID
FROM Appointments
WHERE Patient_ID NOT IN (
    SELECT Patient_ID
    FROM Patients
);

UPDATE Appointments
SET Patient_ID = NULL
WHERE Patient_ID NOT IN (
    SELECT Patient_ID
    FROM Patients
);

SELECT COUNT(*) AS Invalid_Doctor_ID
FROM Appointments
WHERE Doctor_ID NOT IN (
    SELECT Doctor_ID
    FROM Doctors
);

SELECT COUNT(*) AS Blank_Appointment_Date
FROM Appointments
WHERE Appointment_Date IS NULL;

SELECT Appointment_Status, COUNT(*) AS Count_Status
FROM Appointments
GROUP BY Appointment_Status;

UPDATE Appointments
SET Appointment_Status = TRIM(Appointment_Status);

UPDATE Appointments
SET Appointment_Status = 'Completed'
WHERE LOWER(Appointment_Status) = 'completed';

UPDATE Appointments
SET Appointment_Status = 'Unknown'
WHERE Appointment_Status IS NULL
   OR TRIM(Appointment_Status) = '';
   
   
   -- Treatments
   
   
   
   CREATE TABLE Treatments (
    Treatment_ID INT PRIMARY KEY,
    Patient_ID INT,
    Doctor_ID INT,
    Treatment_Date DATE,
    Treatment_Type VARCHAR(100),
    Treatment_Cost DECIMAL(10,2)
);

SELECT COUNT(*) AS Total_Treatments
FROM Treatments;

SELECT Treatment_ID, COUNT(*) AS Count_ID
FROM Treatments
GROUP BY Treatment_ID
HAVING COUNT(*) > 1;

SELECT COUNT(*) AS Invalid_Patient_ID
FROM Treatments
WHERE Patient_ID NOT IN (
    SELECT Patient_ID
    FROM Patients
);

UPDATE Treatments
SET Patient_ID = NULL
WHERE Patient_ID NOT IN (
    SELECT Patient_ID
    FROM Patients
);

SELECT COUNT(*) AS Invalid_Doctor_ID
FROM Treatments
WHERE Doctor_ID NOT IN (
    SELECT Doctor_ID
    FROM Doctors
);

SELECT COUNT(*) AS Blank_Treatment_Date
FROM Treatments
WHERE Treatment_Date IS NULL;

SELECT COUNT(*) AS Negative_Cost
FROM Treatments
WHERE Treatment_Cost < 0;

UPDATE Treatments
SET Treatment_Cost = NULL
WHERE Treatment_Cost < 0;

SELECT Treatment_Type, COUNT(*) AS Count_Type
FROM Treatments
GROUP BY Treatment_Type;

-- Billing

CREATE TABLE Billing (
    Bill_ID INT PRIMARY KEY,
    Patient_ID INT,
    Treatment_ID INT,
    Bill_Date DATE,
    Bill_Amount DECIMAL(10,2),
    Payment_Status VARCHAR(50)
);

SELECT COUNT(*) AS Total_Billing
FROM Billing;

SELECT Bill_ID, COUNT(*) AS Count_ID
FROM Billing
GROUP BY Bill_ID
HAVING COUNT(*) > 1;

SELECT COUNT(*) AS Invalid_Patient_ID
FROM Billing
WHERE Patient_ID NOT IN (
    SELECT Patient_ID
    FROM Patients
);

UPDATE Billing
SET Patient_ID = NULL
WHERE Patient_ID NOT IN (
    SELECT Patient_ID
    FROM Patients
);

SELECT COUNT(*) AS Invalid_Treatment_ID
FROM Billing
WHERE Treatment_ID NOT IN (
    SELECT Treatment_ID
    FROM Treatments
);

UPDATE Billing
SET Treatment_ID = NULL
WHERE Treatment_ID NOT IN (
    SELECT Treatment_ID
    FROM Treatments
);


SELECT COUNT(*) AS Blank_Bill_Date
FROM Billing
WHERE Bill_Date IS NULL;

SELECT COUNT(*) AS Negative_Bill_Amount
FROM Billing
WHERE Bill_Amount < 0;

UPDATE Billing
SET Bill_Amount = NULL
WHERE Bill_Amount < 0;


SELECT Payment_Status, COUNT(*) AS Count_Status
FROM Billing
GROUP BY Payment_Status;

UPDATE Billing
SET Payment_Status = 'Paid'
WHERE LOWER(TRIM(Payment_Status)) = 'paid';

SELECT COUNT(*) AS Blank_Payment_Status
FROM Billing
WHERE Payment_Status IS NULL
   OR TRIM(Payment_Status) = '';
   
   -- join
   
   SELECT
    p.Patient_Name,
    a.Appointment_Date,
    a.Appointment_Status
FROM Patients p
INNER JOIN Appointments a
    ON p.Patient_ID = a.Patient_ID;
    
    SELECT
    p.Patient_Name,
    d.Doctor_Name,
    a.Appointment_Date,
    a.Appointment_Status
FROM Patients p
INNER JOIN Appointments a
    ON p.Patient_ID = a.Patient_ID
INNER JOIN Doctors d
    ON a.Doctor_ID = d.Doctor_ID;
    
    
    SELECT
    d.Doctor_Name,
    COUNT(a.Appointment_ID) AS Total_Appointments
FROM Doctors d
INNER JOIN Appointments a
    ON d.Doctor_ID = a.Doctor_ID
GROUP BY d.Doctor_ID, d.Doctor_Name;

SELECT
    Appointment_Status,
    COUNT(Appointment_ID) AS Total_Appointments
FROM Appointments
GROUP BY Appointment_Status;

SELECT
    d.Doctor_Name,
    COUNT(a.Appointment_ID) AS Total_Appointments
FROM Doctors d
INNER JOIN Appointments a
    ON d.Doctor_ID = a.Doctor_ID
GROUP BY d.Doctor_ID, d.Doctor_Name
HAVING COUNT(a.Appointment_ID) > 200;

SELECT
    d.Doctor_Name,
    SUM(t.Treatment_Cost) AS Total_Treatment_Cost
FROM Doctors d
INNER JOIN Treatments t
    ON d.Doctor_ID = t.Doctor_ID
GROUP BY d.Doctor_ID, d.Doctor_Name;

SELECT
    Treatment_Type,
    SUM(Treatment_Cost) AS Total_Treatment_Cost
FROM Treatments
GROUP BY Treatment_Type;

SELECT
    p.Patient_Name,
    COUNT(t.Treatment_ID) AS Total_Treatments
FROM Patients p
INNER JOIN Treatments t
    ON p.Patient_ID = t.Patient_ID
GROUP BY p.Patient_ID, p.Patient_Name
HAVING COUNT(t.Treatment_ID) > 1;

SELECT
    Payment_Status,
    SUM(Bill_Amount) AS Total_Bill_Amount
FROM Billing
GROUP BY Payment_Status;

SELECT
    p.Patient_Name,
    COUNT(t.Treatment_ID) AS Total_Treatments
FROM Patients p
INNER JOIN Treatments t
    ON p.Patient_ID = t.Patient_ID
GROUP BY p.Patient_ID, p.Patient_Name;

SELECT
    d.Doctor_Name,
    SUM(t.Treatment_Cost) AS Total_Treatment_Cost
FROM Doctors d
INNER JOIN Treatments t
    ON d.Doctor_ID = t.Doctor_ID
GROUP BY d.Doctor_ID, d.Doctor_Name
HAVING SUM(t.Treatment_Cost) > 1000000;

SELECT
    p.Patient_Name,
    SUM(b.Bill_Amount) AS Total_Billing
FROM Patients p
INNER JOIN Billing b
    ON p.Patient_ID = b.Patient_ID
GROUP BY p.Patient_ID, p.Patient_Name
HAVING SUM(b.Bill_Amount) > 50000;

SELECT
    p.Patient_Name,
    COUNT(a.Appointment_ID) AS Completed_Appointments
FROM Patients p
INNER JOIN Appointments a
    ON p.Patient_ID = a.Patient_ID
WHERE a.Appointment_Status = 'Completed'
GROUP BY p.Patient_ID, p.Patient_Name;

SELECT
    d.Doctor_Name,
    COUNT(a.Appointment_ID) AS Completed_Appointments
FROM Doctors d
INNER JOIN Appointments a
    ON d.Doctor_ID = a.Doctor_ID
WHERE a.Appointment_Status = 'Completed'
GROUP BY d.Doctor_ID, d.Doctor_Name
HAVING COUNT(a.Appointment_ID) > 150;

SELECT
    d.Doctor_Name,
    COUNT(a.Appointment_ID) AS Completed_Appointments
FROM Doctors d
INNER JOIN Appointments a
    ON d.Doctor_ID = a.Doctor_ID
WHERE a.Appointment_Status = 'Completed'
GROUP BY d.Doctor_ID, d.Doctor_Name;

SELECT
    d.Doctor_Name,
    AVG(t.Treatment_Cost) AS Average_Treatment_Cost
FROM Doctors d
INNER JOIN Treatments t
    ON d.Doctor_ID = t.Doctor_ID
GROUP BY d.Doctor_ID, d.Doctor_Name;