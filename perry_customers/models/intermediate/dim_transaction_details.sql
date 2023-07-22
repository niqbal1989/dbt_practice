WITH td AS (
    SELECT
* FROM
        {{ ref('transaction_details') }}
) SELECT
    distinct
    transaction_id,
    customer_id,
    transaction_date,
    NVL(payment_method, 'Unknown') as payment_method
FROM
    td