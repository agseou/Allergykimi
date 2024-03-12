//
//  ProductsCollectionViewCell.swift
//  Allergykimi
//
//  Created by 은서우 on 3/12/24.
//

import UIKit

class ProductsCollectionViewCell: BaseCollectionViewCell {
    
    let productImageView = UIImageView()
    let productName = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(productImageView)
        contentView.addSubview(productName)
    }
    
    override func configureView() {
        productImageView.backgroundColor = .gray
        DispatchQueue.main.async {
            self.productImageView.layer.cornerRadius = 15
        }
        productName.text = "상품 이름"
        productName.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    override func setConstraints() {
        productImageView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(contentView).inset(10)
            $0.top.equalTo(contentView).offset(10)
        }
        productName.snp.makeConstraints {
            $0.top.equalTo(productImageView.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(contentView).inset(10)
            $0.bottom.equalTo(contentView).inset(10)
        }
    }
    
}
