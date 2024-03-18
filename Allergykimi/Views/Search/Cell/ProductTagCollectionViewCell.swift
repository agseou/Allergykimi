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
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = CGSize(width: 0, height: 5)
        contentView.layer.shadowColor = UIColor.gray.cgColor
        
        tagLabel.textAlignment = .center
        tagLabel.text = "test"
        tagLabel.font = .systemFont(ofSize: 14, weight: .light)
    }
    
    override func setConstraints() {
        tagLabel.snp.makeConstraints {
            $0.verticalEdges.equalTo(contentView)
            $0.horizontalEdges.equalTo(contentView).inset(5)
        }
    }
    
    func updateUI(data: Allergy) {
        tagLabel.text = data.rawValue
        print(data.rawValue)
        isMyAllergy(data: data)
    }
    
    func isMyAllergy(data: Allergy) {
        let userAllergies = UserDefaultsManager.shared.myAllergies.compactMap { $0 }
        
        if userAllergies.contains(where: { $0 == data }) {
            contentView.backgroundColor = .accent
        } else {
            contentView.backgroundColor = .white 
        }
    }
}
