# 获取Boost

- 获取Boost的最可靠方式是下载`boost_1_82_0.7z`或`boost_1_82_0.zip`并解压以安装完整的Boost发行版。

# Boost发行版

```
boost_1_82_0\ ........ boost根目录
|- index.htm ......... boost官网
|- boost\ ............ boost头文件
|- lib\ .............. 预编译库二进制文件
|- libs\ ............. 库的测试文件，cpp文件，文档文件等
|   |- index.html .... 库文档首页
|   |- algorithm\
|   |- any\
|   |- array\
|   |- ...  .更多的库
|- status\ ........... Boost-wide 测试套件
|- tools\ ............ 实用工具，如Boost.Build，quickbook，bcp
|- more\ ............. 法律文件等
|- doc\ .............. Boost库文档
```

- Boost根目录路径通常表示为`$BOOST_ROOT`（例如`/usr/local/boost_1_82_0`）。
- 编译Boost时，#include路径中需包含`boost/`子目录。
- Boost头文件具有`.hpp`扩展名，位于`boost/`子目录中
  - `#include <boost/whatever.hpp>`
  - `#include "boost/whatever.hpp"`。
- `doc/`子目录仅包含部分Boost文档，完整文档从`libs/index.html`开始。
- 
## 头文件组织

Boost库头文件的组织并不完全统一，但大多数库遵循一些模式：

- 旧库和小库通常将公共头文件直接放在`boost\`目录下。
- 多数库的公共头文件位于以库名命名的`boost\`子目录中，如`boost\python\def.hpp`。
- 部分库在`boost\`下提供聚合头文件，包含库的所有其他头文件，如Boost.Python的`boost\python.hpp`。
- 库的私有头文件通常放在`detail\`或`aux_\`子目录中，不应直接使用。

# 仅限头文件的库

> 无需构建 - 大多数Boost库都是仅限头文件的：
> 它们完全由包含模板和内联函数的头文件组成，不需要单独编译的库二进制文件或在链接时需要特殊处理。

## 唯一必须单独构建的Boost库：
- `Boost.Chrono`
- `Boost.Context`
- `Boost.Filesystem`
- `Boost.GraphParallel`
- `Boost.IOStreams`
- `Boost.Locale`
- `Boost.Log`（见构建文档）
- `Boost.MPI`
- `Boost.ProgramOptions`
- `Boost.Python`（在构建和安装之前，请参见`Boost.Python`构建文档）
- `Boost.Regex`
- `Boost.Serialization`
- `Boost.Thread`
- `Boost.Timer`
- `Boost.Wave`

## 有可选的单独编译的二进制文件

- `Boost.Graph`：有一个二进制组件，仅在你打算解析GraphViz文件时才需要。
- `Boost.Math`：为TR1和C99 cmath函数提供了二进制组件。
- `Boost.Random`：拥有一个二进制组件，该组件仅在使用random_device时才是必需的。
- `Boost.Test`：可以以“仅限头文件”或“单独编译”模式使用，但对于正式用途，推荐使用单独编译模式。

- `Boost.Exception`：为32位`_MSC_VER==1310`和`_MSC_VER==1400`版本提供了`exception_ptr`的非侵入式实现，这需要单独编译的二进制文件。这可以通过定义`BOOST_ENABLE_NON_INTRUSIVE_EXCEPTION_PTR`来启用。

- `Boost.System`：自Boost 1.69起，已成为仅限头文件的库。尽管为了兼容性仍然构建了一个桩库，但不再需要链接到它。

# 使用Boost构建一个简单程序

- 为了保持简单，让我们从使用一个仅限头文件的库开始。下面的程序从标准输入读取整数序列，使用Boost.Lambda将每个数字乘以三，并将它们写入标准输出：
```c++
#include <boost/lambda/lambda.hpp>
#include <iostream>
#include <iterator>
#include <algorithm>

int main()
{
    using namespace boost::lambda;
    typedef std::istream_iterator<int> in;
    std::for_each(in(std::cin), in(), std::cout << (_1 * 3) << " ");
}
```


## 从Visual Studio IDE构建

- 打开Visual Studio，从“文件”菜单选择“新建”>“项目”。
- 在左侧窗格选择“Visual C++”>“Win32”。
- 在右侧窗格选择“Win32控制台应用程序”或“Win32控制台项目”。
- 输入项目名称，例如“example”。
- 在“解决方案资源管理器”中，右键点击项目并选择“属性”。
- 在“配置属性”>“C/C++”>“常规”>“附加包含目录”中，添加Boost根目录路径。
- 在“预编译头文件”设置中，选择“不使用预编译头文件”。
- 替换IDE生成的example.cpp文件内容为示例代码。
- 选择“生成”菜单中的“生成解决方案”。
- 按F5键运行测试，在窗口中输入“1 2 3”后按回车，再按住Ctrl键并按下“Z”后按回车。

**注意**：

- Boost根目录路径需根据实际情况填写。
- 示例代码应替换为具体要测试的代码。
- 根据Visual Studio版本，项目类型和设置选项可能略有不同。

## 或者，从命令提示符构建

- 从你的计算机的开始菜单，如果你是Visual Studio 2005用户，选择...或者，如果你是Visual Studio .NET 2003用户，选择...以打开为Visual Studio编译器设置的特殊命令提示符窗口。在该窗口中，将当前目录设置为创建一些临时文件的适当位置，并输入以下命令后按回车键：

## 错误和警告

- 如果你看到来自Boost头文件的编译器警告，不要惊慌。我们努力消除它们，但并不总是实际可行。错误是另一回事。如果你在本教程的这一点上看到编译错误，请检查确保你正确复制了示例程序，并且你正确识别了Boost根目录。

# 准备使用Boost库二进制文件

- 如果你想使用任何单独编译的Boost库，你需要获取库的二进制文件。

## 简化的从源代码构建

- 如果你希望使用Visual C++从源代码构建，可以使用本节描述的简单构建过程。打开命令提示符并将当前目录更改为Boost根目录。然后，输入以下命令：

## 或者，从源代码构建二进制文件

- 如果你使用的是早期版本的Visual C++，或者来自另一供应商的编译器，你需要使用Boost.Build来创建你自己的二进制文件。

### 安装Boost.Build

- Boost.Build是一个基于文本的系统，用于开发、测试和安装软件。首先，你需要构建并安装它。为此：

  - 转到tools\build\目录。
  - 运行bootstrap.bat。
  - 运行`b2 install --prefix=PREFIX`，其中PREFIX是你想要安装Boost.Build的目录。
  - 将PREFIX\bin添加到你的PATH环境变量。

### 识别你的工具集

- 首先，在下面的表格中找到与你编译器相对应的工具集（Boost.Build文档中始终有最新列表）。

### 选择一个构建目录

- Boost.Build将在构建过程中生成的所有中间文件放置在构建目录中。如果你的Boost根目录是可写的，这一步并不严格必要：默认情况下Boost.Build将在你当前的工作目录中创建一个bin.v2/子目录用于此目的。

### 调用b2

- 更改你的当前目录到Boost根目录并按以下方式调用b2：

### 预期的构建输出

- 在构建Boost库的过程中，你可以期望在控制台看到一些打印的消息。这些可能包括：

  - 关于Boost库配置的通知——例如，当Regex库在没有Unicode支持的情况下构建时，会输出一条关于ICU的消息，如果你没有安装Python，Python库可能会在没有错误（但有通知）的情况下跳过。
  - 构建工具报告的已构建或已跳过的目标数量的消息。如果这些数字对你没有意义，不要感到惊讶；每个库都有很多目标。
  - 描述工具正在做什么的构建动作消息，看起来像这样：`toolset-name.c++ long/path/to/file/being/built`
  - 编译器警告。

#### 5.4 遇到构建错误时

- 构建Boost时你看到的唯一错误消息——如果有的话——应该与IOStreams库对zip和bzip2格式的支持有关。