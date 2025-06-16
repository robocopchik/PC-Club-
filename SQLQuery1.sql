-- Создаём базу данных
CREATE DATABASE ComputerClubDB;
GO

-- Используем созданную базу
USE ComputerClubDB;
GO

-- Создаём таблицы

CREATE TABLE Users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    phone NVARCHAR(20),
    email NVARCHAR(100),
    balance DECIMAL(10, 2) DEFAULT 0,
    registered_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE Employees (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    role NVARCHAR(50),
    username NVARCHAR(50) NOT NULL UNIQUE,
    password_hash NVARCHAR(255) NOT NULL
);

CREATE TABLE Halls (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    description NVARCHAR(MAX) NULL
);

CREATE TABLE Tariffs (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    price_per_hour DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Hall_Tariffs (
    id INT IDENTITY(1,1) PRIMARY KEY,
    hall_id INT NOT NULL,
    tariff_id INT NOT NULL,
    CONSTRAINT FK_HallTariff_Hall FOREIGN KEY (hall_id) REFERENCES Halls(id) ON DELETE CASCADE,
    CONSTRAINT FK_HallTariff_Tariff FOREIGN KEY (tariff_id) REFERENCES Tariffs(id) ON DELETE CASCADE,
    CONSTRAINT UQ_HallTariff UNIQUE (hall_id, tariff_id)
);

CREATE TABLE Computers (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    specs NVARCHAR(255) NULL,
    status NVARCHAR(20) DEFAULT 'available' CHECK (status IN ('available', 'occupied', 'maintenance')),
    hall_id INT NOT NULL,
    tariff_id INT NOT NULL,
    CONSTRAINT FK_Computer_Hall FOREIGN KEY (hall_id) REFERENCES Halls(id) ON DELETE CASCADE,
    CONSTRAINT FK_Computer_Tariff FOREIGN KEY (tariff_id) REFERENCES Tariffs(id) ON DELETE NO ACTION
);

CREATE TABLE Sessions (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    computer_id INT NOT NULL,
    tariff_id INT NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NULL,
    total_price DECIMAL(10, 2) NULL,
    employee_id INT NULL,
    CONSTRAINT FK_Session_User FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE,
    CONSTRAINT FK_Session_Computer FOREIGN KEY (computer_id) REFERENCES Computers(id) ON DELETE CASCADE,
    CONSTRAINT FK_Session_Tariff FOREIGN KEY (tariff_id) REFERENCES Tariffs(id) ON DELETE NO ACTION,
    CONSTRAINT FK_Session_Employee FOREIGN KEY (employee_id) REFERENCES Employees(id) ON DELETE SET NULL
);

CREATE TABLE Bookings (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    computer_id INT NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    status NVARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'cancelled', 'completed')),
    employee_id INT NULL,
    CONSTRAINT FK_Booking_User FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE,
    CONSTRAINT FK_Booking_Computer FOREIGN KEY (computer_id) REFERENCES Computers(id) ON DELETE CASCADE,
    CONSTRAINT FK_Booking_Employee FOREIGN KEY (employee_id) REFERENCES Employees(id) ON DELETE SET NULL
);
