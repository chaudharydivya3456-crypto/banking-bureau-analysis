-- 1. TOTAL ROW COUNT
-- Expected count from the previous validation: 49,890 rows

SELECT
    COUNT(*) AS total_records
FROM CNS_FACT_TBL;


-- 2. CHECK DUPLICATE FACT KEYS
-- fact_key should be unique if it is the primary key.

SELECT
    fact_key,
    COUNT(*) AS duplicate_count
FROM CNS_FACT_TBL
GROUP BY fact_key
HAVING COUNT(*) > 1;


-- 3. CHECK NULL VALUES IN IMPORTANT FACT COLUMNS

SELECT
    COUNT(*) AS total_records,

    SUM(CASE WHEN borrower_key IS NULL
        THEN 1 ELSE 0 END) AS null_borrower_key,

    SUM(CASE WHEN contributor_key IS NULL
        THEN 1 ELSE 0 END) AS null_contributor_key,

    SUM(CASE WHEN loan_account_type_key IS NULL
        THEN 1 ELSE 0 END) AS null_loan_type_key,

    SUM(CASE WHEN repodt_yyyymm IS NULL
        THEN 1 ELSE 0 END) AS null_reporting_period,

    SUM(CASE WHEN total_disb_amount IS NULL
        THEN 1 ELSE 0 END) AS null_disbursed_amount,

    SUM(CASE WHEN total_outstanding_amount IS NULL
        THEN 1 ELSE 0 END) AS null_outstanding_amount,

    SUM(CASE WHEN total_overdue_amount IS NULL
        THEN 1 ELSE 0 END) AS null_overdue_amount

FROM CNS_FACT_TBL;


-- 4. CHECK MISSING BORROWER REFERENCES
-- Every fact borrower key should exist in DIM_BORROWER.

SELECT
    COUNT(*) AS unmatched_borrower_records
FROM CNS_FACT_TBL f
LEFT JOIN DIM_BORROWER b
    ON f.borrower_key = b.borrower_key
WHERE b.borrower_key IS NULL;


-- 5. CHECK MISSING LOAN ACCOUNT TYPE REFERENCES

SELECT
    COUNT(*) AS unmatched_loan_type_records
FROM CNS_FACT_TBL f
LEFT JOIN DIM_LOAN_ACCOUNT_TYPE l
    ON f.loan_account_type_key = l.loan_account_type_key
WHERE l.loan_account_type_key IS NULL;


-- 6. CHECK MISSING CONTRIBUTOR REFERENCES

SELECT
    COUNT(*) AS unmatched_contributor_records
FROM CNS_FACT_TBL f
LEFT JOIN DIM_CONTRIBUTOR c
    ON f.contributor_key = c.contributor_key
WHERE c.contributor_key IS NULL;


-- 7. REPORTING PERIOD COVERAGE

SELECT
    MIN(repodt_yyyymm) AS earliest_reporting_period,
    MAX(repodt_yyyymm) AS latest_reporting_period,
    COUNT(DISTINCT repodt_yyyymm) AS distinct_reporting_periods
FROM CNS_FACT_TBL;


-- 8. RECORD COUNT BY REPORTING PERIOD
-- Helps identify unusually low or high monthly record counts.

SELECT
    repodt_yyyymm,
    COUNT(*) AS total_records
FROM CNS_FACT_TBL
GROUP BY repodt_yyyymm
ORDER BY repodt_yyyymm;


-- 9. CHECK INVALID REPORTING PERIODS
-- Valid YYYYMM values have months from 01 through 12.

SELECT
    repodt_yyyymm,
    COUNT(*) AS invalid_period_records
FROM CNS_FACT_TBL
WHERE repodt_yyyymm IS NOT NULL
  AND (
      repodt_yyyymm < 100001
      OR MOD(repodt_yyyymm, 100) NOT BETWEEN 1 AND 12
  )
GROUP BY repodt_yyyymm;


-- 10. CHECK NEGATIVE FINANCIAL VALUES
-- Review these records before deciding whether they are errors.
-- Negative values may sometimes be legitimate adjustments.

SELECT
    COUNT(*) AS negative_disbursed_records
FROM CNS_FACT_TBL
WHERE total_disb_amount < 0;


SELECT
    COUNT(*) AS negative_outstanding_records
FROM CNS_FACT_TBL
WHERE total_outstanding_amount < 0;


SELECT
    COUNT(*) AS negative_overdue_records
FROM CNS_FACT_TBL
WHERE total_overdue_amount < 0;


-- 11. CHECK DUPLICATE BORROWER AND REPORTING-PERIOD COMBINATIONS
-- This is an investigation check, not proof of duplicate records.
-- Multiple contributors or loan types may legitimately create
-- multiple records for the same borrower and reporting period.

SELECT
    borrower_key,
    repodt_yyyymm,
    COUNT(*) AS record_count
FROM CNS_FACT_TBL
GROUP BY
    borrower_key,
    repodt_yyyymm
HAVING COUNT(*) > 1
ORDER BY record_count DESC;


-- 12. CHECK NULL VALUES IN BORROWER DIMENSION

SELECT
    COUNT(*) AS total_borrowers,

    SUM(CASE WHEN borrower_key IS NULL
        THEN 1 ELSE 0 END) AS null_borrower_keys,

    SUM(CASE WHEN gender_key IS NULL
        THEN 1 ELSE 0 END) AS null_gender_keys,

    SUM(CASE WHEN birth_dt IS NULL
        THEN 1 ELSE 0 END) AS null_birth_dates,

    SUM(CASE WHEN borrower_age_bucket_key IS NULL
        THEN 1 ELSE 0 END) AS null_age_bucket_keys,

    SUM(CASE WHEN std_state_code IS NULL
        THEN 1 ELSE 0 END) AS null_state_codes

FROM DIM_BORROWER;


-- 13. CHECK DUPLICATE BORROWER DIMENSION KEYS
-- borrower_key should be unique if it is the dimension primary key.

SELECT
    borrower_key,
    COUNT(*) AS duplicate_count
FROM DIM_BORROWER
GROUP BY borrower_key
HAVING COUNT(*) > 1;


-- 14. CHECK LOAN ACCOUNT TYPE DIMENSION KEYS

SELECT
    loan_account_type_key,
    COUNT(*) AS duplicate_count
FROM DIM_LOAN_ACCOUNT_TYPE
GROUP BY loan_account_type_key
HAVING COUNT(*) > 1;


-- 15. FINAL FACT TABLE SUMMARY

SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT fact_key) AS distinct_fact_keys,
    COUNT(DISTINCT borrower_key) AS distinct_borrowers,
    COUNT(DISTINCT contributor_key) AS distinct_contributors,
    COUNT(DISTINCT loan_account_type_key) AS distinct_loan_types,
    COUNT(DISTINCT repodt_yyyymm) AS distinct_reporting_periods
FROM CNS_FACT_TBL;