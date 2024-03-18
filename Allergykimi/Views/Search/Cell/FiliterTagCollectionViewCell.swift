//
//  FiliterTagCollectionViewCell.swift
//  Allergykimi
//
//  Created by 은서우 on 3/18/24.
//

import UIKit

class FiliterTagCollectionViewCell: BaseCollectionViewCell {
    
    let stackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 4
        view.distribution = .equalSpacing
        view.alignment = .fill
        return view
    }()
    let tagLabel = UILabel()
    let cancelBtn = UIButton()
    
    override func configureHierarchy() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(tagLabel)
        stackView.addArrangedSubview(cancelBtn)
    }
    
    override func configureView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 0.8
        contentView.layer.borderColor = UIColor.accent.cgColor
        
        tagLabel.textAlignment = .center
    }
    
    
    override func setConstraints() {
        stackView.snp.makeConstraints {
            $0.verticalEdges.equalTo(contentView)
            $0.horizontalEdges.equalTo(contentView).inset(4)
        }
    }
    
//    func updateFiliterUI() {
//        tagLabel.text = "필터"
//        cancelBtn.isHidden = true
//    }
    
    func updateTagUI(data: Allergy) {
        tagLabel.text = data.name.first
        cancelBtn.isHidden = false
        cancelBtn.setImage(UIImage(systemName: "xmark"), for: .normal)
    }
}
