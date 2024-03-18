//
//  TagCollectionViewCell.swift
//  Allergykimi
//
//  Created by 은서우 on 3/13/24.
//

import UIKit

class TagCollectionViewCell: BaseCollectionViewCell {
    
    let iconLabel = UILabel()
    let tagLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(iconLabel)
        contentView.addSubview(tagLabel)
    }
    
    override func configureView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = CGSize(width: 0, height: 5)
        contentView.layer.shadowColor = UIColor.gray.cgColor
        
        tagLabel.textAlignment = .center
    }
    
    override func setConstraints() {
        iconLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(contentView).offset(10)
        }
        tagLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(iconLabel.snp.trailing).offset(4)
            $0.trailing.equalTo(contentView).inset(10)
        }
    }
    
    func updateUI(data: Allergy, list: [Allergy]) {
        iconLabel.text = data.icon
        tagLabel.text = data.name.first
        contentView.backgroundColor = list.contains(data) ? .accent : .white
        tagLabel.textColor = list.contains(data) ? .white : .black
    }
}
