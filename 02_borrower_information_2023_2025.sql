-- last 3 years data from  2023 to 2025  with borrower infomation --


SELECT DISTINCT
    -- Borrower information
    b.borrower_key,
    b.borrower_name,
    b.gender_key,
    b.borrower_age_bucket_key,
    b.pan,
    b.mobile_number,
    b.email,

    -- Date information
    d.date_key,
    d.month,
    d.year,
    d.yyyymm,
    d.month_name,
    d.quarter_num

FROM cns_fact_tbl f

INNER JOIN dim_borrower b
    ON f.borrower_key = b.borrower_key

INNER JOIN dim_date d
    ON f.repodt_yyyymm = d.yyyymm

WHERE f.repodt_yyyymm BETWEEN 202301 AND 202512

ORDER BY
    d.yyyymm,
    b.borrower_key;



-- extract last 3 years loan data for home loan --

SELECT
    F.fact_key,
    F.account_key,
    F.borrower_key,
    F.loan_account_type_key,

    -- Loan details
    T.loan_account,
    T.account_name,
    T.product_category,
    T.mof_class,

    -- Date details
    D.year,
    D.month,
    D.month_name,
    D.yyyymm,
    D.quarter,
    D.fy_label,

    -- Borrower information
    B.borrower_name,
    B.gender_key,
    B.birth_dt,
    B.borrower_age_bucket_key,
    B.occupation_key,
    B.income_level_key,
    B.ownership_ind_key,
    B.std_state_code,
    B.district,
    B.std_pin_code,

    -- Loan performance
    F.disb_yyyymm,
    F.repodt_yyyymm,
    F.mob,
    F.days_past_due,
    F.overdue_ind,
    F.active,
    F.total_disb_amount,
    F.total_outstanding_amount,
    F.total_overdue_amount,
    F.total_write_off_amount,
    F.installment_amount

FROM CNS_FACT_TBL F

LEFT JOIN DIM_LOAN_ACCOUNT_TYPE T
    ON F.loan_account_type_key = T.loan_account_type_key

LEFT JOIN DIM_BORROWER B
    ON F.borrower_key = B.borrower_key

LEFT JOIN DIM_DATE D
    ON F.repodt_yyyymm = D.yyyymm

WHERE F.loan_account_type_key = 6
  AND F.repodt_yyyymm BETWEEN 202401 AND 202608

ORDER BY
    D.yyyymm,
    B.borrower_key;