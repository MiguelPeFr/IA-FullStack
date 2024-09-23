SELECT calls_phone_number, step_name, step_result, identified_client_phone

FROM (
  SELECT calls_phone_number, step_name, step_result
    , DENSE_RANK() OVER(PARTITION BY CAST(calls_ivr_id AS STRING) ORDER BY step_name) AS step_id
    , IF (step_name = "CUSTOMERINFOBYPHONE.TX" AND step_result = "OK", 1, 0) AS identified_client_phone

  FROM `keepcoding.ivr_detail`
  
)

WHERE step_id = 2



