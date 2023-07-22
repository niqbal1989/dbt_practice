with a as
(
    SELECT c.id,
    p.price_dollars * t.quantity :: NUMBER(28,2) as price
    FROM {{ ref('dim_transactions') }} t 
    LEFT JOIN {{ ref('dim_transaction_details') }} td
    on t.transaction_id = td.transaction_id
    LEFT JOIN {{ ref('dim_customers') }} c
    on c.id = td.customer_id
    LEFT JOIN {{ ref('dim_products') }}  p
    on p.product_id = t.product_id
),
b as (Select a.id,
    sum(price) as price
    from a
    group by a.id
)
SELECT mt.customer_id,
lifetime_price_per_customer,
b.price
FROM
{{ ref('metrics_table') }} mt Left join
b
on b.id = mt.customer_id
WHERE b.price != lifetime_price_per_customer
