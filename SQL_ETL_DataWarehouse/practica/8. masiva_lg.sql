SELECT calls_phone_number, module_name
  , IF (module_name = "AVERIA_MASIVA", 1, 0) AS averia_masiva

FROM `keepcoding.ivr_detail`

QUALIFY ROW_NUMBER() OVER(PARTITION BY CAST(calls_ivr_id AS STRING) ORDER BY module_name) = 1