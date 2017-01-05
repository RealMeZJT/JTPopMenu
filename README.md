# JTPopMenu  
用于NavigationBar下的下拉式弹出菜单。

## TODO
修复在leftButtonItem下弹出时菜单左边超出屏幕的问题;  
将使用方法精简为menu.show(under: barButtonItem);  

## 安装  
将 `menu` 目录下的源文件拷贝到项目中。  

## 使用方法  
### 实例化
	let menu = JTPopMenu()  
### 添加数据

	menu.menuItems = [JTPopMenuItem(withImageName: "myImage", title: "item1"),  
                    JTPopMenuItem(withImageName: "myImage", title: "item2"),  
                    JTPopMenuItem(withImageName: "myImage", title: "item3")]  
### 显示
	menu.show(fromView: navigationController!.view, under: barButtonItem)
