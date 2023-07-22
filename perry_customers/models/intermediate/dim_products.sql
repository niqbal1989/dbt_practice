
WITH p AS (
    SELECT
* FROM
        {{ ref('products') }}
) SELECT
    distinct
    product_id,
    product_category,
    unit_price_cents/100 :: NUMBER(20,2) as price_dollars  
FROM
    p