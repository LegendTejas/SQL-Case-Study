/*
1. Detecting Suspicious Transactions (Window Functions)

Find transactions that are much higher than the customer’s average in the last 30 days.
(Here we consider transactions that are > 2x average amount as suspicious.)
*/

WITH customer_avg AS (
    SELECT 
        t.AccountID,
        AVG(t.Amount) AS avg_amount
    FROM Transactions t
    WHERE t.TransactionTime >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
    GROUP BY t.AccountID
)
SELECT 
    t.TransactionID,
    t.AccountID,
    t.Amount,
    ca.avg_amount,
    CASE 
        WHEN t.Amount > 2 * ca.avg_amount THEN 'Suspicious'
        ELSE 'Normal'
    END AS Fraud_Flag
FROM Transactions t
JOIN customer_avg ca ON t.AccountID = ca.AccountID
WHERE t.TransactionTime >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);


/*
2. Customer Spending Trend – Rolling 7-Day Average

Calculate 7-day moving average spending per customer.
*/

SELECT 
    a.CustomerID,
    DATE(t.TransactionTime) AS txn_date,
    SUM(t.Amount) AS daily_spending,
    AVG(SUM(t.Amount)) OVER (
        PARTITION BY a.CustomerID 
        ORDER BY DATE(t.TransactionTime) 
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS rolling_7day_avg
FROM Transactions t
JOIN Accounts a ON t.AccountID = a.AccountID
GROUP BY a.CustomerID, DATE(t.TransactionTime)
ORDER BY a.CustomerID, txn_date;


/*
3. Ranking High-Spending Customers

Identify top 5% of customers based on their total transaction value.
*/

WITH customer_total AS (
    SELECT 
        a.CustomerID,
        SUM(t.Amount) AS total_spending
    FROM Transactions t
    JOIN Accounts a ON t.AccountID = a.AccountID
    GROUP BY a.CustomerID
),
ranked AS (
    SELECT 
        CustomerID,
        total_spending,
        NTILE(20) OVER (ORDER BY total_spending DESC) AS percentile_rank
    FROM customer_total
)
SELECT CustomerID, total_spending
FROM ranked
WHERE percentile_rank = 1
ORDER BY total_spending DESC;


/*
4. Time-Based Fraud Detection – Location Change

Detect transactions where a customer purchased in two different locations within 1 hour.
*/

SELECT 
    t1.TransactionID AS txn1,
    t1.AccountID,
    t1.Location AS location1,
    t1.TransactionTime AS time1,
    t2.TransactionID AS txn2,
    t2.Location AS location2,
    t2.TransactionTime AS time2
FROM Transactions t1
JOIN Transactions t2 
    ON t1.AccountID = t2.AccountID
   AND t1.TransactionID < t2.TransactionID
   AND TIMESTAMPDIFF(MINUTE, t1.TransactionTime, t2.TransactionTime) <= 60
   AND t1.Location <> t2.Location
ORDER BY t1.AccountID, t1.TransactionTime;
