SELECT
    transaction_id,
    customer_id,
    transaction_date,
    payment_method
FROM
    {{ source('perryhealth', 'transaction_details') }}
