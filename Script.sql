
-- Total Sales per year --

SELECT 
    SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_revenue,
    YEAR(o.order_date) AS order_year,
    MONTH(o.order_date) AS order_month
FROM Bikestores.sales.order_items AS oi
JOIN Bikestores.sales.orders AS o ON oi.order_id = o.order_id
WHERE o.order_status = 4 -- only consider completed orders --
GROUP BY YEAR(o.order_date), MONTH(o.order_date)
ORDER BY order_year, order_month;

-- top 10 customers in terms of sales --

SELECT 
    TOP 10 c.first_name +' '+ c.last_name AS customer_name, 
    YEAR(o.order_date) AS order_year,
    MONTH(o.order_date) AS order_month,
    SUM((oi.quantity*oi.list_price) * (1 - oi.discount)) AS revenue
FROM Bikestores.sales.customers AS c
JOIN Bikestores.sales.orders AS o ON c.customer_id = o.customer_id
JOIN Bikestores.sales.order_items AS oi ON o.order_id = oi.order_id
where o.order_status = 4
GROUP BY YEAR(o.order_date), MONTH(o.order_date), c.customer_id, c.first_name, c.last_name 
ORDER by order_year, order_month, revenue DESC;

-- sales per month --

SELECT  
    YEAR(o.order_date) AS order_year,
    MONTH(o.order_date) AS order_month,
    SUM(oi.quantity * oi.list_price * (1-oi.discount)) AS revenue
FROM Bikestores.sales.orders AS o
JOIN Bikestores.sales.order_items AS oi ON oi.order_id = o.order_id
WHERE o.order_status = 4
GROUP BY YEAR(o.order_date), MONTH(o.order_date)
ORDER BY order_year, order_month;

-- sales per category --

SELECT
    TOP 10
    YEAR(o.order_date) AS order_year,
    MONTH(o.order_date) AS order_month,
    c.category_name, SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS revenue
FROM bikestores.production.categories AS c
JOIN bikestores.production.products AS p ON c.category_id = p.category_id
JOIN bikestores.sales.order_items AS oi ON p.product_id = oi.product_id
JOIN bikestores.sales.orders AS o ON oi.order_id = o.order_id
WHERE o.order_status = 4
GROUP BY YEAR (o.order_date), MONTH(o.order_date), c.category_name
ORDER BY order_year, order_month, revenue DESC;

-- Sales per city --

SELECT 
    SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS revenue,
    YEAR(o.order_date) AS order_year,
    MONTH(o.order_date) AS order_month,
    c.city
FROM Bikestores.sales.orders AS o
JOIN Bikestores.sales.order_items AS oi
     ON o.order_id = oi.order_id
JOIN Bikestores.sales.customers AS c
     ON o.customer_id = c.customer_id
WHERE o.order_status = 4 -- only consider completed orders --
GROUP BY YEAR(o.order_date), MONTH(order_date), c.city
ORDER BY order_year, order_month, revenue;
