SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;

CREATE OR REPLACE TABLE Customers (
    customerID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customerName varchar(50) NOT NULL,
    emailAddress varchar(255) NOT NULL,
    phoneNumber varchar(20),
    addressLine1 varchar(50),
    addressLine2 varchar(50),
    city varchar(50),
    `state` varchar(50),
    postalCode varchar(50)
);

CREATE OR REPLACE TABLE Employees (
    employeeID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    employeeName varchar(50) NOT NULL,
    emailAddress varchar(255) NOT NULL,
    phoneNumber varchar(20) NOT NULL
);

CREATE OR REPLACE TABLE Transactions (
    transactionID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customerID int NOT NULL,
    employeeID int NOT NULL,
    transactionAmount decimal(20, 2) NOT NULL,
    transactionDate date NOT NULL,
    FOREIGN KEY (customerID) REFERENCES Customers(customerID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (employeeID) REFERENCES Employees(employeeID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE OR REPLACE TABLE TransactionType (
    transactionTypeID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `description` varchar(75) NOT NULL
);

CREATE OR REPLACE TABLE CarCondition (
    conditionID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `description` varchar(75) NOT NULL
);

CREATE OR REPLACE TABLE Cars (
    carID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    transactionDetailsID int,
    conditionID int NOT NULL,
    make varchar(50) NOT NULL,
    model varchar(50) NOT NULL,
    modelYear varchar(50) NOT NULL,
    dateAcquired date NOT NULL,
    color varchar(50) NOT NULL,
    inLot boolean NOT NULL,
    rentedOut boolean NOT NULL,
    acquiredPrice decimal(20,2) NOT NULL,
    FOREIGN KEY (conditionID) REFERENCES CarCondition(conditionID)
        ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE OR REPLACE TABLE TransactionDetails (
    transactionDetailsID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    transactionID int NOT NULL,
    carID int NOT NULL,
    transactionTypeID int Not NULL,
    unitPrice decimal(20, 2) NOT NULL,
    FOREIGN KEY (transactionID) REFERENCES Transactions(transactionID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    
    FOREIGN KEY (carID) REFERENCES Cars(carID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Customers(customerName, emailAddress, phoneNumber, addressLine1, addressLine2, city, `state`, postalCode)
VALUES
("Joe Swit", "jos@email.com", "2973493", "23 Happy Lane", NULL, "Los Angeles", "California", "1232"),
("Moe Toe", 'mot@email.com', '2973432', '41 Boule Street', NULL, "Corvallis", "Oregon", "9382"),
("Luka Duka", 'lud@email.com', '2973947', '29A Ray Street', NULL, "Portland", 'Oregon', "9421");

INSERT INTO Employees (employeeName, emailAddress, phoneNumber)
VALUES
(
    "Rasho Loe", 
    "ralo@email.com", 
    "293723"
),
(
    "Juda Ouk",
    'judou@email.com',
    "293747"
),
(
    "Lak Tuay",
    'latu@email.com',
    "293844"
);

INSERT INTO Transactions (customerID, employeeID, transactionAmount, transactionDate)
VALUES 
(
    (SELECT customerID FROM Customers WHERE customerName="Moe Toe"), 
    (SELECT employeeID FROM Employees WHERE employeeName="Lak Tuay"), 
    3000.00, 
    DATE "2024-4-18"
),
(
    (SELECT customerID FROM Customers WHERE customerName="Moe Toe"), 
    (SELECT employeeID FROM Employees WHERE employeeName="Juda Ouk"),
    2748.00,
    DATE "2024-4-21"
),
(
    (SELECT customerID FROM Customers WHERE customerName="Joe Swit"), 
    (SELECT employeeID FROM Employees WHERE employeeName="Rasho Loe"),
    937202,
    "2024-5-1"
);

INSERT INTO TransactionType (`description`)
VALUES
("sale"),
("lease");

INSERT INTO CarCondition(`description`)
VALUES
(
    "Well-Used"
),
(
    "Fair"
),
(
    "Like New"
),
(
    "Brand New"
);

INSERT INTO Cars (conditionID, make, model, modelYear, dateAcquired, inLot, rentedOut, color, acquiredPrice)
VALUES
(
    (SELECT conditionID FROM CarCondition WHERE conditionID=3),
    "Toyota",
    "Camry",
    "2018",
    DATE "2020-09-05",
    FALSE,
    FALSE,
    'silver',
    20000
),
(
    (SELECT conditionID FROM CarCondition WHERE conditionID=2),
    "Ford",
    "Mustang",
    "2020",
    DATE "2021-11-10",
    FALSE,
    TRUE,
    "red",
    35000
),
(
    (SELECT conditionID FROM CarCondition WHERE conditionID=2),
    "Honda",
    "Civic",
    "2019",
    DATE "2022-03-15",
    FALSE,
    TRUE,
    "black",
    18500
),
(
    (SELECT conditionID FROM CarCondition WHERE conditionID=4),
    "Chevrolet",
    "Tahoe",
    "2021",
    DATE "2023-06-28",
    FALSE,
    FALSE,
    "white",
    45000
),
(
    (SELECT conditionID FROM CarCondition WHERE conditionID=4),
    "BMW",
    "X5",
    "2017",
    DATE "2024-01-20",
    FALSE,
    FALSE,
    "blue",
    30000
);

INSERT INTO TransactionDetails (transactionID, carID, transactionTypeID, unitPrice)
VALUES
(
    (SELECT transactionID FROM Transactions WHERE transactionID=1),
    (SELECT carID FROM Cars WHERE carID=2),
    (SELECT transactionTypeID WHERE transactionTypeID=1),
    3000
),
(
    (SELECT transactionID FROM Transactions WHERE transactionID=2),
    (SELECT carID FROM Cars WHERE carID=3),
    (SELECT transactionTypeID WHERE transactionTypeID=1),
    2748
),
(
    (SELECT transactionID FROM Transactions WHERE transactionID=3),
    (SELECT carID FROM Cars WHERE carID=1),
    (SELECT transactionTypeID WHERE transactionTypeID=2),
    468601
),
(
    (SELECT transactionID FROM Transactions WHERE transactionID=3),
    (SELECT carID FROM Cars WHERE carID=4),
    (SELECT transactionTypeID WHERE transactionTypeID=2),
    283030
),
(
    (SELECT transactionID FROM Transactions WHERE transactionID=3),
    (SELECT carID FROM Cars WHERE carID=5),
    (SELECT transactionTypeID WHERE transactionTypeID=2),
    185571
);

SET FOREIGN_KEY_CHECKS=1;
COMMIT;