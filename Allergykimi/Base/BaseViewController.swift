//
//  BaseViewController.swift
//  Allergykimi
//
//  Created by 은서우 on 2024/03/07.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureView()
        setConstraints()
    }
    
    func configureHierarchy() { }
    func configureView() { 
        view.backgroundColor = .white
    }
    func setConstraints() { }
    
}
