-- 提供每个区域拥有最高销售额 (total_amt_usd) 的销售代表的姓名。
-- 1. 按每个区域、每个销售代表查询的销售额汇总
-- 2. 在1中查询最高销售额
-- 3. 1 JOIN 2，查询区域和姓名
WITH table1 AS (SELECT r.name region, s.name sales_rep, SUM(o.total_amt_usd) total
FROM modeanalytics.parch_and_posey_region r
JOIN modeanalytics.parch_and_posey_sales_rep s
ON r.id = s.region_id
JOIN modeanalytics.parch_and_posey_account a
ON s.id = a.sales_rep_id
JOIN modeanalytics.parch_and_posey_orders o
ON a.id = o.account_id
GROUP BY 1, 2),

table2 AS (SELECT region, MAX(total)
FROM table1
GROUP BY 1)

SELECT table1.region, table1.sales_rep
FROM table1
JOIN table2
ON table1.region = table2.region AND table1.total = table2.max

-- 对于具有最高销售额 (total_amt_usd) 的区域，总共下了多少个订单？
-- 1. 按区域查询销售额汇总、总订单计数
-- 2. 在 1 中查询最高销售额
-- 3. 1 JOIN 2，查询区域和总订单计数
WITH table1 AS (SELECT r.name region, SUM(o.total_amt_usd) total, COUNT(o.*) order_counts
FROM modeanalytics.parch_and_posey_region r
JOIN modeanalytics.parch_and_posey_sales_rep s
ON r.id = s.region_id
JOIN modeanalytics.parch_and_posey_account a
ON s.id = a.sales_rep_id
JOIN modeanalytics.parch_and_posey_orders o
ON a.id = o.account_id
GROUP BY 1),

table2 AS (SELECT region, total
FROM table1
ORDER BY total DESC
LIMIT 1)

SELECT table1.region, table1.order_counts
FROM table1
JOIN table2
ON table1.region = table2.region


-- 对于购买标准纸张数量 (standard_qty) 最多的客户（在作为客户的整个时期内），
-- 有多少客户的购买总数（total）比该用户的购买总数（total）更多？
-- 1. 按客户查询标准纸张数量以及购买总数
-- 2. 在 1 中查询标准纸张数量最多的客户的购买总数
-- 3. 在 1 中查询比 2 的购买总数更多的客户
WITH table1 AS
  (SELECT a.name account, SUM(o.standard_qty) standard, SUM(o.total) total
  FROM modeanalytics.parch_and_posey_account a
  JOIN modeanalytics.parch_and_posey_orders o
  ON a.id = o.account_id
  GROUP BY 1)

SELECT account
FROM table1
WHERE total >
  (SELECT total
  FROM table1
  ORDER BY standard DESC
  LIMIT 1)

-- 对于（在作为客户的整个时期内）总消费 (total_amt_usd) 最多的客户，他们在每个渠道上有多少 web_events？
-- 1. 查找总消费最多的客户
-- 2. 按客户和渠道查询 web_events
-- 3. 在 2 中查找满足 1 的
-- 查询最高销售额的区域
WITH t1 AS
  (SELECT a.name, SUM(o.total_amt_usd) total
  FROM modeanalytics.parch_and_posey_orders o
  JOIN modeanalytics.parch_and_posey_account a
    ON a.id = o.account_id
  GROUP BY 1
  ORDER BY 2 DESC
  LIMIT 1),
t2 AS
  (SELECT a.name, w.channel, COUNT(*) web_count
  FROM modeanalytics.parch_and_posey_account a
  JOIN modeanalytics.parch_and_posey_web_events w
  ON a.id = w.account_id
  GROUP BY 1, 2)

SELECT *
FROM t2
JOIN t1
ON t2.name = t1.name

-- 对于总消费前十名的客户，他们的平均终身消费 (total_amt_usd) 是多少?

-- 比所有客户的平均消费高的企业平均终身消费 (total_amt_usd) 是多少？
