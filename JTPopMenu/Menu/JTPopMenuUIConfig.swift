//
//  JTPopMenuUIConfiger.swift
//  JTPopMenu
//
//  Created by ZhouJiatao on 05/01/2017.
//  Copyright © 2017 ZhouJiatao. All rights reserved.
//

import UIKit

///PopMenu的样式配置
public protocol JTPopMenuUIConfig {
    var bgViewAlpha:CGFloat {get}
    var arrowSpacingToAnchor:CGFloat {get}
    var arrowViewSize:CGSize {get}
    var minHorizontalSpacingToScreen:CGFloat {get}
    var menuCornerRadius:CGFloat {get}
    var menuBgColor:UIColor {get}
    var separatorColor:UIColor {get}
    var cellHeight:CGFloat {get}
    
    var leftPadding:CGFloat {get}
    var rightPadding:CGFloat {get}
    var iconSpacingToTitle: CGFloat {get}
    var iconSize:CGFloat {get}
    var titleFont:UIFont {get}
    var titleColor:UIColor {get}
}

//MARK: - Theme
public class JTPopMenuDarkTheme: JTPopMenuUIConfig {
    public var bgViewAlpha:CGFloat { return 0.10 }
    public var arrowSpacingToAnchor:CGFloat {return 8 }
    public var arrowViewSize:CGSize { return CGSize(width: 12, height: 7) }
    public var minHorizontalSpacingToScreen:CGFloat { return 4 }
    public var menuCornerRadius:CGFloat { return 4 }
    public var menuBgColor:UIColor {
        return UIColor(red: 41/255, green: 51/255, blue: 45/255, alpha: 1.0)
    }
    public var separatorColor:UIColor {
        return UIColor(red: 57/255, green: 71/255, blue: 63/255, alpha: 1.0)
    }
    public var cellHeight:CGFloat { return 50 }
    public var leftPadding:CGFloat { return 26 }
    public var rightPadding:CGFloat { return 26 }
    public var iconSpacingToTitle: CGFloat { return 24 }
    public var iconSize:CGFloat { return 17 }
    public var titleFont:UIFont { return UIFont.systemFont(ofSize: 17) }
    public var titleColor:UIColor { return UIColor.white }
    
}

public class JTPopMenuLightTheme: JTPopMenuDarkTheme {
    override public var menuBgColor: UIColor {return UIColor.white}
    override public var separatorColor: UIColor {return UIColor.lightGray}
    override public var titleColor: UIColor {return UIColor.black}
}
