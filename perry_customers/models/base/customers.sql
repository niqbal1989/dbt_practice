SELECT
  id,
  sign_up_date,
  state
FROM
  {{ source('perryhealth', 'customers') }}
