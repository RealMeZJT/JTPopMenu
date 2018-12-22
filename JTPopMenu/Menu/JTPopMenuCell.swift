//
//  JTPopMenuCell.swift
//  JTPopMenu
//
//  Created by ZhouJiatao on 13/12/2016.
//  Copyright © 2016 ZhouJiatao. All rights reserved.
//

import UIKit

public class JTPopMenuCell: UITableViewCell {
    
    public var mUIConfig:JTPopMenuUIConfig = JTPopMenuDarkTheme() {
        didSet {
            config()
        }
    }
    
    public var icon = UIImageView()
    public var titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        contentView.addSubview(icon)
        contentView.addSubview(titleLabel)
    }
    
    private func config() {
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        self.separatorInset = UIEdgeInsets.zero
        
        icon.contentMode = .scaleToFill
        
        titleLabel.font = mUIConfig.titleFont
        titleLabel.textColor = mUIConfig.titleColor
    }
    
    @objc dynamic var expectWidth:CGFloat = 0 
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        icon.sizeToFit()
        icon.frame = CGRect(x: mUIConfig.leftPadding,
                            y: (contentView.frame.height - mUIConfig.iconSize) / 2, //make it center
                            width: mUIConfig.iconSize,
                            height: mUIConfig.iconSize)
        
        titleLabel.sizeToFit()
        let titleLabelX = icon.image == nil
            ? mUIConfig.leftPadding
            : icon.frame.maxX + mUIConfig.iconSpacingToTitle
        titleLabel.frame = CGRect(x: titleLabelX,
                                  y: (contentView.frame.height - titleLabel.frame.height) / 2, //make it center
                                  width: titleLabel.frame.width,
                                  height: titleLabel.frame.height)
        
        expectWidth = titleLabel.frame.maxX  + mUIConfig.rightPadding

    }
    
    
    func updateUI(withItem item: JTPopMenuItem) {
        icon.image = UIImage(named: item.imageName ?? "")
        titleLabel.text = item.title
    }
    
    
    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
