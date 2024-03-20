//
//  BannerCollectionViewCell.swift
//  Allergykimi
//
//  Created by 은서우 on 3/20/24.
//

import UIKit

struct BannerBox: Hashable  {
    let title: String
    let subTitle: String
    let image: UIImage
    let url: String?
}

class BannerCollectionViewCell: BaseCollectionViewCell {
    
    private let titleStackView = UIStackView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let imageView = UIImageView()
    
    override func configureHierarchy() {
        contentView.addSubview(titleStackView)
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(subTitleLabel)
        contentView.addSubview(imageView)
    }
    
    override func configureView() {
        self.contentView.backgroundColor = .systemGray6
        self.clipsToBounds = true
        self.layer.cornerRadius = 15
         
        titleStackView.axis = .vertical
        titleStackView.spacing = 2
        titleStackView.alignment = .leading
        titleStackView.distribution = .fill
        
        titleLabel.numberOfLines = 0
        titleLabel.text = "Tittle"
        
        subTitleLabel.numberOfLines = 0
        titleLabel.text = "subTitle"
        
        imageView.image = UIImage(resource: .noCrustaceans)
        imageView.contentMode = .scaleAspectFit
    }
    override func setConstraints() {
        titleStackView.snp.makeConstraints {
            $0.verticalEdges.equalTo(contentView).inset(5)
            $0.width.greaterThanOrEqualTo(contentView).multipliedBy(0.6)
            $0.leading.equalTo(contentView).offset(10)
        }
        imageView.snp.makeConstraints {
            $0.verticalEdges.trailing.equalTo(contentView)
            $0.width.greaterThanOrEqualTo(contentView).multipliedBy(0.4)
            $0.leading.equalTo(titleStackView.snp.trailing).offset(5)
        }
    }
    
    func uppdateUI(data: BannerBox) {
        titleLabel.text = data.title
        subTitleLabel.text = data.subTitle
        imageView.image = data.image
    }
}
