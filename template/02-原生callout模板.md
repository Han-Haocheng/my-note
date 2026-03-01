<%*
let list = {
	"✏️ Note 笔记":"note, 笔记",
	"🗒️ Abstract 定理":"abstract, 定理",
	"🗒️ Summary 总结":"summary, 总结",
	"🗒️ Tldr 要点":"tldr, 要点",
	"ℹ️ Info 信息":"info, 信息",
	"🟩 Todo 未完成":"todo, 未完成",
	"🔥 Tip 提示":"tip, 提示",
	"🔥 Hint 窍门":"hint, 窍门",
	"🔥 Important 重要":"important, 重要",
	"✅️ Success 成功":"success, 成功",
	"✅️ Check 检查":"check, 检查",
	"✅️ Done 完成":"done, 完成",
	"❓ Question 问题":"question, 问题",
	"❓ Help 帮助":"help, 帮助",
	"❓ FAQ 例题":"faq, 例题",
	"⚠️ Warning 警告":"warning, 警告",
	"⚠️ Caution 警告":"caution, 警告",
	"⚠️ Attention 注意":"attention, 注意",
	"❌ Failure 失败":"failure, 失败",
	"❌ Fail 失败":"fail, 失败",
	"❌ Missing 丢失":"missing, 丢失",
	"⚡️ Danger 危险":"danger, 危险",
	"⚡️ Error 错误":"error, 错误",
	"🐞 Bug 异常":"bug, 异常",
	"📋 Example 举例":"example, 举例",
	"󠀢🧲 Quote 证明":"quote, 证明",
	"󠀢🧲 Cite 引用":"cite, 引用",
}

let keys = Object.keys(list);
key = await tp.system.suggester(keys, keys);
let value = list[key];
let index = value.indexOf(",");
let text = value.substring(index+1);
value = value.substring(0, index);
if(key)
	return ">[!" + value + "]+" + text + "";
return "";
%>