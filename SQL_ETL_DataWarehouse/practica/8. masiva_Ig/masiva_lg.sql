SELECT calls_phone_number
  , CASE WHEN module_name = "AVERIA_MASIVA" THEN 1
            ELSE 0
            END AS masiva_lg

FROM `keepcoding.ivr_detail`