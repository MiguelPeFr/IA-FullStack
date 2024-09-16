SELECT calls_phone_number
  , CASE WHEN step_name = "CUSTOMERINFOBYPHONE.TX" AND step_result = "OK" THEN 1
      ELSE 0
    END AS info_by_phone_lg

FROM `keepcoding.ivr_detail`