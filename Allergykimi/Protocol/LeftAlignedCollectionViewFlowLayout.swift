//
//  LeftAlignedCollectionViewFlowLayout.swift
//  Allergykimi
//
//  Created by 은서우 on 3/13/24.
//

import UIKit

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return [] }
        
        var leftMargin = sectionInset.left
        for attribute in attributes where attribute.representedElementCategory == .cell {
            if attribute.frame.origin.x == sectionInset.left {
                leftMargin = sectionInset.left
            } else {
                attribute.frame.origin.x = leftMargin
            }
            leftMargin += attribute.frame.width + minimumInteritemSpacing 
        }
        return attributes
    }
}
