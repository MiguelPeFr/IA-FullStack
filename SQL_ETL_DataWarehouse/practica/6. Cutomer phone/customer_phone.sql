
SELECT calls_ivr_id, calls_phone_number,

  ROW_NUMBER() OVER(PARTITION BY CAST(calls_ivr_id AS INT64) ORDER BY calls_phone_number) 
  
FROM `keepcoding.ivr_detail`

GROUP BY calls_phone_number, calls_ivr_id