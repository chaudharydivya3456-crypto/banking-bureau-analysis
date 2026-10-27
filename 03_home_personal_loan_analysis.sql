-- extract data for home loan for last 3 years for home loan and personal loan  ---

SELECT *
FROM cns_fact_tbl
WHERE loan_account_type_key = 6
  AND disb_yyyymm BETWEEN 202401 AND 202612;
  
  
SELECT *
FROM cns_fact_tbl
WHERE loan_account_type_key = 12
  AND disb_yyyymm BETWEEN 202401 AND 202612;



select count(*) as total_home_loan_application
from cns_fact_tbl
where loan_account_type_key=6
and disb_yyyymm BETWEEN 202401 AND 202612;



select count(*) as total_personal_loan_application
from cns_fact_tbl
where loan_account_type_key=12
and disb_yyyymm BETWEEN 202401 AND 202612;

  
-- extract last 3 year for home loan and personal loan with borrower information--

    
 SELECT
    -- Loan details
    F.fact_key,
    F.account_key,
    F.borrower_key,
    F.loan_account_type_key,
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
left JOIN DIM_LOAN_ACCOUNT_TYPE T
    ON F.loan_account_type_key = T.LOAN_ACCOUNT_TYPE_KEY
left JOIN DIM_BORROWER B
    ON F.borrower_key = B.borrower_key
left JOIN DIM_DATE D
    ON F.repodt_yyyymm = D.yyyymm
WHERE F.loan_account_type_key IN (6, 12)
  AND F.repodt_yyyymm BETWEEN 202401 AND 202608
ORDER BY
    d.yyyymm,
    T.loan_account_type_key,
    b.borrower_key;




SELECT
    F.loan_account_type_key,
    T.loan_account,
    T.account_name,
    COUNT(DISTINCT F.borrower_key) AS total_borrowers
FROM CNS_FACT_TBL F

LEFT JOIN DIM_LOAN_ACCOUNT_TYPE T
    ON F.loan_account_type_key = T.loan_account_type_key

WHERE F.loan_account_type_key IN (6, 12)
  AND F.repodt_yyyymm BETWEEN 202401 AND 202608

GROUP BY
    F.loan_account_type_key,
    T.loan_account,
    T.account_name

ORDER BY
    F.loan_account_type_key;
    
    
