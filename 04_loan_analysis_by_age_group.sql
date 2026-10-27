 -- extract loan data for home loan + personal loan with age <25-35> -- 
  SELECT
    F.fact_key,
    F.account_key,
    F.borrower_key,
    F.loan_account_type_key,
    T.loan_account,
    T.account_name AS loan_type,

    B.borrower_name,
    B.gender_key,
    B.birth_dt,
    F.borrower_age_bucket_key,
    B.occupation_key,
    B.income_level_key,
    B.std_state_code,
    B.district,
    B.std_pin_code,

    D.date_key,
    D.year,
    D.month,
    D.month_name,
    d.yyyymm,

    F.repodt_yyyymm,
    F.disb_yyyymm,
    F.days_past_due,
    F.overdue_ind,
    F.active,
    F.total_disb_amount,
    F.total_outstanding_amount,
    F.total_overdue_amount,
    F.total_write_off_amount,
    F.installment_amount

FROM CNS_FACT_TBL F

JOIN DIM_LOAN_ACCOUNT_TYPE T
    ON F.loan_account_type_key = T.loan_account_type_key

LEFT JOIN DIM_BORROWER B
    ON F.borrower_key = B.borrower_key

JOIN DIM_DATE D
    ON F.repodt_yyyymm = D.yyyymm

WHERE F.loan_account_type_key IN (6,12)
  AND F.borrower_age_bucket_key = 3
  AND F.repodt_yyyymm BETWEEN 202401 AND 202612

ORDER BY
    t.loan_account_type_key,
    d.yyyymm,
    b.borrower_key;
    
    SELECT
    F.borrower_age_bucket_key,
    COUNT(*) AS total_records
FROM CNS_FACT_TBL F
WHERE F.loan_account_type_key IN (6, 12)
  AND F.repodt_yyyymm BETWEEN 202401 AND 202612
GROUP BY F.borrower_age_bucket_key
ORDER BY F.borrower_age_bucket_key;

SELECT
    F.loan_account_type_key,
    F.borrower_age_bucket_key,
    COUNT(*) AS total_records
FROM CNS_FACT_TBL F
WHERE F.loan_account_type_key IN (6, 12)
GROUP BY
    F.loan_account_type_key,
    F.borrower_age_bucket_key
ORDER BY
    F.loan_account_type_key,
    F.borrower_age_bucket_key;
    
    
    