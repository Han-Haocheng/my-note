---
tags:
---


```js
app.vault.getFiles():TFile[]
app.vault.getMarkdownFiles():TFile[]
```

- 含义：获取所有文件列表
- 返回：`TFile[]` 文件列表

```js
app.vault.read(file: TFile):Promise<string> // 读取文件内容
app.vault.cachedRead(file: TFile):Promise<string> // 读取显示内容
```
- 含义：读取文件
- 参数：`file: TFile`文件类型
- 返回：`Promise<string>` 返回文件/显示内容


```js
const files = dv.pages(`#计算机/软件应用/快捷键`)
const headers = ['含义:操作','链接']
let values = new Array()

async function getObFileContents(path,tag){
	let ob_file_contents = await Promise.all(app.vault.getMarkdownFiles()
		.filter(file=>path===file.path)
		.map(file=>app.vault.cachedRead(file).map(content=>{
			let aa = content.split("\n")
				.filter(line => line.includes(tag))
				.map(l => l.replace(/^[>\s\.\-0-9]+|#+.*$/g, '').trim())
			console.log(aa)
			return aa
		})
	))
	return ob_file_contents
}

files.map((f)=>{
	let ob_lines = getObFileContents(f.file.path,'#计算机/软件应用/快捷键')
	let lines = Promise.all(ob_lines)

	values.splice(0,0,[lines,f.file.path])
})

//dv.list(values)
dv.table(headers,values)
```

