# JTPopMenu  
用于NavigationBar下的下拉式弹出菜单。  
提供示例样式 light主题 和 dark主题。同时支持自定义样式，可以对各个元素的尺寸、间距和颜色进行修改。  

<img width="414" height="896" src="https://github.com/RealMeZJT/JTPopMenu/blob/master/Docs/Simulator%20Screen%20Shot%20-%20iPhone%20XR%20-%202018-12-20%20at%2021.53.04.png"/>
<img width="414" height="896" src="https://github.com/RealMeZJT/JTPopMenu/blob/master/Docs/Simulator%20Screen%20Shot%20-%20iPhone%20XR%20-%202018-12-20%20at%2021.53.07.png"/>

## TODO
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
### 显示菜单
	menu.show(fromView: navigationController!.view, under: barButtonItem)

## 自定义样式  
### 方式一:使用示例样式
示例样式有 `JTPopMenuDarkTheme` 和 `JTPopMenuLightTheme` 两种。
默认是dark主题样式。替换成light主题样式:  

	menu.mUIConfig = JTPopMenuLightTheme()

### 方式二:继承示例样式，覆盖个别属性
可以通过继承示例样式,比如 `JTPopMenuDarkTheme` ,然后对个别属性进行 override。

	class MyTheme: JTPopMenuDarkTheme {
	    override var menuBgColor: UIColor {return UIColor.brown}
	    override var separatorColor: UIColor {return UIColor.lightGray}
	    override var titleColor: UIColor {return UIColor.black}
	}
使用你的自定义样式  

	menu.mUIConfig = MyTheme()


### 方式三:实现JTPopMenuUIConfig协议  
还可通过实现JTPopMenuUIConfig协议创建完全自定义的样式，需要实现比较多的属性。 



