//
//  ProfileView.swift
//  Allergykimi
//
//  Created by 은서우 on 3/11/24.
//

import UIKit

final class ProfileView: BaseView {
    
    private let myProfileImage = UIImageView()
    let nameLabel = UILabel()
    lazy var collectionView  = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: "TagCollectionViewCell")
        return view
    }()
    
    override func configureHierarchy() {
        addSubview(myProfileImage)
        addSubview(nameLabel)
    }
    
    override func configureView() {
        backgroundColor = .systemGray6
        
        myProfileImage.backgroundColor = .accent
        nameLabel.text = UserDefaultsManager.shared.nickName
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myProfileImage.layer.cornerRadius = myProfileImage.bounds.width / 2
        myProfileImage.clipsToBounds = true
    }
    
    override func setConstraints() {
        myProfileImage.snp.makeConstraints {
            $0.leading.equalTo(self).offset(30)
            $0.width.equalTo(myProfileImage.snp.height)
            $0.verticalEdges.equalTo(self).inset(40)
        }
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(myProfileImage.snp.trailing).offset(20)
            $0.top.equalTo(myProfileImage.snp.top).offset(10)
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }
}
