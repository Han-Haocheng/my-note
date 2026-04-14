HAVING语句是分组条件
可以使用HAVING短语指定选择条件。


查询有2门及以上课程成绩，并要求成绩大于88分的学生学号及课程数。
```mysql
SELECT studentNo,count(*) 课程数 FROM tb_score WHERE score>88 GROUP BY studentNo HAVING count(*)>=2;
```
 该SELECT查询语句先用WHERE子句筛选出成绩大于88分的记录，再对筛选出的记录用GROUP BY子句分组，分组时用HAVING短语限定2门及以上课程的分组条件。