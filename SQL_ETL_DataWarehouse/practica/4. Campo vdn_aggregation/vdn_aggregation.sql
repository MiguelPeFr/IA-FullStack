SELECT calls_ivr_id 
    , MAX(vdn_aggregation)
FROM 
    (SELECT calls_ivr_id
        ,CASE WHEN ivr_detail.calls_vdn_label LIKE "ATC%" THEN "FRONT"
            WHEN ivr_detail.calls_vdn_label LIKE "TECH%" THEN "TECH"
            WHEN ivr_detail.calls_vdn_label LIKE "ABSORPTION" THEN "ABSORPTION"
            ELSE "RESTO"
        END AS vdn_aggregation
    FROM keepcoding.ivr_detail) AS subquery

GROUP BY calls_ivr_id;