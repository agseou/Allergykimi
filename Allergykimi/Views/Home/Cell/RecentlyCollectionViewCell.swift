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
            $0.centerY.equalTo(productImage)
        }
    }
    
    func updateUI(data: Item) {
        productImage.kf.setImage(with: URL(string: data.item.imgurl1))
        productName.text = data.item.prdlstNm
    }
}
