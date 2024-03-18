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
        contentView.layer.cornerRadius = 10
        
        tagLabel.textAlignment = .center
        tagLabel.text = "test"
        tagLabel.font = .systemFont(ofSize: 15)
    }
    
    override func setConstraints() {
        tagLabel.snp.makeConstraints {
            $0.verticalEdges.equalTo(contentView)
            $0.horizontalEdges.equalTo(contentView).inset(5)
        }
    }
    
    func updateUI(data: Allergy, list: [Allergy]) {
        tagLabel.text = data.name.first
        isFiliterAllergy(data: data, list: list)
    }
    
    func isFiliterAllergy(data: Allergy,  list: [Allergy]) {
        if list.contains(where: { $0 == data }) {
            contentView.backgroundColor = .accent
        } else {
            contentView.backgroundColor = .white 
        }
    }
}
