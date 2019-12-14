-- 练习：CONCAT
-- 1. accounts 表格中的每个客户都想为每个 primary_poc 创建一个电子邮箱。
-- 邮箱应该是 primary_poc 的名字.primary_poc的姓氏@公司名称.com。
WITH t1 AS
  (SELECT name,
          primary_poc,
          LEFT(primary_poc, STRPOS(primary_poc, ' ') - 1) first_name,
          RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name
   FROM modeanalytics.parch_and_posey_account)
SELECT first_name || '.'|| LEFT(last_name, LENGTH(last_name) - 1) || '@' || name || '.com' email
FROM t1

-- 2. 你可能注意到了，在上一个答案中，有些公司名称存在空格，肯定不适合作为邮箱地址。
-- 看看你能否通过删掉客户名称中的所有空格来创建合适的邮箱地址，否则你的答案就和问题 1. 的一样。
-- 此处是一些实用的文档。
WITH t1 AS
  (SELECT name,
          primary_poc,
          LEFT(primary_poc, STRPOS(primary_poc, ' ') - 1) first_name,
          RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name
   FROM modeanalytics.parch_and_posey_account)
SELECT first_name || '.'|| LEFT(last_name, LENGTH(last_name) - 1) || '@' || REPLACE(name, ' ', '') || '.com' email
FROM t1

-- 3. 我们还需要创建初始密码，在用户第一次登录时将更改。
-- 初始密码将是 primary_poc 的名字的第一个字母（小写），
-- 然后依次是名字的最后一个字母（小写）、姓氏的第一个字母（小写）、姓氏的最后一个字母（小写）、
-- 名字的字母数量、姓氏的字母数量，
-- 然后是合作的公司名称（全大写，没有空格）
WITH t1 AS
  (SELECT name,
          primary_poc,
          LEFT(primary_poc, STRPOS(primary_poc, ' ') - 1) first_name,
          REPLACE(RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')), ' ', '') last_name
   FROM modeanalytics.parch_and_posey_account)
SELECT CONCAT(LEFT(LOWER(first_name), 1), RIGHT(LOWER(first_name), 1), LEFT(LOWER(first_name), 1), RIGHT(LOWER(last_name), 1), LENGTH(first_name), LENGTH(last_name), UPPER(REPLACE(name, ' ', ''))) passwd
FROM t1
