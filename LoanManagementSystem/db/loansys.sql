-- Check if the database does not exists and create it if it does
CREATE DATABASE IF NOT EXISTS loansys;
USE loansys;

-- Drop existing tables if you need to recreate them
DROP TABLE IF EXISTS CarLoan;
DROP TABLE IF EXISTS HomeLoan;
DROP TABLE IF EXISTS Loan;
DROP TABLE IF EXISTS Customer;

-- Create Customer table
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    address TEXT NOT NULL,
    credit_score INT NOT NULL
);

-- Create Loan table
CREATE TABLE Loan (
    loan_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    principal_amount DECIMAL(15,2) NOT NULL,
    interest_rate DECIMAL(5,2) NOT NULL,
    loan_term INT NOT NULL,
    loan_type ENUM('HOME', 'CAR') NOT NULL,
    loan_status ENUM('PENDING', 'APPROVED', 'REJECTED') NOT NULL,
    remaining_amount DECIMAL(15,2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- Create HomeLoan table
CREATE TABLE HomeLoan (
    loan_id INT PRIMARY KEY,
    property_address TEXT NOT NULL,
    property_value DECIMAL(15,2) NOT NULL,
    FOREIGN KEY (loan_id) REFERENCES Loan(loan_id)
);

-- Create CarLoan table
CREATE TABLE CarLoan (
    loan_id INT PRIMARY KEY,
    car_model VARCHAR(100) NOT NULL,
    car_value DECIMAL(15,2) NOT NULL,
    FOREIGN KEY (loan_id) REFERENCES Loan(loan_id)
);

-- Insert sample customers
INSERT INTO Customer (name, email, phone_number, address, credit_score) VALUES
('John Doe', 'john@email.com', '1234567890', '123 Main St, City', 700),
('Jane Smith', 'jane@email.com', '9876543210', '456 Oak Ave, Town', 600),
('Bob Wilson', 'bob@email.com', '5555555555', '789 Pine Rd, Village', 800);

-- Insert sample loans
INSERT INTO Loan (customer_id, principal_amount, interest_rate, loan_term, loan_type, loan_status, remaining_amount) VALUES
(1, 500000.00, 7.5, 60, 'HOME', 'APPROVED', 500000.00),
(2, 300000.00, 8.5, 36, 'CAR', 'PENDING', 300000.00),
(3, 1000000.00, 6.5, 120, 'HOME', 'APPROVED', 1000000.00);

-- Insert sample home loans
INSERT INTO HomeLoan (loan_id, property_address, property_value) VALUES
(1, '123 Dream House Lane, City', 800000.00),
(3, '789 Luxury Villa, Resort Town', 1500000.00);

-- Insert sample car loans
INSERT INTO CarLoan (loan_id, car_model, car_value) VALUES
(2, 'Toyota Camry 2023', 350000.00);

SELECT * FROM Customer;
SELECT * FROM Loan;
SELECT * FROM HomeLoan;
SELECT * FROM CarLoan;