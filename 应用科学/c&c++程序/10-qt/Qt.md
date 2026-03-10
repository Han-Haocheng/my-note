# Qt

Qt：大型C++跨平台应用开发框架，支持C++、QML和python语言开发
- QML：类似JS的声明式语言

## Qt Creator

Qt Creator：基于Qt开发的Qt开发套件

## 编写第一个程序

1. 点击菜单项`文件`→`New project`
2. 选择 `application(Qt)`->选择新项目模板
3. 点击 `选择...`按钮
4. 设置项目的名称和路径
5. 点击 `下一步>`按钮
6. 选择构建系统
7. 点击 `下一步>`按钮
8. 设置类信息(类名，窗口基类，头文件名，源文件名，是否生成视图文件，视图文件名)
9. 点击 `下一步>`按钮
10. 选择构建套件
11. 点击 `下一步>`按钮
12. 设置项目管理(作为子项目，版本控制)
13. 点击 `完成`按钮



### 项目模板
-  `Qt Widgets Application`：GUI项目或应用项目，基于界面组件和C++的应用，具有窗口的GUI程序
- `Qt Console Application`：控制台应用，没有 GUI 
- `Qt Quick Application`：基于 Qt Quick 的应用，需要使用 QML 编程


> [!tip] 提示：`Qt Console Application`一般是在学习 C/C++语言基础语法，只需简单的输入输出操作时才创建此类项目

### 构建系统
- qmake
- CMake

### 窗口基类
- QMainWindow/主窗口类：主窗口类具有菜单栏、工具栏和状态栏。 
- QWidget/界面组件基类：可以作为独立的空白窗口
- QDialog/对话框类：窗口具有对话框的显示效果，没有最大化按钮
[[应用科学/c&c++程序/10-qt/QtDesigner]]
[[应用科学/c&c++程序/10-qt/GUI程序设计]]