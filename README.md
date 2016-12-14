# JTPopMenu  
界面类似Popovers的弹出菜单。更方便的使用。

## TODO
添加light主题;
修复在leftButtonItem下弹出时菜单左边超出屏幕的问题;
支持其它方向的显示(目前只支持在锚点view的下方显示);
通过代码绘制小箭头和菜单背景(带圆角阴影);

## 使用方法
### 实例化
  let menu = JTPopMenu()
### 添加数据
  menu.menuItems = [JTPopMenuItem(withImageName: "myImage", title: "item1"),
                    JTPopMenuItem(withImageName: "myImage", title: "item2"),
                    JTPopMenuItem(withImageName: "myImage", title: "item3")]
### 显示
  menu.show(fromView: navigationController!.view, under: barButtonItem)
