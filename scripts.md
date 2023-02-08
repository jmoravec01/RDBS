## SELECTS
```
SELECT AVG(`information_schema`.`tables`.`TABLE_ROWS`) AS `prumerny_pocet_zaznamu`
FROM `information_schema`.`TABLES`
WHERE (`information_schema`.`tables`.`TABLE_SCHEMA` = 'properties');
```
```
SELECT `users`.`first_name` AS `first_name`, `users`.`last_name` AS `last_name`
FROM `users`
WHERE `users`.`id` in (select `users`.`id` from `users` WHERE (`users`.`id` <= 10));
```
```
SELECT concat_ws(' ',`users`.`first_name`,`users`.`last_name`) AS `jména majitelů`
FROM ((`roles` join `users_has_roles` on((`users_has_roles`.`roles_id` = `roles`.`id`)))
JOIN `users` on((`users`.`id` = `users_has_roles`.`users_id`)))
WHERE (`roles`.`role` = 'Majitel');
```

## VIEW
```
CREATE VIEW `vyhledej_majitele` AS
SELECT concat_ws(' ',`users`.`first_name`,`users`.`last_name`) AS `jména majitelů`
FROM ((`roles` join `users_has_roles` on((`users_has_roles`.`roles_id` = `roles`.`id`)))
JOIN `users` on((`users`.`id` = `users_has_roles`.`users_id`)))
WHERE (`roles`.`role` = 'Majitel')  ;
```
```
CREATE VIEW `pocet_nemovitosti_podle_psc` AS 
SELECT `addresses`.`post_code` AS `post_code`, count(0) AS `počet` 
FROM `addresses` 
GROUP BY `addresses`.`post_code``post_code`;
```
```
CREATE VIEW `pocet_zaznamu_na_tabulku` AS 
SELECT avg(`information_schema`.`tables`.`TABLE_ROWS`) AS `prumerny_pocet_zaznamu` 
FROM `information_schema`.`TABLES` 
WHERE (`information_schema`.`tables`.`TABLE_SCHEMA` = 'properties')  ;
```
```
CREATE VIEW `byty_1kk_az_10kk` AS 
SELECT `price` AS `Cenovky nemovitostí`, `id` AS `ID nemovitosti`, `types`.`note` AS `Typ`, `addresses`.`post_code` AS `PSČ` 
FROM ((`properties` join `types` on((`types`.`id` = `types_id`))) 
join `addresses` on((`addresses_id` = `addresses`.`id`))) 
WHERE (`price` between 1000000 and 10000000) HAVING (`types`.`note` = 'byt') 
ORDER BY `price` AS `DESCdesc` ASC  ;
```
```
CREATE VIEW `vnoreny_select`  AS 
SELECT `users`.`first_name` AS `first_name`, `users`.`last_name` AS `last_name` 
FROM `users` WHERE `users`.`id` in (select `users`.`id` from `users` 
where (`users`.`id` <= 10))  ;
```

## INDEX
```
CREATE INDEX indeks ON users (first_name); 
```
```
SELECT * FROM users USE INDEX(indeks) WHERE first_name = "Ladislav"; 
```

## FUNCTION
```
DELIMITER $$

CREATE FUNCTION count_users_name(name TEXT)
RETURNS INT

BEGIN

   DECLARE number INT;
   
   SELECT COUNT(*) INTO number
   FROM users
   WHERE name = users.first_name;
   RETURN number;

END $$

DELIMITER ;
```

## PROCEDURE
```
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `users_full_name_procedure`()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE v_first_name VARCHAR(30);
  DECLARE v_last_name VARCHAR(35);
  DECLARE v_full_name VARCHAR(100);
  DECLARE cur CURSOR FOR SELECT users.first_name, users.last_name FROM users;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  
DROP TABLE IF EXISTS full_names;
CREATE TABLE full_names (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) );

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
DELIMITER ;
```

## TRIGGERS
```
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
```
```
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
```
```
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
```

## TRANSACTION
```
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `new_user_transaction`(IN `firstName` VARCHAR(20), IN `lastName` VARCHAR(25), IN `address` INT)
BEGIN
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
DELIMITER ;
```

## USER
```
CREATE USER 'new_user'@'localhost' IDENTIFIED BY 'password';     	 	
SELECT User, Host FROM mysql.user;      					 		
DROP USER 'john'@'localhost';							 	
GRANT SELECT, INSERT, UPDATE, DELETE ON database.* TO 'username'@'localhost';	
GRANT SELECT ON *.* TO 'username'@'localhost';							
REVOKE SELECT ON *.* FROM 'username'@'localhost';						
SHOW GRANTS FOR 'username'@'localhost';
```
