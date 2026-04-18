-- 1-mashq
SELECT MAX(salary) AS second_highest_salary
FROM employees
WHERE salary < (SELECT MAX(salary) FROM employees);
-- 2-mashq
WITH ranked AS (
    SELECT 
        e.name,
        e.salary,
        d.name AS department,
        RANK() OVER (PARTITION BY d.name ORDER BY e.salary DESC) AS rnk
    FROM employees e
    JOIN departments d ON e.department_id = d.id
)
SELECT department, name, salary
FROM ranked
WHERE rnk = 1;
