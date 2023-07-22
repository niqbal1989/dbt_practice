with a as
(
    SELECT distinct t.transaction_id,
    p.price_dollars * t.quantity :: NUMBER(28,2) as price
    FROM {{ ref('dim_transactions') }} t 
    LEFT JOIN {{ ref('dim_transaction_details') }} td
    on t.transaction_id = td.transaction_id
    LEFT JOIN {{ ref('dim_customers') }} c
    on c.id = td.customer_id
    LEFT JOIN {{ ref('dim_products') }}  p
    on p.product_id = t.product_id
),
b as (Select a.transaction_id,
    sum(price) as price
    from a
    group by a.transaction_id
)
SELECT mt.transaction_id
price_of_customer,
b.price
FROM
{{ ref('metrics_table') }} mt Left join
b
on b.transaction_id = mt.transaction_id
WHERE b.price != price_of_transaction
