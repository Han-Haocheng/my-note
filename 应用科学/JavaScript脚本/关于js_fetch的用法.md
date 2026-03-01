---
tags: []
begin: none
---
# 日记

## 关于js_fetch的用法

```js
faction fetch(resource);
faction fetch(resource, options);
```

- `resource`：定义你想要获取的资源
	- 一个字符串或任何其他具有`字符串化器`的对象（包括 `URL` 对象），提供你想要获取的资源的 URL。URL 可以是相对于基础 URL 的，基础 URL 是窗口上下文中文档的 `baseURI` 或者 worker 上下文中的 `WorkerGlobalScope.location`。
- 一个 `Request`对象
- `options` 可选

一个包含你想要应用到请求上的任何自定义设置的 `RequestInit`](https://developer.mozilla.org/en-US/docs/Web/API/RequestInit%20"此页面目前仅提供英文版本".md) 对象。