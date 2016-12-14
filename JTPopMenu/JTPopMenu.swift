//
//  JTPopMenu.swift
//  JTPopMenu
//
//  Created by ZhouJiatao on 13/12/2016.
//  Copyright © 2016 ZhouJiatao. All rights reserved.
//

import UIKit

protocol JTPopMenuDelegate {
    func popMenu(_ popMenu: JTPopMenu, didSelectRowAt row: Int, withItem item: JTPopMenuItem)
}

class JTPopMenu: UIView,UITableViewDataSource,UITableViewDelegate {

    struct Contants {
        static let MenuCellResuseID = "JTPopMenuCell"
        static let tableBgImageName = "menu_bg_9patch"
        static let arrowImageName = "menu_arrow_up"
        
        //这两个值是从实际图片量取的
        static let tableBgImageCapInsets = UIEdgeInsets(top: 11, left: 11, bottom: 11, right: 11)
        static let tableBgImageShadowLenght:CGFloat = 7 //阴影的长度。tableBgImageCapInsets的一部分。
        
        static let bgViewAlpha:CGFloat = 0.3
        
        static let arrowSpacingToAnchor:CGFloat = 8
        static let minHorizontalSpacingToScreen:CGFloat = 0
        
        static let cellHeight:CGFloat = 44
    }
    
    var popMenuDelegate: JTPopMenuDelegate?
    
    var tableView = UITableView()
    var tableBgView = UIImageView()
    var arrowView = UIImageView()
    var bgView = UIImageView()
    
    var menuItems = [JTPopMenuItem]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        addSubview(bgView)
        addSubview(tableBgView)
        addSubview(tableView)
        addSubview(arrowView)
        //tableview
        tableView.register(JTPopMenuCell.self, forCellReuseIdentifier: Contants.MenuCellResuseID)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        let footView = UIView()
        footView.frame = CGRect(x: 0, y: 0, width: 1, height: 1)
        tableView.tableFooterView = footView //remove seperator from last cell
        //tableView.backgroundColor = UIColor.clear //not work on this, set in layoutSubviews()
        
        tableBgView.contentMode = .scaleToFill
        tableBgView.image = UIImage(named: Contants.tableBgImageName)?
            .resizableImage(withCapInsets: Contants.tableBgImageCapInsets)
        
        //arrow
        arrowView.image = UIImage(named: Contants.arrowImageName)
        
        //bgView
        bgView.backgroundColor = UIColor.black
        bgView.alpha = Contants.bgViewAlpha
        bgView.isUserInteractionEnabled = true
        let bgTap = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        bgView.addGestureRecognizer(bgTap)
        
        //self
        self.frame = UIScreen.main.bounds
    }
    
    override func layoutSubviews() {
        //arrowView
        arrowView.sizeToFit()
        arrowView.frame = CGRect(x: anchorFrame.midX - (arrowView.frame.width / 2), //make it center
                                 y: anchorFrame.maxY + Contants.arrowSpacingToAnchor,
                                 width: arrowView.frame.width,
                                 height: arrowView.frame.height)
        
        //tableBgView
        let tableViewContentSize = CGSize(width: cellExpectMaxWidth, height: tableView.contentSize.height)
        let tbgWidth = tableViewContentSize.width + (Contants.tableBgImageShadowLenght * 2)
        let tbgHeight = tableViewContentSize.height + (Contants.tableBgImageShadowLenght * 2)
        let tbgCantCenterXToArrow = arrowView.frame.midX + (tbgWidth / 2) + Contants.minHorizontalSpacingToScreen - Contants.tableBgImageShadowLenght
            < UIScreen.main.bounds.width
        let tbgX = tbgCantCenterXToArrow
            ? arrowView.frame.midX - (tbgWidth / 2)
            : self.frame.width - Contants.minHorizontalSpacingToScreen - tbgWidth
        let tbgY = arrowView.frame.maxY - Contants.tableBgImageShadowLenght
        tableBgView.frame = CGRect(x: tbgX,
                                   y: tbgY,
                                   width: tbgWidth,
                                   height: tbgHeight)
        
        //tableView
        let tableViewX = tbgX + Contants.tableBgImageShadowLenght
        let tableViewY = tbgY + Contants.tableBgImageShadowLenght
        tableView.frame = CGRect(x:tableViewX,
                                 y: tableViewY ,
                                 width: tableViewContentSize.width,
                                 height: tableViewContentSize.height)
        tableView.backgroundColor = UIColor.clear
        
        //bgView
        bgView.frame = self.bounds

    }
    
    func show(fromView container:UIView, under barbuttonItem: UIBarButtonItem) {
        let anchorView = barbuttonItem.value(forKey: "view") as! UIView
        show(fromView: container, at: anchorView)
    }
    
    private var anchorFrame = CGRect.zero
    private func show(fromView container:UIView, at anchorView:UIView) {
        anchorFrame = anchorView.superview!.convert(anchorView.frame, to: self)
        container.addSubview(self)
    }
    
    func backgroundTapped() {
        dismiss()
    }
    
    func dismiss() {
        removeFromSuperview()
    }
    
    //MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    private var cellExpectMaxWidth:CGFloat = 50 {
        didSet {
            self.setNeedsLayout()
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Contants.MenuCellResuseID, for: indexPath) as! JTPopMenuCell
        cell.updateUI(withItem: menuItems[indexPath.row])
        cell.layoutIfNeeded()
        
        if cellExpectMaxWidth < cell.expectWidth {
            cellExpectMaxWidth = cell.expectWidth
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Contants.cellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss()
        popMenuDelegate?.popMenu(self, didSelectRowAt: indexPath.row, withItem: menuItems[indexPath.row])
    }

}
