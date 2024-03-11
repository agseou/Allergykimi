//
//  BaseView.swift
//  Allergykimi
//
//  Created by 은서우 on 3/11/24.
//

import UIKit
import SnapKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() { }
    func configureView() { }
    func setConstraints() { }
    
}
