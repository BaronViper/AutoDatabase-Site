-- phpMyAdmin SQL Dump
-- version 5.2.1-1.el7.remi
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 28, 2024 at 10:20 PM
-- Server version: 10.6.17-MariaDB-log
-- PHP Version: 8.2.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cs340_tanjer`
--

-- --------------------------------------------------------

--
-- Table structure for table `CarCondition`
--

CREATE TABLE `CarCondition` (
  `conditionID` int(11) NOT NULL,
  `description` varchar(75) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `CarCondition`
--

INSERT INTO `CarCondition` (`conditionID`, `description`) VALUES
(1, 'Well-Used'),
(2, 'Fair'),
(3, 'Like New'),
(4, 'Brand New');

-- --------------------------------------------------------

--
-- Table structure for table `Cars`
--

CREATE TABLE `Cars` (
  `carID` int(11) NOT NULL,
  `transactionDetailsID` int(11) DEFAULT NULL,
  `conditionID` int(11) NOT NULL,
  `make` varchar(50) NOT NULL,
  `model` varchar(50) NOT NULL,
  `modelYear` varchar(50) NOT NULL,
  `dateAcquired` date NOT NULL,
  `color` varchar(50) NOT NULL,
  `inLot` tinyint(1) NOT NULL,
  `rentedOut` tinyint(1) NOT NULL,
  `acquiredPrice` decimal(20,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `Cars`
--

INSERT INTO `Cars` (`carID`, `transactionDetailsID`, `conditionID`, `make`, `model`, `modelYear`, `dateAcquired`, `color`, `inLot`, `rentedOut`, `acquiredPrice`) VALUES
(1, NULL, 3, 'Toyota', 'Camry', '2018', '2020-09-05', 'silver', 0, 0, 20000.00),
(2, NULL, 2, 'Ford', 'Mustang', '2020', '2021-11-10', 'red', 0, 1, 35000.00),
(3, NULL, 2, 'Honda', 'Civic', '2019', '2022-03-15', 'black', 0, 1, 18500.00),
(4, NULL, 4, 'Chevrolet', 'Tahoe', '2021', '2023-06-28', 'white', 0, 0, 45000.00),
(5, NULL, 4, 'BMW', 'X5', '2017', '2024-01-20', 'blue', 0, 0, 30000.00);

-- --------------------------------------------------------

--
-- Table structure for table `Customers`
--

CREATE TABLE `Customers` (
  `customerID` int(11) NOT NULL,
  `customerName` varchar(50) NOT NULL,
  `emailAddress` varchar(255) NOT NULL,
  `phoneNumber` varchar(20) DEFAULT NULL,
  `addressLine1` varchar(50) DEFAULT NULL,
  `addressLine2` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `postalCode` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `Customers`
--

INSERT INTO `Customers` (`customerID`, `customerName`, `emailAddress`, `phoneNumber`, `addressLine1`, `addressLine2`, `city`, `state`, `postalCode`) VALUES
(1, 'Joe Swit', 'jos@email.com', '2973493', '23 Happy Lane', NULL, 'Los Angeles', 'California', '1232'),
(2, 'Moe Toe', 'mot@email.com', '2973432', '41 Boule Street', NULL, 'Corvallis', 'Oregon', '9382'),
(3, 'Luka Duka', 'lud@email.com', '2973947', '29A Ray Street', NULL, 'Portland', 'Oregon', '9421');

-- --------------------------------------------------------

--
-- Table structure for table `Employees`
--

CREATE TABLE `Employees` (
  `employeeID` int(11) NOT NULL,
  `employeeName` varchar(50) NOT NULL,
  `emailAddress` varchar(255) NOT NULL,
  `phoneNumber` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `Employees`
--

INSERT INTO `Employees` (`employeeID`, `employeeName`, `emailAddress`, `phoneNumber`) VALUES
(1, 'Rasho Loe', 'ralo@email.com', '293723'),
(2, 'Juda Ouk', 'judou@email.com', '293747'),
(3, 'Lak Tuay', 'latu@email.com', '293844');

-- --------------------------------------------------------

--
-- Table structure for table `TransactionDetails`
--

CREATE TABLE `TransactionDetails` (
  `transactionDetailsID` int(11) NOT NULL,
  `transactionID` int(11) NOT NULL,
  `carID` int(11) NOT NULL,
  `transactionTypeID` int(11) NOT NULL,
  `unitPrice` decimal(20,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `TransactionDetails`
--

INSERT INTO `TransactionDetails` (`transactionDetailsID`, `transactionID`, `carID`, `transactionTypeID`, `unitPrice`) VALUES
(17, 1, 5, 1, 12341.00),
(18, 3, 3, 2, 312.00);

-- --------------------------------------------------------

--
-- Table structure for table `Transactions`
--

CREATE TABLE `Transactions` (
  `transactionID` int(11) NOT NULL,
  `customerID` int(11) NOT NULL,
  `employeeID` int(11) NOT NULL,
  `transactionAmount` decimal(20,2) NOT NULL,
  `transactionDate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `Transactions`
--

INSERT INTO `Transactions` (`transactionID`, `customerID`, `employeeID`, `transactionAmount`, `transactionDate`) VALUES
(1, 2, 3, 3000.00, '2024-04-18'),
(2, 2, 2, 2748.00, '2024-04-21'),
(3, 1, 1, 937202.00, '2024-05-01');

-- --------------------------------------------------------

--
-- Table structure for table `TransactionType`
--

CREATE TABLE `TransactionType` (
  `transactionTypeID` int(11) NOT NULL,
  `description` varchar(75) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `TransactionType`
--

INSERT INTO `TransactionType` (`transactionTypeID`, `description`) VALUES
(1, 'sale'),
(2, 'lease');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `CarCondition`
--
ALTER TABLE `CarCondition`
  ADD PRIMARY KEY (`conditionID`);

--
-- Indexes for table `Cars`
--
ALTER TABLE `Cars`
  ADD PRIMARY KEY (`carID`),
  ADD KEY `conditionID` (`conditionID`);

--
-- Indexes for table `Customers`
--
ALTER TABLE `Customers`
  ADD PRIMARY KEY (`customerID`);

--
-- Indexes for table `Employees`
--
ALTER TABLE `Employees`
  ADD PRIMARY KEY (`employeeID`);

--
-- Indexes for table `TransactionDetails`
--
ALTER TABLE `TransactionDetails`
  ADD PRIMARY KEY (`transactionDetailsID`),
  ADD KEY `transactionID` (`transactionID`),
  ADD KEY `carID` (`carID`);

--
-- Indexes for table `Transactions`
--
ALTER TABLE `Transactions`
  ADD PRIMARY KEY (`transactionID`),
  ADD KEY `customerID` (`customerID`),
  ADD KEY `employeeID` (`employeeID`);

--
-- Indexes for table `TransactionType`
--
ALTER TABLE `TransactionType`
  ADD PRIMARY KEY (`transactionTypeID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `CarCondition`
--
ALTER TABLE `CarCondition`
  MODIFY `conditionID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `Cars`
--
ALTER TABLE `Cars`
  MODIFY `carID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `Customers`
--
ALTER TABLE `Customers`
  MODIFY `customerID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `Employees`
--
ALTER TABLE `Employees`
  MODIFY `employeeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `TransactionDetails`
--
ALTER TABLE `TransactionDetails`
  MODIFY `transactionDetailsID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `Transactions`
--
ALTER TABLE `Transactions`
  MODIFY `transactionID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `TransactionType`
--
ALTER TABLE `TransactionType`
  MODIFY `transactionTypeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Cars`
--
ALTER TABLE `Cars`
  ADD CONSTRAINT `Cars_ibfk_1` FOREIGN KEY (`conditionID`) REFERENCES `CarCondition` (`conditionID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `TransactionDetails`
--
ALTER TABLE `TransactionDetails`
  ADD CONSTRAINT `TransactionDetails_ibfk_1` FOREIGN KEY (`transactionID`) REFERENCES `Transactions` (`transactionID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `TransactionDetails_ibfk_2` FOREIGN KEY (`carID`) REFERENCES `Cars` (`carID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Transactions`
--
ALTER TABLE `Transactions`
  ADD CONSTRAINT `Transactions_ibfk_1` FOREIGN KEY (`customerID`) REFERENCES `Customers` (`customerID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Transactions_ibfk_2` FOREIGN KEY (`employeeID`) REFERENCES `Employees` (`employeeID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
