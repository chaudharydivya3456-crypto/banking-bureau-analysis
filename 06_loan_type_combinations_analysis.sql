-- extract loan data for loan account type combination like 1+1, 1+2 so on --
SELECT DISTINCT
    f.borrower_key,
    1 AS loan_type_1,
    1 AS loan_type_2,
    '1 + 1' AS combination
FROM CNS_FACT_TBL f
JOIN CNS_FACT_TBL f2
    ON f.borrower_key = f2.borrower_key
WHERE f.loan_account_type_key = 1
  AND f2.loan_account_type_key = 1;
  
  -- this combination for home loan + personal loan --
  
  SELECT distinct
    f.borrower_key,
    b.borrower_name,
    b.gender_key,
    b.birth_dt,
    b.borrower_age_bucket_key,
    b.pan,
    b.email,
    b.occupation_key,
    
	f.loan_account_type_key AS loan_type_1,
    l1.account_name AS loan_account_1,

    f2.loan_account_type_key AS loan_type_2,
    l2.account_name AS loan_account_2,

    CONCAT(
        l1.account_name,
        ' + ',
        l2.account_name
    ) AS loan_combination

FROM CNS_FACT_TBL f

JOIN CNS_FACT_TBL f2
    ON f.borrower_key = f2.borrower_key
    
join dim_borrower b 
	on f.borrower_key=b.borrower_key

JOIN DIM_LOAN_ACCOUNT_TYPE l1
    ON f.loan_account_type_key = l1.loan_account_type_key

JOIN DIM_LOAN_ACCOUNT_TYPE l2
    ON f2.loan_account_type_key = l2.loan_account_type_key

WHERE f.loan_account_type_key = 6
  AND f2.loan_account_type_key = 12;
  
  -- three loan combination Auto Loan + Housing Loan + Personal Loan --
  
  select distinct
  f.borrower_key,
  
  b.borrower_name,
  b.gender_key,
  b.birth_dt,
  b.borrower_age_bucket_key,
  b.pan,
  b.mobile_number,
  b.email,
  b.occupation_key,
  
  -- loan 1
  f.loan_account_type_key as loan_type_1,
  l1.account_name as loan_account_1,
  
  -- loan 2
  f2.loan_account_type_key as loan_type_2,
  l2.account_name as loan_account_2,
  
  -- loan 3 
  f3.loan_account_type_key as loan_type_3,
  l3.account_name as loan_account_3,
  
  concat(
      l1.account_name,
      ' + ' ,
      l2.account_name,
      ' + ',
      l3.account_name
      
	) as loan_combination
    
    from cns_fact_tbl f 
    
    join cns_fact_tbl f2
         on f.borrower_key=f2.borrower_key
         
	join cns_fact_tbl f3 
		on f.borrower_key=f3.borrower_key
        
	join dim_borrower b 
        on f.borrower_key=b.borrower_key 
	
    join dim_loan_account_type l1
        on f.loan_account_type_key = l1.loan_account_type_key
        
	join dim_loan_account_type l2
         on f.loan_account_type_key=l2.loan_account_type_key
         
	join dim_loan_account_type l3
         on f.loan_account_type_key=l3.loan_account_type_key
         
    where f.loan_account_type_key = 5
	and f2.loan_account_type_key = 12
    and f3.loan_account_type_key = 12;
  
 -- 1+2 combination --
  
  select distinct
   f.borrower_key,
   
   b.borrower_name,
   b.gender_key,
   b.birth_dt,
   b.borrower_age_bucket_key,
   b.pan,
   b.mobile_number,
   b.email,
   b.occupation_key,
   
   f.loan_account_type_key as loan_type_1,
   l1.account_name as loan_account_1,
   
   f2.loan_account_type_key as loan_type_2,
   l2.account_name as loan_account_2,
   
   concat(
      l1.account_name,
      ' + ',
      l2.account_name
      
	)
    
    from cns_fact_tbl f 
    
    join cns_fact_tbl f2 
         on f.borrower_key=f2.borrower_key
         
	join dim_borrower b
          on f.borrower_key=b.borrower_key
          
	join dim_loan_account_type l1
        on f.loan_account_type_key=l1.loan_account_type_key
        
	join dim_loan_account_type l2 
        on f.loan_account_type_key=l2.loan_account_type_key
        
	where f.loan_account_type_key = 1
    and f2.loan_account_type_key =2;
    
    
    
    select distinct
   f.borrower_key,
   
   b.borrower_name,
   b.gender_key,
   b.birth_dt,
   b.borrower_age_bucket_key,
   b.pan,
   b.mobile_number,
   b.email,
   b.occupation_key,
   
   f.loan_account_type_key as loan_type_1,
   l1.account_name as loan_account_1,
   
   f2.loan_account_type_key as loan_type_2,
   l2.account_name as loan_account_2,
   
   concat(
      l1.account_name,
      ' + ',
      l2.account_name
      
	)
    
    from cns_fact_tbl f 
    
    join cns_fact_tbl f2 
         on f.borrower_key=f2.borrower_key
         
	join dim_borrower b
          on f.borrower_key=b.borrower_key
          
	join dim_loan_account_type l1
        on f.loan_account_type_key=l1.loan_account_type_key
        
	join dim_loan_account_type l2 
        on f.loan_account_type_key=l2.loan_account_type_key
        
        
	where f.loan_account_type_key = 4
    and f2.loan_account_type_key =3;
  
     
  
  