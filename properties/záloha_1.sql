-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Počítač: 127.0.0.1
-- Vytvořeno: Pát 19. srp 2022, 13:36
-- Verze serveru: 10.4.24-MariaDB
-- Verze PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databáze: `moravec_urdb`
--

-- --------------------------------------------------------

--
-- Struktura tabulky `addresses`
--

CREATE TABLE `addresses` (
  `id` int(10) UNSIGNED NOT NULL,
  `street` varchar(45) NOT NULL,
  `house_number` int(11) NOT NULL,
  `post_code` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Vypisuji data pro tabulku `addresses`
--

INSERT INTO `addresses` (`id`, `street`, `house_number`, `post_code`) VALUES
(1, 'Mostecká', 101, '43401'),
(2, 'Židovická', 55, '43401'),
(3, 'Mariánská', 1234, '40747'),
(4, 'Maxima Gorkého', 581, '43401'),
(5, 'Dukelská', 58, '40563'),
(6, 'Topolová', 45, '43401'),
(7, 'Topolová', 48, '43401'),
(8, 'Drážďanská', 1, '40007'),
(9, 'Ústecká', 5, '40007'),
(10, 'Bradavická', 455, '42508'),
(11, 'Hagridova', 13, '36606'),
(12, 'Gandalfova', 695, '54013'),
(13, 'Lhotova', 88, '54103'),
(14, 'Harryho ', 66, '11101'),
(15, 'U Lucifera', 666, '66666'),
(16, 'Velká Čína', 99, '89523'),
(17, 'Malá Čína', 77, '45287'),
(18, 'Dlouhá', 999, '78452'),
(19, 'Dukelská', 45, '69543'),
(20, 'Bradavická', 455, '18754'),
(21, 'Mostecká', 102, '43401'),
(22, 'Maxima Gorkého', 485, '43401'),
(23, 'Topolová', 685, '43401'),
(24, 'Dukelská', 99, '40007');

-- --------------------------------------------------------

--
-- Struktura tabulky `contracts`
--

CREATE TABLE `contracts` (
  `id` int(10) UNSIGNED NOT NULL,
  `start` datetime NOT NULL,
  `end` datetime DEFAULT NULL,
  `properties_id` int(10) UNSIGNED NOT NULL,
  `types_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Vypisuji data pro tabulku `contracts`
--

INSERT INTO `contracts` (`id`, `start`, `end`, `properties_id`, `types_id`) VALUES
(1, '2022-08-18 12:02:08', NULL, 1, 2),
(2, '2020-08-18 12:03:34', NULL, 2, 1),
(3, '2019-08-18 12:03:56', NULL, 3, 1),
(4, '2018-08-18 12:04:22', NULL, 4, 2),
(5, '2022-04-20 12:07:34', NULL, 5, 1),
(6, '1900-08-18 12:22:21', NULL, 6, 2),
(7, '1922-08-18 15:34:18', NULL, 7, 2),
(8, '1985-08-18 12:48:56', NULL, 9, 2),
(9, '2022-08-18 12:55:03', '2022-08-31 12:55:04', 12, 1),
(10, '2022-08-18 12:55:24', '2022-08-30 12:55:24', 14, 1),
(11, '2022-08-18 12:56:35', NULL, 16, 2),
(12, '2022-08-18 12:57:08', NULL, 17, 1),
(13, '2022-08-18 12:57:16', NULL, 18, 2),
(14, '2022-08-18 13:02:14', NULL, 18, 1),
(15, '2022-08-18 13:02:21', NULL, 19, 2),
(16, '2022-08-18 13:02:28', NULL, 20, 1),
(17, '2022-08-18 13:02:37', NULL, 21, 1),
(18, '2022-08-18 13:02:43', NULL, 22, 2),
(19, '2022-08-18 13:02:49', NULL, 23, 2),
(20, '2022-08-18 13:02:54', NULL, 23, 2),
(21, '2022-08-18 13:03:01', NULL, 24, 2);

-- --------------------------------------------------------

--
-- Zástupná struktura pro pohled `jmena_osob`
-- (Vlastní pohled viz níže)
--
CREATE TABLE `jmena_osob` (
`Celá jména` varchar(46)
);

-- --------------------------------------------------------

--
-- Struktura tabulky `properties`
--

CREATE TABLE `properties` (
  `id` int(10) UNSIGNED NOT NULL,
  `price` decimal(20,2) NOT NULL,
  `addresses_id` int(10) UNSIGNED NOT NULL,
  `types_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Vypisuji data pro tabulku `properties`
--

INSERT INTO `properties` (`id`, `price`, `addresses_id`, `types_id`) VALUES
(1, '45000000.00', 20, 5),
(2, '65000000.00', 10, 6),
(3, '7650000.00', 18, 3),
(4, '32500000.00', 8, 4),
(5, '200000.00', 24, 9),
(6, '450000.00', 19, 8),
(7, '1350000.00', 5, 7),
(8, '55550000.00', 12, 6),
(9, '97350500.00', 11, 5),
(10, '144565000.00', 14, 6),
(11, '78650000.00', 13, 6),
(12, '85000.00', 17, 9),
(13, '9800000.00', 3, 4),
(14, '985000.00', 4, 7),
(15, '367000.00', 22, 8),
(16, '6350450.00', 21, 3),
(17, '1250000.00', 1, 3),
(18, '600500.00', 6, 7),
(19, '1890000.00', 7, 7),
(20, '2650000.00', 23, 7),
(21, '9990990.00', 15, 5),
(22, '3600000.00', 16, 3),
(23, '450000.00', 9, 9),
(24, '1565000.00', 2, 7);

-- --------------------------------------------------------

--
-- Struktura tabulky `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `role` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Vypisuji data pro tabulku `roles`
--

INSERT INTO `roles` (`id`, `role`) VALUES
(1, 'majitel'),
(2, 'správce'),
(3, 'nájemník');

-- --------------------------------------------------------

--
-- Struktura tabulky `types`
--

CREATE TABLE `types` (
  `id` int(10) UNSIGNED NOT NULL,
  `note` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Vypisuji data pro tabulku `types`
--

INSERT INTO `types` (`id`, `note`) VALUES
(1, 'na dobu určitou'),
(2, 'na dobu neurčitou'),
(3, 'dům'),
(4, 'vila'),
(5, 'hrad'),
(6, 'zámek'),
(7, 'byt'),
(8, 'garsonka'),
(9, 'garáž');

-- --------------------------------------------------------

--
-- Struktura tabulky `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(25) NOT NULL,
  `addresses_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Vypisuji data pro tabulku `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `addresses_id`) VALUES
(1, 'Jakub', 'Moravec', 4),
(2, 'Josef', 'Tyl', 20),
(3, 'Harry', 'Potter', 20),
(4, 'Tom', 'Riddle', 20),
(5, 'Jiří', 'Fišer', 12),
(6, 'Jan', 'Jelínek', 18),
(7, 'Petr', 'Rychlý', 8),
(8, 'Filip', 'Moravec', 16),
(9, 'Eliška', 'Krásnohorská', 13),
(10, 'Markéta', 'Sedmizrná', 2),
(11, 'Martin', 'Krásný', 9),
(12, 'Tomáš', 'Slabozraký', 10),
(13, 'Ondřej', 'Pomalý', 19),
(14, 'Martin', 'Malý', 11),
(15, 'Jakub', 'Černohorský', 15),
(16, 'Filip', 'Trestanec', 16),
(17, 'Magdaléna', 'Jelenová', 22),
(18, 'Ladislav', 'Polívka', 3),
(19, 'Tomáš', 'Hluchý', 7),
(20, 'Karolína', 'Plíšková', 21);

-- --------------------------------------------------------

--
-- Struktura tabulky `users_has_contracts`
--

CREATE TABLE `users_has_contracts` (
  `users_id` int(10) UNSIGNED NOT NULL,
  `contracts_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Vypisuji data pro tabulku `users_has_contracts`
--

INSERT INTO `users_has_contracts` (`users_id`, `contracts_id`) VALUES
(1, 5),
(1, 11),
(2, 9),
(3, 4),
(5, 8),
(6, 7),
(7, 21),
(8, 3),
(9, 1),
(10, 10),
(10, 13),
(11, 14),
(13, 16),
(13, 21),
(14, 15),
(15, 6),
(16, 2),
(17, 12),
(18, 11),
(19, 19),
(20, 10);

-- --------------------------------------------------------

--
-- Struktura tabulky `users_has_roles`
--

CREATE TABLE `users_has_roles` (
  `users_id` int(10) UNSIGNED NOT NULL,
  `roles_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Vypisuji data pro tabulku `users_has_roles`
--

INSERT INTO `users_has_roles` (`users_id`, `roles_id`) VALUES
(2, 3),
(3, 1),
(4, 3),
(5, 1),
(6, 1),
(6, 2),
(7, 2),
(8, 3),
(9, 1),
(9, 2),
(10, 1),
(11, 2),
(11, 3),
(12, 3),
(14, 2),
(14, 3),
(15, 2),
(16, 3),
(18, 1),
(19, 2),
(19, 3),
(20, 2),
(20, 3);

-- --------------------------------------------------------

--
-- Struktura pro pohled `jmena_osob`
--
DROP TABLE IF EXISTS `jmena_osob`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `jmena_osob`  AS SELECT concat_ws(' ',`users`.`first_name`,`users`.`last_name`) AS `Celá jména` FROM `users` ORDER BY `users`.`last_name` ASC  ;

--
-- Indexy pro exportované tabulky
--

--
-- Indexy pro tabulku `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pro tabulku `contracts`
--
ALTER TABLE `contracts`
  ADD PRIMARY KEY (`id`,`types_id`),
  ADD KEY `fk_contracts_properties1_idx` (`properties_id`),
  ADD KEY `fk_contracts_types1_idx` (`types_id`);

--
-- Indexy pro tabulku `properties`
--
ALTER TABLE `properties`
  ADD PRIMARY KEY (`id`,`addresses_id`,`types_id`),
  ADD KEY `fk_properties_addresses1_idx` (`addresses_id`),
  ADD KEY `fk_properties_types1_idx` (`types_id`);

--
-- Indexy pro tabulku `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pro tabulku `types`
--
ALTER TABLE `types`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pro tabulku `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_users_addresses1_idx` (`addresses_id`);

--
-- Indexy pro tabulku `users_has_contracts`
--
ALTER TABLE `users_has_contracts`
  ADD PRIMARY KEY (`users_id`,`contracts_id`),
  ADD KEY `fk_users_has_contracts_contracts1_idx` (`contracts_id`),
  ADD KEY `fk_users_has_contracts_users1_idx` (`users_id`);

--
-- Indexy pro tabulku `users_has_roles`
--
ALTER TABLE `users_has_roles`
  ADD PRIMARY KEY (`users_id`,`roles_id`),
  ADD KEY `fk_users_has_roles_roles1_idx` (`roles_id`),
  ADD KEY `fk_users_has_roles_users_idx` (`users_id`);

--
-- AUTO_INCREMENT pro tabulky
--

--
-- AUTO_INCREMENT pro tabulku `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT pro tabulku `contracts`
--
ALTER TABLE `contracts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT pro tabulku `properties`
--
ALTER TABLE `properties`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT pro tabulku `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pro tabulku `types`
--
ALTER TABLE `types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pro tabulku `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Omezení pro exportované tabulky
--

--
-- Omezení pro tabulku `contracts`
--
ALTER TABLE `contracts`
  ADD CONSTRAINT `fk_contracts_properties1` FOREIGN KEY (`properties_id`) REFERENCES `properties` (`id`),
  ADD CONSTRAINT `fk_contracts_types1` FOREIGN KEY (`types_id`) REFERENCES `types` (`id`);

--
-- Omezení pro tabulku `properties`
--
ALTER TABLE `properties`
  ADD CONSTRAINT `fk_properties_addresses1` FOREIGN KEY (`addresses_id`) REFERENCES `addresses` (`id`),
  ADD CONSTRAINT `fk_properties_types1` FOREIGN KEY (`types_id`) REFERENCES `types` (`id`);

--
-- Omezení pro tabulku `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_addresses1` FOREIGN KEY (`addresses_id`) REFERENCES `addresses` (`id`);

--
-- Omezení pro tabulku `users_has_contracts`
--
ALTER TABLE `users_has_contracts`
  ADD CONSTRAINT `fk_users_has_contracts_contracts1` FOREIGN KEY (`contracts_id`) REFERENCES `contracts` (`id`),
  ADD CONSTRAINT `fk_users_has_contracts_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`);

--
-- Omezení pro tabulku `users_has_roles`
--
ALTER TABLE `users_has_roles`
  ADD CONSTRAINT `fk_users_has_roles_roles1` FOREIGN KEY (`roles_id`) REFERENCES `roles` (`id`),
  ADD CONSTRAINT `fk_users_has_roles_users` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
