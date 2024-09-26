SELECT calls_phone_number
  , calls_start_date
  , IF(DATETIME_DIFF(LAG(calls_start_date) OVER(PARTITION BY calls_phone_number ORDER BY calls_start_date, calls_ivr_id), calls_start_date, HOUR) > -24, 1, 0) AS repeated_phone
  , IF(DATETIME_DIFF(LEAD(calls_start_date) OVER(PARTITION BY calls_phone_number ORDER BY calls_start_date, calls_ivr_id), calls_start_date, HOUR) < 24, 1, 0) AS recall_phone
FROM(SELECT calls_ivr_id
  , calls_phone_number
  , calls_start_date

FROM `keepcoding.ivr_detail`

QUALIFY ROW_NUMBER() OVER(PARTITION BY CAST(calls_ivr_id AS STRING) ORDER BY calls_phone_number) = 1

ORDER BY calls_start_date, calls_ivr_id)
