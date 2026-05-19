# QtDesigner

### 控件盒子

控件盒子：包含界面设计的常用组件
- Layouts、Buttons、Display Widgets


### 设计区域

设计区域：窗口中间主要区域是待设计的窗体
### Action 编辑器
待设计窗体下方有 Action 编辑器（Action Editor）和信号与槽编辑器（Signals and Slots Editor）。Action 编辑器用于可视化设计 Action，信号与槽编辑器用于可视化地进行信号与 槽的关联。

### 信号槽编辑器

 信号槽编辑器
 
### 对象查看器

Object Inspector/对象查看器：窗口上方有一个布局和界面设计工具栏，工具栏上的按钮主要用于实现布局和界面设计

### 属性编辑器

Property Editor/属性编辑器：窗口右侧下方，属性编辑器显示窗体上选中的组件或窗体 的各种属性，可以在属性编辑器里修改这些属性的值。

## 界面组件布局管理

### 界面组件层次关系

容器类组件：可以容纳多个组件的组件，可以将界面上的各个组件的分布设计得更加美观


### 布局管理

布局管理功能：包含Layouts/布局和Spacers/间隔两个分组

#### 组件面板

| 图标                                                        | 名称                | 中文名称   | 含义                                      |
| --------------------------------------------------------- | ----------------- | ------ | --------------------------------------- |
| ![[应用科学/c&c++程序/attachments/Pasted image 20250319230450.png]] | Vertical Layout   | 垂直方向布局 | 组件自动在垂直方向上分布                            |
| ![[../../../attachments/Pasted image 20250319230457.png]] | Horizontal Layout | 水平方向布局 | 组件自动在水平方向上分布                            |
| ![[../../../attachments/Pasted image 20250319230505.png]] | Grid Layout       | 网格布局   | 网格布局大小改变时，每个网格的大小都改变                    |
| ![[../../../attachments/Pasted image 20250319230513.png]] | Form Layout       | 表单布局   | 与网格布局类似，但是只有最右侧的一列网格会改变大小，适用于只有两列组件时的布局 |
| ![[../../../attachments/Pasted image 20250319230523.png]] | Horizontal Spacer | 水平间隔   | 用于水平间隔的非可视组件                            |
| ![[../../../attachments/Pasted image 20250319230530.png]] | Vertical Spacer   | 垂直间隔   | 用于垂直间隔的非可视组件                            |

#### 工具栏按钮

| 图标                                                        | 名称                               | 中文名称    | 快捷键    | 含义                                                  |
| --------------------------------------------------------- | -------------------------------- | ------- | ------ | --------------------------------------------------- |
| ![[应用科学/c&c++程序/attachments/Pasted image 20250319232040.png]]                   | Edit Widget                      | 界面编辑    | F3     | 界面设计进入编辑状态，默认状态                                     |
| ![[../../../attachments/Pasted image 20250319232046.png]] | Edit Signals/Slots               | 信号/槽编辑  | F4     | 进入信号与槽的可视化设计状态                                      |
| ![[../../../attachments/Pasted image 20250319232054.png]] | Edit Buddies                     | 伙伴关系编辑  |        | 进入伙伴关系编辑状态<br>可以设置一个标签与一个组件构成伙伴关系                   |
| ![[../../../attachments/Pasted image 20250319232103.png]] | Edit Tab Order                   | Tab顺序编辑 |        | 进入Tab顺序编辑状态<br>Tab 顺序是在键盘上按 Tab 键时输入焦点在界面各组件之间移动的顺序 |
| ![[应用科学/c&c++程序/attachments/Pasted image 20250319232117.png]]                   | Lay Out Horizontally             | 转化为水平布局 | Ctrl+H | 将窗体上所选组件水平布局                                        |
| ![[应用科学/c&c++程序/attachments/Pasted image 20250319232124.png]]                   | Lay Out Vertically               | 转化为垂直布局 | Ctrl+L | 将窗体上所选组件垂直布局                                        |
| ![[../../../attachments/Pasted image 20250319232139.png]] | Lay Out Horizontally in Splitter |         |        | 将窗体上所选组件用一个分割条（QSplitter类）进行水平分割布局                  |
| ![[应用科学/c&c++程序/attachments/Pasted image 20250319232132.png]]                   | Lay Out Vertically in Splitter   |         |        | 将窗体上所选组件用一个分割条进行垂直分割布局                              |
| ![[应用科学/c&c++程序/attachments/Pasted image 20250319232146.png]]                   | Lay Out in a Form Layout         |         |        | 将窗体上所选组件按表单方式布局                                     |
| ![[../../../attachments/Pasted image 20250319232153.png]] | Lay Out in a Grid                |         |        | 将窗体上所选组件按网格方式布局                                     |
| ![[../../../attachments/Pasted image 20250319232159.png]] | Break Layout                     | 解除布局    |        | 解除窗体上所选组件的布局，打散现有的布局                                |
| ![[../../../attachments/Pasted image 20250319232205.png]] | Adjust Size                      | 自动调整大小  | Ctrl+J | 自动调整所选组件的大小                                         |

### 伙伴关系

伙伴关系：指界面上一个标签和一个具有输入焦点的组件相关联，在程序运行时通过快捷键将输入焦点切换到某个组件上


建立伙伴关系
1. 进入伙伴关系编辑状态
2. 选中一个标签
3. 按住鼠标左键
4. 拖向一个编辑框（QLineEdit 类）

### Tab 顺序

Tab 顺序：指在程序运行时，按下键盘上的 Tab 键时输入焦点的移动顺序
