# TASKS

## 日历


```dataview
CALENDAR file.ctime
```

## 今天任务




```dataview
CALENDAR begin
FROM #类型/日记
```

```dataview
TASK
FROM "个人记录/日记"
WHERE file.cday=date(today) and !completed
```

## 全部任务

### 未完成

```dataview
TASK
WHERE !completed and !contains(file.path,"个人记录/日记")
```

### 已完成

```dataview
TASK
WHERE completed and !contains(file.path,"个人记录/日记")
GROUP BY 
```