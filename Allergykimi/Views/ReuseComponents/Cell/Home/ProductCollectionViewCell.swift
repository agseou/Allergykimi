//
//  ProductCollectionViewCell.swift
//  Allergykimi
//
//  Created by 은서우 on 3/24/24.
//

import UIKit

class ProductCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - Components
    private let productImageView = UIImageView()
    private let productName = UILabel()
    
    // MARK: - Properties
    
    // MARK: - Life Cycle Functions
    
    // MARK: - Functions
    override func configureHierarchy() {
        super.configureHierarchy()
        
        contentView.addSubviews([productImageView, productName])
    }
    
    override func configureView() {
        super.configureView()
        
        productImageView.backgroundColor = .gray
        productImageView.layer.cornerRadius = 10
        productImageView.clipsToBounds = true
        
        productName.numberOfLines = 0
        productName.font = AllergykimiFonts.TmoneyRoundWind.regular(size: 15)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        productImageView.snp.makeConstraints {
            $0.verticalEdges.leading.equalTo(contentView).offset(5)
            $0.width.equalTo(100)
        }
        productName.snp.makeConstraints {
            $0.leading.equalTo(productImageView.snp.trailing).offset(5)
            $0.top.equalTo(productImageView.snp.top).offset(20)
            $0.trailing.equalTo(contentView).inset(5)
        }
    }
    
    func updateUI(productData: recentProduct?) {
        if let productData = productData {
            productImageView.kf.setImage(with: URL(string: productData.prductImgURL))
            productName.text = productData.prductName
        } else {
            productImageView.image = nil
            productName.text = "데이터가 없습니다"
        }    }
    
    func updateUI(productData: favoriteProduct?) {
        if let productData = productData {
            productImageView.kf.setImage(with: URL(string: productData.prductImgURL))
            productName.text = productData.prductName
        } else {
            productImageView.image = nil
            productName.text = "데이터가 없습니다"
        }
    }
    
}
