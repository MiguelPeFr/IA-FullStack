SELECT   ivr_detail.calls_vdn_label,

    CASE WHEN ivr_detail.calls_vdn_label LIKE "ATC%" THEN "FRONT"
        WHEN ivr_detail.calls_vdn_label LIKE "TECH%" THEN "TECH"
        WHEN ivr_detail.calls_vdn_label LIKE "ABSORPTION" THEN "ABSORPTION"
        ELSE "RESTO"
    END AS vdn_aggregation
FROM keepcoding.ivr_detail;