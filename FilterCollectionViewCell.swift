//
//  FilterCollectionViewCell.swift
//  mental_health_proj
//
//  Created by Alina Kim on 4/26/19.
//  Copyright © 2019 Mitchell Lin. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    var filterLabel: UILabel!
    var unselectedColor: UIColor = .white
    var selectedColor: UIColor = UIColor(red:1, green: 0.4, blue: 0.4, alpha: 1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        filterLabel = UILabel(frame: bounds)
        filterLabel.textAlignment = .center
        filterLabel.font = .systemFont(ofSize: 14)
        filterLabel.textColor = UIColor(red:1, green: 0.5, blue: 0.5, alpha: 1)
        layer.cornerRadius = 5
        backgroundColor = .white
        contentView.addSubview(filterLabel)
        isSelected = false
    }
    
    func setup(with title: String) {
        filterLabel.text = title
    }
    
    override var isSelected: Bool {
        didSet {
            super.isSelected = isSelected
            if isSelected {
                backgroundColor = selectedColor
                filterLabel.textColor = unselectedColor
            } else {
                backgroundColor = unselectedColor
                filterLabel.textColor = selectedColor
            }
            setNeedsDisplay()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

