WITH c AS (
    SELECT
* FROM
        {{ ref('customers') }}
) SELECT
    distinct
    id,
    sign_up_date AS customer_sign_up_date,
    NVL(state,
        'Unknown'
    ) AS customer_state
FROM
    c