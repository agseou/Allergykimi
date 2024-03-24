//
//  UIView+Extension.swift
//  Allergykimi
//
//  Created by 은서우 on 3/22/24.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
 
}
