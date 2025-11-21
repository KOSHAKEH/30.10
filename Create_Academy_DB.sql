CREATE DATABASE Academy;
GO

USE Academy;
GO

CREATE TABLE Faculties (
    Id   INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL UNIQUE 
         CHECK (LTRIM(RTRIM(Name)) <> '')
);

CREATE TABLE Departments (
    Id          INT IDENTITY(1,1) PRIMARY KEY,
    Name        NVARCHAR(100) NOT NULL UNIQUE 
                CHECK (LTRIM(RTRIM(Name)) <> ''),
    Financing   MONEY NOT NULL DEFAULT 0 
                CHECK (Financing >= 0),
    FacultyId   INT NOT NULL
);

CREATE TABLE Groups (
    Id      INT IDENTITY(1,1) PRIMARY KEY,
    Name    NVARCHAR(10) NOT NULL UNIQUE 
            CHECK (LTRIM(RTRIM(Name)) <> ''),
    Year    INT NOT NULL CHECK (Year BETWEEN 1 AND 5),
    Rating  INT NOT NULL CHECK (Rating BETWEEN 0 AND 5),
    FacultyId INT NOT NULL
);

CREATE TABLE Teachers (
    Id              INT IDENTITY(1,1) PRIMARY KEY,
    Name            NVARCHAR(MAX) NOT NULL 
                    CHECK (LTRIM(RTRIM(Name)) <> ''),
    Surname         NVARCHAR(MAX) NOT NULL 
                    CHECK (LTRIM(RTRIM(Surname)) <> ''),
    Salary          MONEY NOT NULL CHECK (Salary > 0),
    Premium         MONEY NOT NULL DEFAULT 0 CHECK (Premium >= 0),
    EmploymentDate  DATE NOT NULL CHECK (EmploymentDate >= '1990-01-01'),
    DepartmentId    INT NULL
);

ALTER TABLE Departments
ADD CONSTRAINT FK_Departments_Faculties 
    FOREIGN KEY (FacultyId) REFERENCES Faculties(Id);

ALTER TABLE Groups
ADD CONSTRAINT FK_Groups_Faculties 
    FOREIGN KEY (FacultyId) REFERENCES Faculties(Id);

ALTER TABLE Teachers
ADD CONSTRAINT FK_Teachers_Departments 
    FOREIGN KEY (DepartmentId) REFERENCES Departments(Id);

PRINT 'Таблица успешно создана';
