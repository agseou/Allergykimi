//
//  SearchBarCollectionViewCell.swift
//  Allergykimi
//
//  Created by 은서우 on 3/20/24.
//

import UIKit

class SearchBarCollectionViewCell: BaseCollectionViewCell {
    
    private let label = UILabel()
    let searchBar = UIButton()
    
    override func configureHierarchy() {
        contentView.addSubview(label)
        contentView.addSubview(searchBar)
    }
    
    override func configureView() {
        label.text = "\(UserDefaultsManager.shared.nickName)님 반가워요!"
        label.textAlignment = .left
        
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.baseForegroundColor = .gray
        config.baseBackgroundColor = .white
        config.image = UIImage(systemName: "magnifyingglass")
        config.imagePlacement = .leading
        config.title = "식품을 검색하세요!"
        searchBar.configuration = config
        DispatchQueue.main.async {
            self.searchBar.layer.cornerRadius = self.searchBar.bounds.height/2
        }
        searchBar.layer.borderColor = UIColor.accent.cgColor
        searchBar.layer.borderWidth = 3
    }
    
    
    override func setConstraints() {
        label.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(30)
            $0.horizontalEdges.equalTo(contentView).inset(40)
        }
        searchBar.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(5)
            $0.horizontalEdges.equalTo(contentView).inset(10)
            $0.height.equalTo(50)
        }
    }
    
}
