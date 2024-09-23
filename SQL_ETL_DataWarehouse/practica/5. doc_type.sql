SELECT calls_ivr_id, document_type, document_identification

FROM(
  SELECT calls_ivr_id, document_type, document_identification,

  ROW_NUMBER() OVER(PARTITION BY CAST(calls_ivr_id AS STRING) ORDER BY document_identification, document_type) AS doc_iden
  
FROM `keepcoding.ivr_detail`

GROUP BY document_type, document_identification, calls_ivr_id
)

WHERE doc_iden = 1