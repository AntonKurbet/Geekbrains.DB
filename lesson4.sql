-- 1. Создать VIEW на основе запросов, которые вы сделали в ДЗ к уроку 3.
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `dept_info` AS
    SELECT 
        `d`.`dept_name` AS `dept_name`, COUNT(0) AS `count(*)`
    FROM
        ((`employees` `e`
        JOIN `dept_emp` `de` ON (((`de`.`emp_no` = `e`.`emp_no`)
            AND (`de`.`to_date` > CURDATE()))))
        JOIN `departments` `d` ON ((`d`.`dept_no` = `de`.`dept_no`)))
    GROUP BY `d`.`dept_no`;
    
-- 2. Создать функцию, которая найдет менеджера по имени и фамилии.
CREATE DEFINER=`root`@`localhost` FUNCTION `get_manager_no`(p_first_name varchar(50), p_last_name varchar(50)) RETURNS int
DETERMINISTIC
BEGIN
	DECLARE result integer default -1;
	SELECT 
		e.emp_no
	INTO result FROM
		employees e
			JOIN
		dept_manager m ON e.emp_no = m.emp_no
	WHERE
		e.first_name = p_first_name
			AND e.last_name = p_last_name;
	RETURN result;
END;

-- 3. Создать триггер, который при добавлении нового сотрудника будет 
--    выплачивать ему вступительный бонус, занося запись об этом в таблицу salary.
DROP TRIGGER IF EXISTS `employees`.`employees_AFTER_INSERT`;

DELIMITER $$
USE `employees`$$
CREATE DEFINER = CURRENT_USER TRIGGER `employees`.`employees_AFTER_INSERT` AFTER INSERT ON `employees` FOR EACH ROW
BEGIN
	insert into salaries (emp_no,salary,from_date,to_date)
    values (new.emp_no,1000,new.hire_date,new.hire_date);
END$$
DELIMITER ;

