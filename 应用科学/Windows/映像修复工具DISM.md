
# DISM

**DISM**（Deployment Image Servicing and Management）是 Windows 系统内置的映像修复工具，可用于修复系统文件、安装/卸载更新、管理驱动程序和修复系统镜像。以下为详细使用说明。枚举、安装、卸载、配置和更新 Windows 映像中的功能和程序包。可以使用的命令取决于提供的映像以及映像是处于脱机还是运行状态。

## DISM 核心功能
- **修复系统镜像**：修复损坏的 Windows 镜像文件。
- **清理系统文件**：删除过期的更新缓存和临时文件。
- **管理功能/更新**：启用/禁用系统功能，安装/卸载更新补丁。
- **检查系统健康状态**：诊断系统镜像是否损坏。


### 指令描述

DISM.exe [dism_options] <Imaging_command> [<Imaging_arguments>]
DISM.exe </Image:<path_to_offline_image> | /Online> [dism_options]
         {servicing_command} [<servicing_arguments>]

### FFU 命令

- `/Capture-Ffu：`：物理磁盘映像捕获到新的 FFU 文件中。
- `/Apply-Ffu`：应用 .ffu 映像。
- `/Split-Ffu`：将现有 .ffu 文件拆分成多个只读已拆分 FFU 文件。
- `/Optimize-Ffu`：优化 FFU 文件，使其其可应用于不同大小的存储。

### WIM命令

- `/Apply-CustomDataImage`：冻结自定义数据映像中包含的文件。
- `/Capture-CustomImage`：将自定义设置捕获到 WIMBoot 系统上的增量 WIM 文件中。捕获的目录包括所有子文件夹和数据。
- `/Get-WIMBootEntry`：显示指定磁盘卷的WIMBoot 配置项。
- `/Update-WIMBootEntry`：更新指定磁盘卷的WIMBoot 配置项。
- `/List-Image`：显示指定映像中的文件和文件夹的列表。
- `/Delete-Image`：从具有多个卷映像的 WIM 文件删除指定的卷映像。
- `/Export-Image`：将指定映像的副本导出到其他文件。
- `/Append-Image`：将其他映像添加到 WIM 文件中。
- `/Capture-Image`：将驱动器的映像捕获到新的 WIM 文件中。捕获的目录包含所有子文件夹和数据。
- `/Get-MountedWimInfo`：显示有关安装的 WIM 映像的信息。
- `/Get-WimInfo`：显示有关 WIM 文件中的映像的信息。
- `/Commit-Wim`：保存对安装的 WIM 映像的更改。
- `/Unmount-Wim`：卸载安装的 WIM 映像。
- `/Mount-Wim`：从 WIM 文件安装映像。
- `/Remount-Wim`：恢复孤立的 WIM 安装目录。
- `/Cleanup-Wim`：删除与损坏的已安装 WIM映像关联的资源。

### 通用映像处理命令

- `/Split-Image`：将现有 .wim 文件拆分为多个只读拆分 WIM (SWM) 文件。
- `/Apply-Image`：应用一个映像。
- `/Get-MountedImageInfo`：显示有关安装的 WIM 和 VHD 映像的信息。
- `/Get-ImageInfo`：显示有关 WIM、VHD 或 FFU 文件中映像的信息。
- `/Commit-Image`：保存对装载的 WIM 或 VHD 映像的更改。
- `/Unmount-Image`：卸载已装载的 WIM 或 VHD 映像。
- `/Mount-Image`：从 WIM 或 VHD 文件装载映像。
- `/Remount-Image`：恢复孤立的映像装载目录。
- `/Cleanup-Mountpoints`：删除与损坏的已安装映像关联的资源。

### 映像规格

- `/Online`：以正在运行的操作系统为目标。
- `/Image`：指定脱机 Windows 映像的根目录的路径。

### dism_options

- `/English`：用英文显示命令行输出。
- `/Format`：指定报告输出格式。
- `/WinDir`：指定 Windows 目录的路径。
- `/SysDriveDir`：指定名为 BootMgr 的系统加载程序文件的路径。
- `/LogPath`：指定日志文件路径。
- `/LogLevel`：指定日志(1-4)中所示的输出级别。
- `/NoRestart`：取消自动重新启动和重新启动提示。
- `/Quiet`：取消除错误消息之外的所有输出。
- `/ScratchDir`：指定暂存目录的路径。

若要获得有关这些 DISM 选项及其参数的详细信息，请在紧挨着 /? 之前指定一个选项。

DISM.exe /Mount-Wim /?
DISM.exe /ScratchDir /?
DISM.exe /Image：C：\test\offline /?
DISM.exe /Online /?

## 常用参数详解


### **检查系统健康状态**

```shell
DISM /Online /Cleanup-Image /CheckHealth
```

- `/Online`：操作当前运行的系统（而非离线镜像）。
- `/Cleanup-Image`：清理或修复镜像。
- `/CheckHealth`：快速检查系统是否损坏（仅报告结果，不修复）。

### **扫描并修复系统镜像**

```shell
DISM /Online /Cleanup-Image /ScanHealth
DISM /Online /Cleanup-Image /RestoreHealth
```

- `/ScanHealth`：深度扫描系统镜像，检测损坏文件。
- `/RestoreHealth`：自动从 Windows Update 下载并替换损坏文件


#### **修复源指定**（若 Windows Update 不可用）：
  ```shell
  DISM /Online /Cleanup-Image /RestoreHealth /Source：wim：路径\install.wim：1 /LimitAccess
  ```
  - `/Source`：指定本地或网络镜像文件（如 ISO 中的 `install.wim`）。
  - `/LimitAccess`：禁止从 Windows Update 下载。


### **清理系统镜像**

```shell
DISM /Online /Cleanup-Image /StartComponentCleanup
```
- `/StartComponentCleanup`：删除旧版更新备份文件，释放磁盘空间。

#### **彻底清理**（谨慎使用）

  ```shell
  DISM /Online /Cleanup-Image /StartComponentCleanup /ResetBase
  ```
  - `/ResetBase`：删除所有旧版本更新，无法回滚已安装的补丁。


### **管理 Windows 功能**

```shell
DISM /Online /Enable-Feature /FeatureName：功能名称
DISM /Online /Disable-Feature /FeatureName：功能名称
```
- `/Enable-Feature`：启用系统功能（如 `NetFx3` 表示 .NET Framework 3.5）。
- `/Disable-Feature`：禁用系统功能。



### **处理离线镜像（针对非当前系统）**

```shell
DISM /Image：C：\挂载路径 /Cleanup-Image /RestoreHealth
```
- `/Image`：指定离线镜像的挂载路径。

### **导出修复后的镜像**
```shell
DISM /Commit-Image /MountDir：C：\挂载路径
```
- `/Commit-Image`：保存对挂载镜像的修改。
- `/MountDir`：指定挂载目录。

## 使用场景示例

### 修复系统更新失败

1. 扫描镜像：
   ```shell
   DISM /Online /Cleanup-Image /ScanHealth
   ```
2. 自动修复：
   ```shell
   DISM /Online /Cleanup-Image /RestoreHealth
   ```
3. 完成后重启，再次尝试更新系统。

### 清理旧版更新

释放磁盘空间并阻止回滚：
```shell
DISM /Online /Cleanup-Image /StartComponentCleanup /ResetBase
```

### 修复组件存储损坏

若提示“无法修复组件存储”：
1. 挂载系统 ISO 中的 `install.wim`。
2. 指定源文件修复：
```shell
DISM /Online /Cleanup-Image /RestoreHealth /Source：wim：D：\sources\install.wim：1 /LimitAccess
```

## 注意事项
1. **管理员权限**：所有命令需在 **管理员权限的 shell 或 PowerShell** 中运行。
2. **备份数据**：修复操作可能影响系统稳定性，建议提前备份。
3. **与 SFC 结合使用**：修复完成后，运行 `sfc /scannow` 修复剩余文件。
4. **离线镜像操作**：处理非当前系统时，确保镜像已正确挂载。

## 常见问题
- **错误 0x800f081f**：缺少修复源文件，需通过 `/Source` 指定有效的 `install.wim`。
- **错误 0x800f0906**：网络问题导致无法下载文件，使用 `/LimitAccess` 跳过 Windows Update。
- **DISM 日志位置**：`C：\Windows\Logs\DISM\dism.log`
