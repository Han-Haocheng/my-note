# GUI程序设计

## GUI程序结构与运行机制

### GUI项目组成

```
project/
	project.pro
	Headers/
		widget.h
	Sources/
		main.cpp
		widget.cpp
	Forms/
		widget.ui
```

- `widget.h`：窗口类定义头文件，它用到了 UI 文件 widget.ui 中的一个可视 化设计的窗口界面
- `widget.cpp`：对应于 `widget.h` 的源程序文件

### 项目配置文件

`project.pro`：qmake构建系统的项目配置文件，其中存储了项目的各种设置内容

### UI文件

`widget.ui`：UI 文件，这是用于窗口界面可视化设计的文件


### 主程序文件

`main.cpp`：主程序文件，包含 main()函数

```c++
#include "widget.h" 
#include <QApplication> 

int main(int argc, char *argv[]) 
{ 
	QApplication a(argc, argv);	//定义并创建应用程序 
	Widget w;                   //定义并创建窗口对象 
	w.show();                   //显示窗口 
	return a.exec();            //运行应用程序，开始应用程序的消息循环和事件处理 
}
```

### 窗口相关的文件

- widget.h 定义了窗口类 Widget
- widget.cpp 实现 Widget 类的功能的源程序文件 
- widget.ui 窗口 UI 文件，用于在 Qt Designer 中进行 UI 可视化设计。widget.ui 是一个 XML 文件，存储界面上各 个组件的属性和布局内容 
- ui_widget.h UI 文件经过 UIC 编译后生成的文件，这个文件里定义了一个类，类的名称是 Ui_Widget，用 C++语言 描述 UI 文件中界面组件的属性设置、布局以及信号与槽的关联等内容

## 可视化UI设计

### 信号与槽

- 信号（signal）：在特定情况下被发射的通知
- 槽（slot，槽函数）：对信号进行响应的函数。与信号关联，当信号被发射时自动运行

#### 信号与槽关联函数

```c++
QObject::connect(sender, SIGNAL(signal()), receiver, SLOT(slot()));
```

| 参数       | 类型       | 含义                                    |
| -------- | -------- | ------------------------------------- |
| sender   | QObject* | 发射信号的对象的名称                            |
| signal() |          | 信号，可以看作特殊的函数<br>需要带有括号，有参数时还需要指明各参数类型 |
| receiver | QObject* | 接收信号的对象的名称                            |
| slot()   |          | 槽函数<br>需要带有括号，有参数时还需要指明各参数类型          |

- 一个信号可以连接多个槽函数
- 多个信号可以连接同一个槽函数
- 一个信号可以连接另一个信号
- 严格的情况下，信号与槽的参数个数和类型需要一致，至少信号的参数不能少于槽的参 数。如果参数不匹配，会出现编译错误或运行错误
- 在使用信号与槽的类中，必须在类的定义中插入宏 Q_OBJECT
- 当一个信号被发射时，与其关联的槽函数通常被立即运行，就像正常调用函数一样

#### 公有的槽函数

- accept()：功能是关闭对话框，表示肯定的选择，如对话框上的“确定”按钮 
- reject()：功能是关闭对话框，表示否定的选择，如对话框上的“取消”按钮
- close()：功能是关闭对话框

#### 转到槽对话框

转到槽对话框：显示控件的所有可用信号，并在对应界面类中生成相应的槽函数

- 扫描槽函数：将名称匹配的信号和槽关联起来
- 槽函数命名规则：`void on_<object name>_<signal name>(<signal parameters>);`
```c
static void QMetaObject::connectSlotsByName(QObject *o)
```

### 设置应用程序图标

通过pro文件设置：在project.pro文件中添加 `RC_ICONS = <icon name>.ico`内容

> [!warning] 注意：ico文件必须是需要校验文件头的，不能通过修改文件扩展名修改得到

## 使用CMake构建系统

```cmake
cmake_minimum_required(VERSION 3.5)
project(project_name VERSION 0.1 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMKAE_AUTORCC ON)
set(CMKAE_CXX_STANDARD 11)
set(CMKAE_CXX_STANDARD_REQUIRED ON)

find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Widgets REQUIRED)
set(PROJECT_SOURCES
	main.cpp
	dialog.cpp
	dialog.h
	dialog.ui
)

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
	qt_add_executable(
		project_name
		MANUAL_FINALIZATION
		${PROJECT_SOURCES}
	)
endif()

target_link_libraries(project_name PRIVATE QT${QT_VERSION_MAJOR}::Widgets)

set_target_properties(project_name PROPERTIES
	MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
	MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
	MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
	MACOSX_BUNDLE TRUE 
	WIN32_EXECUTABLE TRUE
)

if(QT_VERSION_MAJOR EQUAL 6) 
	qt_finalize_executable(project_name) #最后生成可执行文件 samp2_4
endif()
```

