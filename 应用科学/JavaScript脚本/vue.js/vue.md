---
tags:
  - 计算机/编程/前端
begin: 2024-04-20 13:18
---

# 目录

- [1.1 创建一个vue应用](应用科学/JavaScript脚本/vue.js/1.1%20创建一个vue应用.md)
- [1.2 模板语法](应用科学/JavaScript脚本/vue.js/1.2%20模板语法.md)
- [1.3 响应式基础](应用科学/JavaScript脚本/vue.js/1.3%20响应式基础.md)
- [1.4 计算属性](应用科学/JavaScript脚本/vue.js/1.4%20计算属性.md)
- [1.5 Class与Style绑定](应用科学/JavaScript脚本/vue.js/1.5%20Class与Style绑定.md)
- [1.6 条件渲染](应用科学/JavaScript脚本/vue.js/1.6%20条件渲染.md)
- [1.7 列表渲染](应用科学/JavaScript脚本/vue.js/1.7%20列表渲染.md)
- [1.8 事件处理](应用科学/JavaScript脚本/vue.js/1.8%20事件处理.md)

# 简介

vue是渐进式js前端框架，用于构建用户界面，基于标准 HTML、CSS 和 JavaScript 构建，提供了一套声明式的、组件化的编程模型

## 核心功能

- **声明式渲染**：Vue 基于标准 HTML 拓展了一套模板语法，使得我们可以声明式地描述最终输出的 HTML 和 JavaScript 状态之间的关系。

- **响应性**：Vue 会自动跟踪 JavaScript 状态并在其发生变化时响应式地更新 DOM。

# vue3构建

## 环境

- node.js >= 18.0

## 安装vue框架

```shell
npm install -g vue@latest
```

## 创建vue项目

```shell
npm create vue@latest
```

### 可选择的构建选项

- Project name: …\<your-project-name\>
- Add TypeScript? … No / Yes
- Add JSX Support? … No / Yes
- Add Vue Router for Single Page Application development? … No / Yes
- Add Pinia for state management? … No / Yes
- Add Vitest for Unit testing? … No / Yes
- Add an End-to-End Testing Solution? … No / Cypress / Playwright
- Add ESLint for code quality? … No / Yes
- Add Prettier for code formatting? … No / Yes

## 启动vue项目

```shell
cd <your-project-name>
npm install
npm run dev
```

## 发布vue项目

```shell
npm build
```
