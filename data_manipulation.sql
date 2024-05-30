-- All SQL operations for Paul and Jeremy's DataBase
--Creating all 4 CRUD operations for all 7 tables 

--get all car condition IDs from Car conditions to populate Condition Dropdown FK 
SELECT conditionID, `description` FROM CarCondition

--CREATE Cars
INSERT INTO Cars (conditionID, make, model, modelYear, dateAcquired, inLot, rentedOut, color, acquiredPrice)
VALUES (:conditionFromDD, :makeInput, :modelInput, :dateInput, :lotBool, :rentedBool, :colorInput, :acquiredPriceInput)

--RETRIEVE Cars
SELECT * FROM Cars

--UPDATE Cars
UPDATE Cars SET carID = carIDInput, conditionID = :conditionFromDD, make = :makeInput, model = :modelInput, dateAcquired = :dateInput, inLot = :lotBool, rentedOut = :rentedBool, color = :colorInput, acquiredPrice = :acquiredPriceInput WHERE carID = :carIDFORM

--DELETE Cars 

DELETE FROM Cars WHERE id = :carIDCarPage

--CREATE Car Condition
INSERT INTO CarCondition(`description`)
VALUES(:descriptionInput)

--RETRIEVE Car Condition
SELECT * FROM CarCondition

--UPDATE Car Condition
UPDATE CarCondition SET conditionID= :conditionIDInput `description` = :descriptionInput WHERE conditionID = :conditionIDForm

--DELETE Car Condition
DELETE FROM CarCondition WHERE conditionID= :conditionIDconditionPage

--CREATE Customers
INSERT INTO Customers(customerID, customerName, emailAddress, phoneNumber, addressLine1, addressLine2, city, `state`, postalCode)
VALUES (:customerIDInput, :customerNameInput, :emailAddressInput, :phoneNumberInput, :addressLine1Input, :addressLine2Input, :cityInput, :stateInput, :postalCodeInput)

--RETRIEVE Customers
SELECT * FROM Customers

--UPDATE Customers
UPDATE Customers SET customerID = customerIDInput customerName = :customerNameInput, emailAddress = :emailAddressInput, phoneNumber = :phoneNumberInput, addressLine1 = :addressLine1Input, addressLine2 = :addressLine2Input, city = :cityInput, `state` = :stateInput, postalCode = :postalCodeInput WHERE customerID = customerIDForm

--DELETE Customers
DELETE FROM Customers WHERE customerID = :customerIDCustomerPage

--CREATE Employees
INSERT INTO Employees (employeeName, emailAddress, phoneNumber)
VALUES (:employeeNameInput, :emailAddressInput, :phoneNumberInput)

--RETRIEVE Employees
SELECT * FROM Employees

--UPDATE Employees
UPDATE Employees SET employeeID= :employeeIDInput employeeName = :employeeNameInput, emailAddress = :emailAddressInput, phoneNumber = :phoneNumberInput WHERE employeeID= :employeeIDForm

--DELETE Employees
DELETE FROM Employees WHERE employeeID = :employeeIDEmployeesPage


--get customers and employees for dropdowns
SELECT customerID, customerName FROM Customers
SELECT employeeID, employeeName FROM Employees

--CREATE Transactions
INSERT INTO Transactions (transactionID, customerID, employeeID, transactionAmount, transactionDate)
VALUES (:transactionIDInput, :customerIdDropDown, :employeeIDDropDown, :transactionAmountInput, :transactionDateInput)

--RETRIEVE Transactions
SELECT * FROM Transactions

--UPDATE Transactions
UPDATE Transactions SET transactionID = :transactionIDInput customerID= :customerIdDropDown, employeeID = :employeeIDDropDown, transactionAmount = :transactionAmountInput, transactionDate = :transactionDateInput WHERE transactionID = :transactionIDForm

--DELETE Transations
DELETE FROM Transactions WHERE transactionID = :transactionIDTransactionPage

--get transactions, car, transaction type for dropdowns
SELECT transactionID FROM Transactions
SELECT carID, model, modelYear FROM Cars
SELECT transactionTypeID, `description` FROM TransactionType

--CREATE Transaction Details
INSERT INTO TransactionDetails (transactionID, carID, transactionTypeID, unitPrice)
VALUES (:transactionIDDropDown, :carIDDropDown, :transactionTypeIDDropDown, :unitPriceInput)
--RETRIEVE Transaction Details
SELECT * FROM TransactionDetails

--UPDATE Transaction Details
UPDATE TransactionDetails SET transactionDetailsID = :transactionDetailsIDInput, transactionID = :transactionIDDropDown, carID = :carIDDropDown, transactionTypeID = :transactionTypeIDDropDown, unitPrice = :unitPriceInput WHERE transactionDetailsID = :transactionDetailsIDForm

--DELETE Transation Details
DELETE FROM TransactionDetails WHERE transactionDetailsID = :transactionDetailsIDTransactionDetailsPage

--CREATE Transaction Type
INSERT INTO TransactionType (`description`)
VALUES (:descriptionInput)

--RETRIEVE Transaction Type
SELECT * FROM TransactionType

--UPDATE Transaction Type
UPDATE TransactionType SET transactionTypeID = :transactionTypeIDInput, `description` = :descriptionInput WHERE transactionTypeID = :transactionTypeIDForm

--DELETE Transation Type
DELETE FROM TransactionType WHERE transactionTypeID = :transactionTypeIDPage
