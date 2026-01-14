-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 14, 2026 at 11:50 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `property_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL,
  `accountName` varchar(191) NOT NULL,
  `assetType` varchar(191) NOT NULL,
  `openingBalance` decimal(10,2) NOT NULL DEFAULT 0.00,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `accountName`, `assetType`, `openingBalance`, `createdAt`, `updatedAt`) VALUES
(1, 'service', 'Income', 130000.00, '2026-01-14 05:39:20.411', '2026-01-14 05:39:39.691');

-- --------------------------------------------------------

--
-- Table structure for table `communication`
--

CREATE TABLE `communication` (
  `id` int(11) NOT NULL,
  `type` varchar(191) NOT NULL,
  `recipient` varchar(191) NOT NULL,
  `subject` varchar(191) DEFAULT NULL,
  `message` varchar(191) NOT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'Sent',
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `document`
--

CREATE TABLE `document` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  `type` varchar(191) NOT NULL,
  `expiryDate` datetime(3) DEFAULT NULL,
  `fileUrl` varchar(191) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `document`
--

INSERT INTO `document` (`id`, `userId`, `name`, `type`, `expiryDate`, `fileUrl`, `createdAt`, `updatedAt`) VALUES
(1, 4, 'images.png', 'Other', NULL, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1768368902/tenant_documents/mpvvtefftoujnraqnjol.png', '2026-01-14 05:35:00.483', '2026-01-14 05:35:00.483'),
(2, 9, 'images.png', 'Other', NULL, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1768374172/tenant_documents/x8ekv1pcmmdgkwf4ncez.png', '2026-01-14 07:02:52.138', '2026-01-14 07:02:52.138'),
(3, 11, 'images.png', 'Other', NULL, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1768382394/tenant_documents/w0oq4hes4vqecsogwo6l.png', '2026-01-14 09:19:54.843', '2026-01-14 09:19:54.843'),
(4, 3, 'images.png', 'Other', NULL, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1768383635/tenant_documents/rbudmsxlyy1vfmoadwov.png', '2026-01-14 09:40:36.372', '2026-01-14 09:40:36.372'),
(5, 10, 'images.png', 'Other', NULL, 'https://res.cloudinary.com/dw48hcxi5/image/upload/v1768383738/tenant_documents/gg6bewrvyzens9ssg1ec.png', '2026-01-14 09:42:19.452', '2026-01-14 09:42:19.452');

-- --------------------------------------------------------

--
-- Table structure for table `insurance`
--

CREATE TABLE `insurance` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `provider` varchar(191) NOT NULL,
  `policyNumber` varchar(191) NOT NULL,
  `startDate` datetime(3) NOT NULL,
  `endDate` datetime(3) NOT NULL,
  `documentUrl` varchar(191) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `unitId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `insurance`
--

INSERT INTO `insurance` (`id`, `userId`, `provider`, `policyNumber`, `startDate`, `endDate`, `documentUrl`, `createdAt`, `updatedAt`, `unitId`) VALUES
(1, 3, 'State Farm', 'SF-12345', '2025-01-01 00:00:00.000', '2026-01-01 00:00:00.000', NULL, '2026-01-14 05:23:47.168', '2026-01-14 05:23:47.168', NULL),
(2, 9, 'star', '1', '2026-01-01 00:00:00.000', '2026-01-13 00:00:00.000', NULL, '2026-01-14 07:28:17.219', '2026-01-14 07:46:55.043', 143),
(3, 11, 'marsh', '12', '2026-01-14 00:00:00.000', '2026-01-17 00:00:00.000', NULL, '2026-01-14 09:20:29.824', '2026-01-14 09:20:29.824', 150);

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

CREATE TABLE `invoice` (
  `id` int(11) NOT NULL,
  `invoiceNo` varchar(191) NOT NULL,
  `tenantId` int(11) NOT NULL,
  `unitId` int(11) NOT NULL,
  `month` varchar(191) NOT NULL,
  `amount` decimal(65,30) NOT NULL,
  `rent` decimal(65,30) NOT NULL,
  `serviceFees` decimal(65,30) NOT NULL DEFAULT 0.000000000000000000000000000000,
  `status` varchar(191) NOT NULL DEFAULT 'draft',
  `paidAt` datetime(3) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `dueDate` datetime(3) DEFAULT NULL,
  `paymentMethod` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `invoice`
--

INSERT INTO `invoice` (`id`, `invoiceNo`, `tenantId`, `unitId`, `month`, `amount`, `rent`, `serviceFees`, `status`, `paidAt`, `createdAt`, `updatedAt`, `dueDate`, `paymentMethod`) VALUES
(1, 'INV-001', 4, 133, 'December 2025', 1400.000000000000000000000000000000, 1400.000000000000000000000000000000, 0.000000000000000000000000000000, 'paid', '2026-01-14 05:35:06.186', '2026-01-14 05:30:50.163', '2026-01-14 05:35:06.188', NULL, NULL),
(2, 'INV-002', 5, 135, 'January 2026', 3000.000000000000000000000000000000, 3000.000000000000000000000000000000, 0.000000000000000000000000000000, 'paid', '2026-01-14 05:43:41.348', '2026-01-14 05:42:24.972', '2026-01-14 05:43:41.349', NULL, NULL),
(3, 'INV-1768374037209', 9, 143, 'January 2026', 3000.000000000000000000000000000000, 3000.000000000000000000000000000000, 0.000000000000000000000000000000, 'paid', '2026-01-14 07:31:40.043', '2026-01-14 07:00:37.211', '2026-01-14 07:31:40.044', NULL, NULL),
(4, 'INV-004', 9, 143, 'January 2026', 2117.000000000000000000000000000000, 2000.000000000000000000000000000000, 117.000000000000000000000000000000, 'draft', NULL, '2026-01-14 08:46:12.131', '2026-01-14 08:46:12.131', NULL, NULL),
(5, 'INV-1768381557308', 11, 150, 'January 2026', 2500.000000000000000000000000000000, 2500.000000000000000000000000000000, 0.000000000000000000000000000000, 'paid', '2026-01-14 09:08:53.158', '2026-01-14 09:05:57.310', '2026-01-14 09:08:53.160', NULL, NULL),
(6, 'INV-1768387200435', 12, 152, 'January 2026', 6500.000000000000000000000000000000, 6500.000000000000000000000000000000, 0.000000000000000000000000000000, 'Unpaid', NULL, '2026-01-14 10:40:00.436', '2026-01-14 10:40:00.436', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `lease`
--

CREATE TABLE `lease` (
  `id` int(11) NOT NULL,
  `unitId` int(11) NOT NULL,
  `tenantId` int(11) NOT NULL,
  `startDate` datetime(3) DEFAULT NULL,
  `endDate` datetime(3) DEFAULT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'Active',
  `monthlyRent` decimal(65,30) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `securityDeposit` decimal(65,30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lease`
--

INSERT INTO `lease` (`id`, `unitId`, `tenantId`, `startDate`, `endDate`, `status`, `monthlyRent`, `createdAt`, `updatedAt`, `securityDeposit`) VALUES
(1, 1, 3, '2025-01-01 00:00:00.000', '2026-01-01 00:00:00.000', 'Active', 1200.000000000000000000000000000000, '2026-01-14 05:23:47.181', '2026-01-14 05:23:47.181', NULL),
(2, 133, 4, '2025-12-31 00:00:00.000', '2026-01-14 00:00:00.000', 'Active', 1400.000000000000000000000000000000, '2026-01-14 05:29:13.972', '2026-01-14 05:30:49.970', 200.000000000000000000000000000000),
(3, 135, 5, '2026-01-01 00:00:00.000', '2026-01-31 00:00:00.000', 'Active', 3000.000000000000000000000000000000, '2026-01-14 05:41:48.164', '2026-01-14 05:42:24.949', 3000.000000000000000000000000000000),
(4, 140, 8, NULL, NULL, 'DRAFT', NULL, '2026-01-14 06:55:08.915', '2026-01-14 06:55:08.915', NULL),
(5, 143, 9, '2026-01-13 00:00:00.000', '2026-01-30 00:00:00.000', 'Active', 3000.000000000000000000000000000000, '2026-01-14 06:59:46.604', '2026-01-14 07:00:37.158', 3000.000000000000000000000000000000),
(6, 142, 10, NULL, NULL, 'DRAFT', NULL, '2026-01-14 08:52:35.201', '2026-01-14 08:52:35.201', NULL),
(7, 150, 11, '2026-01-14 00:00:00.000', '2026-01-31 00:00:00.000', 'Active', 2500.000000000000000000000000000000, '2026-01-14 09:04:54.211', '2026-01-14 09:05:57.291', 3000.000000000000000000000000000000),
(8, 152, 12, '2026-01-01 00:00:00.000', '2026-01-31 00:00:00.000', 'Active', 6500.000000000000000000000000000000, '2026-01-14 10:38:17.446', '2026-01-14 10:40:00.416', 200.000000000000000000000000000000),
(9, 157, 13, NULL, NULL, 'DRAFT', NULL, '2026-01-14 10:47:04.583', '2026-01-14 10:47:04.583', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `maintenancetask`
--

CREATE TABLE `maintenancetask` (
  `id` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  `propertyId` int(11) DEFAULT NULL,
  `type` varchar(191) NOT NULL,
  `frequency` varchar(191) NOT NULL,
  `dueDate` datetime(3) NOT NULL,
  `vendor` varchar(191) NOT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'Upcoming',
  `notes` varchar(191) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `message`
--

CREATE TABLE `message` (
  `id` int(11) NOT NULL,
  `content` text NOT NULL,
  `senderId` int(11) NOT NULL,
  `receiverId` int(11) NOT NULL,
  `isRead` tinyint(1) NOT NULL DEFAULT 0,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `property`
--

CREATE TABLE `property` (
  `id` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  `address` varchar(191) NOT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'Active',
  `ownerId` int(11) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `property`
--

INSERT INTO `property` (`id`, `name`, `address`, `status`, `ownerId`, `createdAt`, `updatedAt`) VALUES
(1, 'Sunset Apartments', '123 Sunset Blvd, CA', 'Active', 2, '2026-01-14 05:23:47.142', '2026-01-14 05:23:47.142'),
(2, 'green velly', 'Not Provided', 'Active', 6, '2026-01-14 05:26:43.108', '2026-01-14 05:47:09.113'),
(3, 'delux', 'Not Provided', 'Active', 7, '2026-01-14 06:52:37.261', '2026-01-14 06:53:57.524'),
(4, 'hostel', 'Not Provided', 'Active', NULL, '2026-01-14 08:54:16.622', '2026-01-14 08:54:16.622'),
(5, 'own', 'Not Provided', 'Active', NULL, '2026-01-14 10:36:10.916', '2026-01-14 10:36:10.916');

-- --------------------------------------------------------

--
-- Table structure for table `refreshtoken`
--

CREATE TABLE `refreshtoken` (
  `id` int(11) NOT NULL,
  `token` varchar(191) NOT NULL,
  `userId` int(11) NOT NULL,
  `expiresAt` datetime(3) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `refreshtoken`
--

INSERT INTO `refreshtoken` (`id`, `token`, `userId`, `expiresAt`, `createdAt`) VALUES
(1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzY4MzY4MzIzLCJleHAiOjE3Njg5NzMxMjN9.apGavv02LB0-tEQcG8NDNgnLW-3AXaqqMe1spRTF45Q', 1, '2026-01-21 05:25:23.201', '2026-01-14 05:25:23.204'),
(2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NCwiaWF0IjoxNzY4MzY4Njk5LCJleHAiOjE3Njg5NzM0OTl9.-AbgW2cat80A6swnobOGwm7o2b5wCCKQOLZGmndpWPY', 4, '2026-01-21 05:31:39.463', '2026-01-14 05:31:39.464'),
(3, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzY4MzY4OTQ5LCJleHAiOjE3Njg5NzM3NDl9.5imx2exPqCHkkSvRTnIFQfQ3PLpKTqdbWOcOgaW3vZU', 1, '2026-01-21 05:35:49.069', '2026-01-14 05:35:49.070'),
(4, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiaWF0IjoxNzY4MzY5Mzk0LCJleHAiOjE3Njg5NzQxOTR9.wRbkH2WUfhwoNRWnyLT3HFKMj6g8nzC-GWX_dBblMds', 5, '2026-01-21 05:43:14.053', '2026-01-14 05:43:14.055'),
(5, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzY4MzY5NTcwLCJleHAiOjE3Njg5NzQzNzB9.6dwFWY9W5ShF_rZG1ifPdMJjnX9DHAt5sVzdKGxcHm8', 1, '2026-01-21 05:46:10.516', '2026-01-14 05:46:10.517'),
(6, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NiwiaWF0IjoxNzY4MzY5NjQ4LCJleHAiOjE3Njg5NzQ0NDh9.aI7uqGG4RsvF9e4kLIlMO94nr3UbHA0bvp2LF4Rw3WU', 6, '2026-01-21 05:47:28.373', '2026-01-14 05:47:28.375'),
(7, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzY4MzcwODg5LCJleHAiOjE3Njg5NzU2ODl9.zDoBncu7fK2kodv4gbZ67GZsMc-cYIF1tEfKi8T_Fzg', 1, '2026-01-21 06:08:09.489', '2026-01-14 06:08:09.491'),
(8, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzY4MzczNDM5LCJleHAiOjE3Njg5NzgyMzl9.Pyl_zB3VMBDqxCOynsNysMbzvHTRi6el9bupo8d76eA', 1, '2026-01-21 06:50:39.052', '2026-01-14 06:50:39.055'),
(9, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OSwiaWF0IjoxNzY4Mzc0MDc4LCJleHAiOjE3Njg5Nzg4Nzh9.f_jDroDDnOeS1cbLeRciyGDoTov2INT1I9vrAJ5UC60', 9, '2026-01-21 07:01:18.997', '2026-01-14 07:01:18.998'),
(10, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzY4Mzc0NDc3LCJleHAiOjE3Njg5NzkyNzd9.XO1IAos5hi_Y1Nh3P25JcQndo-Pb6Huh1RUdZSVD-PE', 1, '2026-01-21 07:07:57.604', '2026-01-14 07:07:57.606'),
(11, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OSwiaWF0IjoxNzY4Mzc0NjAyLCJleHAiOjE3Njg5Nzk0MDJ9.BbXPrGzEuNoWeeBpUNp-3T3nL83eDNzQQaEZhHUF6KY', 9, '2026-01-21 07:10:02.910', '2026-01-14 07:10:02.911'),
(12, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OSwiaWF0IjoxNzY4Mzc1MjEwLCJleHAiOjE3Njg5ODAwMTB9.ggGXJOUqGTqhq95FkBtl-W31mVZ8B_zUmwltkU4DeCY', 9, '2026-01-21 07:20:10.718', '2026-01-14 07:20:10.720'),
(13, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzY4Mzc1NzI0LCJleHAiOjE3Njg5ODA1MjR9.lgmudUojicC3r7h8RLLOz-DBfwLx9VaXbOknB-ETlbs', 1, '2026-01-21 07:28:44.002', '2026-01-14 07:28:44.003'),
(14, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OSwiaWF0IjoxNzY4Mzc1ODM3LCJleHAiOjE3Njg5ODA2Mzd9.dahXkeRXQ-drnf797bIs0v18GARRTXOF8BzYfH3bx4o', 9, '2026-01-21 07:30:37.531', '2026-01-14 07:30:37.532'),
(15, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzY4MzgwMTI3LCJleHAiOjE3Njg5ODQ5Mjd9.YF2vrZ7CdETRArQZqJVdpqDmnNujerGkD5FshgJTQFY', 1, '2026-01-21 08:42:07.699', '2026-01-14 08:42:07.701'),
(16, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OSwiaWF0IjoxNzY4MzgwNDEwLCJleHAiOjE3Njg5ODUyMTB9.PptyomCmUF4Lav4U1NROkLk7uTV4rVy8PVpBEpmhv50', 9, '2026-01-21 08:46:50.084', '2026-01-14 08:46:50.085'),
(17, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzY4MzgwNDk4LCJleHAiOjE3Njg5ODUyOTh9.--Xb0vVsj3f6f5uicfFTz451Wv4WL9QGd5UjiyTONYE', 1, '2026-01-21 08:48:18.675', '2026-01-14 08:48:18.676'),
(18, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTEsImlhdCI6MTc2ODM4MTU5OSwiZXhwIjoxNzY4OTg2Mzk5fQ.PLuDYrxAnx2QNiEZZ2GZI1hB52-hBOxuegBKHkSeut4', 11, '2026-01-21 09:06:39.519', '2026-01-14 09:06:39.521'),
(19, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzY4MzgyNDQ0LCJleHAiOjE3Njg5ODcyNDR9.PyqUNGzUwELguh6fcqQh1_HEvaJw-J1UoLGWpkyDFok', 1, '2026-01-21 09:20:44.299', '2026-01-14 09:20:44.301'),
(20, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MywiaWF0IjoxNzY4MzgzNjEwLCJleHAiOjE3Njg5ODg0MTB9.VwVBmXd0GMk37kTiEspVyGzSe0bczGogqsu_H2W73F0', 3, '2026-01-21 09:40:10.438', '2026-01-14 09:40:10.440'),
(21, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTAsImlhdCI6MTc2ODM4MzcxMywiZXhwIjoxNzY4OTg4NTEzfQ.9YaOfC2PR5w2pS1znAdQ6NzvsQY5-hT1pQlZZaDSYVo', 10, '2026-01-21 09:41:53.317', '2026-01-14 09:41:53.318'),
(22, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzY4MzgzNzUwLCJleHAiOjE3Njg5ODg1NTB9.5ec18Xv1xEkzq1KcBasrJPe_TvPQJlsCbITGBSD4Qbg', 1, '2026-01-21 09:42:30.666', '2026-01-14 09:42:30.667'),
(23, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzY4Mzg0ODA5LCJleHAiOjE3Njg5ODk2MDl9.vrUsLau7fI_evhhZbcPInSzA0n_y5Uph6UEJT_Sw4Ho', 1, '2026-01-21 10:00:09.526', '2026-01-14 10:00:09.528'),
(24, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OSwiaWF0IjoxNzY4Mzg2NTY2LCJleHAiOjE3Njg5OTEzNjZ9.t-Af0ZspCwKOPouBlEAjJ5G1ehykQ5EUIKNzDwTmi_U', 9, '2026-01-21 10:29:26.582', '2026-01-14 10:29:26.584'),
(25, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzY4Mzg2NjMyLCJleHAiOjE3Njg5OTE0MzJ9.Jpa4KQiHTa-u8sMLjOV7zQugKXloR5dhZAY3BtO7bRQ', 1, '2026-01-21 10:30:32.497', '2026-01-14 10:30:32.498');

-- --------------------------------------------------------

--
-- Table structure for table `refundadjustment`
--

CREATE TABLE `refundadjustment` (
  `id` int(11) NOT NULL,
  `requestId` varchar(191) NOT NULL,
  `type` varchar(191) NOT NULL,
  `reason` varchar(191) NOT NULL,
  `tenantId` int(11) NOT NULL,
  `unitId` int(11) NOT NULL,
  `amount` decimal(65,30) NOT NULL,
  `date` datetime(3) NOT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'Pending',
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `systemsetting`
--

CREATE TABLE `systemsetting` (
  `id` int(11) NOT NULL,
  `key` varchar(191) NOT NULL,
  `value` varchar(191) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `taxes`
--

CREATE TABLE `taxes` (
  `id` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  `rate` decimal(10,2) NOT NULL DEFAULT 0.00,
  `appliesTo` varchar(50) NOT NULL DEFAULT 'Rent',
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ticket`
--

CREATE TABLE `ticket` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `subject` varchar(191) NOT NULL,
  `description` varchar(191) NOT NULL,
  `priority` varchar(191) NOT NULL DEFAULT 'Low',
  `status` varchar(191) NOT NULL DEFAULT 'Open',
  `attachmentUrls` varchar(191) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `propertyId` int(11) DEFAULT NULL,
  `unitId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ticket`
--

INSERT INTO `ticket` (`id`, `userId`, `subject`, `description`, `priority`, `status`, `attachmentUrls`, `createdAt`, `updatedAt`, `propertyId`, `unitId`) VALUES
(1, 4, 'door fix', 'fixet', 'Medium', 'Open', '[{\"type\":\"image\",\"url\":\"https://res.cloudinary.com/dw48hcxi5/image/upload/v1768368886/tickets/images/bf08ztfcnuojcgogqyau.png\"}]', '2026-01-14 05:34:44.041', '2026-01-14 05:34:44.041', 2, 133),
(2, 9, 'terish clean', 'apolo', 'Medium', 'Open', '[{\"type\":\"image\",\"url\":\"https://res.cloudinary.com/dw48hcxi5/image/upload/v1768374209/tickets/images/cwrqbl2z6e3gebfwcw5i.png\"}]', '2026-01-14 07:03:28.924', '2026-01-14 07:03:28.924', 3, 143),
(3, 11, 'bulb fitting', 'aas', 'Medium', 'Open', '[{\"type\":\"image\",\"url\":\"https://res.cloudinary.com/dw48hcxi5/image/upload/v1768382365/tickets/images/dnrpwmxnxyguaw7vvbp6.png\"}]', '2026-01-14 09:19:26.437', '2026-01-14 09:19:26.437', 4, 150),
(4, 9, 'bike speace', 'hlo', 'Medium', 'Open', '[{\"type\":\"image\",\"url\":\"https://res.cloudinary.com/dw48hcxi5/image/upload/v1768386614/tickets/images/yht0kzfialyflpssrrgf.png\"}]', '2026-01-14 10:30:14.462', '2026-01-14 10:30:14.462', 3, 143);

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `id` int(11) NOT NULL,
  `date` datetime(3) NOT NULL,
  `description` varchar(191) NOT NULL,
  `type` varchar(191) NOT NULL,
  `amount` decimal(65,30) NOT NULL,
  `balance` decimal(65,30) NOT NULL DEFAULT 0.000000000000000000000000000000,
  `status` varchar(191) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`id`, `date`, `description`, `type`, `amount`, `balance`, `status`, `createdAt`, `updatedAt`) VALUES
(1, '2026-01-14 05:35:06.174', 'Rent Payment - December 2025 (card)', 'Income', 1400.000000000000000000000000000000, 0.000000000000000000000000000000, 'Completed', '2026-01-14 05:35:06.175', '2026-01-14 05:35:06.175'),
(2, '2026-01-14 05:43:41.329', 'Rent Payment - January 2026 (card)', 'Income', 3000.000000000000000000000000000000, 0.000000000000000000000000000000, 'Completed', '2026-01-14 05:43:41.331', '2026-01-14 05:43:41.331'),
(3, '2026-01-14 07:31:40.029', 'Rent Payment - January 2026 (card)', 'Income', 3000.000000000000000000000000000000, 0.000000000000000000000000000000, 'Completed', '2026-01-14 07:31:40.031', '2026-01-14 07:31:40.031'),
(4, '2026-01-14 09:08:53.147', 'Rent Payment - January 2026 (card)', 'Income', 2500.000000000000000000000000000000, 0.000000000000000000000000000000, 'Completed', '2026-01-14 09:08:53.149', '2026-01-14 09:08:53.149');

-- --------------------------------------------------------

--
-- Table structure for table `unit`
--

CREATE TABLE `unit` (
  `id` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  `propertyId` int(11) NOT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'Vacant',
  `bedrooms` int(11) NOT NULL DEFAULT 1,
  `rentAmount` decimal(65,30) NOT NULL DEFAULT 0.000000000000000000000000000000,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `rentalMode` enum('FULL_UNIT','BEDROOM_WISE') NOT NULL DEFAULT 'FULL_UNIT'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `unit`
--

INSERT INTO `unit` (`id`, `name`, `propertyId`, `status`, `bedrooms`, `rentAmount`, `createdAt`, `updatedAt`, `rentalMode`) VALUES
(1, '101', 1, 'Occupied', 2, 1200.000000000000000000000000000000, '2026-01-14 05:23:47.142', '2026-01-14 05:23:47.142', 'FULL_UNIT'),
(2, '102', 1, 'Occupied', 2, 1200.000000000000000000000000000000, '2026-01-14 05:23:47.142', '2026-01-14 05:23:47.142', 'FULL_UNIT'),
(3, '103', 1, 'Occupied', 2, 1200.000000000000000000000000000000, '2026-01-14 05:23:47.142', '2026-01-14 05:23:47.142', 'FULL_UNIT'),
(4, '104', 1, 'Occupied', 2, 1200.000000000000000000000000000000, '2026-01-14 05:23:47.142', '2026-01-14 05:23:47.142', 'FULL_UNIT'),
(5, '105', 1, 'Occupied', 2, 1200.000000000000000000000000000000, '2026-01-14 05:23:47.142', '2026-01-14 05:23:47.142', 'FULL_UNIT'),
(6, '106', 1, 'Occupied', 2, 1200.000000000000000000000000000000, '2026-01-14 05:23:47.142', '2026-01-14 05:23:47.142', 'FULL_UNIT'),
(7, '107', 1, 'Occupied', 2, 1200.000000000000000000000000000000, '2026-01-14 05:23:47.142', '2026-01-14 05:23:47.142', 'FULL_UNIT'),
(8, '108', 1, 'Occupied', 2, 1200.000000000000000000000000000000, '2026-01-14 05:23:47.142', '2026-01-14 05:23:47.142', 'FULL_UNIT'),
(9, '109', 1, 'Occupied', 2, 1200.000000000000000000000000000000, '2026-01-14 05:23:47.142', '2026-01-14 05:23:47.142', 'FULL_UNIT'),
(10, '110', 1, 'Occupied', 2, 1200.000000000000000000000000000000, '2026-01-14 05:23:47.142', '2026-01-14 05:23:47.142', 'FULL_UNIT'),
(11, '111', 1, 'Occupied', 2, 1200.000000000000000000000000000000, '2026-01-14 05:23:47.142', '2026-01-14 05:23:47.142', 'FULL_UNIT'),
(12, '112', 1, 'Vacant', 2, 1200.000000000000000000000000000000, '2026-01-14 05:23:47.142', '2026-01-14 05:23:47.142', 'FULL_UNIT'),
(13, 'Unit 1', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(14, 'Unit 2', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(15, 'Unit 3', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(16, 'Unit 4', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(17, 'Unit 5', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(18, 'Unit 6', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(19, 'Unit 7', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(20, 'Unit 8', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(21, 'Unit 9', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(22, 'Unit 10', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(23, 'Unit 11', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(24, 'Unit 12', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(25, 'Unit 13', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(26, 'Unit 14', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(27, 'Unit 15', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(28, 'Unit 16', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(29, 'Unit 17', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(30, 'Unit 18', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(31, 'Unit 19', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(32, 'Unit 20', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(33, 'Unit 21', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(34, 'Unit 22', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(35, 'Unit 23', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(36, 'Unit 24', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(37, 'Unit 25', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(38, 'Unit 26', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(39, 'Unit 27', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(40, 'Unit 28', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(41, 'Unit 29', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(42, 'Unit 30', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(43, 'Unit 31', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(44, 'Unit 32', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(45, 'Unit 33', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(46, 'Unit 34', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(47, 'Unit 35', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(48, 'Unit 36', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(49, 'Unit 37', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(50, 'Unit 38', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(51, 'Unit 39', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(52, 'Unit 40', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(53, 'Unit 41', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(54, 'Unit 42', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(55, 'Unit 43', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(56, 'Unit 44', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(57, 'Unit 45', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(58, 'Unit 46', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(59, 'Unit 47', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(60, 'Unit 48', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(61, 'Unit 49', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(62, 'Unit 50', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(63, 'Unit 51', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(64, 'Unit 52', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(65, 'Unit 53', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(66, 'Unit 54', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(67, 'Unit 55', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(68, 'Unit 56', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(69, 'Unit 57', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(70, 'Unit 58', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(71, 'Unit 59', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(72, 'Unit 60', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(73, 'Unit 61', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(74, 'Unit 62', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(75, 'Unit 63', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(76, 'Unit 64', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(77, 'Unit 65', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(78, 'Unit 66', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(79, 'Unit 67', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(80, 'Unit 68', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(81, 'Unit 69', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(82, 'Unit 70', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(83, 'Unit 71', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(84, 'Unit 72', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(85, 'Unit 73', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(86, 'Unit 74', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(87, 'Unit 75', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(88, 'Unit 76', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(89, 'Unit 77', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(90, 'Unit 78', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(91, 'Unit 79', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(92, 'Unit 80', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(93, 'Unit 81', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(94, 'Unit 82', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(95, 'Unit 83', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(96, 'Unit 84', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(97, 'Unit 85', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(98, 'Unit 86', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(99, 'Unit 87', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(100, 'Unit 88', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(101, 'Unit 89', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(102, 'Unit 90', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(103, 'Unit 91', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(104, 'Unit 92', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(105, 'Unit 93', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(106, 'Unit 94', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(107, 'Unit 95', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(108, 'Unit 96', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(109, 'Unit 97', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(110, 'Unit 98', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(111, 'Unit 99', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(112, 'Unit 100', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(113, 'Unit 101', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(114, 'Unit 102', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(115, 'Unit 103', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(116, 'Unit 104', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(117, 'Unit 105', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(118, 'Unit 106', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(119, 'Unit 107', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(120, 'Unit 108', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(121, 'Unit 109', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(122, 'Unit 110', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(123, 'Unit 111', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(124, 'Unit 112', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(125, 'Unit 113', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(126, 'Unit 114', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(127, 'Unit 115', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(128, 'Unit 116', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(129, 'Unit 117', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(130, 'Unit 118', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(131, 'Unit 119', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(132, 'Unit 120', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:43.108', '2026-01-14 05:26:43.108', 'FULL_UNIT'),
(133, 'unit 1', 2, 'Occupied', 1, 0.000000000000000000000000000000, '2026-01-14 05:26:56.848', '2026-01-14 05:30:49.980', 'FULL_UNIT'),
(134, 'unit 2', 2, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 05:27:06.934', '2026-01-14 05:27:06.934', 'FULL_UNIT'),
(135, 'unit 3', 2, 'Occupied', 3, 0.000000000000000000000000000000, '2026-01-14 05:41:08.487', '2026-01-14 05:42:24.963', 'BEDROOM_WISE'),
(136, 'Unit 1', 3, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 06:52:37.261', '2026-01-14 06:52:37.261', 'FULL_UNIT'),
(137, 'Unit 2', 3, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 06:52:37.261', '2026-01-14 06:52:37.261', 'FULL_UNIT'),
(138, 'Unit 3', 3, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 06:52:37.261', '2026-01-14 06:52:37.261', 'FULL_UNIT'),
(139, 'Unit 4', 3, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 06:52:37.261', '2026-01-14 06:52:37.261', 'FULL_UNIT'),
(140, 'unit 1', 3, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 06:52:51.858', '2026-01-14 06:52:51.858', 'FULL_UNIT'),
(141, 'unit 2', 3, 'Vacant', 3, 0.000000000000000000000000000000, '2026-01-14 06:53:02.138', '2026-01-14 06:53:02.138', 'BEDROOM_WISE'),
(142, 'unit 3', 3, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 06:58:26.472', '2026-01-14 06:58:26.472', 'FULL_UNIT'),
(143, 'unit 4', 3, 'Occupied', 3, 0.000000000000000000000000000000, '2026-01-14 06:58:48.012', '2026-01-14 07:00:37.166', 'BEDROOM_WISE'),
(144, 'Unit 1', 4, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 08:54:16.622', '2026-01-14 08:54:16.622', 'FULL_UNIT'),
(145, 'Unit 2', 4, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 08:54:16.622', '2026-01-14 08:54:16.622', 'FULL_UNIT'),
(146, 'Unit 3', 4, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 08:54:16.622', '2026-01-14 08:54:16.622', 'FULL_UNIT'),
(147, 'Unit 4', 4, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 08:54:16.622', '2026-01-14 08:54:16.622', 'FULL_UNIT'),
(148, 'Unit 5', 4, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 08:54:16.622', '2026-01-14 08:54:16.622', 'FULL_UNIT'),
(149, 'unit 101', 4, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 08:55:01.538', '2026-01-14 08:55:01.538', 'FULL_UNIT'),
(150, '2', 4, 'Occupied', 3, 0.000000000000000000000000000000, '2026-01-14 09:03:36.238', '2026-01-14 09:05:57.300', 'BEDROOM_WISE'),
(151, '1', 4, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 10:34:52.650', '2026-01-14 10:34:52.650', 'FULL_UNIT'),
(152, 'Unit 1', 5, 'Occupied', 1, 0.000000000000000000000000000000, '2026-01-14 10:36:10.916', '2026-01-14 10:40:00.426', 'FULL_UNIT'),
(153, 'Unit 2', 5, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 10:36:10.916', '2026-01-14 10:36:10.916', 'FULL_UNIT'),
(154, 'Unit 3', 5, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 10:36:10.916', '2026-01-14 10:36:10.916', 'FULL_UNIT'),
(155, 'Unit 4', 5, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 10:36:10.916', '2026-01-14 10:36:10.916', 'FULL_UNIT'),
(156, '1', 5, 'Vacant', 1, 0.000000000000000000000000000000, '2026-01-14 10:36:34.909', '2026-01-14 10:36:34.909', 'FULL_UNIT'),
(157, '2', 5, 'Vacant', 3, 0.000000000000000000000000000000, '2026-01-14 10:45:53.947', '2026-01-14 10:45:53.947', 'BEDROOM_WISE');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(191) NOT NULL,
  `password` varchar(191) NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  `role` enum('ADMIN','OWNER','TENANT') NOT NULL DEFAULT 'TENANT',
  `phone` varchar(191) DEFAULT NULL,
  `type` varchar(191) DEFAULT 'Individual',
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `email`, `password`, `name`, `role`, `phone`, `type`, `createdAt`, `updatedAt`) VALUES
(1, 'admin@property.com', '$2b$10$KLCcHvKNiz97xDmYmM7OCeF.0Bb1qhv/i7eK0i9skN1Y78JM6J6Ku', 'Super Admin', 'ADMIN', NULL, 'Individual', '2026-01-14 05:23:47.110', '2026-01-14 05:23:47.110'),
(2, 'owner@property.com', '$2b$10$KLCcHvKNiz97xDmYmM7OCeF.0Bb1qhv/i7eK0i9skN1Y78JM6J6Ku', 'Mr. Landlord', 'OWNER', NULL, 'Individual', '2026-01-14 05:23:47.123', '2026-01-14 05:23:47.123'),
(3, 'tenant@example.com', '$2b$10$KLCcHvKNiz97xDmYmM7OCeF.0Bb1qhv/i7eK0i9skN1Y78JM6J6Ku', 'John Smith', 'TENANT', '+1 (555) 012-3456', 'Individual', '2026-01-14 05:23:47.168', '2026-01-14 05:23:47.168'),
(4, 'naman@gmail.com', '$2b$10$00K/ZGym4FzCylBORZAcm.CHUKwD211ZWAcDT7pAw2PvpS2aRFNCa', 'naman', 'TENANT', '3214567123', 'Individual', '2026-01-14 05:29:13.956', '2026-01-14 05:29:13.956'),
(5, 'aaa@gmail.com', '$2b$10$4PqNQdoVfXirBmf8OJ5rieq5nSGVdzDT/JdCHMaD5vENXPC4Nw1/i', 'aaa', 'TENANT', '4321567890', 'Individual', '2026-01-14 05:41:48.162', '2026-01-14 05:41:48.162'),
(6, 'owner@gmail.com', '$2b$10$5w/1Il/bMijsuQFWfYSPjepAD7g4DA5P4fVbH.xNGIs3utYlaZ//W', 'owner ', 'OWNER', '3214325678', 'Individual', '2026-01-14 05:47:09.113', '2026-01-14 05:47:09.113'),
(7, 'delux@gmail.com', '$2b$10$8cLc42L2AyIWyLjCIvzMOu2B3Bb7DP3YyFLy97HkjsNjC/TOxdEO6', 'delux owner', 'OWNER', '4326512890', 'Individual', '2026-01-14 06:53:57.524', '2026-01-14 06:53:57.524'),
(8, 'd@gmail.com', '$2b$10$Pc6x0nYnvFr5dfTHABner.7LmFUdUZQ5VWGjSFx9aBAmFnjSOHHcW', 'd', 'TENANT', '19752100980', 'Individual', '2026-01-14 06:55:08.910', '2026-01-14 06:55:08.910'),
(9, 'dd@gmail.com', '$2b$10$O3C15Y..KiG4T8ek95BO6uKcxsc40.0Ims.qf2fBH3LK0E4JVZI2i', 'dd', 'TENANT', '9752100980', 'Individual', '2026-01-14 06:59:46.599', '2026-01-14 06:59:46.599'),
(10, 'ram@gmail.com', '$2b$10$MmMXMMX8E5VG.0/h/RC0UOIk4jPS66W4WpUcAemYcAVZrJkYGUOBS', 'ram', 'TENANT', '9752100980', 'Individual', '2026-01-14 08:52:35.196', '2026-01-14 08:52:35.196'),
(11, 'jhon@gmail.com', '$2b$10$Jlb59PBcW9k9/CeteFtwoe2kx5xBKmpbiqs6JWYwE3Ue0ZAQ3xGkS', 'jhon', 'TENANT', '9752100980', 'Individual', '2026-01-14 09:04:54.209', '2026-01-14 09:04:54.209'),
(12, 'rr@gmail.com', '$2b$10$FzND0Q7oq7eCTw42XpqbEutg0ouxBJ/anGKjr2x4cEEnLoeP5qzzi', 'rr', 'TENANT', '17521009', 'Individual', '2026-01-14 10:38:17.432', '2026-01-14 10:38:17.432'),
(13, 'rrr@gmail.com', '$2b$10$FnR12fu/87bwKiy0wvK4vu2dhn3.Xt4Fr93GbD1lczegRYr29AOti', 'rrr', 'TENANT', '9752100980', 'Individual', '2026-01-14 10:47:04.580', '2026-01-14 10:47:04.580');

-- --------------------------------------------------------

--
-- Table structure for table `_prisma_migrations`
--

CREATE TABLE `_prisma_migrations` (
  `id` varchar(36) NOT NULL,
  `checksum` varchar(64) NOT NULL,
  `finished_at` datetime(3) DEFAULT NULL,
  `migration_name` varchar(255) NOT NULL,
  `logs` text DEFAULT NULL,
  `rolled_back_at` datetime(3) DEFAULT NULL,
  `started_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `applied_steps_count` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `_prisma_migrations`
--

INSERT INTO `_prisma_migrations` (`id`, `checksum`, `finished_at`, `migration_name`, `logs`, `rolled_back_at`, `started_at`, `applied_steps_count`) VALUES
('1f988ad6-0a31-4bea-839c-0fb21cc0536b', 'ead8e5d7a48586cf30be682fbd4e48eca6aa59ab719c78da8fa358fa707c17d5', '2026-01-14 05:23:16.627', '20260112164936_init', NULL, NULL, '2026-01-14 05:23:16.482', 1),
('37e7bce8-7390-471f-bf6f-1589625b5b88', 'e499badb54b59a2192d727bf14d5531f0d49f21c83b621489598b1483c21854e', '2026-01-14 05:23:17.046', '20260114022541_add_taxes_table', NULL, NULL, '2026-01-14 05:23:17.008', 1),
('54c2119b-c89c-4f3f-a26f-9fa3503013f6', 'da230bf5e8574f5c7a3e8d6743622dff64f54f126303ca22688d288a38d18d9e', '2026-01-14 05:23:16.477', '20260111211523_init', NULL, NULL, '2026-01-14 05:23:14.188', 1),
('6956dc5b-0271-4d6c-b38a-078a2e5c711e', '6ec49d3b2f2912d906f5e393d8f3b23bfa0bf189b8508c0af3d026349e3107bc', '2026-01-14 05:23:17.414', '20260114024812_add_accounts_table', NULL, NULL, '2026-01-14 05:23:17.050', 1),
('d1b0a869-43a9-4eb7-95b7-e869e2e5a64e', '4a511dee4c967cadc351786a6f719812ad62c2b6aa827f51da2280752f2c1782', '2026-01-14 05:23:17.002', '20260114011900_init', NULL, NULL, '2026-01-14 05:23:16.633', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `communication`
--
ALTER TABLE `communication`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `document`
--
ALTER TABLE `document`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Document_userId_fkey` (`userId`);

--
-- Indexes for table `insurance`
--
ALTER TABLE `insurance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Insurance_userId_fkey` (`userId`),
  ADD KEY `Insurance_unitId_fkey` (`unitId`);

--
-- Indexes for table `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Invoice_invoiceNo_key` (`invoiceNo`),
  ADD KEY `Invoice_tenantId_fkey` (`tenantId`),
  ADD KEY `Invoice_unitId_fkey` (`unitId`);

--
-- Indexes for table `lease`
--
ALTER TABLE `lease`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Lease_unitId_fkey` (`unitId`),
  ADD KEY `Lease_tenantId_fkey` (`tenantId`);

--
-- Indexes for table `maintenancetask`
--
ALTER TABLE `maintenancetask`
  ADD PRIMARY KEY (`id`),
  ADD KEY `MaintenanceTask_propertyId_fkey` (`propertyId`);

--
-- Indexes for table `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Message_senderId_fkey` (`senderId`),
  ADD KEY `Message_receiverId_fkey` (`receiverId`);

--
-- Indexes for table `property`
--
ALTER TABLE `property`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Property_ownerId_fkey` (`ownerId`);

--
-- Indexes for table `refreshtoken`
--
ALTER TABLE `refreshtoken`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `RefreshToken_token_key` (`token`),
  ADD KEY `RefreshToken_userId_fkey` (`userId`);

--
-- Indexes for table `refundadjustment`
--
ALTER TABLE `refundadjustment`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `RefundAdjustment_requestId_key` (`requestId`),
  ADD KEY `RefundAdjustment_tenantId_fkey` (`tenantId`),
  ADD KEY `RefundAdjustment_unitId_fkey` (`unitId`);

--
-- Indexes for table `systemsetting`
--
ALTER TABLE `systemsetting`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `SystemSetting_key_key` (`key`);

--
-- Indexes for table `taxes`
--
ALTER TABLE `taxes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ticket`
--
ALTER TABLE `ticket`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Ticket_userId_fkey` (`userId`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `unit`
--
ALTER TABLE `unit`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Unit_propertyId_fkey` (`propertyId`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `User_email_key` (`email`);

--
-- Indexes for table `_prisma_migrations`
--
ALTER TABLE `_prisma_migrations`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `communication`
--
ALTER TABLE `communication`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `document`
--
ALTER TABLE `document`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `insurance`
--
ALTER TABLE `insurance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `invoice`
--
ALTER TABLE `invoice`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `lease`
--
ALTER TABLE `lease`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `maintenancetask`
--
ALTER TABLE `maintenancetask`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `message`
--
ALTER TABLE `message`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `property`
--
ALTER TABLE `property`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `refreshtoken`
--
ALTER TABLE `refreshtoken`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `refundadjustment`
--
ALTER TABLE `refundadjustment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `systemsetting`
--
ALTER TABLE `systemsetting`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `taxes`
--
ALTER TABLE `taxes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ticket`
--
ALTER TABLE `ticket`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `unit`
--
ALTER TABLE `unit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=158;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `document`
--
ALTER TABLE `document`
  ADD CONSTRAINT `Document_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `insurance`
--
ALTER TABLE `insurance`
  ADD CONSTRAINT `Insurance_unitId_fkey` FOREIGN KEY (`unitId`) REFERENCES `unit` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `Insurance_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `invoice`
--
ALTER TABLE `invoice`
  ADD CONSTRAINT `Invoice_tenantId_fkey` FOREIGN KEY (`tenantId`) REFERENCES `user` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `Invoice_unitId_fkey` FOREIGN KEY (`unitId`) REFERENCES `unit` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `lease`
--
ALTER TABLE `lease`
  ADD CONSTRAINT `Lease_tenantId_fkey` FOREIGN KEY (`tenantId`) REFERENCES `user` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `Lease_unitId_fkey` FOREIGN KEY (`unitId`) REFERENCES `unit` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `maintenancetask`
--
ALTER TABLE `maintenancetask`
  ADD CONSTRAINT `MaintenanceTask_propertyId_fkey` FOREIGN KEY (`propertyId`) REFERENCES `property` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `message`
--
ALTER TABLE `message`
  ADD CONSTRAINT `Message_receiverId_fkey` FOREIGN KEY (`receiverId`) REFERENCES `user` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `Message_senderId_fkey` FOREIGN KEY (`senderId`) REFERENCES `user` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `property`
--
ALTER TABLE `property`
  ADD CONSTRAINT `Property_ownerId_fkey` FOREIGN KEY (`ownerId`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `refreshtoken`
--
ALTER TABLE `refreshtoken`
  ADD CONSTRAINT `RefreshToken_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `refundadjustment`
--
ALTER TABLE `refundadjustment`
  ADD CONSTRAINT `RefundAdjustment_tenantId_fkey` FOREIGN KEY (`tenantId`) REFERENCES `user` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `RefundAdjustment_unitId_fkey` FOREIGN KEY (`unitId`) REFERENCES `unit` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `ticket`
--
ALTER TABLE `ticket`
  ADD CONSTRAINT `Ticket_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `unit`
--
ALTER TABLE `unit`
  ADD CONSTRAINT `Unit_propertyId_fkey` FOREIGN KEY (`propertyId`) REFERENCES `property` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
