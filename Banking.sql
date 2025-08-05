CREATE DATABASE banking;
USE banking;

CREATE TABLE bank_basic (
  Transaction_ID INT PRIMARY KEY,
  CustomerId INT,
  Surname VARCHAR(255),
  CreditScore INT,
  Geography VARCHAR(50),
  Gender VARCHAR(10),
  Age INT
);

CREATE TABLE bank_account (
  Transaction_ID INT PRIMARY KEY,
  Tenure INT,
  Balance DECIMAL(12,2),
  NumOfProducts INT,
  HasCrCard BOOLEAN
);

CREATE TABLE bank_activity (
  Transaction_ID INT PRIMARY KEY,
  IsActiveMember BOOLEAN,
  EstimatedSalary DECIMAL(12,2),
  Exited BOOLEAN
);

Select * From bank_basic;

Select * From bank_account;

Select * from bank_activity;

SELECT COUNT(*) FROM bank_basic;

SELECT COUNT(*) FROM bank_activity;

SELECT COUNT(*) FROM bank_account;

SELECT *
FROM bank_basic AS bb
JOIN bank_account AS ba ON bb.Transaction_ID = ba.Transaction_ID
JOIN bank_activity AS bac ON bb.Transaction_ID = bac.Transaction_ID
LIMIT 10;

SELECT 
	bac.IsActiveMember,
    COUNT(*) AS Total_Customers,
    SUM(bac.Exited) AS Churned_Customers,
    ROUND(SUM(bac.Exited) * 100.0 / COUNT(*), 2) AS Churn_Rate_Percent
FROM bank_basic AS bb
JOIN bank_account AS ba ON bb.Transaction_ID = ba.Transaction_ID
JOIN bank_activity AS bac ON bb.Transaction_ID = bac.Transaction_ID
GROUP BY bac.IsActiveMember;    

SELECT 
	ba.NumOfProducts,
    COUNT(*) AS Total_Customers,
    SUM(bac.Exited) AS Churned_Customers,
    ROUND(SUM(bac.Exited) * 100.0 / COUNT(*), 2) AS Churn_Rate_Percent
FROM bank_basic AS bb
JOIN bank_account AS ba ON bb.Transaction_ID = ba.Transaction_ID
JOIN bank_activity AS bac ON bb.Transaction_ID = bac.Transaction_ID
GROUP BY ba.NumOfProducts
ORDER BY ba.NumOfProducts;

SELECT 
	bb.Geography,
    COUNT(*) AS Total_Customers,
	SUM(bac.Exited) AS Churned_Customers,
    ROUND(SUM(bac.Exited) * 100.0 / COUNT(*), 2) AS Churn_Rate_Percent
FROM bank_basic AS bb
JOIN bank_account AS ba ON bb.Transaction_ID = ba.Transaction_ID
JOIN bank_activity AS bac ON bb.Transaction_ID = bac.Transaction_ID
GROUP BY bb.Geography
ORDER BY Churn_Rate_Percent DESC;

SELECT 
    bb.Gender,
    ROUND(AVG(bb.CreditScore), 1) AS Avg_CreditScore,
    COUNT(*) AS Total_Customers,
    SUM(bac.Exited) AS Churned_Customers,
    ROUND(SUM(bac.Exited) * 100.0 / COUNT(*), 2) AS Churn_Rate_Percent
FROM bank_basic AS bb
JOIN bank_account AS ba ON bb.Transaction_ID = ba.Transaction_ID
JOIN bank_activity AS bac ON bb.Transaction_ID = bac.Transaction_ID
GROUP BY bb.Gender
ORDER BY Churn_Rate_Percent DESC;

CREATE VIEW bank_full_view AS
SELECT 
    bb.CustomerID,
    bb.Surname,
    bb.CreditScore,
    bb.Geography,
    bb.Gender,
    bb.Age,
    ba.Balance,
    ba.NumOfProducts,
    ba.HasCrCard,
    bac.IsActiveMember,
    bac.EstimatedSalary,
    bac.Exited
FROM bank_basic AS bb
JOIN bank_account AS ba ON bb.Transaction_ID = ba.Transaction_ID
JOIN bank_activity AS bac ON bb.Transaction_ID = bac.Transaction_ID;

SELECT * FROM bank_full_view LIMIT 10;