//
//  BaseViewController.swift
//  Allergykimi
//
//  Created by 은서우 on 2024/03/07.
//

import UIKit
import SnapKit

protocol BaseViewControllerProtocol {
    func setupDelegate() // - 델리게이트
    func configureHierarchy() // - 계층
    func configureView() // - 프로퍼티 ex) label
    func setConstraints() // - 레이아웃
}

class BaseViewController: UIViewController, BaseViewControllerProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupDelegate()
        setupBind()
        configureHierarchy()
        configureView()
        setConstraints()
    }
    
    func setupDelegate() { }
    func setupBind() { }
    func configureHierarchy() { }
    func configureView() { }
    func setConstraints() { }
    
}
