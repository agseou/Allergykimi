//
//  EmptyItemsCollectionViewCell.swift
//  Allergykimi
//
//  Created by 은서우 on 3/20/24.
//

import UIKit

class EmptyItemsCollectionViewCell: BaseCollectionViewCell {
    
    let infoLabel = UILabel()
    
    override func configureHierarchy() {
        addSubview(infoLabel)
    }
    
    override func configureView() {
        infoLabel.text = "상품을 추가해주세요!"
        infoLabel.textAlignment = .center
        infoLabel.font = .systemFont(ofSize: 24, weight: .bold)
    }
    
    override func setConstraints() {
        infoLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
