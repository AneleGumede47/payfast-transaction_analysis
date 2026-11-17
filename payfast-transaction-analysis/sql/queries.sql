-- Question 1
SELECT
    c.TYPE_DESC AS Card_Type,
    COUNT(DISTINCT t.TRANS_NO) AS Unique_Transactions
FROM transactions t
JOIN card_type c ON t.CARD_TYPE = c.TYPE_CODE
WHERE t.DATE_START BETWEEN '2024-06-15 00:00:00' AND '2024-07-15 23:59:59'
GROUP BY c.TYPE_DESC
ORDER BY Unique_Transactions DESC;


-- Question 2
SELECT
    BANK,
    COUNT(*) AS Unique_Transactions,
    ROUND(SUM(AMOUNT_ZAR), 2) AS Total_Amount_ZAR
FROM (
    SELECT TRANS_NO, BANK, AMOUNT_ZAR,
           ROW_NUMBER() OVER (PARTITION BY TRANS_NO ORDER BY DATE_START, TRANS_ID) AS rn
    FROM transactions
) sub
WHERE rn = 1
GROUP BY BANK
ORDER BY Unique_Transactions DESC;


-- Question 3
SELECT
    COUNT(*) AS Total_VISA_Transactions,
    ROUND(SUM(AMOUNT_ZAR), 2) AS Total_ZAR
FROM (
    SELECT t.TRANS_NO, t.AMOUNT_ZAR,
           ROW_NUMBER() OVER (PARTITION BY t.TRANS_NO ORDER BY t.DATE_START, t.TRANS_ID) AS rn
    FROM transactions t
    JOIN card_type c ON t.CARD_TYPE = c.TYPE_CODE
    WHERE t.BANK = 'Bank Green'
      AND c.TYPE_DESC = 'VISA'
      AND t.DATE_START >= '2024-07-01'
      AND t.DATE_START < '2024-08-01') sub
WHERE rn = 1;


-- Question 4
SELECT
    COUNT(*) AS Successful_Transactions,
    ROUND(AVG(t.DURATION_SEC), 1) AS Avg_Seconds,
    ROUND(AVG(t.DURATION_SEC) / 60.0, 2) AS Avg_Minutes
FROM transactions t
JOIN transaction_type tt ON t.TRANSACTION_TYPE = tt.TRANSACTION_CODE
JOIN transaction_status ts ON t.TRANSACTION_STATUS = ts.TRANSACTION_STATUS
WHERE t.BANK = 'Bank Blue'
  AND tt.TRANSACTION_DESC = 'Settlement'
  AND ts.TRANSACTION_DESC = 'Paid'
  AND DATE(t.DATE_START) = '2024-07-25';
