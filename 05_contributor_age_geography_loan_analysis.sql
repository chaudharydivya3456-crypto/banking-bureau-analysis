 -- extract loan data with contributor , age, sdp , with loan account type -- 
    select distinct
     b.borrower_name,
     b.gender_key,
     b.pan,
     b.mobile_number,
     b.email,
     
     d.date_key,
     d.month,
     d.year,
     d.month_name,
     d.yyyymm,
     d.quarter_num
     
     from cns_fact_tbl f 
     
     join dim_date d 
     on f.repodt_yyyymm=d.yyyymm
     
     left join dim_borrower b 
     on f.borrower_key=b.borrower_key
     
     where f.repodt_yyyymm between 202401 and 202512
     
     order by 
     d.yyyymm;
     
     
     select distinct
     b.borrower_key,
     b.borrower_name,
     b.gender_key,
     b.pan,
     b.mobile_number,
     b.email,
     
     c.contributor_key,
     c.contri_key,
     c.contributor_name,
     c.bureau_flag,
     
     d.date_key,
     d.month,
     d.year,
     d.yyyymm,
     d.month_name,
     d.quarter_num
     
     from cns_fact_tbl f 
     
     left join dim_borrower b 
     on f.borrower_key=b.borrower_key
     
     join dim_contributor c 
     on f.contributor_key= c.contributor_key
     
     join dim_date d 
     on f.repodt_yyyymm=d.yyyymm
     
     where f.repodt_yyyymm between 202401 and  202512 
     and c.contributor_key in (1,2,3)
     
     order by 
     d.yyyymm;
     
     
     select distinct
     
     b.borrower_key,
     b.borrower_name,
     b.gender_key,
     b.pan,
     b.mobile_number,
     b.email,
     
     d.date_key,
     d.month,
     d.year,
     d.yyyymm,
     d.quarter_num,
     
     c.contributor_key,
     c.contri_key,
     c.contributor_name,
     c.bureau_flag,
     
     a.borrower_age_bucket_key,
     a.code
     
     from cns_fact_tbl f 
     
     left join dim_borrower b 
     on f.borrower_key=b.borrower_key
     
     join dim_date d 
     on f.repodt_yyyymm=d.yyyymm
     
     join dim_contributor c 
     on f.contributor_key=c.contributor_key 
     
     join dim_borrower_age_bucket a 
     on f.borrower_age_bucket_key=a.borrower_age_bucket_key
     
     where f.repodt_yyyymm between 202401 and 202512
     and c.contributor_key in (1,2,3)
     and a.borrower_age_bucket_key in (3,4)
     
     order by 
     d.yyyymm,
     a.borrower_age_bucket_key;
     
     
     select distinct
     
     b.borrower_key,
     b.borrower_name,
     b.gender_key,
     b.pan,
     b.mobile_number,
     b.email,
     
     d.date_key,
     d.month,
     d.year,
     d.yyyymm,
     d.quarter_num,
     
     c.contributor_key,
     c.contri_key,
     c.contributor_name,
     c.bureau_flag,
     
     a.borrower_age_bucket_key,
     a.code,
     
     s.sdp_key,
     s.district,
     s.std_pin_code,
     s.std_state_code 
     
     from cns_fact_tbl f 
     
     left join dim_borrower b 
     on f.borrower_key = b.borrower_key 
     
    left join dim_date d 
     on f.repodt_yyyymm = d.yyyymm
     
    left join dim_contributor c 
     on f.contributor_key=c.contributor_key 
     
    left join dim_borrower_age_bucket a 
     on f.borrower_age_bucket_key = a.borrower_age_bucket_key 
     
    left join dim_sdp s 
     on f.sdp_key=s.sdp_key 
     
     where f.repodt_yyyymm between 202401 and 202512
     and c.contributor_key in (1,2,3)
     and a.borrower_age_bucket_key in (3,4)
     
     order by
     d.yyyymm,
     a.borrower_age_bucket_key,
     s.sdp_key;
     
     
     select distinct
     b.borrower_key,
     b.borrower_name,
     b.gender_key,
     b.pan,
     b.email,
     b.mobile_number,
     
     c.contributor_key,
     c.contri_key,
     c.contributor_name,
     c.bureau_flag,
     
     d.date_key,
     d.month,
     d.year,
     d.yyyymm,
     d.quarter_num,
     
     a.borrower_age_bucket_key,
     a.code,
     
     s.sdp_key,
     s.std_state_code,
     s.std_pin_code,
     s.district,
     
     l.loan_account_type_key,
     l.account_name,
     l.product_category,
     l.account_type_short_name
     
     from cns_fact_tbl f 
      
      left join dim_borrower b 
      on f.borrower_key=b.borrower_key 
      
      left join dim_date d 
      on f.repodt_yyyymm=d.yyyymm
      
      left join dim_contributor c 
      on f.contributor_key=c.contributor_key 
      
      left join dim_borrower_age_bucket a 
      on f.borrower_age_bucket_key = a.borrower_age_bucket_key 
      
      left join dim_sdp s 
      on f.sdp_key = s.sdp_key
      
      left join dim_loan_account_type l 
      on f.loan_account_type_key = l.loan_account_type_key
      
      where f.repodt_yyyymm between 202401 and 202512
      and f.contributor_key in (1,2,3)
      and f.borrower_age_bucket_key in (3,4)
      and f.loan_account_type_key in (7,10)
      
      order by
      d.yyyymm,
      c.contributor_key,
	  a.borrower_age_bucket_key,
      s.sdp_key,
      l.loan_account_type_key;
      
      
      SELECT COUNT(*) AS records_query_1
FROM
(
    SELECT DISTINCT
        b.borrower_key,
        b.borrower_name,
        b.gender_key,
        b.pan,
        b.mobile_number,
        b.email,

        d.date_key,
        d.month,
        d.year,
        d.yyyymm,
        d.quarter_num,

        c.contributor_key,
        c.contri_key,
        c.contributor_name,
        c.bureau_flag,

        a.borrower_age_bucket_key,
        a.code,

        s.sdp_key,
        s.district,
        s.std_pin_code,
        s.std_state_code

    FROM cns_fact_tbl f

    LEFT JOIN dim_borrower b
        ON f.borrower_key = b.borrower_key

    LEFT JOIN dim_date d
        ON f.repodt_yyyymm = d.yyyymm

    LEFT JOIN dim_contributor c
        ON f.contributor_key = c.contributor_key

    LEFT JOIN dim_borrower_age_bucket a
        ON f.borrower_age_bucket_key = a.borrower_age_bucket_key

    LEFT JOIN dim_sdp s
        ON f.sdp_key = s.sdp_key

    WHERE f.repodt_yyyymm BETWEEN 202401 AND 202512
      AND f.contributor_key IN (1,2,3)
      AND f.borrower_age_bucket_key IN (3,4)
) x;
      
      
        
     
     SELECT COUNT(*) AS records_query_2
FROM
(
    SELECT DISTINCT
        b.borrower_key,
        b.borrower_name,
        b.gender_key,
        b.pan,
        b.email,
        b.mobile_number,

        c.contributor_key,
        c.contri_key,
        c.contributor_name,
        c.bureau_flag,

        d.date_key,
        d.month,
        d.year,
        d.yyyymm,
        d.quarter_num,

        a.borrower_age_bucket_key,
        a.code,

        s.sdp_key,
        s.std_state_code,
        s.std_pin_code,
        s.district,

        l.loan_account_type_key,
        l.account_name,
        l.product_category,
        l.account_type_short_name

    FROM cns_fact_tbl f

    LEFT JOIN dim_borrower b
        ON f.borrower_key = b.borrower_key

    LEFT JOIN dim_date d
        ON f.repodt_yyyymm = d.yyyymm

    LEFT JOIN dim_contributor c
        ON f.contributor_key = c.contributor_key

    LEFT JOIN dim_borrower_age_bucket a
        ON f.borrower_age_bucket_key = a.borrower_age_bucket_key

    LEFT JOIN dim_sdp s
        ON f.sdp_key = s.sdp_key

    LEFT JOIN dim_loan_account_type l
        ON f.loan_account_type_key = l.loan_account_type_key

    WHERE f.repodt_yyyymm BETWEEN 202401 AND 202512
      AND f.contributor_key IN (1,2,3)
      AND f.borrower_age_bucket_key IN (3,4)
      AND f.loan_account_type_key IN (7,10)
) x;
     
    SELECT
    f.loan_account_type_key,
    l.account_name,
    COUNT(*) AS records,
    COUNT(DISTINCT f.borrower_key) AS unique_borrowers
FROM cns_fact_tbl f

LEFT JOIN dim_loan_account_type l
    ON f.loan_account_type_key = l.loan_account_type_key

WHERE f.repodt_yyyymm BETWEEN 202401 AND 202512
  AND f.contributor_key IN (1,2,3)
  AND f.borrower_age_bucket_key IN (3,4)

GROUP BY
    f.loan_account_type_key,
    l.account_name

ORDER BY
    f.loan_account_type_key;
    
    
    
    SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT borrower_key) AS borrowers,
    COUNT(DISTINCT contributor_key) AS contributors,
    COUNT(DISTINCT borrower_age_bucket_key) AS age_buckets,
    COUNT(DISTINCT sdp_key) AS sdps
FROM cns_fact_tbl
WHERE repodt_yyyymm BETWEEN 202401 AND 202512;
    
    
    SELECT
    contributor_key,
    borrower_age_bucket_key,
    sdp_key,
    COUNT(*) AS records
FROM cns_fact_tbl
WHERE repodt_yyyymm BETWEEN 202401 AND 202512
  AND contributor_key IN (1,2,3)
  AND borrower_age_bucket_key IN (3,4)
GROUP BY
    contributor_key,
    borrower_age_bucket_key,
    sdp_key
ORDER BY
    contributor_key,
    borrower_age_bucket_key,
    sdp_key;
    
    
    
    
    -- verify and check output--
    
    SELECT
    MIN(repodt_yyyymm) AS min_period,
    MAX(repodt_yyyymm) AS max_period,
    COUNT(*) AS total_records
FROM cns_fact_tbl
WHERE repodt_yyyymm BETWEEN 202401 AND 202512;

-- Step 2 — Check contributors-- 
SELECT
    f.contributor_key,
    c.contributor_name,
    COUNT(*) AS total_records,
    COUNT(DISTINCT f.borrower_key) AS unique_borrowers
FROM cns_fact_tbl f

LEFT JOIN dim_contributor c
    ON f.contributor_key = c.contributor_key

WHERE f.repodt_yyyymm BETWEEN 202401 AND 202512
  AND f.contributor_key IN (1,2,3)

GROUP BY
    f.contributor_key,
    c.contributor_name

ORDER BY
    f.contributor_key;
    
    -- Step 3 — Check age buckets--
    SELECT
    f.borrower_age_bucket_key,
    a.code AS age_bucket_code,
    COUNT(*) AS total_records,
    COUNT(DISTINCT f.borrower_key) AS unique_borrowers
FROM cns_fact_tbl f

LEFT JOIN dim_borrower_age_bucket a
    ON f.borrower_age_bucket_key = a.borrower_age_bucket_key

WHERE f.repodt_yyyymm BETWEEN 202401 AND 202512
  AND f.contributor_key IN (1,2,3)
  AND f.borrower_age_bucket_key IN (3,4)

GROUP BY
    f.borrower_age_bucket_key,
    a.code

ORDER BY
    f.borrower_age_bucket_key;
    
    -- Step 4 — Check loan account types--
    SELECT
    f.loan_account_type_key,
    l.loan_account,
    l.account_name,
    l.product_category,
    l.account_type_short_name,
    COUNT(*) AS total_records,
    COUNT(DISTINCT f.borrower_key) AS unique_borrowers
FROM cns_fact_tbl f

LEFT JOIN dim_loan_account_type l
    ON f.loan_account_type_key = l.loan_account_type_key

WHERE f.repodt_yyyymm BETWEEN 202401 AND 202512
  AND f.contributor_key IN (1,2,3)
  AND f.borrower_age_bucket_key IN (3,4)
  AND f.loan_account_type_key IN (7,10)

GROUP BY
    f.loan_account_type_key,
    l.loan_account,
    l.account_name,
    l.product_category,
    l.account_type_short_name

ORDER BY
    f.loan_account_type_key;
    
    -- Step 5 — Check the combination of all filters--
    SELECT
    f.contributor_key,
    f.borrower_age_bucket_key,
    f.loan_account_type_key,
    COUNT(*) AS total_records,
    COUNT(DISTINCT f.borrower_key) AS unique_borrowers
FROM cns_fact_tbl f

WHERE f.repodt_yyyymm BETWEEN 202401 AND 202512
  AND f.contributor_key IN (1,2,3)
  AND f.borrower_age_bucket_key IN (3,4)
  AND f.loan_account_type_key IN (7,10)

GROUP BY
    f.contributor_key,
    f.borrower_age_bucket_key,
    f.loan_account_type_key

ORDER BY
    f.contributor_key,
    f.borrower_age_bucket_key,
    f.loan_account_type_key;
    
    SELECT
    f.borrower_key,
    b.borrower_name,
    COUNT(*) AS record_count
FROM cns_fact_tbl f

LEFT JOIN dim_borrower b
    ON f.borrower_key = b.borrower_key

WHERE f.repodt_yyyymm BETWEEN 202401 AND 202512
  AND f.contributor_key IN (1,2,3)
  AND f.borrower_age_bucket_key IN (3,4)
  AND f.loan_account_type_key IN (7,10)

GROUP BY
    f.borrower_key,
    b.borrower_name

HAVING COUNT(*) > 1

ORDER BY record_count DESC;