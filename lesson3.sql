-- База данных «Страны и города мира»:
-- 1. Сделать запрос, в котором мы выберем все данные о городе – регион, страна.
SELECT 
    ct.title city, r.title region, c.title country
FROM
    _cities ct
        JOIN
    _regions r ON r.id = ct.region_id
        JOIN
    _countries c ON c.id = ct.country_id
ORDER BY country , region , city; 
-- 2. Выбрать все города из Московской области.
SELECT 
    ct.title city, r.title region, c.title country
FROM
    _cities ct
        JOIN
    _regions r ON r.id = ct.region_id
        JOIN
    _countries c ON c.id = ct.country_id
WHERE
    -- r.title LIKE 'Московская%'
    r.title = 'Московская область'
ORDER BY city; 
-- База данных «Сотрудники»:
-- 1. Выбрать среднюю зарплату по отделам.
SELECT 
    d.dept_name, AVG(s.salary)
FROM
    employees e
        JOIN
    dept_emp de ON de.emp_no = e.emp_no
               AND de.to_date > CURDATE()
        JOIN
    salaries s ON s.emp_no = e.emp_no
              AND s.from_date = de.from_date
        JOIN
    departments d ON d.dept_no = de.dept_no
GROUP BY d.dept_no; 
-- 2. Выбрать максимальную зарплату у сотрудника.
SELECT 
    MAX(s.salary)
FROM
    salaries s 
WHERE
	s.to_date > CURDATE(); 
-- 3. Удалить одного сотрудника, у которого максимальная зарплата.
DELETE FROM employees 
WHERE
    emp_no = (SELECT 
        s.emp_no
    FROM
        salaries s
    
    WHERE
        s.to_date > CURDATE()
    ORDER BY s.salary DESC
    LIMIT 1); 
-- 4. Посчитать количество сотрудников во всех отделах.
SELECT 
    d.dept_name, count(*)
FROM
    employees e
        JOIN
    dept_emp de ON de.emp_no = e.emp_no
               AND de.to_date > CURDATE()
        JOIN
    departments d ON d.dept_no = de.dept_no
GROUP BY d.dept_no;
-- 5. Найти количество сотрудников в отделах и посмотреть, сколько всего денег получает отдел.
SELECT 
    d.dept_name, count(e.emp_no), sum(s.salary)
FROM
    employees e
        JOIN
    dept_emp de ON de.emp_no = e.emp_no
               AND de.to_date > CURDATE()
        JOIN
    salaries s ON s.emp_no = e.emp_no
              AND s.from_date = de.from_date
        JOIN
    departments d ON d.dept_no = de.dept_no
GROUP BY d.dept_no;