SELECT
  product_id,
  product_category,
  unit_price_cents
FROM 
  {{ source('perryhealth', 'products') }}
