SELECT 
td.transaction_id,
td.transaction_date,
p.product_id,
p.product_category,
td.customer_id,
c.customer_sign_up_date,
c.customer_state,
t.quantity,
td.payment_method,
t.quantity *p.price_dollars:: NUMBER(28,2) as total_price_dollars
FROM {{ ref('dim_transactions') }} t
LEFT JOIN {{ ref('dim_transaction_details') }} td
on td.transaction_id = t.transaction_id
LEFT JOIN {{ ref('dim_customers') }} c
on c.id = td.customer_id
LEFT JOIN {{ ref('dim_products') }} p
ON t.product_id = p.product_id