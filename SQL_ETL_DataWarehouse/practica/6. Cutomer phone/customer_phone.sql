SELECT calls_phone_number AS customer_phone
    ,document_identification
    , COUNT(document_identification) AS rep_document


FROM `keepcoding.ivr_detail`

WHERE document_identification != "UNKNOWN"
GROUP BY calls_phone_number, document_identification

ORDER BY rep_document DESC
