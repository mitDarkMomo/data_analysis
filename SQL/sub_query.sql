/*
 * 3. 对于购买标准纸张数量 (standard_qty) 最多的客户（在作为客户的整个时期内），
 * 有多少客户的购买总数依然更多？
 */

-- 1. 查询'客户，标准纸张数量，购买总数'
SELECT a.name account, SUM(o.standard_qty) total_standard, 
      SUM(o.total) total
FROM modeanalytics.parch_and_posey_account a
JOIN modeanalytics.parch_and_posey_orders o
ON a.id = o.account_id
GROUP BY 1

-- 2. 查询购买标准纸张最多的客户：购买总数
SELECT total
FROM
  (SELECT a.name account, SUM(o.standard_qty) total_standard, 
        SUM(o.total) total
  FROM modeanalytics.parch_and_posey_account a
  JOIN modeanalytics.parch_and_posey_orders o
  ON a.id = o.account_id
  GROUP BY 1) sub
ORDER BY total_standard DESC
LIMIT 1

-- 3. 查询购买总数比2更多的客户
SELECT *
FROM (
  SELECT a.name account, SUM(o.standard_qty) total_standard, 
      SUM(o.total) total
  FROM modeanalytics.parch_and_posey_account a
  JOIN modeanalytics.parch_and_posey_orders o
  ON a.id = o.account_id
  GROUP BY 1) t1
WHERE t1.total >=
  (SELECT total
    FROM
      (SELECT a.name account, SUM(o.standard_qty) total_standard, 
            SUM(o.total) total
      FROM modeanalytics.parch_and_posey_account a
      JOIN modeanalytics.parch_and_posey_orders o
      ON a.id = o.account_id
      GROUP BY 1) sub
    ORDER BY total_standard DESC
    LIMIT 1)

/*
 * 4. 对于（在作为客户的整个时期内）总消费 (total_amt_usd) 最多的客户，
 *他们在每个渠道上有多少 web_events？
 */
-- 1. 找到总消费最多的客户id
SELECT a.id id
FROM modeanalytics.parch_and_posey_account a
JOIN modeanalytics.parch_and_posey_orders o
ON a.id = o.account_id
GROUP BY 1
ORDER BY SUM(o.total_amt_usd) DESC
LIMIT 1

-- 2. 统计此客户每个渠道的计数
SELECT channel, COUNT(*) web_events_count
FROM modeanalytics.parch_and_posey_web_events w
GROUP BY w.account_id, 1
HAVING w.account_id = 
  (
  SELECT a.id id
  FROM modeanalytics.parch_and_posey_account a
  JOIN modeanalytics.parch_and_posey_orders o
  ON a.id = o.account_id
  GROUP BY 1
  ORDER BY SUM(o.total_amt_usd) DESC
  LIMIT 1
  )

/*
 * 5. 对于总消费前十名的客户，他们的平均终身消费 (total_amt_usd) 是多少?
 */
-- 1. 查询'总消费前十'
SELECT a.name account, SUM(o.total_amt_usd) total
FROM modeanalytics.parch_and_posey_account a
JOIN modeanalytics.parch_and_posey_orders o
ON a.id = o.account_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10

-- 2. 查询平均消费
SELECT AVG(total)
FROM
  (SELECT a.name account, SUM(o.total_amt_usd) total
  FROM modeanalytics.parch_and_posey_account a
  JOIN modeanalytics.parch_and_posey_orders o
  ON a.id = o.account_id
  GROUP BY 1
  ORDER BY 2 DESC
  LIMIT 10) sub

/*
 * 6. 比所有客户的平均消费高的企业平均终身消费 (total_amt_usd) 是多少？
 */
-- 1. 查询所有客户的总消费
SELECT SUM(o.total_amt_usd) total
FROM modeanalytics.parch_and_posey_account a
JOIN modeanalytics.parch_and_posey_orders o
ON a.id = o.account_id
GROUP BY a.name

-- 2. 求平均消费
SELECT AVG(total)
FROM
  (SELECT SUM(o.total_amt_usd) total
  FROM modeanalytics.parch_and_posey_account a
  JOIN modeanalytics.parch_and_posey_orders o
  ON a.id = o.account_id
  GROUP BY a.name) t2

-- 3. 1中比2高的企业终身消费
SELECT t1.total
FROM
  (SELECT SUM(o.total_amt_usd) total
  FROM modeanalytics.parch_and_posey_account a
  JOIN modeanalytics.parch_and_posey_orders o
  ON a.id = o.account_id
  GROUP BY a.name) t1
WHERE t1.total > 
  (SELECT AVG(total)
  FROM
    (SELECT SUM(o.total_amt_usd) total
    FROM modeanalytics.parch_and_posey_account a
    JOIN modeanalytics.parch_and_posey_orders o
    ON a.id = o.account_id
    GROUP BY a.name) t2)

-- 4. 平均终身消费
SELECT AVG(t3.total)
FROM
  (SELECT t1.total
  FROM
    (SELECT SUM(o.total_amt_usd) total
    FROM modeanalytics.parch_and_posey_account a
    JOIN modeanalytics.parch_and_posey_orders o
    ON a.id = o.account_id
    GROUP BY a.name) t1
  WHERE t1.total > 
    (SELECT AVG(total)
    FROM
      (SELECT SUM(o.total_amt_usd) total
      FROM modeanalytics.parch_and_posey_account a
      JOIN modeanalytics.parch_and_posey_orders o
      ON a.id = o.account_id
      GROUP BY a.name) t2)) t3