with a as
(
    SELECT distinct p.product_category,
    c.id as q
    FROM {{ ref('dim_transactions') }} t 
    LEFT JOIN {{ ref('dim_transaction_details') }} td
    on t.transaction_id = td.transaction_id
    LEFT JOIN {{ ref('dim_customers') }} c
    on c.id = td.customer_id
    LEFT JOIN {{ ref('dim_products') }}  p
    on p.product_id = t.product_id
),
b as (Select a.product_category,
    count(distinct q) as q
    from a
    group by a.product_category
)
SELECT mt.product_category,
unique_customers_per_product_category,
b.q
FROM
{{ ref('metrics_table') }} mt Left join
b
on b.product_category = mt.product_category
WHERE b.q != unique_customers_per_product_category