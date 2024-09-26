CREATE OR REPLACE TABLE keepcoding.ivr_summary AS
WITH summary 
AS(
    SELECT calls_ivr_id
        ,CASE WHEN ivr_detail.calls_vdn_label LIKE "ATC%" THEN "FRONT"
            WHEN ivr_detail.calls_vdn_label LIKE "TECH%" THEN "TECH"
            WHEN ivr_detail.calls_vdn_label LIKE "ABSORPTION" THEN "ABSORPTION"
            ELSE "RESTO"
        END AS vdn_aggregation
    FROM keepcoding.ivr_detail
    QUALIFY ROW_NUMBER() OVER(PARTITION BY CAST(calls_ivr_id AS STRING) ORDER BY calls_vdn_label) = 1
), phone
AS(
    SELECT calls_ivr_id, calls_phone_number,
    FROM `keepcoding.ivr_detail`
    QUALIFY ROW_NUMBER() OVER(PARTITION BY CAST(calls_ivr_id AS STRING) ORDER BY calls_phone_number) = 1
), dni
AS(
    SELECT calls_ivr_id, calls_phone_number, step_name, step_result, document_identification
        , IF (step_name = "CUSTOMERINFOBYDNI.TX" AND step_result = "OK" AND document_identification != "UNKNOWN", 1, 0) AS identified_client_dni
    FROM `keepcoding.ivr_detail`

QUALIFY ROW_NUMBER() OVER(PARTITION BY CAST(calls_ivr_id AS STRING) ORDER BY step_name) = 1
), docs
AS(
    SELECT calls_ivr_id, document_type, document_identification,
    FROM `keepcoding.ivr_detail`
    QUALIFY ROW_NUMBER() OVER(PARTITION BY CAST(calls_ivr_id AS STRING) ORDER BY document_identification, document_type) = 1
), billing
AS(
    SELECT calls_ivr_id, calls_phone_number, billing_account_id
    FROM `keepcoding.ivr_detail`
    QUALIFY ROW_NUMBER() OVER (PARTITION BY CAST(calls_ivr_id AS STRING) ORDER BY calls_phone_number, billing_account_id) = 1
), info_by_phone
AS(
    SELECT calls_ivr_id, calls_phone_number, step_name, step_result
        , IF (step_name = "CUSTOMERINFOBYPHONE.TX" AND step_result = "OK", 1, 0) AS identified_client_phone
    FROM `keepcoding.ivr_detail`
    QUALIFY ROW_NUMBER() OVER(PARTITION BY CAST(calls_ivr_id AS STRING) ORDER BY step_name) = 2

), masiva
AS(
    SELECT calls_ivr_id, calls_phone_number, module_name
        , IF (module_name = "AVERIA_MASIVA", 1, 0) AS averia_masiva
    FROM `keepcoding.ivr_detail`
    QUALIFY ROW_NUMBER() OVER(PARTITION BY CAST(calls_ivr_id AS STRING) ORDER BY module_name) = 1
), repeated_recall_call
AS(
    SELECT calls_ivr_id, calls_phone_number, calls_start_date
        , IF(DATETIME_DIFF(LAG(calls_start_date) OVER(PARTITION BY calls_phone_number ORDER BY calls_start_date, calls_ivr_id), calls_start_date, HOUR) > -24, 1, 0) AS repeated_phone
        , IF(DATETIME_DIFF(LEAD(calls_start_date) OVER(PARTITION BY calls_phone_number ORDER BY calls_start_date, calls_ivr_id), calls_start_date, HOUR) < 24, 1, 0) AS recall_phone
    
    FROM(
        SELECT calls_ivr_id, calls_phone_number, calls_start_date
        FROM `keepcoding.ivr_detail`
        QUALIFY ROW_NUMBER() OVER(PARTITION BY CAST(calls_ivr_id AS STRING) ORDER BY calls_phone_number) = 1
        ORDER BY calls_start_date, calls_ivr_id)

), aggregation
AS(
    SELECT calls_ivr_id
    , calls_phone_number
    , calls_ivr_result
    , calls_start_date
    , calls_end_date
    , calls_total_duration
    , calls_customer_segment
    , calls_ivr_language
    , calls_steps_module
    , calls_module_aggregation
    , document_identification
    , document_type
    FROM keepcoding.ivr_detail
    QUALIFY ROW_NUMBER() OVER(PARTITION BY CAST(calls_ivr_id AS STRING) ORDER BY calls_phone_number) = 1
)

SELECT summary.calls_ivr_id
    , aggregation.calls_phone_number
    , calls_ivr_result
    , vdn_aggregation
    , aggregation.calls_start_date
    , calls_end_date
    , calls_total_duration
    , calls_customer_segment
    , calls_ivr_language
    , calls_steps_module
    , calls_module_aggregation
    , docs.document_identification
    , docs.document_type
    , phone.calls_phone_number AS identified_phone
    , billing.billing_account_id
    , masiva.averia_masiva
    , info_by_phone.identified_client_phone
    , dni.identified_client_dni
    , repeated_recall_call.recall_phone
    , repeated_recall_call.repeated_phone

FROM summary
JOIN aggregation
ON summary.calls_ivr_id = aggregation.calls_ivr_id

JOIN docs
ON summary.calls_ivr_id = docs.calls_ivr_id

JOIN phone
ON summary.calls_ivr_id = phone.calls_ivr_id

JOIN billing
ON summary.calls_ivr_id = billing.calls_ivr_id

JOIN masiva
ON summary.calls_ivr_id = masiva.calls_ivr_id

JOIN info_by_phone
ON summary.calls_ivr_id = info_by_phone.calls_ivr_id

JOIN dni
ON summary.calls_ivr_id = dni.calls_ivr_id

JOIN repeated_recall_call
ON summary.calls_ivr_id = repeated_recall_call.calls_ivr_id