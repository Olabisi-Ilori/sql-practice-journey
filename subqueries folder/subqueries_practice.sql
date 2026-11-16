Find customers whose total spending is greater than 400
SELECT
    customer_id,
    total_spent
FROM (
    SELECT
        customer_id,
        SUM(amount) AS total_spent
    FROM orders
    GROUP BY customer_id
) AS customers_total

WHERE total_spent > 400;
Find products whose total quantity sold is greater than the average quantity sold across all individual sales records.
SELECT
    product,
    total_quantity
FROM (
    SELECT
        product,
        SUM(quantity) AS total_quantity
    FROM sales
    GROUP BY product
) AS products_total

WHERE total_quantity > (
    SELECT AVG(quantity)
    FROM sales
);
I have 2 tables and I need to identify both home team players
Without subqueries (simpler approach)
SELECT
    m.date,
    p1.player_name AS home_pl1,
    p2.player_name AS home_pl2

FROM match AS m

INNER JOIN players AS p1
ON m.home_player_1 = p1.player_id

INNER JOIN players AS p2
ON m.home_player_2 = p2.player_id

LIMIT 5;
With subqueries
SELECT
    p1.date,
    p1.player_name AS home_pl1,
    p2.player_name AS home_pl2

FROM (
    SELECT
        m.id,
        p.player_name,
        m.date
    FROM match AS m
    INNER JOIN players AS p
        ON m.home_player_1 = p.player_id
) AS p1

INNER JOIN (
    SELECT
        m.id,
        p.player_name
    FROM match AS m
    INNER JOIN players AS p
        ON m.home_player_2 = p.player_id
) AS p2

ON p1.id = p2.id

LIMIT 5;
A subquery is not compulsory just because a task inolves multiple tables or calculations
Write an SQL query to find departments whose average salary is higher than the overall average salary of all employees.
SELECT
    department,
    avg_salary,
    (SELECT AVG(salary)
     FROM employees) AS overall_avg

FROM (
    SELECT
        department,
        AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department
) AS dept_avg

WHERE avg_salary > (
    SELECT AVG(salary)
    FROM employees
);