//
//  MagazineCollectionViewCell.swift
//  Allergykimi
//
//  Created by 은서우 on 3/20/24.
//

import UIKit
import Kingfisher

class RecentlyCollectionViewCell: BaseCollectionViewCell {
    
    private let productImage = UIImageView()
    private let productName = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(productImage)
        contentView.addSubview(productName)
    }
    
    override func configureView() {
        
    }
    override func setConstraints() {
        productImage.snp.makeConstraints {
            $0.width.equalTo(productImage.snp.height)
            $0.leading.equalTo(contentView).offset(10)
            $0.verticalEdges.equalTo(contentView).inset(10)
        }
        productName.snp.makeConstraints {
            $0.leading.equalTo(productImage.snp.trailing)
            $0.top.equalTo(productImage)
            $0.trailing.equalTo(contentView)
        }
    }
    
    func updateUI(data: recentProduct) {
        productImage.kf.setImage(with: URL(string: data.prductImgURL))
        productName.text = data.prductName
    }
}
