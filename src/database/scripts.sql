-- Delete Database
DROP DATABASE University;

-- Create Database
CREATE DATABASE University;

-- Use the database
USE University;

-- Create the Users table
CREATE TABLE Users (
    ID CHAR(36) PRIMARY KEY,
    FullName VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Username INT UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    Role ENUM('Student', 'Teacher', 'Administrator') NOT NULL
);

-- Create the Campuses table
CREATE TABLE Campuses (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    CampusName VARCHAR(255) UNIQUE NOT NULL
);

-- Create the Classrooms table
CREATE TABLE Classrooms (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ClassroomName VARCHAR(255),
    CampusID INT NOT NULL,
    FOREIGN KEY (CampusID) REFERENCES Campuses(ID)
);

-- Create the DeviceTypes table
CREATE TABLE DeviceTypes (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    TypeName VARCHAR(255) NOT NULL UNIQUE,
    ImageURL VARCHAR(255)
);

-- Create the Devices table
CREATE TABLE Devices (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    DeviceTypeID INT NOT NULL,
    InventoryNumber INT,
    IdentifierNumber INT,
    DeviceStatus ENUM('Available', 'In use', 'Damaged') NOT NULL,
    FOREIGN KEY (DeviceTypeID) REFERENCES DeviceTypes(ID)
);

-- Create the Programs table
CREATE TABLE Programs (
    ID INT PRIMARY KEY,
    ProgramName VARCHAR(255) UNIQUE NOT NULL
);

-- Create the Requests table
CREATE TABLE Requests (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    RequestDate TIMESTAMP NOT NULL,
    BorrowDate TIMESTAMP NOT NULL,
    StartTime TIMESTAMP NOT NULL,
    EndTime TIMESTAMP NOT NULL,
    ClassroomID INT NOT NULL,
    ActivityDescription TEXT NOT NULL,
    RequestStatus ENUM('Pending', 'Approved', 'Closed') NOT NULL,
    UserID CHAR(36) NOT NULL,
    ProgramID INT NOT NULL,
    ApprovedBy CHAR(36),
    ClosedBy CHAR(36),
    FOREIGN KEY (ClassroomID) REFERENCES Classrooms(ID),
    FOREIGN KEY (UserID) REFERENCES Users(ID),
    FOREIGN KEY (ProgramID) REFERENCES Programs(ID),
    FOREIGN KEY (ApprovedBy) REFERENCES Users(ID),
    FOREIGN KEY (ClosedBy) REFERENCES Users(ID)
);

-- Create the DeviceRequests table
CREATE TABLE DeviceTypeRequests (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    RequestID INT NOT NULL,
    DeviceTypeID INT NOT NULL,
    Device INT,
    FOREIGN KEY (RequestID) REFERENCES Requests(ID),
    FOREIGN KEY (DeviceTypeID) REFERENCES DeviceTypes(ID),
    FOREIGN KEY (Device) REFERENCES Devices(ID)
);

-- Create the DevicesRequests table
CREATE TABLE DevicesRequests (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    RequestID INT NOT NULL,
    DeviceID INT NOT NULL,
    FOREIGN KEY (RequestID) REFERENCES Requests(ID),
    FOREIGN KEY (DeviceID) REFERENCES Devices(ID)
);

-- Add ON DELETE CASCADE to FOREIGN KEY constraints

-- In the Classrooms table, when a row in Campuses is deleted, related rows in Classrooms will also be deleted.
ALTER TABLE Classrooms
ADD FOREIGN KEY (CampusID) REFERENCES Campuses(ID) ON DELETE CASCADE;

-- In the Devices table, when a row in DeviceTypes is deleted, related rows in Devices will also be deleted.
ALTER TABLE Devices
ADD FOREIGN KEY (DeviceTypeID) REFERENCES DeviceTypes(ID) ON DELETE CASCADE;

-- In the Requests table, when a row in Users is deleted, related rows in Requests for UserID, ApprovedBy, and ClosedBy will also be deleted.
ALTER TABLE Requests
ADD FOREIGN KEY (UserID) REFERENCES Users(ID) ON DELETE CASCADE,
ADD FOREIGN KEY (ApprovedBy) REFERENCES Users(ID) ON DELETE CASCADE,
ADD FOREIGN KEY (ClosedBy) REFERENCES Users(ID) ON DELETE CASCADE;

-- In the DeviceTypeRequests table, when a row in Requests or Devices is deleted, related rows in DeviceTypeRequests will also be deleted.
ALTER TABLE DeviceTypeRequests
ADD FOREIGN KEY (RequestID) REFERENCES Requests(ID) ON DELETE CASCADE,
ADD FOREIGN KEY (DeviceTypeID) REFERENCES DeviceTypes(ID) ON DELETE CASCADE,
ADD FOREIGN KEY (Device) REFERENCES Devices(ID) ON DELETE CASCADE;

-- In the DevicesRequests table, when a row in Requests or Devices is deleted, related rows in DevicesRequests will also be deleted.
ALTER TABLE DevicesRequests
ADD FOREIGN KEY (RequestID) REFERENCES Requests(ID) ON DELETE CASCADE,
ADD FOREIGN KEY (DeviceID) REFERENCES Devices(ID) ON DELETE CASCADE;