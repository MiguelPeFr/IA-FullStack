  SELECT calls_phone_number, step_name, step_result

    , IF (step_name = "CUSTOMERINFOBYPHONE.TX" AND step_result = "OK", 1, 0) AS identified_client_phone

  FROM `keepcoding.ivr_detail`

QUALIFY ROW_NUMBER() OVER(PARTITION BY CAST(calls_ivr_id AS STRING) ORDER BY step_name) = 2
