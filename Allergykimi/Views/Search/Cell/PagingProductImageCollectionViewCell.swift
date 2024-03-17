//
//  PagingProductImageCollectionViewCell.swift
//  Allergykimi
//
//  Created by 은서우 on 3/15/24.
//

import UIKit
import Kingfisher

class PagingProductImageCollectionViewCell: BaseCollectionViewCell {
    
    let image = UIImageView()
    
    override func configureHierarchy() {
        contentView.addSubview(image)
    }
    
    override func configureView() {
        contentView.backgroundColor = .black
        
        image.contentMode = .scaleAspectFit
    }
    
    override func setConstraints() {
        image.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
    }
    
    func updateUI(url: String) {
        image.kf.setImage(with: URL(string: url))
    }
}
