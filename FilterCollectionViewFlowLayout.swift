//
//  FilterCollectionViewFlowLayout.swift
//  mental_health_proj
//
//  Created by Alina Kim on 4/26/19.
//  Copyright © 2019 Mitchell Lin. All rights reserved.
//

import Foundation
import UIKit

class FilterCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    var cellWidth: CGFloat!
    var cellHeight: CGFloat!
    let edgeInset: CGFloat = 6
    let itemHeight: CGFloat = 34
    let itemWidth: CGFloat = 100
    
    override func prepare() {
        super.prepare()
        itemSize = CGSize(width: itemWidth, height: itemHeight)
        minimumLineSpacing = edgeInset
        minimumInteritemSpacing = edgeInset
        scrollDirection = .horizontal
        sectionInset = .zero
    }
}
