//
//  ViewController.swift
//  JTPopMenu
//
//  Created by ZhouJiatao on 13/12/2016.
//  Copyright © 2016 ZhouJiatao. All rights reserved.
//

import UIKit

class ViewController: UIViewController,JTPopMenuDelegate {

    
    @IBOutlet weak var label: UILabel!
    
    let leftMenu = JTPopMenu()
    let rightMenu = JTPopMenu()
    override func viewDidLoad() {
        super.viewDidLoad()

        leftMenu.menuItems = [JTPopMenuItem(withImageName: "share", title: "item1"),
                          JTPopMenuItem(withImageName: "share", title: "item2"),
                          JTPopMenuItem(withImageName: "share", title: "item3")]
        leftMenu.popMenuDelegate = self
        
        rightMenu.menuItems = [JTPopMenuItem(withImageName: "share", title: "item4"),
                          JTPopMenuItem(withImageName: "share", title: "item5"),
                          JTPopMenuItem(withImageName: "share", title: "item6")]
        rightMenu.popMenuDelegate = self

    }
    


    @IBAction func testLeftMenu(_ sender: UIBarButtonItem) {
        leftMenu.show(fromView: navigationController!.view, under: sender)
    }
    
    @IBAction func testRightMenu(_ sender: UIBarButtonItem) {
        rightMenu.show(fromView: navigationController!.view, under: sender)
    }

    func popMenu(_ popMenu: JTPopMenu, didSelectRowAt row: Int, withItem item: JTPopMenuItem) {
        label.text = item.title
    }
    
}

