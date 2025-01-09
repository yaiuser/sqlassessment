CREATE DATABASE userprogressdb;

USE userprogressdb;

-- 1. Analyse the data
-- Hint: use a SELECT statement via a JOIN to sample the data
-- ****************************************************************
-- user_id
SELECT u.*, p.* FROM users u JOIN progress p ON u.user_id = p.user_id;

-- 2. What are the Top 25 schools (.edu domains)?
-- Hint: use an aggregate function to COUNT() schools with most students
-- ****************************************************************
SELECT COUNT(u.email_domain) as "Number of students", u.email_domain AS "Domain name" FROM users u GROUP BY u.email_domain ORDER BY COUNT(u.email_domain) DESC LIMIT 25;

-- 3. How many .edu learners are located in New York?
-- Hint: use an aggregate function to COUNT() students in New York
-- ****************************************************************
SELECT COUNT(u.email_domain) as "Number of .edu learners from New York" from users u WHERE u.email_domain LIKE "%.edu" AND u.city = "New York";

-- 4. The mobile_app column contains either mobile-user or NULL. 
-- How many of these learners are using the mobile app?
-- Hint: COUNT()...WHERE...IN()...GROUP BY...
-- Hint: Alternate answers are accepted.
-- ****************************************************************
SELECT count(u.user_id) as "Number of learners using the mobile app" from users u WHERE u.mobile_app = "mobile-user" GROUP BY u.mobile_app;

-- 5. Query for the sign up counts for each hour.
-- Hint: https://dev.mysql.com/doc/refman/5.7/en/date-and-time-functions.html#function_date-format 
-- ****************************************************************
SELECT HOUR(u.sign_up_at) as "Hour", COUNT(HOUR(u.sign_up_at)) as "Number of Sign Ups" from users u GROUP BY HOUR(u.sign_up_at) ORDER BY HOUR(u.sign_up_at);

-- 6. What courses are the New Yorker Students taking?
-- Hint: SUM(CASE WHEN learn_cpp NOT IN('') THEN 1 ELSE 0 END) AS "New Yorker learners taking C++"
-- ****************************************************************
SELECT u.city, SUM(CASE WHEN p.learn_cpp NOT IN('') THEN 1 ELSE 0 END) AS "New Yorker learners taking C++" ,
SUM(CASE WHEN p.learn_sql NOT IN('') THEN 1 ELSE 0 END) AS "New Yorker learners taking SQL",
SUM(CASE WHEN p.learn_html NOT IN('') THEN 1 ELSE 0 END) AS "New Yorker learners taking HTML",
SUM(CASE WHEN p.learn_javascript NOT IN('') THEN 1 ELSE 0 END) AS "New Yorker learners taking Javascript",
SUM(CASE WHEN p.learn_java NOT IN('') THEN 1 ELSE 0 END) AS "New Yorker learners taking Java"
FROM users u JOIN progress p ON u.user_id = p.user_id WHERE u.city = "New York";

-- 7. What courses are the Chicago Students taking?
-- Hint: SUM(CASE WHEN learn_cpp NOT IN('') THEN 1 ELSE 0 END) AS "Chicago learners taking C++"
-- ****************************************************************
SELECT u.city, SUM(CASE WHEN p.learn_cpp NOT IN('') THEN 1 ELSE 0 END) AS "Chicago learners taking C++" ,
SUM(CASE WHEN p.learn_sql NOT IN('') THEN 1 ELSE 0 END) AS "Chicago learners taking SQL",
SUM(CASE WHEN p.learn_html NOT IN('') THEN 1 ELSE 0 END) AS "Chicago learners taking HTML",
SUM(CASE WHEN p.learn_javascript NOT IN('') THEN 1 ELSE 0 END) AS "Chicago learners taking Javascript",
SUM(CASE WHEN p.learn_java NOT IN('') THEN 1 ELSE 0 END) AS "Chicago learners taking Java"
FROM users u JOIN progress p ON u.user_id = p.user_id WHERE u.city = "Chicago";
