//
//  JTPopMenuUIConfiger.swift
//  JTPopMenu
//
//  Created by ZhouJiatao on 05/01/2017.
//  Copyright © 2017 ZhouJiatao. All rights reserved.
//

import UIKit

///PopMenu的样式配置
protocol JTPopMenuUIConfig {
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
class JTPopMenuDarkTheme: JTPopMenuUIConfig {
    var bgViewAlpha:CGFloat { return 0.10 }
    var arrowSpacingToAnchor:CGFloat {return 8 }
    var arrowViewSize:CGSize { return CGSize(width: 12, height: 7) }
    var minHorizontalSpacingToScreen:CGFloat { return 4 }
    var menuCornerRadius:CGFloat { return 4 }
    var menuBgColor:UIColor {
        return UIColor(colorLiteralRed: 41/255, green: 51/255, blue: 45/255, alpha: 1.0)
    }
    var separatorColor:UIColor {
        return UIColor(colorLiteralRed: 57/255, green: 71/255, blue: 63/255, alpha: 1.0)
    }
    var cellHeight:CGFloat { return 50 }
    var leftPadding:CGFloat { return 26 }
    var rightPadding:CGFloat { return 26 }
    var iconSpacingToTitle: CGFloat { return 24 }
    var iconSize:CGFloat { return 17 }
    var titleFont:UIFont { return UIFont.systemFont(ofSize: 17) }
    var titleColor:UIColor { return UIColor.white }
    
}

class JTPopMenuLightTheme: JTPopMenuDarkTheme {
    override var menuBgColor: UIColor {return UIColor.white}
    override var separatorColor: UIColor {return UIColor.lightGray}
    override var titleColor: UIColor {return UIColor.black}
}
