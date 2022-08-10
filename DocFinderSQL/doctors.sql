-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 10, 2022 at 01:55 AM
-- Server version: 10.5.16-MariaDB
-- PHP Version: 7.3.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `id19318024_docfinder`
--

-- --------------------------------------------------------

--
-- Table structure for table `doctors`
--

CREATE TABLE `doctors` (
  `id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `state` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `pincode` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `speciality` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `CPSO` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `doctors`
--

INSERT INTO `doctors` (`id`, `name`, `address`, `city`, `state`, `pincode`, `phone`, `speciality`, `latitude`, `longitude`, `CPSO`) VALUES
(101, 'Adams, Colin James', '302-435 The Boardwalk Medical Centre 2', 'Waterloo', 'ON', 'N2T 0C2', '519-741-5252', 'Internal Medicine,Respirology', 43.43992, -80.56613, 105944),
(102, 'Alangh, Avreet', 'Suite 208 - 430 The Boardwalk', 'Waterloo', 'ON', 'N2T 0C1', '519-742-0107', 'Family Medicine', 43.440283, -80.56527, 98491),
(103, 'Alarakhia, Mohamed', 'Suite 4111 250 Laurelwood Drive', 'Waterloo', 'ON', 'N2J 0E2', '519-904-0656', 'Family Medicine', 43.476679, -80.57079, 88754),
(104, 'Alexander, John Peter', 'TLC Laser Eye Centers 200 Columbia Street', 'Waterloo', 'ON', 'N2L 3G1', '519-888-4502', 'Anesthesiology', 43.451565, -80.587971, 24347),
(105, 'Ali, Sammy Hatem', 'Suite 206 430 The Boardwalk', 'Waterloo', 'ON', 'N2T 0C1', '519-741-5252', 'Cardiology,Internal Medicine', 43.440283, -80.56527, 88487),
(106, 'Almanfud, Abdullah A A', 'Suite 206 430 The Boardwalk', 'Waterloo', 'ON', 'N2T 0C1', '519-741-5252', 'Cardiology,Internal Medicine', 43.440283, -80.56527, 94725),
(107, 'Amin, Surendra', '200 University Avenue West', 'Waterloo', 'ON', 'N2L 3G1', '519-888-4567', 'Family Medicine', 43.468276, -80.542949, 92430),
(108, 'Andrus, Catherine Lynn', '200-435 The Boardwalk', 'Waterloo', 'ON', 'N2T 0C2', '519-571-0822', 'Obstetrics,Gynecology', 43.43992, -80.56613, 88324),
(109, 'Appavoo, Siva', 'Suite 202 445Beechwood Place', 'Waterloo', 'ON', 'N2T 1Z2', '519-880-9878', 'Psychiatry', 43.451647, -80.556849, 75901),
(110, 'Astawan, Leanne', '155 Frobisher Dr Suite H-111', 'Waterloo', 'ON', 'N2V 2E1', '519-578-4230', 'Family Medicine', 43.506212, -80.526833, 80212),
(111, 'Azadeh, Manizheh', 'Suite 304 430 The Boardwalk', 'Waterloo', 'ON', 'N2T 0C1', '519-578-3500', 'Family Medicine', 43.440283, -80.56527, 118476),
(112, 'Baath, Kulrajbir Singh', '207-435 The Boardwalk', 'Waterloo', 'ON', 'N2T 0C2', '519-744-1167', 'Gastroenterology,Internal Medicine', 43.43992, -80.56613, 84506),
(113, 'Baath, Sahebjot Kaur', '430 The Boardwalk Suite 408', 'Waterloo', 'ON', 'N2T 0C1', '519-744-2592', 'Family Medicine', 43.440283, -80.56527, 98834),
(114, 'Babapulle, Mohan Niranjan', 'Suite 206 430 The Boardwalk', 'Waterloo', 'ON', 'N2T 0C1', '519-741-5252', 'Cardiology,Internal Medicine', 43.440283, -80.56527, 81963),
(115, 'Bahadur, Randy', 'Suite 201 245 The Boardwalk', 'Waterloo', 'ON', 'N2T 0A6', '226-336-8961', 'Family Medicine', 43.436588, -80.562265, 91320),
(116, 'Bajaj, Renu', '543 Paradise Cresent', 'Waterloo', 'ON', 'N2T 2N7', '519-578-6099', 'Family Medicine', 43.454377, -80.567683, 58331),
(117, 'Banerjee, Avik Upadhyay', 'Unit 310 55 Erb St. East', 'Waterloo', 'ON', 'N2J 4K8', '519-896-0949', 'Otolaryngology,Head,Neck Surgery', 43.46566, -80.519052, 75011),
(118, 'Barnes, Matthew Joseph', '435 The Boardwalk Suite 408', 'Waterloo', 'ON', 'N2T 0C2', '519-571-8181', 'Family Medicine', 43.43992, -80.56613, 110227),
(119, 'Bedrosian, Kathleen Elizabeth', 'Suite 305 430 The Boardwalk', 'Waterloo', 'ON', 'N2T 0C1', '519-745-3117', 'Family Medicine', 43.440283, -80.56527, 59984),
(120, 'Beilhartz, Natallia Louella', 'Suite 4111 250 Laurelwood Drive', 'Waterloo', 'ON', 'N2H 0E2', '519-904-0656', 'Family Medicine', 43.476679, -80.57079, 95942),
(121, 'Bell, Ruth Elizabeth', 'Suite 408 430 The Boardwalk', 'Waterloo', 'ON', 'N2T 0C1', '519-744-2592', 'Family Medicine', 43.440283, -80.56527, 28768),
(122, 'Benedet, Lynda Louise', 'University of Waterloo Health Services 200 University Avenue West', 'Waterloo', 'ON', 'N2L 3G1', '519-888-4096', 'Family Medicine', 43.470945, -80.538, 82028),
(123, 'Bentley-Taylor, Michael Martin', '206 Mohawk Avenue', 'Waterloo', 'ON', 'N2L 2T3', '226-989-6771', 'Cardiology,Internal Medicine', 43.464364, -80.550466, 23790),
(124, 'Blackmore, Charlotte Megan', '435 The Boardwalk Suite 408', 'Waterloo', 'ON', 'N2T 0C2', '519-571-8181', 'Family Medicine', 43.43992, -80.56613, 110000),
(125, 'Bruce, Rodney Robert', 'Suite 102 520 University Avenue West', 'Waterloo', 'ON', 'N2T 2Z6', '519-576-4910', 'Family Medicine', 43.437862, -80.560033, 77112),
(126, 'Bubtana, Sumaya', '408-430 The Boardwalk', 'Waterloo', 'ON', 'N2T 0C1', '519-744-2592', 'Family Medicine', 43.440283, -80.56527, 136442),
(127, 'Burk, Keith William', 'Suite 7 420 Erb Street West', 'Waterloo', 'ON', 'N2L 6H6', '519-884-6707', 'Family Medicine', 43.453141, -80.553212, 59054),
(128, 'Burkett, Andrew Michael', 'Cardio Pulmonary Services 430 The Boardwalk Suite 210', 'Waterloo', 'ON', 'N2T 0C1', '519-741-5252', 'Internal Medicine,Respirology', 43.440283, -80.56527, 91873),
(129, 'Campanaro, Judith Margaret', '435 The Boardwalk Suite 508', 'Waterloo', 'ON', 'N2T 0C2', '519-570-0090', 'Obstetrics,Gynecology', 43.43992, -80.56613, 59560),
(130, 'Carleton, Susan Andrea', '127 Park Street Waterloo ON N2L 1Y4', 'Waterloo', 'ON', 'N2L 1Y4', '519-743-1451', 'Neurology', 43.459029, -80.52156, 25100),
(131, 'Chand, Pankaj Pappu', 'Waterloo Town Square 75 King Street South', 'Waterloo', 'ON', 'N2J 4V1', '800-785-1519', 'Family Medicine', 43.463607, -80.521935, 65048),
(132, 'Chettimada, Anil Kumar Somanna', 'Unit 7 570 University Avenue East', 'Waterloo', 'ON', 'N2K 4P2', '519-743-2951', 'Family Medicine', 43.495281, -80.490691, 77354),
(133, 'Coyne, Jade Brittany Rita', '435 The Boardwalk, Medical Center 2 Cardiopulmonary Services Suite 302', 'Waterloo', 'ON', 'N2T 0C2', '519-741-5252', 'Internal Medicine,Respirology', 43.43992, -80.56613, 95466),
(134, 'Cushnie, Duncan Wells', '153 Union St E', 'Waterloo', 'ON', 'N2J 1C4', '519-603-0989', 'Orthopedic', 43.463363, -80.507894, 98139),
(135, 'Cy, Ajith', '135 Union Street East', 'Waterloo', 'ON', 'N2J 1C4', '519-579-8996', 'Dermatology', 43.463446, -80.509175, 89297),
(136, 'Dai, Tianyang', '100 Solstice Way Waterloo', 'Waterloo', 'ON', 'N2K 0G3', '519-578-9757', 'Family Medicine', 43.516186, -80.506968, 116172),
(137, 'Davies, Anthony Ayebakro', '38 Bridgeport Rd E', 'Waterloo', 'ON', 'N2J 2J5', '519-742-2046', 'Family Medicine', 43.468259, -80.520748, 101524),
(138, 'Dawood, Mahomed Farouk', 'Suite 902 570 University Avenue East', 'Waterloo', 'ON', 'N2K 4P2', '519-570-1280', 'Family Medicine', 43.495281, -80.490691, 74142),
(139, 'Dawood, Mahomed Rayhaan', '570 University Ave E Unit 2', 'Waterloo', 'ON', 'N2K 4P2', '519-746-4344', 'Family Medicine', 43.495281, -80.490691, 107027),
(140, 'Delaney, Keri', '435 The Boardwalk Unit 408', 'Waterloo', 'ON', 'N2T 0C2', '519-571-8181', 'Family Medicine', 43.43992, -80.56613, 108833),
(141, 'Desai, Dushyant Kapilray', 'Medical Centre Suite 206 430 The Boardwalk', 'Waterloo', 'ON', 'N2T 0C1', '519-741-5252', 'Cardiology,Internal Medicine', 43.440283, -80.56527, 90264),
(142, 'Dhillon, Sandeep S', '435 The Boardwalk Suite 208', 'Waterloo', 'ON', 'N2T 0C2', '519-804-9585', 'Internal Medicine,Rheumatology', 43.43992, -80.56613, 109452),
(143, 'Dixon, Corinne Evelyn', 'Suite 306 430 The Boardwalk', 'Waterloo', 'ON', 'N2T 0C1', '519-743-1011', 'Family Medicine', 43.440283, -80.56527, 56751),
(144, 'Duke, Marin Jonina', 'Suite 12 65 University Ave East', 'Waterloo', 'ON', 'N2J 2V9', '519-746-2220', 'Family Medicine', 43.476917, -80.520886, 77278),
(145, 'Dundon, John Charles', '200 University Ave W Health Services University of Waterloo', 'Waterloo', 'ON', 'N2L 3G1', '519-888-4096', 'Family Medicine', 43.472916, -80.543005, 73295),
(146, 'El Boreky, Fadia Refaat Ramzy', '149 Union Street East', 'Waterloo', 'ON', 'N2J 1C4', '519-569-8500', 'Family Medicine', 43.463445, -80.508496, 90022),
(147, 'El Shatshat, Mohamed A', 'Waterloo Walk in 13-170 University Avenue West', 'Waterloo', 'ON', 'N2L 3E9', '519-725-1514', 'Family Medicine', 43.443945, -80.545223, 99825),
(148, 'Elmaraghy, Mohamed Waguih', 'Suite 100 135 Erb Street East', 'Waterloo', 'ON', 'N2J 1M3', '519-585-0859', 'Plastic Surgery', 43.466864, -80.514561, 66461),
(149, 'Emini, Neim Nick', '170 University Ave. West Unit 13', 'Waterloo', 'ON', 'N2L 3E9', '519-725-1514', 'Family Medicine', 43.472713, -80.537787, 92181),
(150, 'English, Penny Gabrielle', '435 The Boardwalk Suite 203', 'Waterloo', 'ON', 'N2T 0C2', '226-243-2043', 'Family Medicine', 43.43992, -80.56613, 91502),
(151, 'Ergaiey, Houda Ali', '207-435 The Boardwalk', 'Waterloo', 'ON', 'N2T 0C2', '519-745-9889', 'Gastroenterology,Internal Medicine', 43.43992, -80.56613, 74124),
(152, 'Fikry, Sameh Adly', '149 Union St E', 'Waterloo', 'ON', 'N2J 1C4', '519-569-8500', 'Family Medicine', 43.463445, -80.508496, 92534),
(153, 'Frank, Sheldon Michael', 'Suite 6 420 Erb Street West', 'Waterloo', 'ON', 'N2L 6H6', '519-579-5850', 'Obstetrics,Gynecology', 43.453141, -80.553212, 22738),
(154, 'Fuss, Carolyn Lee', 'Suite 404 435 The Boardwalk', 'Waterloo', 'ON', 'N2T 0C2', '226-476-3178', 'Family Medicine', 43.43992, -80.56613, 86770),
(155, 'Gajewski, Martin', '520 University Avenue West Unit 203', 'Waterloo', 'ON', 'N2T 2Z6', '519-743-3641', 'Family Medicine', 43.437862, -80.560033, 71320),
(156, 'Gandhi, Mandark Sudhirkumar', 'Suite 207 435 The Boardwalk', 'Waterloo', 'ON', 'N2T 0C1', '519-744-1167', 'Gastroenterology,Internal Medicine', 43.43992, -80.56613, 103362),
(157, 'Gill, Vikram Singh', '408-430 The Boardwalk', 'Waterloo', 'ON', 'N2T 0C1', '519-744-2592', 'Family Medicine', 43.440283, -80.56527, 103596),
(158, 'Grant, David Ross', 'Suite 201 520 University Avenue West', 'Waterloo', 'ON', 'N2T 2Z6', '519-744-7200', 'Family Medicine', 43.437862, -80.560033, 32801),
(159, 'Guy, Brent Steven', '435 The Boardwalk Suite 304', 'Waterloo', 'ON', 'N2T 0C2', '519-741-5252', 'Internal Medicine,Respirology', 43.43992, -80.56613, 103451),
(160, 'Guzar, Rebecca Lynne', 'Suite 204 430 The Boardwalk', 'Waterloo', 'ON', 'N2T 0C1', '519-576-2992', 'Family Medicine', 43.440283, -80.56527, 74677),
(161, 'Habib, Hasan Arsalan', 'Suite 302 430 The Boardwalk', 'Waterloo', 'ON', 'N2T 0C1', '519-578-8050', 'Family Medicine', 43.440283, -80.56527, 107674),
(162, 'Haddad, Dimitri Elias', 'The Armoury Sports Medicine Centre 245 The Boardwalk', 'Waterloo', 'ON', 'N2J 3Z4', '226-336-8961', 'Orthopedic Surgery', 43.436588, -80.562265, 76302),
(163, 'Hahn, Ernest Michael', 'Medical Centre Suite 307 430 The Boardwalk', 'Waterloo', 'ON', 'N2T 0C1', '519-893-5568', 'Family Medicine', 43.440283, -80.56527, 50661),
(164, 'Harlick, Claire Marjorie', '100 Solstice Way', 'Waterloo', 'ON', 'N2K 0G3', '519-578-9757', 'Family Medicine', 43.516186, -80.506968, 100360),
(165, 'Heath, David Stanley', '3-139 Father David Bauer Dr', 'Waterloo', 'ON', 'N2L 6L1', '519-497-0959', 'Psychiatry', 43.462501, -80.536525, 24795),
(166, 'Heckman, George Albert Winston', 'Research Institute for Aging 250 Laurelwood Drive', 'Waterloo', 'ON', 'N2J 0E2', '519-904-0660', 'Geriatric Medicine,Internal Medicine', 43.476679, -80.57079, 69138),
(167, 'Hentschel, Eric Philip', '201-50 Westmount Rd N', 'Waterloo', 'ON', 'N2L 2R5', '519-570-0062', 'Internal Medicine,Respirology', 43.46136, -80.537083, 52851),
(168, 'Hickman, Donald Norman', '596 Wingrove Court', 'Waterloo', 'ON', 'N2T 2C2', '519-501-4293', 'Family Medicine', 43.460286, -80.571231, 31336),
(169, 'Hladio, Manisha', '435 The Boardwalk', 'Waterloo', 'ON', 'N2T 0C2', '226-243-2043', 'Family Medicine', 43.43992, -80.56613, 105875),
(170, 'Husein, Nadira', 'Suite 201 99 Northfield Drive East', 'Waterloo', 'ON', 'N2K 3P9', '519-585-7527', 'Endocrinology,Metabolism,Internal Medicine', 43.50456, -80.525819, 66395),
(171, 'Ip, Kenneth Ka Chi', '250 Laurelwood Dr Suite 4111', 'Waterloo', 'ON', 'N2J 0E2', '519-904-0656', 'Family Medicine', 43.476679, -80.57079, 140450),
(172, 'Jackson, Mary Elizabeth', 'Suite 206 430 The Boardwalk', 'Waterloo', 'ON', 'N2T 0C1', '519-741-8660', 'Internal Medicine,Respirology', 43.440283, -80.56527, 51383),
(173, 'Jeyasingham, Gabriel Kiruban Luther', '208-435 The Boardwalk', 'Waterloo', 'ON', 'N2T 0C2', '519-279-4047', 'Internal Medicine,Rheumatology', 43.43992, -80.56613, 113151),
(174, 'Jhaveri, Faeza', 'Suite 902 570 University Avenue East', 'Waterloo', 'ON', 'N2K 4P2', '519-570-1280', 'Family Medicine', 43.495281, -80.490691, 74132),
(175, 'Johnston, Calvin Frederick', '106-318 Spruce St', 'Waterloo', 'ON', 'N2L 0E9', '519-725-1111', 'Family Medicine', 43.47876, -80.526762, 101188);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `doctors`
--
ALTER TABLE `doctors`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `doctors`
--
ALTER TABLE `doctors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=176;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
