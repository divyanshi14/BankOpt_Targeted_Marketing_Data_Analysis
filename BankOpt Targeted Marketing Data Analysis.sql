-- 1. Age Distribution of Clients

WITH table1 AS
(SELECT CASE
           WHEN age BETWEEN 18 AND 27 THEN '18-27'
		   WHEN age BETWEEN 28 AND 37 THEN '28-37'
		   WHEN age BETWEEN 38 AND 47 THEN '38-47'
		   WHEN age BETWEEN 48 AND 57 THEN '48-57'
		   WHEN age BETWEEN 58 AND 67 THEN '58-67'
		   WHEN age BETWEEN 68 AND 77 THEN '68-77'
		   WHEN age BETWEEN 78 AND 87 THEN '78-87'
		   WHEN age BETWEEN 88 AND 97 THEN '88-97'
		END AS Age_Range,
age FROM Bank)
SELECT Age_Range, Count(age) AS Count_of_Age FROM table1
GROUP BY Age_Range
Order BY Age_Range



-- 2. Term deposit subscription across different job type

WITH table2 AS
(SELECT job, COUNT(y) AS 'Subscribed' 
FROM Bank 
WHERE y = 'yes' 
GROUP BY job),

table3 AS
(SELECT job, COUNT(y) AS 'Not_Subscribed' 
FROM Bank 
WHERE y = 'no' 
GROUP BY job)

SELECT table2.job, table2.Subscribed, table3.Not_Subscribed
FROM table2
LEFT JOIN table3 
ON table2.job = table3.job



-- 3. How does having a personal loan or housing loan affect the likelihood of subscribing to a term deposit?	

WITH table4 AS
(SELECT CASE
            WHEN housing = 'yes' THEN 'Have taken House Loan'
			ELSE 'Have not taken House Loan'
        END AS 'Housing_Loan',
		y
 FROM Bank)
 SELECT Housing_Loan, COUNT(y) AS 'Subscribed Term Deposit'
 FROM table4
 WHERE y = 'yes'
 GROUP BY Housing_Loan



 --4 Term deposit subscription across different Education Level

 WITH table5 AS
(SELECT education, COUNT(y) AS 'Subscribed' 
FROM Bank 
WHERE y = 'yes' 
GROUP BY education),

table6 AS
(SELECT education, COUNT(y) AS 'Not_Subscribed' 
FROM Bank 
WHERE y = 'no' 
GROUP BY education)

SELECT table5.education, table5.Subscribed, table6.Not_Subscribed
FROM table5
LEFT JOIN table6
ON table5.education = table6.education



-- 5. Previous Campaign with subscription

WITH table5 AS
(SELECT poutcome, COUNT(y) AS 'Subscribed' 
FROM Bank 
WHERE y = 'yes' 
GROUP BY poutcome),

table6 AS
(SELECT poutcome, COUNT(y) AS 'Not_Subscribed' 
FROM Bank 
WHERE y = 'no' 
GROUP BY poutcome)

SELECT table5.poutcome, table5.Subscribed, table6.Not_Subscribed
FROM table5
LEFT JOIN table6
ON table5.poutcome = table6.poutcome



-- 6. Which method of contact leads to the highest subscription rates?		

SELECT contact, COUNT(y) AS 'Num_of_Subscription'
FROM Bank
WHERE y = 'yes'
GROUP BY contact



-- 7. In which month are clients most likely to subscribe?		

SELECT month, COUNT(y) AS 'Num_of_Subscription'
FROM Bank
WHERE y = 'yes'
GROUP BY month



--8. How does having a credit in default affect the likelihood of subscribing?		

WITH table7 AS
(SELECT CASE
            WHEN default1 = 'yes' THEN 'Client has Credit in Default'
			ELSE 'Client does not have Credit in Default'
        END AS 'Credit_in_Default',
		y
 FROM Bank)
 SELECT Credit_in_Default, COUNT(y) AS 'Subscribed Term Deposit'
 FROM table7
 WHERE y = 'yes'
 GROUP BY Credit_in_Default



 -- 9. Which combination of job type and education level has the highest subscription rate?		
 
WITH table5 AS
(SELECT job, COUNT(education) AS 'Primary1' FROM Bank WHERE y = 'yes' AND education = 'primary'
GROUP BY job),
table6 AS
(SELECT job, COUNT(education) AS 'Secondary' FROM Bank WHERE y = 'yes' AND education = 'secondary'
GROUP BY job),
table7 AS
(SELECT job, COUNT(education) AS 'Tertiary' FROM Bank WHERE y = 'yes' AND education = 'tertiary'
GROUP BY job),
table8 AS
(SELECT job, COUNT(education) AS 'Unknown' FROM Bank WHERE y = 'yes' AND education = 'unknown'
GROUP BY job)
SELECT table5.job, table5.Primary1, table6.Secondary, table7.Tertiary, table8.Unknown
FROM table5
LEFT JOIN table6 ON table5.job = table6.job
LEFT JOIN table7 ON table6.job = table7.job
LEFT JOIN table8 ON table7.job = table8.job



-- 10. Subsription as per Marital Status

SELECT marital AS Marital_Status, COUNT(y) AS Num_of_Subsciptions
FROM Bank
WHERE y = 'yes'
GROUP BY marital





