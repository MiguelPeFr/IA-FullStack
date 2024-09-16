SELECT calls_phone_number AS customer_phone
    ,billing_account_id
    , COUNT(billing_account_id) AS rep_billing


FROM `keepcoding.ivr_detail`

WHERE billing_account_id != "UNKNOWN"
GROUP BY calls_phone_number, billing_account_id

ORDER BY rep_billing DESC
