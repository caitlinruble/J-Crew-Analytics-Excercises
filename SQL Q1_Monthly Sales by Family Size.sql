--Question 1 full query:
--What is monthly sales by customer type? Customer type defined as Single (1 family size), Couple (2 family size), Family (3-5), Large Family (6+)

WITH
 checkouts_fam AS (
   SELECT 
   ch.customer_id, 
   ch.cart_id, 
   DATE_FORMAT(ch.date, '%m-%Y') AS month_year, 
     CASE
       WHEN cu.family_size = 1 THEN 'Single'
       WHEN cu.family_size = 2 THEN 'Couple'
       WHEN cu.family_size > 5  THEN 'Large Family'
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
