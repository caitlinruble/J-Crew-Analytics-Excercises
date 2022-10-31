--Question 3 full query:
--For each customer, what is the difference between the value of their first order and the second order?

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