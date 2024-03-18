//
//  ProductTagCollectionViewCell.swift
//  Allergykimi
//
//  Created by 은서우 on 3/18/24.
//

import UIKit

class ProductTagCollectionViewCell: BaseCollectionViewCell {
    
    let tagLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(tagLabel)
    }
    
    override func configureView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 15
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = CGSize(width: 0, height: 5)
        contentView.layer.shadowColor = UIColor.gray.cgColor
        
        tagLabel.textAlignment = .center
    }
    
    override func setConstraints() {
        tagLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.horizontalEdges.equalTo(contentView).inset(5)
        }
    }
    
    func updateUI(data: Allergy) {
        tagLabel.text = data.rawValue
    }
}
