# 获取系统规则(各种规制参数)
- 函数:
int GetSystemMetrics(

int iIndex

)
- 功能
  - GetSystemMetrics 函数返回 Windows 中各种图形项（图标、鼠标指针、标题栏和滚动条等）的尺寸信息。
  - 在不同的显卡和驱动中，这些尺寸是不一样的，为了在程序中做到与\*设备无关\*的图形输出，GetSystemMetrics是一个很重要的函数。
  - 注意：GetSystemMetrics 函数获取的所有尺寸均以像素为单位。

- 系统规则索引标签表:
| 值          | 含义              |
|-------------|-------------------|
| SM_CXSCREEN | 屏幕x轴长度像素数 |
| SM_CYSCREEN | 屏幕y轴长度像素数 |
# 获取设备环境
DeviceContext 设备环境句柄是应用程序使用GDI函数的通行证
1.  方式一:
相应WM_PAINT消息时使用
- 获取hdc函数：
HDC BeginPaint(

HWND hwnd,

LPPAINTSTRUCT lpps

)

- 释放hdc函数：
void EndPaint(

HWND hwnd,

LPPAINTSTRUCT lpps

)

- 使用方式：
HDC hdc = BeginPaint(hwnd,&paintStruct);

//使用GDI函数

EndPaint(hwnd,&paintStruct);//释放调用

2.  方式二:
可以任何时候使用,通用获取方式
- 获取hdc函数：
HDC GetDC(

HWND hwnd

)
- 释放hdc函数：
void ReleaseDC(

HWND hwnd,

HDC hdc

)
- 使用方式:
HDC hdc = GetDC(hwnd);

// 使用GDI函数

ReleaseDC(hwnd,hdc);

# 重绘函数
函数
BOOL InvalidateRect(

HWND hWnd,

CONST RECT \*lpRect,

BOOL bErase

)
参数含义：
- hWnd
  - 指向待更新客户区所在窗口的句柄
  - 如果为NULL，则重绘**所有**窗口，并在函数返回前发送WM_ERASEBKGND和WM_PAINT消息
- lpRect
  - 一个指向RECT结构的指针,指定无效区域的矩形,该矩形将会被重新绘制
  - 如果为NULL则会重绘整个窗口
- bErase - 指定更新区域内的背景是否重绘
  - TRUE - 调用BeginPaint函数时背景重绘
  - FALSE - 背景保持不变
注意
此为普通信息，等前面的信息执行完，才会被接收。
# 获取客户区尺寸
1.  方式一：
只有在全屏时只有客户区，客户区分辨率等于屏幕分辨率

cxClient = GetSystemMetrics(SM_CXSCREEN);

cyClient = GetSystemMetrics(SM_CYSCREEN);

2.  方式二：
使用GetClientRect函数，获取rect，低效率

RECT rect;

GetClientRect(hwnd,&rect)

cxClient = rect.

cyClient = rect.

3.  方式三：
通过改变窗口大小时发送消息WM_SIZE时，传递进来的wParam和lParam来获取客户区大小。

static int cxClient, cyClient;

cxClient = LOWORD(lParam);

cyClient = LOWORD(lParam);

