//
//  JTPopMenuCell.swift
//  JTPopMenu
//
//  Created by ZhouJiatao on 13/12/2016.
//  Copyright © 2016 ZhouJiatao. All rights reserved.
//

import UIKit

class JTPopMenuCell: UITableViewCell {
    static let ReuseIdentifier = "JTPopMenuCell"
    
    struct Contants {
        static let horizontalMargin:CGFloat = 15
        static let iconSize:CGFloat = 15
        static let titleFont = UIFont.systemFont(ofSize: 14)
        static let titleColor = UIColor.white
    }
    
    var icon = UIImageView()
    var titleLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
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
        
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        self.separatorInset = UIEdgeInsets.zero
        
        icon.contentMode = .scaleToFill
        
        titleLabel.font = Contants.titleFont
        titleLabel.textColor = Contants.titleColor
    }
    
    dynamic var expectWidth:CGFloat = 0 
    override func layoutSubviews() {
        super.layoutSubviews()
        
        icon.sizeToFit()
        icon.frame = CGRect(x: Contants.horizontalMargin,
                            y: (contentView.frame.height - Contants.iconSize) / 2, //make it center
                            width: Contants.iconSize,
                            height: Contants.iconSize)
        
        titleLabel.sizeToFit()
        let titleLabelX = icon.image == nil
            ? Contants.horizontalMargin
            : icon.frame.maxX + Contants.horizontalMargin
        titleLabel.frame = CGRect(x: titleLabelX,
                                  y: (contentView.frame.height - titleLabel.frame.height) / 2, //make it center
                                  width: titleLabel.frame.width,
                                  height: titleLabel.frame.height)
        
        expectWidth = titleLabel.frame.maxX  + Contants.horizontalMargin
    }
    
    
    func updateUI(withItem item: JTPopMenuItem) {
        icon.image = UIImage(named: item.imageName ?? "")
        titleLabel.text = item.title
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
