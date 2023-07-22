with a as
(
    SELECT distinct p.product_id,
    c.id as q
    FROM {{ ref('dim_transactions') }} t 
    LEFT JOIN {{ ref('dim_transaction_details') }} td
    on t.transaction_id = td.transaction_id
    LEFT JOIN {{ ref('dim_customers') }} c
    on c.id = td.customer_id
    LEFT JOIN {{ ref('dim_products') }}  p
    on p.product_id = t.product_id
),
b as (Select a.product_id,
    count(distinct q) as q
    from a
    group by a.product_id
)
SELECT mt.product_id,
unique_customers_per_product_id,
b.q
FROM
{{ ref('metrics_table') }} mt Left join
b
on b.product_id = mt.product_id
WHERE b.q != unique_customers_per_product_id