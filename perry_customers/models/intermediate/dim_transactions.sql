WITH t AS (
    SELECT
* FROM
        {{ ref('transactions') }}
) SELECT
    distinct
    transaction_id,
    product_id,
    quantity
FROM
    t