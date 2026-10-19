CREATE DATABASE BloodBankDB;
GO

USE BloodBankDB;
GO
 
CREATE TABLE BloodGroup (
    BloodGroupID INT IDENTITY (1,1) PRIMARY KEY,
    BloodType VARCHAR (3) NOT NULL,
    RhFactor VARCHAR (1) NOT NULL,
    Description VARCHAR (100),

    CONSTRAINT UQ_BloodGroup_Type_Rh
        UNIQUE (BloodType, RhFactor),

    CONSTRAINT CK_BloodGroup_Type
        CHECK (BloodType IN ('A', 'B', 'AB', 'O')),

    CONSTRAINT CK_BloodGroup_Rh
        CHECK (RhFactor IN ('+', '-'))
);
GO 

select * from BloodGroup

CREATE TABLE Staff (
    StaffID INT IDENTITY (1,1) PRIMARY KEY,
    FirstName VARCHAR (50) NOT NULL,
    LastName VARCHAR (50) NOT NULL,
    Phone VARCHAR (15) NOT NULL UNIQUE,
    Email VARCHAR (100) UNIQUE,
    Role VARCHAR (30) NOT NULL,

    CONSTRAINT CK_Staff_Role
      CHECK (Role IN ('Admin', 'Technician', 'Receptionist'))
);
GO

select * from Staff
 
CREATE TABLE Donor (
    DonorID INT IDENTITY (1,1) PRIMARY KEY,
    FirstName VARCHAR (50) NOT NULL,
    LastName VARCHAR (50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender VARCHAR (10),
    Email VARCHAR (100),
    Phone VARCHAR (15),
    Address VARCHAR (200),
    BloodGroupID INT NOT NULL,
    LastDonationDate DATE,

    CONSTRAINT FK_Donor_BloodGroup
        FOREIGN KEY (BloodGroupID)
        REFERENCES BloodGroup (BloodGroupID),

    CONSTRAINT CK_Donor_Gender
        CHECK (Gender IN ('Male', 'Female', 'Other'))
);
GO 

select * from Donor

CREATE TABLE Donation (
    DonationID INT IDENTITY (1,1) PRIMARY KEY,
    DonorID INT NOT NULL,
    DonationDate DATE NOT NULL,
    QuantityML INT NOT NULL,
    BloodGroupID INT NOT NULL,
    StaffID INT NOT NULL,
    Remarks VARCHAR (200),

    CONSTRAINT FK_Donation_Donor
        FOREIGN KEY (DonorID)
        REFERENCES Donor (DonorID),

    CONSTRAINT FK_Donation_BloodGroup
        FOREIGN KEY (BloodGroupID)
        REFERENCES BloodGroup (BloodGroupID),

    CONSTRAINT FK_Donation_Staff
        FOREIGN KEY (StaffID)
        REFERENCES Staff (StaffID),

    CONSTRAINT CK_Donation_Quantity
        CHECK (QuantityML BETWEEN 250 AND 500)
);
GO

select * from Donation
 
CREATE TABLE BloodInventory (
    InventoryID INT IDENTITY (1,1) PRIMARY KEY,
    BloodGroupID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitType VARCHAR (20) NOT NULL,
    DateAdded DATE NOT NULL,
    ExpiryDate DATE NOT NULL,
    StorageLocation VARCHAR (100),

    CONSTRAINT FK_Inventory_BloodGroup
        FOREIGN KEY (BloodGroupID)
        REFERENCES BloodGroup (BloodGroupID),

    CONSTRAINT CK_Inventory_Quantity
        CHECK (Quantity >= 0),

    CONSTRAINT CK_Inventory_Dates
        CHECK (ExpiryDate > DateAdded)
);
GO

select * from BloodInventory
 
CREATE TABLE Hospital (
    HospitalID INT IDENTITY (1,1) PRIMARY KEY,
    HospitalName VARCHAR (100) NOT NULL UNIQUE,
    Address VARCHAR (200),
    Phone VARCHAR (15),
    Email VARCHAR (100)
);
GO

select * from Hospital
 
CREATE TABLE BloodRequest (
    RequestID INT IDENTITY (1,1) PRIMARY KEY,
    HospitalID INT NOT NULL,
    BloodGroupID INT NOT NULL,
    RequestDate DATE NOT NULL DEFAULT CAST (GETDATE () AS DATE),
    Quantity INT NOT NULL,
    Status VARCHAR (20) NOT NULL DEFAULT 'Pending',
    NeededDate DATE,
    Remarks VARCHAR (200),

    CONSTRAINT FK_Request_Hospital
        FOREIGN KEY (HospitalID)
        REFERENCES Hospital (HospitalID),

    CONSTRAINT FK_Request_BloodGroup
        FOREIGN KEY (BloodGroupID)
        REFERENCES BloodGroup (BloodGroupID),

    CONSTRAINT CK_Request_Quantity
        CHECK (Quantity > 0),

    CONSTRAINT CK_Request_Status
        CHECK (Status IN
        ('Pending', 'Approved', 'Completed', 'Rejected'))
);
GO

select * from BloodRequest

CREATE TABLE BloodIssue (
    IssueID INT IDENTITY (1,1) PRIMARY KEY,
    RequestID INT NOT NULL,
    InventoryID INT NOT NULL,
    IssueDate DATE NOT NULL DEFAULT CAST (GETDATE () AS DATE),
    QuantityIssued INT NOT NULL,
    IssuedBy INT NOT NULL,
    Remarks VARCHAR (200),

    CONSTRAINT FK_Issue_Request
        FOREIGN KEY (RequestID)
        REFERENCES BloodRequest (RequestID),

    CONSTRAINT FK_Issue_Inventory
        FOREIGN KEY (InventoryID)
        REFERENCES BloodInventory (InventoryID),

    CONSTRAINT FK_Issue_Staff
        FOREIGN KEY (IssuedBy)
        REFERENCES Staff (StaffID),

    CONSTRAINT CK_Issue_Quantity
        CHECK (QuantityIssued > 0)
);
GO

select * from BloodIssue

INSERT INTO BloodGroup (BloodType, RhFactor, Description)
VALUES
('A', '+', 'A Positive'),
('A', '-', 'A Negative'),
('B', '+', 'B Positive'),
('B', '-', 'B Negative'),
('AB', '+', 'AB Positive'),
('AB', '-', 'AB Negative'),
('O', '+', 'O Positive'),
('O', '-', 'O Negative');

select * from BloodGroup
 
INSERT INTO Staff
(FirstName, LastName, Phone, Email, Role)
VALUES
('Garima', 'Neupane', '9800000001',
 'garimaneup2@gmail.com', 'Admin'),

('Muna', 'Gharti', '9800000002',
 'munagharti3@gmail.com', 'Technician'),

('Helina', 'Poudel', '9800000003',
 'helinakc@gmail.com', 'Receptionist');

 select * from Staff
 
INSERT INTO Donor
(FirstName, LastName, DateOfBirth, Gender, Email, Phone,
 Address, BloodGroupID, LastDonationDate)
VALUES
('Saurav', 'Subedi', '2004-04-12', 'Male',
 'saurav@gmail.com', '9811111111',
 'Kathmandu', 7, '2026-05-01'),

('Aashutosh', 'Singh', '2005-09-23', 'Male',
 'aashu@gmail.com', '9822222222',
 'Lalitpur', 1, NULL),

('Veronica', 'Park', '2000-01-15', 'Female',
 'veronica@gmail.com', '9833333333',
 'Bhaktapur', 7, '2026-03-10'); 

 select * from Donor

INSERT INTO Hospital
(HospitalName, Address, Phone, Email)
VALUES
('Alka Hospital', 'Kathmandu',
 '014412233', 'alkahospital@gmail.com'),

('Patan Hospital', 'Lalitpur',
 '015523344', 'patanhospital@gmail.com');

 select * from Hospital
 
INSERT INTO BloodInventory
(BloodGroupID, Quantity, UnitType, DateAdded, ExpiryDate, StorageLocation)
VALUES
(1, 20, 'Unit', '2026-08-01', '2026-11-01', 'Refrigerator A'),
(7, 60, 'Unit', '2026-08-01', '2026-10-15', 'Refrigerator B'),
(3, 15, 'Unit', '2026-08-01', '2026-09-20', 'Refrigerator A');

select * from BloodInventory

INSERT INTO Donation (DonorID, BloodGroupID, StaffID, DonationDate, QuantityML) VALUES
(1, 7, 2, '2026-05-01', 350),
(3, 7, 2, '2026-03-10', 400);

select * from Donation

INSERT INTO BloodRequest
(HospitalID, BloodGroupID, RequestDate, Quantity, Status, NeededDate, Remarks)
VALUES
(1, 7, '2026-08-05', 5, 'Pending', '2026-08-06', 'Urgent requirement'),
(2, 1, '2026-08-05', 2, 'Pending', '2026-08-08', 'Regular request');

select * from BloodRequest

INSERT INTO BloodIssue
(RequestID, InventoryID, IssueDate, QuantityIssued, IssuedBy, Remarks)
VALUES
(1, 2, '2026-08-06', 5, 1, 'Issued to Alka Hospital');

select * from BloodIssue

-- Update a donor's phone number
UPDATE Donor SET Phone = '9800099999' WHERE DonorID = 2;

-- Update inventory after a donation is added to stock
UPDATE BloodInventory
SET Quantity = Quantity + 1
WHERE BloodGroupID = 7;

select * from BloodInventory

-- Approve a pending blood request
UPDATE BloodRequest
SET Status = 'Approved'
WHERE RequestID = 1
  AND Status = 'Pending';

select * from BloodRequest
 
-- Delete an expired inventory batch
DELETE FROM BloodInventory
WHERE ExpiryDate < CAST(GETDATE() AS DATE)
AND NOT EXISTS
(
    SELECT 1
    FROM BloodIssue
    WHERE BloodIssue.InventoryID = BloodInventory.InventoryID
);

select * from BloodInventory

-- List all O+ donors, most recently registered first
SELECT
    D.FirstName + ' ' + D.LastName AS DonorName,
    D.Phone,
    B.BloodType,
    B.RhFactor,
    D.LastDonationDate
FROM Donor D
JOIN BloodGroup B
    ON D.BloodGroupID = B.BloodGroupID
WHERE B.BloodType = 'O'
AND B.RhFactor = '+'
ORDER BY D.LastDonationDate DESC;
go

--Join
-- Donor + Donation: full donation history with donor name
SELECT
    D.FirstName + ' ' + D.LastName AS DonorName,
    DN.DonationDate,
    DN.QuantityML,
    B.BloodType,
    B.RhFactor,
    S.FirstName + ' ' + S.LastName AS StaffName
FROM Donation DN
JOIN Donor D
    ON DN.DonorID = D.DonorID
JOIN BloodGroup B
    ON DN.BloodGroupID = B.BloodGroupID
JOIN Staff S
    ON DN.StaffID = S.StaffID
ORDER BY DN.DonationDate DESC; 

-- Hospital + BloodRequest: outstanding requests per hospital
SELECT
    H.HospitalName,
    R.Quantity,
    R.Status,
    R.NeededDate,
    R.RequestDate,
    R.Remarks
FROM BloodRequest R
JOIN Hospital H
    ON R.HospitalID = H.HospitalID
WHERE R.Status <> 'Completed';

SELECT
    BI.IssueID,
    H.HospitalName,
    BG.BloodType,
    BG.RhFactor,
    BI.QuantityIssued,
    BI.IssueDate,
    S.FirstName + ' ' + S.LastName AS IssuedBy
FROM BloodIssue BI
JOIN BloodRequest BR
    ON BI.RequestID = BR.RequestID
JOIN Hospital H
    ON BR.HospitalID = H.HospitalID
JOIN BloodGroup BG
    ON BR.BloodGroupID = BG.BloodGroupID
JOIN Staff S
    ON BI.IssuedBy = S.StaffID;

--Aggregate Function
-- Total donations received per blood group
SELECT
    B.BloodType,
    B.RhFactor,
    COUNT(DN.DonationID) AS TotalDonations,
    SUM(DN.QuantityML) AS TotalML
FROM Donation DN
JOIN BloodGroup B
    ON DN.BloodGroupID = B.BloodGroupID
GROUP BY
    B.BloodType,
    B.RhFactor; 

-- Blood groups currently holding more than 50 units
SELECT
    B.BloodType,
    B.RhFactor,
    SUM(I.Quantity) AS TotalQuantity
FROM BloodInventory I
JOIN BloodGroup B
    ON I.BloodGroupID = B.BloodGroupID
GROUP BY
    B.BloodType,
    B.RhFactor
HAVING SUM(I.Quantity) > 50;

--Nested Queries
-- Donors who have never donated
SELECT
    D.FirstName + ' ' + D.LastName AS FullName,
    D.Phone
FROM Donor D
WHERE D.DonorID NOT IN
(
    SELECT DISTINCT DonorID
    FROM Donation
); 

-- Hospitals that requested a blood group currently out of stock
SELECT DISTINCT
    H.HospitalName
FROM BloodRequest R
JOIN Hospital H
    ON R.HospitalID = H.HospitalID
WHERE NOT EXISTS
(
    SELECT 1
    FROM BloodInventory I
    WHERE I.BloodGroupID = R.BloodGroupID
      AND I.Quantity > 0
      AND I.ExpiryDate >= CAST(GETDATE() AS DATE)
);
go

--Views
CREATE VIEW AvailableBloodstock AS
SELECT
    I.InventoryID,
    B.BloodType,
    B.RhFactor,
    I.Quantity,
    I.UnitType,
    I.DateAdded,
    I.ExpiryDate,
    I.StorageLocation
FROM BloodInventory I
JOIN BloodGroup B
    ON I.BloodGroupID = B.BloodGroupID
WHERE I.Quantity > 0
  AND I.ExpiryDate >= CAST(GETDATE() AS DATE);
GO

select * from AvailableBloodstock
go

CREATE VIEW ActiveBloodRequests AS
SELECT
    R.RequestID,
    H.HospitalName,
    B.BloodType,
    B.RhFactor,
    R.Quantity,
    R.Status,
    R.NeededDate,
    R.RequestDate,
    R.Remarks
FROM BloodRequest R
JOIN Hospital H
    ON R.HospitalID = H.HospitalID
JOIN BloodGroup B
    ON R.BloodGroupID = B.BloodGroupID
WHERE R.Status IN ('Pending', 'Approved');
GO 

select * from ActiveBloodRequests
order by NeededDate desc;
go

CREATE VIEW DonationHistory AS
SELECT
    D.FirstName + ' ' + D.LastName AS DonorName,
    B.BloodType,
    B.RhFactor,
    DN.DonationDate,
    DN.QuantityML,
    S.FirstName + ' ' + S.LastName AS RecordedBy,
    DN.Remarks
FROM Donation DN
JOIN Donor D
    ON DN.DonorID = D.DonorID
JOIN BloodGroup B
    ON DN.BloodGroupID = B.BloodGroupID
JOIN Staff S
    ON DN.StaffID = S.StaffID;
GO

SELECT *
FROM DonationHistory
ORDER BY DonationDate DESC;
go

--Stored procedure
CREATE PROCEDURE RegisterDonor
    @FirstName VARCHAR (50),
    @LastName VARCHAR (50),
    @Gender VARCHAR (10),
    @DOB DATE,
    @Phone VARCHAR (15),
    @Email VARCHAR (100),
    @Address VARCHAR (200),
    @BloodGroupID INT
AS
BEGIN
    INSERT INTO Donor
    (
        FirstName,
        LastName,
        Gender,
        DateOfBirth,
        Phone,
        Email,
        Address,
        BloodGroupID
    )
    VALUES
    (
        @FirstName,
        @LastName,
        @Gender,
        @DOB,
        @Phone,
        @Email,
        @Address,
        @BloodGroupID
    );
END;
GO 

EXEC RegisterDonor
    @FirstName = 'Riya',
    @LastName = 'Sharma',
    @Gender = 'Female',
    @DOB = '2002-05-10',
    @Phone = '9841234567',
    @Email = 'riya@gmail.com',
    @Address = 'Kathmandu',
    @BloodGroupID = 1;
GO

SELECT * FROM Donor
WHERE Phone = '9841234567';
go

CREATE PROCEDURE DonateBlood
    @DonorID INT,
    @BloodGroupID INT,
    @StaffID INT,
    @QuantityML INT,
    @Remarks VARCHAR(200)
AS
BEGIN

    INSERT INTO Donation
    (
        DonorID,
        BloodGroupID,
        StaffID,
        DonationDate,
        QuantityML,
        Remarks
    )
    VALUES
    (
        @DonorID,
        @BloodGroupID,
        @StaffID,
        CAST(GETDATE() AS DATE),
        @QuantityML,
        @Remarks
    );

    UPDATE Donor
    SET LastDonationDate = CAST(GETDATE() AS DATE)
    WHERE DonorID = @DonorID;

END;
GO

EXEC DonateBlood
    @DonorID = 1,
    @BloodGroupID = 7,
    @StaffID = 2,
    @QuantityML = 350,
    @Remarks = 'Routine donation';
GO

SELECT * FROM Donation
ORDER BY DonationID DESC;
go

CREATE PROCEDURE RequestBlood
    @HospitalID INT,
    @BloodGroupID INT,
    @Quantity INT,
    @NeededDate DATE,
    @Remarks VARCHAR(200)
AS
BEGIN

    INSERT INTO BloodRequest
    (
        HospitalID,
        BloodGroupID,
        RequestDate,
        Quantity,
        Status,
        NeededDate,
        Remarks
    )
    VALUES
    (
        @HospitalID,
        @BloodGroupID,
        CAST(GETDATE() AS DATE),
        @Quantity,
        'Pending',
        @NeededDate,
        @Remarks
    );

END;
GO
EXEC RequestBlood
    @HospitalID = 1,
    @BloodGroupID = 7,
    @Quantity = 3,
    @NeededDate = '2026-08-20',
    @Remarks = 'Urgent requirement';

SELECT * FROM BloodRequest
ORDER BY RequestID DESC;
SELECT 'Blood request submitted successfully.' AS Message;
Go

 
CREATE PROCEDURE UpdateInventory
    @InventoryID INT,
    @Quantity INT,
    @UnitType VARCHAR(20),
    @ExpiryDate DATE,
    @StorageLocation VARCHAR(100)
AS
BEGIN

    UPDATE BloodInventory
    SET
        Quantity = @Quantity,
        UnitType = @UnitType,
        ExpiryDate = @ExpiryDate,
        StorageLocation = @StorageLocation
    WHERE InventoryID = @InventoryID;

END;
GO

EXEC UpdateInventory
    @InventoryID = 2,
    @Quantity = 55,
    @UnitType = 'Unit',
    @ExpiryDate = '2026-10-20',
    @StorageLocation = 'Refrigerator B';

SELECT * FROM BloodInventory
WHERE InventoryID = 2;
Go

--Transactions
CREATE PROCEDURE IssueBlood
    @RequestID INT,
    @StaffID INT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    DECLARE @BloodGroupID INT;
    DECLARE @QuantityRequested INT;
    DECLARE @InventoryID INT;
    DECLARE @QuantityAvailable INT;

    BEGIN TRANSACTION;

    BEGIN TRY

        SELECT
            @BloodGroupID = BloodGroupID,
            @QuantityRequested = Quantity
        FROM BloodRequest
        WHERE RequestID = @RequestID
          AND Status = 'Approved';

        IF @BloodGroupID IS NULL
            THROW 51001, 'Request not found or is not approved.', 1;

        SELECT TOP 1
            @InventoryID = InventoryID,
            @QuantityAvailable = Quantity
        FROM BloodInventory
        WHERE BloodGroupID = @BloodGroupID
          AND Quantity > 0
          AND ExpiryDate >= CAST(GETDATE() AS DATE)
        ORDER BY ExpiryDate ASC;

        IF @InventoryID IS NULL
            THROW 51002, 'No available blood stock found.', 1;

        IF @QuantityAvailable < @QuantityRequested
            THROW 51003, 'Insufficient stock to fulfil this request.', 1;

        UPDATE BloodInventory
        SET Quantity = Quantity - @QuantityRequested
        WHERE InventoryID = @InventoryID;

        INSERT INTO BloodIssue
        (
            RequestID,
            InventoryID,
            IssueDate,
            QuantityIssued,
            IssuedBy,
            Remarks
        )
        VALUES
        (
            @RequestID,
            @InventoryID,
            CAST(GETDATE() AS DATE),
            @QuantityRequested,
            @StaffID,
            'Blood issued successfully'
        );

        UPDATE BloodRequest
        SET Status = 'Completed'
        WHERE RequestID = @RequestID;

        COMMIT TRANSACTION;

    END TRY

    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END;
GO

UPDATE BloodRequest
SET Status = 'Approved'
WHERE RequestID = 1;

EXEC IssueBlood
    @RequestID = 1,
    @StaffID = 1;
GO

SELECT * FROM BloodIssue;

SELECT * FROM BloodInventory;

SELECT * FROM BloodRequest
WHERE RequestID = 1;

INSERT INTO BloodRequest
(HospitalID, BloodGroupID, RequestDate, Quantity, Status, NeededDate, Remarks)
VALUES
(1, 7, CAST(GETDATE() AS DATE), 1000, 'Approved',
 '2026-08-20', 'Rollback test');

 EXEC IssueBlood
    @RequestID = 3,
    @StaffID = 1;

SELECT * FROM BloodIssue
WHERE RequestID = 3;

SELECT * FROM BloodInventory
WHERE BloodGroupID = 7;

SELECT * FROM BloodRequest
WHERE RequestID = 3;