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
```
cs
```
