//
//  CategoryCollectionViewCell.swift
//  Allergykimi
//
//  Created by 은서우 on 3/19/24.
//

import UIKit

enum categoryViewType: CaseIterable {
    case bread
    case snack
    case frozen
    case instant
    
    var title: String {
        switch self {
        case .bread:
            "빵"
        case .snack:
            "과자"
        case .frozen:
            "냉동식품"
        case .instant:
            "즉석식품"
        }
    }
    
    var image: UIImage {
        switch self {
        case .bread:
            UIImage(named: "bread")!
        case .snack:
            UIImage(named: "cookie")!
        case .frozen:
            UIImage(named: "pizza")!
        case .instant:
            UIImage(named: "bento")!
        }
    }
}

class CategoryCollectionViewCell: BaseCollectionViewCell {
    
    let stackView = UIStackView()
    
    override func configureHierarchy() {
        contentView.addSubview(stackView)
    }
    override func configureView() {
        self.contentView.backgroundColor = .systemGray6
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        for category in categoryViewType.allCases {
            let subStackView = createSubStackView(image: category.image, label: category.title)
            stackView.addArrangedSubview(subStackView)
        }
    }
    
    private func createSubStackView(image: UIImage, label: String) -> UIStackView {
        let subStackView = UIStackView()
        subStackView.axis = .vertical
        subStackView.alignment = .center
        subStackView.distribution = .fillProportionally
        subStackView.spacing = 0
        
        let titleLabel = UILabel()
        titleLabel.text = label
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        
        imageView.snp.makeConstraints {
            $0.size.equalTo(50)
        }
        
        subStackView.addArrangedSubview(imageView)
        subStackView.addArrangedSubview(titleLabel)
        
        return subStackView
    }
    override func setConstraints() {
        stackView.snp.makeConstraints {
            $0.verticalEdges.equalTo(contentView).inset(4)
            $0.horizontalEdges.equalTo(contentView).inset(4)
        }
    }
}
