SELECT calls_ivr_id, document_type, document_identification

FROM(
  SELECT calls_ivr_id, document_type, document_identification,

  DENSE_RANK() OVER(PARTITION BY CAST(calls_ivr_id AS INT64) ORDER BY document_identification, document_type) AS dociden
  
FROM `keepcoding.ivr_detail`

GROUP BY document_type, document_identification, calls_ivr_id
)

WHERE dociden = 1