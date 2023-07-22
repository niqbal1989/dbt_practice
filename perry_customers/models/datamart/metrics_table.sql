{{ config(
    materialized = 'view'
    )
}}
SELECT
customer_id,
transaction_id,
payment_method,
customer_sign_up_date,
customer_state,
transaction_date,
total_price_dollars,
product_id,
product_category,
SUM(total_price_dollars) over (partition by customer_id) as lifetime_price_per_customer,
SUM(total_price_dollars) over (partition by transaction_id) as price_of_transaction,
count(distinct transaction_id) over (partition by customer_id) as transactions_per_customer,
SUM(quantity) over (partition by product_id) as count_per_product_id,
SUM(quantity) over (partition by product_category) as count_per_product_category,
COUNT(distinct customer_id) over (partition by product_id) as unique_customers_per_product_id,
COUNT(distinct customer_id) over (partition by product_category) as unique_customers_per_product_category,
CASE WHEN lifetime_price_per_customer > 1000 then TRUE else FALSE END AS is_high_value
FROM {{ ref('dim_joined_data') }}