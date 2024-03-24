//
//  BaseTableViewCell.swift
//  Allergykimi
//
//  Created by 은서우 on 2024/03/07.
//

import UIKit
import SnapKit

class BaseTableViewCell: UITableViewCell, BaseViewProtocol {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
