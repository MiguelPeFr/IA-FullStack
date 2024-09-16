CREATE OR REPLACE TABLE keepcoding.ivr_documents AS
SELECT
  COUNT(calls_phone_number) AS num_llamadas,
  calls_phone_number,
  document_type,
  document_identification
FROM 
  keepcoding.ivr_detail

JOIN
keepcoding.ivr_calls

ON phone_number = calls_phone_number

GROUP BY document_type, calls_phone_number, document_identification

HAVING 
  document_type != 'UNKNOWN' 
  AND document_identification != 'UNKNOWN'

ORDER BY num_llamadas DESC;
