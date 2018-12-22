//
//  JTPopMenu.swift
//  JTPopMenu
//
//  Created by ZhouJiatao on 13/12/2016.
//  Copyright © 2016 ZhouJiatao. All rights reserved.
//

import UIKit

public protocol JTPopMenuDelegate {
    func popMenu(_ popMenu: JTPopMenu, didSelectRowAt row: Int, withItem item: JTPopMenuItem)
}



public class JTPopMenu: UIView,UITableViewDataSource,UITableViewDelegate {
    static let MenuCellResuseID = "JTPopMenuCell"
    public var mUIConfig:JTPopMenuUIConfig = JTPopMenuDarkTheme() {
        didSet {
            config()
        }
    }
    
    public var popMenuDelegate: JTPopMenuDelegate?
    
    var tableView = UITableView()
    var arrowView = UIView()
    var bgView = UIImageView()
    
    public var menuItems = [JTPopMenuItem]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        config()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        config()
    }
    
    private func setup() {
        addSubview(bgView)
        addSubview(tableView)
        addSubview(arrowView)
        
        
        //arrowView:
            // Build a triangular path
        let arrowPath = UIBezierPath()
        arrowPath.move(to: CGPoint(x:0, y:mUIConfig.arrowViewSize.height))
        arrowPath.addLine(to: CGPoint(x:mUIConfig.arrowViewSize.width, y:mUIConfig.arrowViewSize.height))
        arrowPath.addLine(to: CGPoint(x:mUIConfig.arrowViewSize.width / 2, y:0))
        arrowPath.close()
            // Create a CAShapeLayer with this triangular path
        let arrowMask = CAShapeLayer()
        arrowMask.frame = CGRect(origin: CGPoint.zero, size: mUIConfig.arrowViewSize)
        arrowMask.path = arrowPath.cgPath
            // Mask the arrowView's layer with this shape
        arrowView.layer.mask = arrowMask
        
        //tableview
        tableView.register(JTPopMenuCell.self, forCellReuseIdentifier: JTPopMenu.MenuCellResuseID)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        
        let footView = UIView()
        footView.frame = CGRect(x: 0, y: 0, width: 1, height: 1)
        tableView.tableFooterView = footView //remove seperator from last cell
        
        //bgView
        bgView.isUserInteractionEnabled = true
        let bgTap = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        bgView.addGestureRecognizer(bgTap)
        
        //self
        self.frame = UIScreen.main.bounds
    }
    
    private func config() {
        arrowView.backgroundColor = mUIConfig.menuBgColor
        
        tableView.separatorColor = mUIConfig.separatorColor
        tableView.layer.cornerRadius = mUIConfig.menuCornerRadius
        //tableView.backgroundColor = mUIConfig.menuBgColor //not work here, set in layoutSubviews()
        
        bgView.backgroundColor = UIColor.black
        bgView.alpha = mUIConfig.bgViewAlpha
    }
    
    public override func layoutSubviews() {
        //arrowView
        arrowView.frame = CGRect(x: anchorFrame.midX - (arrowView.frame.width / 2), //make it center
                                 y: anchorFrame.maxY + mUIConfig.arrowSpacingToAnchor,
                                 width: mUIConfig.arrowViewSize.width,
                                 height: mUIConfig.arrowViewSize.height)
        
        //tableView: 相对arrowView进行定位
        let tableViewContentSize = CGSize(width: cellExpectMaxWidth, height: tableView.contentSize.height)
       
        let tableViewX = getTableViewX(byArrowViewFrame: arrowView.frame,
                                    tableViewContentSize: tableViewContentSize)
        let tableViewY = arrowView.frame.maxY
        
        tableView.frame = CGRect(x:tableViewX,
                                 y: tableViewY ,
                                 width: tableViewContentSize.width,
                                 height: tableViewContentSize.height)
        tableView.backgroundColor = mUIConfig.menuBgColor
        tableView.backgroundView = nil
        
        //bgView
        bgView.frame = self.bounds

    }
    
    private func getTableViewX(byArrowViewFrame arrowFrame:CGRect, tableViewContentSize:CGSize) -> CGFloat{
        let isRightSide = arrowFrame.midX > self.frame.midX //箭头(arrow)是否在屏幕右边
        var result:CGFloat = 0
        if isRightSide {
            //从arrowView的中心开始，向右延伸tableView一半的宽度，再向右延伸"到屏幕最小间距"，是否会超出屏幕；
            //如果不会超出，则可以让arrowView和tableView居中对齐。
            let tbCantCenterXToArrow = arrowView.frame.midX + (tableViewContentSize.width / 2) + mUIConfig.minHorizontalSpacingToScreen
                < self.bounds.width
            result = tbCantCenterXToArrow
                ? arrowView.frame.midX - (tableViewContentSize.width / 2)
                : self.frame.width - mUIConfig.minHorizontalSpacingToScreen - tableViewContentSize.width
        } else {
            //从arrowView的中心开始，向左延伸tableView一半的宽度，再向左延伸"到屏幕最小间距"，是否会超出屏幕；
            //如果不会超出，则可以让arrowView和tableView居中对齐。
            let tbCantCenterXToArrow = arrowView.frame.midX - (tableViewContentSize.width / 2) - mUIConfig.minHorizontalSpacingToScreen
                > 0
            result = tbCantCenterXToArrow
                ? arrowView.frame.midX - (tableViewContentSize.width / 2)
                : 0 + mUIConfig.minHorizontalSpacingToScreen
        }
        
        return result
    }
    
    public func show(fromView container:UIView, under barbuttonItem: UIBarButtonItem) {
        let anchorView = barbuttonItem.value(forKey: "view") as! UIView
        show(fromView: container, at: anchorView)
    }
    
    private var anchorFrame = CGRect.zero
    private func show(fromView container:UIView, at anchorView:UIView) {
        anchorFrame = anchorView.superview!.convert(anchorView.frame, to: self)
        container.addSubview(self)
    }
    
    @objc func backgroundTapped() {
        dismiss()
    }
    
    public func dismiss() {
        removeFromSuperview()
    }
    
    //MARK: - UITableViewDataSource
    private func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    private var cellExpectMaxWidth:CGFloat = 50 {
        didSet {
            self.setNeedsLayout()
        }
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: JTPopMenu.MenuCellResuseID, for: indexPath) as! JTPopMenuCell
        cell.mUIConfig = mUIConfig
        cell.updateUI(withItem: menuItems[indexPath.row])
        cell.layoutIfNeeded()
        
        if cellExpectMaxWidth < cell.expectWidth {
            cellExpectMaxWidth = cell.expectWidth
        }
        
        return cell
    }
    
    private func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return mUIConfig.cellHeight
    }
    
    private func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    private func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    private func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss()
        popMenuDelegate?.popMenu(self, didSelectRowAt: indexPath.row, withItem: menuItems[indexPath.row])
    }

}

