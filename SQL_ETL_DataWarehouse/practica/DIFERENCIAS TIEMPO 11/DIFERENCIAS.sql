
SELECT calls_ivr_id, calls_phone_number, calls_start_date, 

--LAG(calls_start_date) OVER(PARTITION BY calls_phone_number ORDER BY calls_start_date ASC),
--LEAD(calls_start_date) OVER(PARTITION BY calls_phone_number ORDER BY calls_start_date ASC),

--DATETIME_DIFF(LAG(calls_start_date) OVER(PARTITION BY calls_phone_number ORDER BY calls_start_date ASC), calls_start_date, HOUR) ,
--DATETIME_DIFF(LEAD(calls_start_date) OVER(PARTITION BY calls_phone_number ORDER BY calls_start_date ASC), calls_start_date, HOUR) ,

  IF(DATETIME_DIFF(LAG(calls_start_date) OVER(PARTITION BY calls_phone_number ORDER BY calls_start_date), calls_start_date, HOUR) >= -24, 1, 0)  AS previous_call,

  IF(DATETIME_DIFF(LEAD(calls_start_date) OVER(PARTITION BY calls_phone_number ORDER BY calls_start_date), calls_start_date, HOUR) <= 24, 1, 0)  AS next_call
FROM `keepcoding.ivr_detail`

QUALIFY ROW_NUMBER() OVER (PARTITION BY CAST(calls_ivr_id AS STRING) ORDER BY calls_phone_number) = 1
--WHERE calls_phone_number = "400000006"
ORDER BY calls_phone_number, calls_start_date


--OTRO

SELECT calls_ivr_id, calls_phone_number, great_amount_lg, er, step_id, calls_start_date, en, el

FROM(
  SELECT calls_ivr_id
           , calls_phone_number
           , calls_start_date
           , ROW_NUMBER() OVER(PARTITION BY CAST(calls_ivr_id AS STRING) ORDER BY calls_phone_number) AS step_id
           , IF(DATETIME_DIFF(LAG(calls_start_date) OVER(PARTITION BY calls_phone_number ORDER BY calls_start_date, calls_ivr_id), calls_start_date, HOUR) > -24, 1, 0) AS great_amount_lg
           , IF(DATETIME_DIFF(LEAD(calls_start_date) OVER(PARTITION BY calls_phone_number ORDER BY calls_start_date, calls_ivr_id), calls_start_date, HOUR) < 24, 1, 0) AS er
           , DATETIME_DIFF(LAG(calls_start_date) OVER(PARTITION BY calls_phone_number ORDER BY calls_start_date, calls_ivr_id), calls_start_date, HOUR) AS en
           , DATETIME_DIFF(LEAD(calls_start_date) OVER(PARTITION BY calls_phone_number ORDER BY calls_start_date, calls_ivr_id), calls_start_date, HOUR) AS el
        FROM `keepcoding.ivr_detail`
)
WHERE step_id = 1

ORDER BY calls_phone_number




SELECT calls_phone_number
  , en
  , el
  , calls_start_date
  , IF(en < -24,1, 0)
  , IF(el < 24, 0, 1)
FROM(SELECT calls_ivr_id
  , calls_phone_number
  , calls_start_date
  , ROW_NUMBER() OVER(PARTITION BY CAST(calls_ivr_id AS STRING) ORDER BY calls_start_date) AS calls
  , DATETIME_DIFF(LAG(calls_start_date)OVER(PARTITION BY calls_phone_number ORDER BY calls_start_date, calls_ivr_id), calls_start_date, HOUR) AS en
  , DATETIME_DIFF(LEAD(calls_start_date)OVER(PARTITION BY calls_phone_number ORDER BY calls_start_date, calls_ivr_id), calls_start_date, HOUR) AS el
FROM `keepcoding.ivr_detail`
--WHERE calls_phone_number = "400002983"

ORDER BY calls_start_date, calls_ivr_id)
