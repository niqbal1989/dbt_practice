SELECT
    transaction_id,
    product_id,
    quantity
FROM
    {{ source('perryhealth', 'transactions') }}
