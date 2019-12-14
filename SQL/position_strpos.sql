
-- 练习：POSITION 和 STRPOS
-- 对于以下练习，需要用到 LEFT 和 RIGHT 以及 POSITION 或 STRPOS 知识。

-- 1. 使用 accounts 表格创建一个名字和姓氏列，用于存储 primary_poc 的名字和姓氏。
SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ') - 1) first_name,
       RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name
FROM modeanalytics.parch_and_posey_account


-- 2. 现在创建一个包含 sales_rep 表格中每个销售代表姓名的列，同样，需要提供名字和姓氏列。
SELECT LEFT(name, STRPOS(name, ' ') - 1) first_name,
       RIGHT(name, LENGTH(name) - STRPOS(name, ' ')) last_name
FROM modeanalytics.parch_and_posey_sales_rep
