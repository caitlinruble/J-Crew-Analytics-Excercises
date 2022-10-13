
--Question 1 full query for MySQL/PostgreSQL

WITH
 checkouts_fam AS (
   SELECT 
   ch.customer_id, 
   ch.cart_id, 
   DATE_FORMAT(ch.date, '%m-%Y') AS month_year, 
     CASE
       WHEN cu.family_size = 1 THEN 'Single'
       WHEN cu. family_size = 2 THEN 'Couple'
       WHEN cu. family_size > 5  THEN 'Large Family'
       ELSE 'Family'
     END AS customer_type,
    cu.family_size
   FROM checkouts AS ch 
   LEFT JOIN customers AS cu 
     ON ch.customer_id = cu.customer_id),
 transactions AS (
   SELECT 
   cart_id, 
   SUM((price_per_unit_cents * quantity)/100) AS trans_value_USD,
   SUM(quantity) AS n_items_purchased
   FROM checkout_items 
   GROUP BY cart_id)
SELECT 
customer_type, 
month_year, 
COUNT(cf.cart_id) AS total_monthly_cart_checkouts, 
SUM(tr.n_items_purchased) AS total_monthly_items_puchased,
SUM(tr.trans_value_USD) AS total_monthly_trans_value_USD
FROM checkouts_fam AS cf
LEFT JOIN transactions AS tr 
 ON cf.cart_id = tr.cart_id 
GROUP BY customer_type, month_year
ORDER BY cf.family_size, month_year;


--Question 2 full query for MySQL/PostgreSQL

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
GROUP BY co.year_cohort
ORDER BY co.year_cohort;


--Question 3 full query as would be written for MySQL/PostgreSQL

WITH 
cart_vals AS(
        SELECT 
        ch.customer_id,
        ch.date AS time_of_purchase,
        ch.cart_id, 
        SUM((ci.price_per_unit_cents * quantity)/100) AS cart_value_USD,
        COUNT(ch.cart_id) OVER (PARTITION BY customer_id ORDER BY ch.date) AS order_number 
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
FIRST_VALUE(difference) OVER (PARTITION BY customer_id ORDER BY order_number) as value_of_first_order_minus_value_of_second_order_USD,
FROM differences
GROUP BY customer_id