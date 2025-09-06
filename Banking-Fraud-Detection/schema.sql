-- Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL
);

-- Accounts Table
CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Transactions Table
CREATE TABLE Transactions (
    TransactionID BIGINT PRIMARY KEY,
    AccountID INT,
    Amount DECIMAL(15,2),
    Merchant VARCHAR(100),
    Category VARCHAR(50),
    Status VARCHAR(20),
    Location VARCHAR(100),
    TransactionTime DATETIME,
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);
