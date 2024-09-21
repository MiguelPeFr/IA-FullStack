SELECT 
  calls_ivr_id, 
  calls_phone_number, 
  billing_account_id
FROM 
  `keepcoding.ivr_detail`
QUALIFY 
  ROW_NUMBER() OVER (
    PARTITION BY CAST(calls_ivr_id AS INT64) 
    ORDER BY calls_phone_number, billing_account_id
  ) = 1


