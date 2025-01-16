SELECT name AS DatabaseName 
FROM sys.databases;

USE [Bank Loan DB];
GO

select * from bank_loan_data

select count(id) as Total_Loan_Application from bank_loan_data

select count(id) as MTD_Total_Loan_Application from bank_loan_data
where MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

select sum(loan_amount) as MTD_Total_Funded_Amount from bank_loan_data
where MONTH(issue_date) = 12 AND YEAR(issue_date)=2021

select sum(loan_amount) as PMTD_Total_Funded_Amount from bank_loan_data
where MONTH(issue_date) = 11 AND year(issue_date)= 2021

select sum(total_payment) as MTD_Total_Amount_Recieved from bank_loan_data
where MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

select sum(total_payment) as PMTD_Total_Amount_Recieved from bank_loan_data
where MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

select round(avg(int_rate),4) *100 as Avg_Interest_Rate from bank_loan_data

select round(avg(int_rate),4) *100 as MTD_Avg_Interest_Rate from bank_loan_data
where MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

select round(avg(int_rate),4) *100 as PMTD_Avg_Interest_Rate from bank_loan_data
where MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

select avg(dti) * 100 as MTD_Avg_DTI from bank_loan_data
where MONTH(issue_date) = 12 And year(issue_date) = 2021

select avg(dti) * 100 as PMTD_Avg_DTI from bank_loan_data
where MONTH(issue_date) = 11 And year(issue_date) = 2021

-- Good Loan percentage
select
      (count(case when loan_status = 'Fully Paid' or loan_status = 'Current' then id end)*100)
	  /
	  count(id) as Good_Loan_Percentage
from bank_loan_data

select count(id) as Total_Good_Loan_Application from bank_loan_data
where loan_status = 'Fully Paid' Or loan_status = 'Current'

select sum(total_payment) as Good_Loan_Amount_Received from bank_loan_data
where loan_status = 'Fully Paid' Or loan_status = 'Current'

-- Bad loan
select 
(count(case when loan_status = 'Charged Off' then id end)*100) / 
count(id) as Bad_Loan_Percentage
from bank_loan_data

select sum(total_payment) as Bad_Loan_Recieved_Amount from bank_loan_data
where loan_status = 'Charged Off'

select
        loan_status,
		count(id) as Total_Loan_Application,
		sum(total_payment) as Total_Amount_Recieved,
		sum(loan_amount) as Total_Funded_Amount,
		Avg(int_rate*100) as Interest_Rate,
		AVG(dti*100) as DTI
		from bank_loan_data
		group by loan_status

select
        loan_status,
		sum(total_payment) as MTD_Total_Amount_Recieved,
		sum(loan_amount) as MTD_Total_Funded_Amount
		from bank_loan_data
		where MONTH(issue_date) = 12
		group by loan_status

select 
       MONTH(issue_date) as Month_Number,
       DATENAME(MONTH, issue_date) as Month_Name,
	   count(id) as Total_Loan_Application,
	   sum(loan_amount) as Total_Funded_Amount,
	   sum(total_payment) as Total_Amount_Recieved
from bank_loan_data
-- if we taking dimensions or calculating aggregation then we have to use group by
group by month(issue_date),DATENAME(MONTH, issue_date)
order by MONTH(issue_date)

select 
      address_state,
	  count(id) as Total_Loan_Application,
	  sum(loan_amount) as Total_Funded_Amount,
	  sum(total_payment) as Total_Recieved_Amount
from bank_loan_data
group by address_state
order by address_state

select 
      address_state,
	  count(id) as Total_Loan_Application,
	  sum(loan_amount) as Total_Funded_Amount,
	  sum(total_payment) as Total_Recieved_Amount
from bank_loan_data
group by address_state
order by count(id) desc

select 
      address_state,
	  count(id) as Total_Loan_Application,
	  sum(loan_amount) as Total_Funded_Amount,
	  sum(total_payment) as Total_Recieved_Amount
from bank_loan_data
group by address_state
order by sum(loan_amount) desc

select 
      term,
	  count(id) as Total_Loan_Application,
	  sum(loan_amount) as Total_Funded_Amount,
	  sum(total_payment) as Total_Recieved_Amount
from bank_loan_data
group by term
order by term

select 
      purpose,
	  count(id) as Total_Loan_Application,
	  sum(loan_amount) as Total_Funded_Amount,
	  sum(total_payment) as Total_Recieved_Amount
from bank_loan_data
group by purpose
order by purpose

select 
      home_ownership,
	  count(id) as Total_Loan_Application,
	  sum(loan_amount) as Total_Funded_Amount,
	  sum(total_payment) as Total_Recieved_Amount
from bank_loan_data
group by home_ownership
order by home_ownership
