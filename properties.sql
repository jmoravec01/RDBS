-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Počítač: 127.0.0.1:3306
-- Vytvořeno: Stř 08. úno 2023, 15:21
-- Verze serveru: 8.0.31
-- Verze PHP: 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databáze: `properties`
--

DELIMITER $$
--
-- Procedury
--
DROP PROCEDURE IF EXISTS `get_all_users`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_users` ()   BEGIN
SELECT * FROM users;
END$$

DROP PROCEDURE IF EXISTS `new_user`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `new_user` (IN `first_name` VARCHAR(20), IN `last_name` VARCHAR(25), IN `address` INT)   BEGIN

INSERT INTO users (first_name, last_name, addresses_id) VALUES (first_name, last_name, address);

END$$

DROP PROCEDURE IF EXISTS `new_user_transaction`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `new_user_transaction` (IN `firstName` VARCHAR(20), IN `lastName` VARCHAR(25), IN `address` INT)   BEGIN
    DECLARE duplicate_user INT DEFAULT 0;
    
    SELECT COUNT(*) INTO duplicate_user
    FROM users
    WHERE firstName = users.first_name AND lastName = users.last_name;
    
    START TRANSACTION;
    IF duplicate_user = 0 THEN
        INSERT INTO users (first_name, last_name, addresses_id) 
        VALUES (firstName, lastName, address);
        Select CONCAT("User has been added successfully.") as "INFO";
        COMMIT;
    ELSE
    	Select CONCAT("User has not been added.") as "INFO";
        ROLLBACK;
    END IF;
END$$

DROP PROCEDURE IF EXISTS `users_full_name_procedure`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `users_full_name_procedure` ()   BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE v_first_name VARCHAR(30);
  DECLARE v_last_name VARCHAR(35);
  DECLARE v_full_name VARCHAR(100);
  DECLARE cur CURSOR FOR SELECT users.first_name, users.last_name FROM users;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  
DROP TABLE IF EXISTS full_names;
CREATE TABLE full_names (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100)
);

  
  OPEN cur;
  
  REPEAT
    FETCH cur INTO v_first_name, v_last_name;
    IF NOT done THEN
      SET v_full_name = CONCAT(v_first_name, ' ', v_last_name);
      INSERT INTO full_names (full_name) VALUES (v_full_name);

    END IF;
  UNTIL done END REPEAT;
  
  CLOSE cur;
  
END$$

--
-- Funkce
--
DROP FUNCTION IF EXISTS `count_users_name`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `count_users_name` (`name` TEXT) RETURNS INT  BEGIN

   DECLARE number INT;
   
   SELECT COUNT(*) INTO number
   FROM users
   WHERE name = users.first_name;
   RETURN number;

END$$

DROP FUNCTION IF EXISTS `square`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `square` (`n` INT) RETURNS INT  BEGIN
  RETURN n * n;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabulky `activity_log`
--

DROP TABLE IF EXISTS `activity_log`;
CREATE TABLE IF NOT EXISTS `activity_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `activity` varchar(50) NOT NULL,
  `user` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;

--
-- Vypisuji data pro tabulku `activity_log`
--

INSERT INTO `activity_log` (`id`, `activity`, `user`, `created_at`) VALUES
(2, 'Update', 'root', '2023-02-06 22:44:45'),
(3, 'Delete', 'root', '2023-02-06 22:45:18'),
(4, 'Update', 'root', '2023-02-07 12:01:48'),
(5, 'Update', 'root', '2023-02-07 13:25:24'),
(6, 'Update', 'root', '2023-02-07 13:30:51'),
(7, 'Update', 'root', '2023-02-07 13:32:08'),
(8, 'Update', 'root', '2023-02-07 13:33:19'),
(9, 'Update', 'root', '2023-02-07 13:33:51'),
(10, 'Update', 'root', '2023-02-07 15:46:39'),
(11, 'Update', 'novy_uzivatel', '2023-02-07 16:17:26'),
(12, 'Update', 'root', '2023-02-07 16:35:10'),
(13, 'Update', 'root', '2023-02-08 13:14:24'),
(14, 'Update', 'root', '2023-02-08 15:00:01');

-- --------------------------------------------------------

--
-- Struktura tabulky `addresses`
--

DROP TABLE IF EXISTS `addresses`;
CREATE TABLE IF NOT EXISTS `addresses` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `street` varchar(45) NOT NULL,
  `house_number` int NOT NULL,
  `post_code` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
-- Zástupná struktura pro pohled `byty_1kk_az_10kk`
-- (Vlastní pohled viz níže)
--
DROP VIEW IF EXISTS `byty_1kk_az_10kk`;
CREATE TABLE IF NOT EXISTS `byty_1kk_az_10kk` (
`Cenovky nemovitostí` decimal(20,2)
,`ID nemovitosti` int unsigned
,`Typ` text
,`PSČ` varchar(45)
);

-- --------------------------------------------------------

--
-- Struktura tabulky `contracts`
--

DROP TABLE IF EXISTS `contracts`;
CREATE TABLE IF NOT EXISTS `contracts` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `start` datetime NOT NULL,
  `end` datetime DEFAULT NULL,
  `properties_id` int UNSIGNED NOT NULL,
  `types_id` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`,`types_id`),
  KEY `fk_contracts_properties1_idx` (`properties_id`),
  KEY `fk_contracts_types1_idx` (`types_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
-- Struktura tabulky `full_names`
--

DROP TABLE IF EXISTS `full_names`;
CREATE TABLE IF NOT EXISTS `full_names` (
  `id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb3;

--
-- Vypisuji data pro tabulku `full_names`
--

INSERT INTO `full_names` (`id`, `full_name`) VALUES
(1, 'Alfréd Jonášový'),
(2, 'Bartoloměj Barevný'),
(3, 'Bilbo Pytlík'),
(4, 'Bublifuk Bublinový'),
(5, 'Eliška Krásnohorská'),
(6, 'Filip Moravec'),
(7, 'Filip Trestanec'),
(8, 'Franta Pepa'),
(9, 'Harry Potter'),
(10, 'Hermiona Blabla'),
(11, 'Jakub Černohorský'),
(12, 'Jakub Moravec'),
(13, 'Jan Jelínek'),
(14, 'Jiří Fišer'),
(15, 'Josef Tyl'),
(16, 'Karolína Plíšková'),
(17, 'Ladislav Polívka'),
(18, 'Ladislav Polívkaa'),
(19, 'Ladislavv Polívka'),
(20, 'Ladislavv Polívkaa'),
(21, 'Ladislavvv Polívka'),
(22, 'Magdaléna Jelenová'),
(23, 'Majnkrafak Žigulik'),
(24, 'Markéta Sedmizrná'),
(25, 'Martin Krásný'),
(26, 'Martin Malý'),
(27, 'Ondřej Pomalý'),
(28, 'Petr Rychlý'),
(29, 'Sony Reproduktor'),
(30, 'Tom Riddle'),
(31, 'Tomáš Hluchý'),
(32, 'Tomáš Slabozraký');

-- --------------------------------------------------------

--
-- Zástupná struktura pro pohled `pocet_nemovitosti_podle_psc`
-- (Vlastní pohled viz níže)
--
DROP VIEW IF EXISTS `pocet_nemovitosti_podle_psc`;
CREATE TABLE IF NOT EXISTS `pocet_nemovitosti_podle_psc` (
`post_code` varchar(45)
,`počet` bigint
);

-- --------------------------------------------------------

--
-- Zástupná struktura pro pohled `pocet_zaznamu_na_tabulku`
-- (Vlastní pohled viz níže)
--
DROP VIEW IF EXISTS `pocet_zaznamu_na_tabulku`;
CREATE TABLE IF NOT EXISTS `pocet_zaznamu_na_tabulku` (
`prumerny_pocet_zaznamu` decimal(25,4)
);

-- --------------------------------------------------------

--
-- Struktura tabulky `properties`
--

DROP TABLE IF EXISTS `properties`;
CREATE TABLE IF NOT EXISTS `properties` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `price` decimal(20,2) NOT NULL,
  `addresses_id` int UNSIGNED NOT NULL,
  `types_id` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`,`addresses_id`,`types_id`),
  KEY `fk_properties_addresses1_idx` (`addresses_id`),
  KEY `fk_properties_types1_idx` (`types_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `role` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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

DROP TABLE IF EXISTS `types`;
CREATE TABLE IF NOT EXISTS `types` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `note` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(25) NOT NULL,
  `addresses_id` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_jmena_unikat` (`first_name`,`last_name`),
  KEY `fk_users_addresses1_idx` (`addresses_id`),
  KEY `index_jmena` (`first_name`,`last_name`),
  KEY `index_first_last` (`first_name`,`last_name`),
  KEY `indeks` (`first_name`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
(20, 'Karolína', 'Plíšková', 21),
(22, 'Bilbo', 'Pytlík', 1),
(24, 'Franta', 'Pepa', 1),
(30, 'Alfréd', 'Jonášový', 6),
(31, 'Majnkrafak', 'Žigulik', 4),
(32, 'Ladislavv', 'Polívka', 4),
(33, 'Ladislav', 'Polívkaa', 4),
(34, 'Ladislavv', 'Polívkaa', 4),
(35, 'Ladislavvv', 'Polívka', 4),
(36, 'Bartoloměj', 'Barevný', 8),
(37, 'Bublifuk', 'Bublinový', 5),
(38, 'Hermiona', 'Blabla', 5),
(40, 'Sony', 'Reproduktor', 20),
(41, 'Ladislav', 'Brbla', 5);

--
-- Triggery `users`
--
DROP TRIGGER IF EXISTS `activity_delete_users`;
DELIMITER $$
CREATE TRIGGER `activity_delete_users` AFTER DELETE ON `users` FOR EACH ROW BEGIN
  DECLARE user VARCHAR(50);
  SET user = SUBSTRING_INDEX(USER(), '@', 1);
  INSERT INTO activity_log (activity, user)
  VALUES ('Delete', user);
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `activity_insert_users`;
DELIMITER $$
CREATE TRIGGER `activity_insert_users` AFTER INSERT ON `users` FOR EACH ROW BEGIN
  DECLARE user VARCHAR(50);
  SET user = SUBSTRING_INDEX(USER(), '@', 1);
  INSERT INTO activity_log (activity, user)
  VALUES ('Update', user);
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `activity_update_users`;
DELIMITER $$
CREATE TRIGGER `activity_update_users` AFTER UPDATE ON `users` FOR EACH ROW BEGIN
  DECLARE user VARCHAR(50);
  SET user = SUBSTRING_INDEX(USER(), '@', 1);
  INSERT INTO activity_log (activity, user)
  VALUES ('Update', user);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabulky `users_has_contracts`
--

DROP TABLE IF EXISTS `users_has_contracts`;
CREATE TABLE IF NOT EXISTS `users_has_contracts` (
  `users_id` int UNSIGNED NOT NULL,
  `contracts_id` int UNSIGNED NOT NULL,
  PRIMARY KEY (`users_id`,`contracts_id`),
  KEY `fk_users_has_contracts_contracts1_idx` (`contracts_id`),
  KEY `fk_users_has_contracts_users1_idx` (`users_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Vypisuji data pro tabulku `users_has_contracts`
--

INSERT INTO `users_has_contracts` (`users_id`, `contracts_id`) VALUES
(9, 1),
(16, 2),
(8, 3),
(3, 4),
(1, 5),
(15, 6),
(6, 7),
(5, 8),
(2, 9),
(10, 10),
(20, 10),
(1, 11),
(18, 11),
(17, 12),
(10, 13),
(11, 14),
(14, 15),
(13, 16),
(19, 19),
(7, 21),
(13, 21);

-- --------------------------------------------------------

--
-- Struktura tabulky `users_has_roles`
--

DROP TABLE IF EXISTS `users_has_roles`;
CREATE TABLE IF NOT EXISTS `users_has_roles` (
  `users_id` int UNSIGNED NOT NULL,
  `roles_id` int UNSIGNED NOT NULL,
  PRIMARY KEY (`users_id`,`roles_id`),
  KEY `fk_users_has_roles_roles1_idx` (`roles_id`),
  KEY `fk_users_has_roles_users_idx` (`users_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Vypisuji data pro tabulku `users_has_roles`
--

INSERT INTO `users_has_roles` (`users_id`, `roles_id`) VALUES
(3, 1),
(5, 1),
(6, 1),
(9, 1),
(10, 1),
(18, 1),
(6, 2),
(7, 2),
(9, 2),
(11, 2),
(14, 2),
(15, 2),
(19, 2),
(20, 2),
(2, 3),
(4, 3),
(8, 3),
(11, 3),
(12, 3),
(14, 3),
(16, 3),
(19, 3),
(20, 3);

-- --------------------------------------------------------

--
-- Zástupná struktura pro pohled `vnoreny_select`
-- (Vlastní pohled viz níže)
--
DROP VIEW IF EXISTS `vnoreny_select`;
CREATE TABLE IF NOT EXISTS `vnoreny_select` (
`first_name` varchar(20)
,`last_name` varchar(25)
);

-- --------------------------------------------------------

--
-- Zástupná struktura pro pohled `vyhledej_majitele`
-- (Vlastní pohled viz níže)
--
DROP VIEW IF EXISTS `vyhledej_majitele`;
CREATE TABLE IF NOT EXISTS `vyhledej_majitele` (
`jména majitelů` varchar(46)
);

-- --------------------------------------------------------

--
-- Struktura pro pohled `byty_1kk_az_10kk`
--
DROP TABLE IF EXISTS `byty_1kk_az_10kk`;

DROP VIEW IF EXISTS `byty_1kk_az_10kk`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `byty_1kk_az_10kk`  AS SELECT `price` AS `Cenovky nemovitostí`, `id` AS `ID nemovitosti`, `types`.`note` AS `Typ`, `addresses`.`post_code` AS `PSČ` FROM ((`properties` join `types` on((`types`.`id` = `types_id`))) join `addresses` on((`addresses_id` = `addresses`.`id`))) WHERE (`price` between 1000000 and 10000000) HAVING (`types`.`note` = 'byt') ORDER BY `price` AS `DESCdesc` ASC  ;

-- --------------------------------------------------------

--
-- Struktura pro pohled `pocet_nemovitosti_podle_psc`
--
DROP TABLE IF EXISTS `pocet_nemovitosti_podle_psc`;

DROP VIEW IF EXISTS `pocet_nemovitosti_podle_psc`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pocet_nemovitosti_podle_psc`  AS SELECT `addresses`.`post_code` AS `post_code`, count(0) AS `počet` FROM `addresses` GROUP BY `addresses`.`post_code``post_code`  ;

-- --------------------------------------------------------

--
-- Struktura pro pohled `pocet_zaznamu_na_tabulku`
--
DROP TABLE IF EXISTS `pocet_zaznamu_na_tabulku`;

DROP VIEW IF EXISTS `pocet_zaznamu_na_tabulku`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pocet_zaznamu_na_tabulku`  AS SELECT avg(`information_schema`.`tables`.`TABLE_ROWS`) AS `prumerny_pocet_zaznamu` FROM `information_schema`.`TABLES` WHERE (`information_schema`.`tables`.`TABLE_SCHEMA` = 'properties')  ;

-- --------------------------------------------------------

--
-- Struktura pro pohled `vnoreny_select`
--
DROP TABLE IF EXISTS `vnoreny_select`;

DROP VIEW IF EXISTS `vnoreny_select`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vnoreny_select`  AS SELECT `users`.`first_name` AS `first_name`, `users`.`last_name` AS `last_name` FROM `users` WHERE `users`.`id` in (select `users`.`id` from `users` where (`users`.`id` <= 10))  ;

-- --------------------------------------------------------

--
-- Struktura pro pohled `vyhledej_majitele`
--
DROP TABLE IF EXISTS `vyhledej_majitele`;

DROP VIEW IF EXISTS `vyhledej_majitele`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vyhledej_majitele`  AS SELECT concat_ws(' ',`users`.`first_name`,`users`.`last_name`) AS `jména majitelů` FROM ((`roles` join `users_has_roles` on((`users_has_roles`.`roles_id` = `roles`.`id`))) join `users` on((`users`.`id` = `users_has_roles`.`users_id`))) WHERE (`roles`.`role` = 'Majitel')  ;

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
