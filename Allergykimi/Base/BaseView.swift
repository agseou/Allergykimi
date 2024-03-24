//
//  BaseView.swift
//  Allergykimi
//
//  Created by 은서우 on 3/11/24.
//

import UIKit
import SnapKit


protocol BaseViewProtocol {
    func configureHierarchy() // - 계층
    func configureView() // - 프로퍼티 ex) label
    func setConstraints() // - 레이아웃
}

class BaseView: UIView, BaseViewProtocol {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupDelegate()
        configureHierarchy()
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupDelegate() { }
    func configureHierarchy() { }
    func configureView() { }
    func setConstraints() { }
    
}
