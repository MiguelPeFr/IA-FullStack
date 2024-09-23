-- En algunos casos el step_name y el step_result salen positivos, pero el document_identification sale como "UNKNOWN" lo cual no está registrando bien los datos, como en calls_phone_number = 400009762.
-- Por ello incluyo una variable más sobre document_identification.

SELECT calls_phone_number, step_name, step_result, identified_client_dni , document_identification
FROM (
  SELECT calls_phone_number, step_name, step_result, document_identification
    , ROW_NUMBER() OVER(PARTITION BY CAST(calls_ivr_id AS STRING) ORDER BY step_name) AS step_id
    , IF (step_name = "CUSTOMERINFOBYDNI.TX" AND step_result = "OK" AND document_identification != "UNKNOWN", 1, 0) AS identified_client_dni

  FROM `keepcoding.ivr_detail`

)

WHERE step_id = 1 