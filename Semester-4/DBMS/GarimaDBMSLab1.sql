CREATE DATABASE HospitalDB
ON PRIMARY
(
    NAME = HospitalDB_Data,
    FILENAME = 'C:\Users\Dell\Downloads\MSSQL17.SQLEXPRESS\MSSQL\DATA\HospitalDB_Data.mdf',
    SIZE = 5MB,
    FILEGROWTH = 2MB
)
LOG ON
(
    NAME = HospitalDB_Log,
    FILENAME = 'C:\Users\Dell\Downloads\MSSQL17.SQLEXPRESS\MSSQL\DATA\HospitalDB_log.ldf',
    SIZE = 2MB,
    FILEGROWTH = 1MB
);

ALTER DATABASE HospitalDB
MODIFY FILE
(
    NAME = HospitalDB_Data,
    SIZE = 15MB
);

USE HospitalDB;
GO

CREATE TABLE Patients
(
    PatientID INT PRIMARY KEY,
    PatientName VARCHAR(50),
    Age INT,
    Gender VARCHAR(10)
);
GO

Select * from Patients

CREATE TABLE Doctors
(
    DoctorID INT PRIMARY KEY,
    DoctorName VARCHAR(50) NOT NULL,
    Specialty VARCHAR(50) DEFAULT 'General',
    Experience INT CHECK (Experience >= 0)
);
GO

Select * from Doctors

CREATE TABLE Appointments
(
    AppointmentID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATE,

    CONSTRAINT FK_Appointments_Patients
        FOREIGN KEY (PatientID)
        REFERENCES Patients(PatientID),

    CONSTRAINT FK_Appointments_Doctors
        FOREIGN KEY (DoctorID)
        REFERENCES Doctors(DoctorID)
);

GO

Select * from Appointments


ALTER TABLE Patients
ADD PhoneNumber VARCHAR(15);

GO

ALTER TABLE Patients
DROP COLUMN Age;

GO

ALTER TABLE Patients
ADD CONSTRAINT CHK_Gender
CHECK (Gender IN ('Male','Female','Other'));

GO

Select * from Patients

ALTER TABLE Doctors
ADD Email VARCHAR(100) NOT NULL
DEFAULT 'unknown@hospital.com';

GO

Select * from Doctors

INSERT INTO
    Patients(
        PatientID,
        PatientName,
        Gender
    )
VALUES
    (
        2,
        'Florida',
        'Female'
    );

INSERT INTO
    Doctors(
        DoctorID,
        DoctorName,
        Specialty,
        Experience
    )
VALUES
    (
        23,
        'Felix',
        'Neurologist',
        3
    );


DECLARE @ConstraintName NVARCHAR(200);

SELECT @ConstraintName = dc.name
FROM sys.default_constraints dc
JOIN sys.columns c
ON dc.parent_object_id = c.object_id
AND dc.parent_column_id = c.column_id
WHERE OBJECT_NAME(dc.parent_object_id) = 'Doctors'
AND c.name = 'Specialty';

IF @ConstraintName IS NOT NULL
EXEC('ALTER TABLE Doctors DROP CONSTRAINT ' + @ConstraintName);

GO

DROP TABLE Appointments;

GO

DROP TABLE Doctors;

GO

SELECT *
FROM INFORMATION_SCHEMA.TABLES;

USE master;
GO

DROP DATABASE HospitalDB;

GO

SELECT name
FROM sys.databases
WHERE name='HospitalDB';

