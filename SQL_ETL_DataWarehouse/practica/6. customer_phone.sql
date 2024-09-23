SELECT calls_ivr_id, calls_phone_number

FROM(
  SELECT calls_ivr_id, calls_phone_number,

  ROW_NUMBER() OVER(PARTITION BY CAST(calls_ivr_id AS STRING) ORDER BY calls_phone_number) AS calls_iden
  
FROM `keepcoding.ivr_detail`

GROUP BY calls_phone_number, calls_ivr_id
)

WHERE calls_iden = 1