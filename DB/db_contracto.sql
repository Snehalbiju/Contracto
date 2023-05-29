-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 29, 2023 at 06:21 AM
-- Server version: 5.7.36
-- PHP Version: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_mainproject`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_admin`
--

DROP TABLE IF EXISTS `tbl_admin`;
CREATE TABLE IF NOT EXISTS `tbl_admin` (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_name` char(30) NOT NULL,
  `admin_email` char(30) NOT NULL,
  `admin_password` varchar(32) NOT NULL,
  PRIMARY KEY (`admin_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_admin`
--

INSERT INTO `tbl_admin` (`admin_id`, `admin_name`, `admin_email`, `admin_password`) VALUES
(1, 'admin', 'admin@gmail.com', '1234');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_category`
--

DROP TABLE IF EXISTS `tbl_category`;
CREATE TABLE IF NOT EXISTS `tbl_category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_category`
--

INSERT INTO `tbl_category` (`category_id`, `category_name`) VALUES
(1, 'House Work'),
(2, 'Road Contract'),
(3, 'Concreting'),
(4, 'Plumbing'),
(5, 'Electrical Wiring'),
(6, 'Roofing Work');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_chat`
--

DROP TABLE IF EXISTS `tbl_chat`;
CREATE TABLE IF NOT EXISTS `tbl_chat` (
  `chat_id` int(11) NOT NULL AUTO_INCREMENT,
  `chat_fromcon` int(11) NOT NULL DEFAULT '0',
  `chat_tocon` int(11) NOT NULL DEFAULT '0',
  `chat_fromclient` int(11) NOT NULL DEFAULT '0',
  `chat_toclient` int(11) NOT NULL DEFAULT '0',
  `chat_content` varchar(100) NOT NULL,
  `chat_date` varchar(100) NOT NULL,
  `chat_status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`chat_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_chat`
--

INSERT INTO `tbl_chat` (`chat_id`, `chat_fromcon`, `chat_tocon`, `chat_fromclient`, `chat_toclient`, `chat_content`, `chat_date`, `chat_status`) VALUES
(1, 1, 0, 0, 1, 'Hi Robert', 'May 02 2023, 09:03 PM', 1),
(2, 1, 0, 0, 1, 'I would like to take up your work', 'May 02 2023, 09:04 PM', 1),
(3, 1, 0, 0, 2, 'Hi', 'May 02 2023, 09:04 PM', 0),
(4, 0, 1, 1, 0, 'Hi', 'May 02 2023, 09:05 PM', 1),
(5, 0, 1, 1, 0, 'It is nice to hear', 'May 02 2023, 09:06 PM', 1),
(6, 0, 1, 1, 0, 'Let me go through your bio', 'May 02 2023, 09:06 PM', 1),
(7, 0, 2, 1, 0, 'Hi ', 'May 02 2023, 09:06 PM', 0),
(8, 0, 2, 1, 0, 'Robert here', 'May 02 2023, 09:07 PM', 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_client`
--

DROP TABLE IF EXISTS `tbl_client`;
CREATE TABLE IF NOT EXISTS `tbl_client` (
  `client_id` int(11) NOT NULL AUTO_INCREMENT,
  `client_name` char(30) NOT NULL,
  `client_email` varchar(50) NOT NULL,
  `client_address` text NOT NULL,
  `client_gender` varchar(10) NOT NULL,
  `client_contact` varchar(10) NOT NULL,
  `client_photo` varchar(30) DEFAULT NULL,
  `place_id` int(11) NOT NULL,
  `client_password` char(32) NOT NULL,
  PRIMARY KEY (`client_id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_client`
--

INSERT INTO `tbl_client` (`client_id`, `client_name`, `client_email`, `client_address`, `client_gender`, `client_contact`, `client_photo`, `place_id`, `client_password`) VALUES
(1, 'Robert', 'robert@gmail.com', 'Royal Villa,Thodupuzha', 'Male', '9074928095', 'Client_1827.png', 80, 'Robert'),
(2, 'Vimala', 'vimala@gmail.com', 'Vimala Bhavan, Kattappana Town', 'Female', '7894830211', 'Client_1838.png', 68, 'Vimala'),
(8, 'Rayan', 'rayan@gmail.com', 'Rayan Villa, Edappally', 'Male', '7890985563', 'Client_1046.png', 92, 'rayan'),
(7, 'Alphi', 'alphi@gmail.com', 'Azhakathu (H)', 'Male', '9855647839', 'Client_1461.png', 52, 'alphi'),
(9, 'Martin', 'martin@gmail.com', 'Martin Villa, Panavu', 'Male', '9087985678', 'Client_1285.png', 76, 'martin');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_complaint`
--

DROP TABLE IF EXISTS `tbl_complaint`;
CREATE TABLE IF NOT EXISTS `tbl_complaint` (
  `complaint_id` int(11) NOT NULL AUTO_INCREMENT,
  `complaint_title` text NOT NULL,
  `complaint_description` text NOT NULL,
  `complaint_status` int(11) NOT NULL DEFAULT '0',
  `complaint_date` date NOT NULL,
  `client_id` int(11) DEFAULT NULL,
  `contractor_id` int(11) DEFAULT NULL,
  `landlord_id` int(11) DEFAULT NULL,
  `complaint_reply` text,
  PRIMARY KEY (`complaint_id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_complaint`
--

INSERT INTO `tbl_complaint` (`complaint_id`, `complaint_title`, `complaint_description`, `complaint_status`, `complaint_date`, `client_id`, `contractor_id`, `landlord_id`, `complaint_reply`) VALUES
(1, 'On communication problem', 'Could have added chat facility to improve communication', 0, '2023-03-04', NULL, NULL, 1, NULL),
(2, 'hi', 'hsjsisismsnsjsjsndhjwnsnsn. Sjsjsnnsbsnsnsn', 0, '2023-04-19', NULL, 1, NULL, NULL),
(3, 'hi', 'jsjskskdkdkkd', 0, '2023-04-19', NULL, 1, NULL, NULL),
(4, 'dnndd', 'jjsjskskks', 0, '2023-04-22', NULL, 1, NULL, NULL),
(5, '', '', 0, '2023-04-22', NULL, 1, NULL, NULL),
(6, '', '', 0, '2023-04-22', NULL, 1, NULL, NULL),
(7, '', '', 0, '2023-04-22', NULL, 1, NULL, NULL),
(8, '', '', 0, '2023-04-22', NULL, 1, NULL, NULL),
(9, 'jejeiie', 'eieiei', 0, '2023-04-22', NULL, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_contractor`
--

DROP TABLE IF EXISTS `tbl_contractor`;
CREATE TABLE IF NOT EXISTS `tbl_contractor` (
  `contractor_id` int(11) NOT NULL AUTO_INCREMENT,
  `contractor_name` char(30) NOT NULL,
  `contractor_email` varchar(50) NOT NULL,
  `contractor_contact` varchar(10) NOT NULL,
  `contractor_address` text NOT NULL,
  `contractor_gender` char(10) NOT NULL,
  `contractor_photo` varchar(30) DEFAULT NULL,
  `contractor_proof` varchar(30) DEFAULT NULL,
  `place_id` int(11) NOT NULL,
  `contractor_password` varchar(32) NOT NULL,
  `contractor_doj` date NOT NULL,
  `contractor_status` int(11) DEFAULT '0',
  PRIMARY KEY (`contractor_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_contractor`
--

INSERT INTO `tbl_contractor` (`contractor_id`, `contractor_name`, `contractor_email`, `contractor_contact`, `contractor_address`, `contractor_gender`, `contractor_photo`, `contractor_proof`, `place_id`, `contractor_password`, `contractor_doj`, `contractor_status`) VALUES
(1, 'Snehal Biju', 'snehalbiju1@gmail.com', '9074928096', 'Chollankattil(H), Arakulam ', 'Male', 'Contractor_1532.png', 'Contractor_1639.png', 80, 'abcd', '2023-01-10', 1),
(2, 'Alan', 'alan@gmail.com', '9374928096', 'AS builders, Cheruthoni', 'Male', 'Contractor_1085.png', 'Contractor_1551.png', 66, 'abc', '2023-01-28', 1),
(3, 'Rajeev', 'rajeev@gmail.com', '9375028075', 'RAR Builders, Kattappana', 'Male', 'Contractor_1204.png', 'Contractor_1519.png', 68, 'abc', '2023-01-28', 1),
(4, 'Tom', 'tom@gmail.com', '8375028075', 'Tom builders,Thodupuzha', 'Male', 'Contractor_1477.png', 'Contractor_1839.png', 80, 'abc', '2023-01-28', 1),
(5, 'Daniel', 'daniel@gmail.com', '7502807542', 'Dream builders, Idukki', 'Male', 'Contractor_2034.png', 'Contractor_1466.png', 67, 'abc', '2023-01-28', 2),
(6, 'Rajeev', 'rajeev1@gmail.com', '8759407542', 'Connect Builders', 'Male', 'Contractor_2027.png', 'Contractor_2067.png', 84, 'abc', '2023-02-04', 0),
(7, 'Kevin', 'kevin@gmail.com', '9407542123', 'KRK Buliders', 'Male', 'Contractor_1436.png', 'Contractor_1135.png', 80, 'abc', '2023-02-04', 0),
(8, 'Ray', 'ray@gmail.com', '7542123222', 'Ray builders', 'Male', 'Contractor_2028.png', 'Contractor_1226.png', 85, 'abc', '2023-02-04', 0),
(9, 'Tom', 'tom1@gmail.com', '7542134234', 'tm builders', 'Male', 'Contractor_1327.png', 'Contractor_1151.png', 69, 'abc', '2023-02-04', 0),
(10, 'Thomas', 'thomas@gmail.com', '9746513057', 'tmo builders', 'Male', 'Contractor_1456.png', 'Contractor_1663.png', 92, 'abc', '2023-02-04', 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_district`
--

DROP TABLE IF EXISTS `tbl_district`;
CREATE TABLE IF NOT EXISTS `tbl_district` (
  `district_id` int(11) NOT NULL AUTO_INCREMENT,
  `district_name` varchar(50) NOT NULL,
  PRIMARY KEY (`district_id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_district`
--

INSERT INTO `tbl_district` (`district_id`, `district_name`) VALUES
(1, 'Thiruvananthapuram '),
(2, 'Kollam'),
(3, 'Pathanamthitta '),
(4, 'Alappuzha '),
(5, 'Kottayam '),
(6, 'Idukki '),
(7, 'Ernakulam'),
(8, 'Thrissur'),
(9, 'Palakkad '),
(10, 'Malappuram'),
(11, 'Wayanad '),
(12, 'Kozhikode'),
(13, 'Kannur'),
(14, 'Kasaragod ');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_feedback`
--

DROP TABLE IF EXISTS `tbl_feedback`;
CREATE TABLE IF NOT EXISTS `tbl_feedback` (
  `feedback_id` int(11) NOT NULL AUTO_INCREMENT,
  `feedback_content` varchar(100) NOT NULL,
  `client_id` int(11) NOT NULL,
  PRIMARY KEY (`feedback_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_feedback`
--

INSERT INTO `tbl_feedback` (`feedback_id`, `feedback_content`, `client_id`) VALUES
(4, 'Very nice website', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_landlord`
--

DROP TABLE IF EXISTS `tbl_landlord`;
CREATE TABLE IF NOT EXISTS `tbl_landlord` (
  `landlord_id` int(11) NOT NULL AUTO_INCREMENT,
  `landlord_name` char(30) NOT NULL,
  `landlord_email` varchar(50) NOT NULL,
  `landlord_contact` varchar(10) NOT NULL,
  `landlord_address` text NOT NULL,
  `landlord_gender` char(10) NOT NULL,
  `landlord_photo` varchar(30) DEFAULT NULL,
  `landlord_proof` varchar(30) DEFAULT NULL,
  `landlord_password` varchar(32) NOT NULL,
  `place_id` int(11) NOT NULL,
  `landlord_status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`landlord_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_landlord`
--

INSERT INTO `tbl_landlord` (`landlord_id`, `landlord_name`, `landlord_email`, `landlord_contact`, `landlord_address`, `landlord_gender`, `landlord_photo`, `landlord_proof`, `landlord_password`, `place_id`, `landlord_status`) VALUES
(1, 'Olivia', 'olivia@gmail.com', '9946478900', 'Mecheril(H)', 'Female', 'Landlord_1122.png', 'Landlord_1083.png', 'Olivia', 80, 1),
(2, 'Mercy', 'mercy@gmail.com', '9009946478', 'Tanikkal(H)', 'Female', 'Landlord_1077.png', 'Landlord_1844.png', 'Mercy', 80, 2),
(3, 'Emma', 'emma@gmail.com', '7890099464', 'Chollankattil(H)', 'Female', 'Landlord_1135.png', 'Landlord_1852.png', 'emma', 92, 1),
(4, 'Derik', 'derik@gmail.com', '9867599434', 'Vallomkunnel(H)', 'Male', 'Landlord_1561.png', 'Landlord_1804.png', 'derik', 92, 1),
(5, 'Tom', 'tom2@gmail.com', '7599434143', 'Veliyil(H)', 'Male', 'Landlord_1326.png', 'Landlord_1489.png', 'tom', 80, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_place`
--

DROP TABLE IF EXISTS `tbl_place`;
CREATE TABLE IF NOT EXISTS `tbl_place` (
  `place_id` int(11) NOT NULL AUTO_INCREMENT,
  `place_name` varchar(50) NOT NULL,
  `district_id` int(11) NOT NULL,
  PRIMARY KEY (`place_id`)
) ENGINE=MyISAM AUTO_INCREMENT=233 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_place`
--

INSERT INTO `tbl_place` (`place_id`, `place_name`, `district_id`) VALUES
(1, 'Alamcode', 1),
(2, 'Attingal', 1),
(3, 'Kaniyapuram', 1),
(4, 'Kattakada', 1),
(5, 'Kilimanoor', 1),
(6, 'Konchiravila', 1),
(7, 'Kurakkanni', 1),
(8, 'Nedumangad', 1),
(9, 'Thiruvananthapuram', 1),
(10, 'Varkala', 1),
(11, 'Adinad', 2),
(12, 'Ampalamkunnu', 2),
(13, 'Ayoor', 2),
(14, 'Chathannoor', 2),
(15, 'Kadakkal', 2),
(16, 'Karunagappalli', 2),
(17, 'Kottarakkara', 2),
(18, 'Kundara', 2),
(19, 'Mukhathala', 2),
(20, 'Mylakkadu', 2),
(21, 'Nilamel', 2),
(22, 'Oachira', 2),
(23, 'Paravur', 2),
(24, 'Perumpuzha', 2),
(25, 'Punalur', 2),
(26, 'Tangasseri', 2),
(27, 'Vallikavu', 2),
(28, 'Adoor', 3),
(29, 'Kadapra', 3),
(30, 'Konni', 3),
(31, 'Kozhencherry', 3),
(32, 'Mallapally', 3),
(33, 'Pandalam', 3),
(34, 'Ranni', 3),
(35, 'Thiruvalla', 3),
(36, 'Vennikulam', 3),
(37, 'Alappuzha', 4),
(38, 'Ambalappuzha', 4),
(39, 'Aroor', 4),
(40, 'Chengannur', 4),
(41, 'Cherthala', 4),
(42, 'Chettikulangara', 4),
(43, 'Haripad', 4),
(44, 'Kayamkulam', 4),
(45, 'Kokkamangalam', 4),
(46, 'Mannar', 4),
(47, 'Mavelikkara', 4),
(48, 'Muhamma', 4),
(49, 'Pallickal, Mavelikkara', 4),
(50, 'Thuravoor, Cherthala', 4),
(52, 'Changanassery', 5),
(53, 'Erattupetta', 5),
(54, 'Ettumanoor', 5),
(55, 'Kanjirappally', 5),
(56, 'Kottayam', 5),
(57, 'Manarcaud', 5),
(58, 'Pala', 5),
(59, 'Pampady', 5),
(60, 'Parathanam', 5),
(61, 'Ponkunnam', 5),
(62, 'Ramapuram', 5),
(63, 'Teekoy', 5),
(64, 'Vaikom', 5),
(65, 'Adimali', 6),
(66, 'Cheruthoni', 6),
(67, 'Idukki township', 6),
(68, 'Kattappana', 6),
(69, 'Kumily', 6),
(71, 'Marayur', 6),
(72, 'Munnar', 6),
(73, 'Murickassery', 6),
(74, 'Muthalakodam', 6),
(75, 'Nedumkandam', 6),
(76, 'Painavu', 6),
(77, 'Parathode', 6),
(78, 'Peermade', 6),
(79, 'Thekkady', 6),
(80, 'Thodupuzha', 6),
(81, 'Thopramkudy', 6),
(82, 'Udumbanchola', 6),
(83, 'Vandiperiyar', 6),
(84, 'Aluva', 7),
(85, 'Angamaly', 7),
(86, 'Arakkunnam', 7),
(87, 'Cheranallur', 7),
(88, 'Cheruvattoor', 7),
(89, 'Choornikkara', 7),
(90, 'Chowwara', 7),
(91, 'Edachira', 7),
(92, 'Edappally', 7),
(93, 'Edathala', 7),
(94, 'Ernakulam', 7),
(95, 'Irumpanam', 7),
(96, 'Kadungalloor', 7),
(97, 'Kakkanad', 7),
(98, 'Kalady', 7),
(99, 'Kalamassery', 7),
(100, 'Kochi', 7),
(101, 'Kolenchery', 7),
(102, 'Koonammavu', 7),
(103, 'Koothattukulam', 7),
(104, 'Kothamangalam', 7),
(105, 'Malayattoor', 7),
(106, 'Muvattupuzha', 7),
(107, 'Nedumbassery', 7),
(108, 'North Paravur', 7),
(109, 'Oorakkad', 7),
(110, 'Palliyangadi', 7),
(111, 'Payyal', 7),
(112, 'Perumbavoor', 7),
(113, 'Pezhakkappilly', 7),
(114, 'Piravom', 7),
(115, 'Pizhala', 7),
(116, 'Ponjassery', 7),
(117, 'Pukkattupadi', 7),
(118, 'Puliyanam', 7),
(119, 'Thiruvankulam', 7),
(120, 'Thrippunithura', 7),
(121, 'Varappuzha', 7),
(122, 'Vazhakulam', 7),
(123, 'Vyttila', 7),
(124, 'Akathiyoor', 8),
(125, 'Brahmakulam', 8),
(126, 'Chalakudy', 8),
(127, 'Chavakkad', 8),
(128, 'Chevoor', 8),
(129, ' Guruvayur', 8),
(130, 'Irinjalakuda', 8),
(131, 'Kanimangalam', 8),
(132, 'Kechery', 8),
(133, 'Kodakara', 8),
(134, 'Kodungallur', 8),
(135, 'Koratty', 8),
(136, 'Kottapuram', 8),
(137, 'Kunnamkulam', 8),
(138, 'Kuthiran', 8),
(139, 'Mala', 8),
(140, 'Manaloor', 8),
(141, 'Palakkal', 8),
(142, 'Palayur', 8),
(143, 'Pavaratty', 8),
(144, 'Perambra', 8),
(145, 'Puthukkad', 8),
(146, 'Thaikkad', 8),
(147, 'Thalapilly', 8),
(148, 'Thalore', 8),
(149, 'Thrissur', 8),
(150, 'Triprayar', 8),
(151, 'Vadakkumkara ', 8),
(152, 'Vallachira', 8),
(153, 'Wadakkancherry', 8),
(154, 'Chandranagar', 9),
(155, 'Chittur-Thathamangalam', 9),
(156, 'Kumbidi', 9),
(157, 'Manissery', 9),
(158, 'Mankurussi', 9),
(159, 'Mannarkkad', 9),
(160, 'Olavakkode', 9),
(161, 'Palakkad', 9),
(162, 'Pattambi', 9),
(163, ' Shoranur', 9),
(164, 'Vadakkencherry', 9),
(165, 'Vaniyamkulam', 9),
(166, 'Walayar', 9),
(167, 'Alamkod, Edappal', 10),
(168, 'Areekode', 10),
(169, 'Chemmad', 10),
(170, 'Chungathara', 10),
(171, 'Edakkara', 10),
(172, ' Kakkad, Malappuram', 10),
(173, 'Kalady, Malappuram', 10),
(174, 'Karipur', 10),
(175, 'Kondotty', 10),
(176, 'Kottakkal', 10),
(177, 'Malappuram', 10),
(178, 'Mampad', 9),
(179, 'Manjeri', 10),
(180, 'Nediyiruppu', 10),
(181, 'Parappanangadi', 10),
(182, 'Pattikkad', 10),
(183, 'Perinthalmanna', 10),
(184, 'Ponnani', 10),
(185, 'Tanur', 10),
(186, 'Tennala', 10),
(187, 'Thalakkad', 10),
(188, 'Thalappara', 10),
(189, 'Tirur', 10),
(190, 'Valanchery', 10),
(191, 'Vaniyambalam', 10),
(192, 'Vazhayur', 10),
(193, 'Vengara', 10),
(194, 'Kalpetta', 11),
(195, 'Kayakkunn', 11),
(196, 'Mananthavady', 11),
(197, 'Meenangadi', 11),
(198, 'Panamaram', 11),
(199, 'Pulpally', 11),
(200, 'Sultan Bathery', 11),
(201, 'Balussery', 12),
(202, 'Kinassery', 12),
(203, 'Koduvally', 12),
(204, 'Koyilandy', 12),
(205, 'Kunnamangalam', 12),
(206, 'Perambra', 12),
(207, 'Ramanattukara', 12),
(208, 'Thamarassery', 12),
(209, 'Thiruvambady', 12),
(210, 'Alakode', 13),
(211, 'Cherupuzha ', 13),
(212, 'Irikkur', 13),
(213, 'Iritty', 13),
(214, 'Kadannappalli', 13),
(215, 'Kannapuram', 13),
(216, 'Kannur', 13),
(217, 'Pappinisseri', 13),
(218, 'Pariyaram', 13),
(219, 'Payyanur', 13),
(220, 'Pinarayi', 13),
(221, 'Sreekandapuram', 13),
(222, 'Thalassery', 13),
(223, ' Bangramanjeshwar', 14),
(224, 'Cherkala', 14),
(225, 'Cheruvathur', 14),
(226, 'Hosabettu', 14),
(227, 'Kanhangad', 14),
(228, 'Kasaragod', 14),
(229, 'Manjeshwar', 14),
(230, 'Nileshwaram', 14),
(231, 'Puthur', 14),
(232, 'Uppala', 14);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_plot`
--

DROP TABLE IF EXISTS `tbl_plot`;
CREATE TABLE IF NOT EXISTS `tbl_plot` (
  `plot_id` int(11) NOT NULL AUTO_INCREMENT,
  `landlord_id` int(11) NOT NULL,
  `plot_details` text NOT NULL,
  `plot_landmark` varchar(50) NOT NULL,
  `place_id` int(11) NOT NULL,
  `advance_amount` int(11) NOT NULL,
  `plot_status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`plot_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_plot`
--

INSERT INTO `tbl_plot` (`plot_id`, `landlord_id`, `plot_details`, `plot_landmark`, `place_id`, `advance_amount`, `plot_status`) VALUES
(1, 1, '2 acres land', 'Near St. Marys Church', 80, 450000, 1),
(2, 1, '20 cent with house', 'Near St. Marys Church', 80, 30000, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_plotbooking`
--

DROP TABLE IF EXISTS `tbl_plotbooking`;
CREATE TABLE IF NOT EXISTS `tbl_plotbooking` (
  `booking_id` int(11) NOT NULL AUTO_INCREMENT,
  `plot_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `payment_status` int(11) NOT NULL DEFAULT '0',
  `booking_date` date NOT NULL,
  PRIMARY KEY (`booking_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_plotbooking`
--

INSERT INTO `tbl_plotbooking` (`booking_id`, `plot_id`, `client_id`, `payment_status`, `booking_date`) VALUES
(1, 1, 2, 0, '2023-03-04'),
(2, 1, 1, 0, '2023-03-04');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_work`
--

DROP TABLE IF EXISTS `tbl_work`;
CREATE TABLE IF NOT EXISTS `tbl_work` (
  `work_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `work_details` text NOT NULL,
  `client_id` int(11) NOT NULL,
  `work_status` int(11) NOT NULL DEFAULT '0',
  `work_date` date NOT NULL,
  `place_id` int(11) NOT NULL,
  `work_photo` varchar(50) NOT NULL,
  PRIMARY KEY (`work_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_work`
--

INSERT INTO `tbl_work` (`work_id`, `category_id`, `work_details`, `client_id`, `work_status`, `work_date`, `place_id`, `work_photo`) VALUES
(1, 1, 'Near bus stand\r\nExpected Amount: 70000 ', 1, 2, '2023-07-31', 80, 'Work_1238.jpg'),
(2, 3, 'Near Railway Station\r\nExpected Amount: 300000', 1, 0, '2023-05-31', 84, 'Work_1144.jpg'),
(3, 5, 'Near Town\r\nExpected Amount: 15000', 2, 1, '2023-03-31', 68, 'Work_2079.png'),
(4, 4, 'Near Church\r\n30000', 8, 0, '2023-05-31', 92, 'Work_1968.PNG'),
(5, 6, 'Near Church\r\n100000', 8, 0, '2023-06-15', 92, 'Work_1124.jpg'),
(6, 6, 'Near bus stand\r\n50000', 7, 0, '2023-05-31', 52, 'Work_1471.jpg'),
(7, 3, 'Near government school\r\n250000', 9, 0, '2023-07-01', 76, 'Work_1714.jpg'),
(8, 1, 'near church\r\n500000', 1, 0, '2023-09-03', 80, 'Work_1460.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_workrequest`
--

DROP TABLE IF EXISTS `tbl_workrequest`;
CREATE TABLE IF NOT EXISTS `tbl_workrequest` (
  `request_id` int(11) NOT NULL AUTO_INCREMENT,
  `request_details` text NOT NULL,
  `work_id` int(11) NOT NULL,
  `contractor_id` int(11) NOT NULL,
  `request_status` int(11) NOT NULL DEFAULT '0',
  `request_date` date NOT NULL,
  PRIMARY KEY (`request_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_workrequest`
--

INSERT INTO `tbl_workrequest` (`request_id`, `request_details`, `work_id`, `contractor_id`, `request_status`, `request_date`) VALUES
(7, 'nxnxmkxk', 1, 1, 0, '2023-04-21'),
(2, 'Time: 1 month\r\nAmount: 14000', 3, 2, 0, '2023-04-04'),
(3, 'Time: 4 months\r\nAmount : 650000', 1, 2, 0, '2023-07-31'),
(4, 'Time: 2 months and 15 days\r\nAmount : 600000', 1, 3, 0, '2023-05-18'),
(5, '1 month\r\n', 3, 1, 0, '2023-05-16');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
