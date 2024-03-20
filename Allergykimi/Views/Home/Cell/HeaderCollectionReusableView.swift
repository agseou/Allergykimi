//
//  HeaderCollectionReusableView.swift
//  Allergykimi
//
//  Created by 은서우 on 3/20/24.
//

import UIKit

class HeaderCollectionReusableView: BaseCollectionReusableView {
    
    let headerLabel = UILabel()
    
    override func configureHierarchy() {
        addSubview(headerLabel)
    }
    
    override func configureView() {
        headerLabel.text = "Header"
        headerLabel.textAlignment = .left
        headerLabel.font = .systemFont(ofSize: 24, weight: .bold)
    }
    
    override func setConstraints() {
        headerLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(10)
        }
    }
}
