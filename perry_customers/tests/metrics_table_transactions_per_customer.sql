with a as
(
    SELECT distinct c.id,
    t.transaction_id
    FROM {{ ref('dim_transactions') }} t 
    LEFT JOIN {{ ref('dim_transaction_details') }} td
    on t.transaction_id = td.transaction_id
    LEFT JOIN {{ ref('dim_customers') }} c
    on c.id = td.customer_id
    LEFT JOIN {{ ref('dim_products') }}  p
    on p.product_id = t.product_id
),
b as (Select a.id,
    count(transaction_id) as co
    from a
    group by a.id
)
SELECT mt.customer_id,
b.co,
transactions_per_customer
FROM
{{ ref('metrics_table') }} mt Left join
b
on b.id = mt.customer_id
WHERE b.co != transactions_per_customer