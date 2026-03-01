# npm包管理工具

## 安装

1. 下载[node.js](https://nodejs.cn/download/.md)

### 检查当前nodejs和npm版本

```shell
node -v
npm -v
```

### 安装包

```shell
npm install [<package-spec> ...]
```

同义词:
- `add`
- `i`
- `in`
- `ins`
- `inst`
- `insta`
- `instal`
- `isnt`
- `isnta`
- `isntal`
- `isntall`

#### 描述

此命令安装一个包和它所依赖的任何包。如果包有一个包锁，或者一个 npm 收缩封装文件，或者一个 Yarn 锁文件，依赖的安装将由它驱动，遵循以下优先顺序：

- `npm-shrinkwrap.json`
- `package-lock.json`
- `yarn.lock`

见 package-lock.json](https://npm.nodejs.cn/cli/v10/configuring-npm/package-lock-json.md) 和 [`npm%20shrinkwrap`](https://npm.nodejs.cn/cli/v10/commands/npm-shrinkwrap.md)。

一个 `package` 是：

- a) 包含由 [`package.json`](https://npm.nodejs.cn/cli/v10/configuring-npm/package-json.md) 文件描述的程序的文件夹
    
- b) 一个 gzipped tarball，包含 (a)
    
- c) 解析为 (b) 的 url
    
- d) 在注册表上发布的 `<name>@<version>`（参见 `registry`](https://npm.nodejs.cn/cli/v10/using-npm/registry.md)），带有%20(c)
    
- e) 指向 (d) 的 `<name>@<tag>`（见 [`npm dist-tag`](https://npm.nodejs.cn/cli/v10/commands/npm-dist-tag.md)）
    
- f) 具有满足 (e) 的 "latest" 标签的 `<name>`
    
- g) 解决为 (a) 的 `<git remote url>`
    

即使你从不发布你的包，如果你只是想写一个 node 程序（a），你仍然可以获得使用 npm 的很多好处，也许你还想在打包后能够轻松地安装它成一个 tarball (b)。