--Question 2 full query:
--What is the average cart value by acquisition year cohort (e.g., what is the average cart value for customers acquired in 2019, 2020, 2021, etc.)

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