
#Question 1 full query for MySQL

WITH
    cte1 AS (
        SELECT 
        ch.customer_id, 
        cart_id, 
        date, 
        CASE
            WHEN family_size = 1 THEN 'Single'
            WHEN family_size = 2 THEN 'Couple'
            WHEN family_size > 5  THEN 'Large Family'
            ELSE 'Family'
        END AS customer_type
        FROM checkouts AS ch 
        LEFT JOIN customers AS cu 
        ON ch.customer_id = cu.customer_id),
    cte2 AS (
        SELECT 
        cart_id, 
        SUM((price_per_unit_cents * quantity)/100) AS trans_value_USD 
        FROM checkout_items 
        GROUP BY cart_id)
SELECT 
DATE_FORMAT(cte1.date, '%m-%Y') AS month_year, 
cte1.customer_type, 
COUNT(cte1.cart_id) AS total_transactions, 
SUM(cte2.trans_value_USD) AS total_trans_value_USD
FROM cte1 
LEFT JOIN cte2 
  ON cte1.cart_id = cte2.cart_id 
GROUP BY customer_type, month_year
ORDER BY month_year DESC;


#Question 2 full query for MySQL

WITH
    cart_vals AS(
        SELECT 
        ch.customer_id,
        ch.cart_id, 
        SUM((ci.price_per_unit_cents * quantity)/100) AS cart_value_USD 
        FROM checkouts as ch
        LEFT JOIN checkout_items AS ci
        ON ci.cart_id = ch.cart_id
        GROUP BY ch.cart_id
        ),
    cohorts AS(
        SELECT 
        customer_id,
        MIN(YEAR(date)) AS year_cohort
        FROM checkouts
        GROUP BY customer_id
        ) 
SELECT 
co.year_cohort,
AVG(cv.cart_value_USD) AS avg_cart_value_USD
FROM cart_vals AS cv
LEFT JOIN cohorts AS co
ON cv.customer_id = co.customer_id
GROUP BY co.year_cohort;


#Question 3

WITH 
    cart_vals AS(
            SELECT 
            ch.customer_id,
            ch.date,
            ch.cart_id, 
            SUM((ci.price_per_unit_cents * quantity)/100) AS cart_value_USD
            COUNT(ch.cart_id) OVER(PARTITION BY customer_id ORDER BY ch.date) AS order_number 
            FROM checkouts as ch
            LEFT JOIN checkout_items AS ci
            ON ci.cart_id = ch.cart_id
            GROUP BY ch.cart_id
            ),
    differences AS(
            SELECT customer_id, 
            order_number,
            cart_value_USD - LEAD(cart_value_USD) OVER(PARTITION BY customer_id ORDER BY order_number) AS difference 
            FROM cart_vals 
            WHERE order_number <= 2)
SELECT 
customer_id,
FIRST_VALUE(difference) OVER(PARTITION BY customer_id ORDER BY order_number) as difference_in_value_of_first_and_second_orders_USD,
FROM differences
GROUP BY customer_id;