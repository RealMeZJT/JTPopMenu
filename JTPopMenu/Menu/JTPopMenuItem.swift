//
//  JTPopMenuItem.swift
//  JTPopMenu
//
//  Created by ZhouJiatao on 13/12/2016.
//  Copyright © 2016 ZhouJiatao. All rights reserved.
//

import Foundation

public class JTPopMenuItem {
    public var imageName: String?
    public var title: String
    public init(withImageName imageName: String? = nil, title: String) {
        self.imageName = imageName
        self.title = title
    }
    
}
