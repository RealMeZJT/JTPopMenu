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
        static let leftPadding:CGFloat = 26
        static let rightPadding:CGFloat = 45
        static let iconSpacingToTitle: CGFloat = 24
        static let iconSize:CGFloat = 17
        static let titleFont = UIFont.systemFont(ofSize: 17)
        static let titleColor = UIColor.white
        
        //分界线57,71,63
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
        icon.frame = CGRect(x: Contants.leftPadding,
                            y: (contentView.frame.height - Contants.iconSize) / 2, //make it center
                            width: Contants.iconSize,
                            height: Contants.iconSize)
        
        titleLabel.sizeToFit()
        let titleLabelX = icon.image == nil
            ? Contants.leftPadding
            : icon.frame.maxX + Contants.iconSpacingToTitle
        titleLabel.frame = CGRect(x: titleLabelX,
                                  y: (contentView.frame.height - titleLabel.frame.height) / 2, //make it center
                                  width: titleLabel.frame.width,
                                  height: titleLabel.frame.height)
        
        expectWidth = titleLabel.frame.maxX  + Contants.rightPadding

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
