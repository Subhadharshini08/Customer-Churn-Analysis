USE churn_analysis;

SELECT COUNT(*) AS total_rows 
FROM telco_customer_cleaned;

-- OVERALL CHURN RATE
select count(*) as total_customers,
sum(case when churn="Yes" then 1 else 0 end) as churned,
round(sum(case when churn ="Yes" then 1 else 0 end)*100.0/count(*),2) as churn_rate
from telco_customer_cleaned;

-- CHURN BY CONTRACT TYPE
select contract,count(*) as total_customers,
sum(case when churn="Yes" then 1 else 0 end) as churned,
round(sum(case when churn="Yes" then 1 else 0 end)*100.0/count(*),2) as churn_rate
from telco_customer_cleaned
group by contract
order by churn_rate desc;

-- CHURN BY INTERNET SERVICE
select InternetService,count(*) as total_customers,
sum(case when churn="Yes" then 1 else 0 end) as churned,
round(sum(case when churn="Yes" then 1 else 0 end)*100.0/count(*),2) as churn_rate
from telco_customer_cleaned
group by InternetService
order by churn_rate desc;

-- CHURN BY PAYMENT METHOD
select PaymentMethod,count(*) as total_customers,
sum(case when churn="Yes" then 1 else 0 end) as churned,
round(sum(case when churn="Yes" then 1 else 0 end)*100.0/count(*),2) as churn_rate
from telco_customer_cleaned
group by PaymentMethod
order by churn_rate desc;

-- CHURN BY SENIOR CITIZEN
select SeniorCitizen,count(*) as total_customers,
sum(case when churn="Yes" then 1 else 0 end) as churned,
round(sum(case when churn="Yes" then 1 else 0 end)*100.0/count(*),2) as churn_rate
from telco_customer_cleaned
group by SeniorCitizen
order by churn_rate desc;

-- AVG MONTHLY CHARGES FOR CHURNED vs NON-CHURNED
select Churn,
round(avg(MonthlyCharges),2) as avg_monthly_charges,
round(avg(tenure),2) as avg_tenure_months
from telco_customer_cleaned
group by churn;

-- TOP 5 HIGH RISK CUSTOMERS
select ï»¿customerID,MonthlyCharges,tenure,Contract,Churn
from telco_customer_cleaned
where Churn="Yes" and MonthlyCharges>70 and tenure<12
order by MonthlyCharges desc 
limit 5;

-- CHURN BY CONTRACT TYPE AND INTERNET SERVICE
select Contract,InternetService,
round(avg(MonthlyCharges),2) as avg_charges,
count(*) as total_customers,
sum(case when Churn="Yes" then 1 else 0 end) as churned
from telco_customer_cleaned
group by Contract,InternetService
order by churned desc;


