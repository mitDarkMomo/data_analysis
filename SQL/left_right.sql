-- 在 accounts 表格中，有一个列存储的是每个公司的网站。
-- 最后三个数字表示他们使用的是什么类型的网址。此处给出了扩展（和价格）列表。
-- 请获取这些扩展并得出 accounts 表格中每个网址类型的存在数量。
SELECT RIGHT(website, 3), COUNT(RIGHT(website, 3))
FROM modeanalytics.parch_and_posey_account AS a
GROUP BY 1

-- 对于公司名称（甚至名称的第一个字母）的作用存在颇多争议 
-- - https://www.entrepreneur.com/article/237643 。
-- 请从 accounts 表格中获取每个公司名称的第一个字母，看看以每个字母（数字）开头的公司名称分布情况。
SELECT LEFT(name, 1) first_, COUNT(LEFT(name, 1))
FROM modeanalytics.parch_and_posey_account AS a
GROUP BY 1
ORDER BY 1

-- 使用 accounts 表格和 CASE 语句创建两个群组：
--   一个是以数字开头的公司名称群组，另一个是以字母开头的公司名称群组。
-- 以字母开头的公司名称所占的比例是多少？
WITH t1 AS
  (SELECT name,
          CASE
              WHEN LEFT(name, 1) BETWEEN '0' AND '9' THEN 1
              ELSE 0
          END AS num,
          CASE
              WHEN LEFT(name, 1) BETWEEN '0' AND '9' THEN 0
              ELSE 1
          END AS letter
   FROM modeanalytics.parch_and_posey_account AS a
   ORDER BY 1)
SELECT SUM(num) num,
       SUM(letter) letter
FROM t1

-- 元音是指 a、e、i、o 和 u。
-- 有多少比例的公司名称以元音开头，以其他音节开头的公司名称百分比是多少？
WITH t1 AS
  (SELECT name,
    CASE WHEN LEFT(LOWER(name), 1) IN ('a', 'e', 'i', 'o', 'u') THEN 1
      ELSE 0 END AS vowel,
    CASE WHEN LEFT(LOWER(name), 1) IN ('a', 'e', 'i', 'o', 'u') THEN 0
      ELSE 1 END AS not_vowel
  FROM modeanalytics.parch_and_posey_account)

SELECT SUM(vowel), SUM(not_vowel)
FROM t1