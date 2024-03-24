//
//  ProfileView.swift
//  Allergykimi
//
//  Created by 은서우 on 3/11/24.
//

import UIKit

final class MyPageProfileView: BaseView {
    
    // MARK: - Components
    private let editButton = UIButton()
    private let myProfileImage = ProfileView()
    private let nameLabel = UILabel()
    private let myAllergyLabel = UILabel()
    private lazy var collectionView  = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.register(ProductTagCollectionViewCell.self, forCellWithReuseIdentifier: "ProductTagCollectionViewCell")
        return view
    }()
    
    // MARK: - Properties
    private let allergiesList = UserDefaultsManager.shared.myAllergies
    var onEditButtonTapped: (() -> Void)?
    
    // MARK: - Functions
    override func setupDelegate() {
        super.setupDelegate()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func configureHierarchy() {
        addSubviews([ myProfileImage, nameLabel, myAllergyLabel, collectionView])
    }
    
    override func configureView() {
        if let loadedImage = ImageStorageManager.shared.loadImage() {
            myProfileImage.profileImage.image = loadedImage
        }
        
        backgroundColor = .systemGray6
        
//        editButton.setImage(UIImage(systemName: "pencil.circle.fill"), for: .normal)
//        editButton.addTarget(self, action: #selector(tapEditButton), for: .touchUpInside)
        
        nameLabel.font = AllergykimiFonts.TmoneyRoundWind.regular(size: 17)
        nameLabel.text = UserDefaultsManager.shared.nickName
        
        myAllergyLabel.text = "나의 알러지 정보"
        myAllergyLabel.font = AllergykimiFonts.TmoneyRoundWind.regular(size: 15)
        
        collectionView.backgroundColor = .clear
    }
    
    override func setConstraints() {
//        editButton.snp.makeConstraints {
//            $0.top.equalTo(self).offset(4)
//            $0.trailing.equalTo(self).inset(4)
//            $0.size.equalTo(40)
//        }
        myProfileImage.snp.makeConstraints {
            $0.leading.equalTo(self).offset(15)
            $0.size.equalTo(100)
            $0.top.equalTo(self).offset(15)
        }
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(myProfileImage.snp.trailing).offset(20)
            $0.top.equalToSuperview().offset(10)
        }
        myAllergyLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(10)
            $0.trailing.equalToSuperview().inset(20)
            $0.leading.equalTo(myProfileImage.snp.trailing).offset(20)
        }
        collectionView.snp.makeConstraints {
            $0.leading.equalTo(myProfileImage.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(myAllergyLabel.snp.bottom).offset(2)
            $0.bottom.equalToSuperview().inset(10)
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

    @objc private func tapEditButton() {
            onEditButtonTapped?()
    }
}

extension MyPageProfileView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allergiesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductTagCollectionViewCell", for: indexPath) as! ProductTagCollectionViewCell
        
        let data = allergiesList[indexPath.row]
        cell.updateBasicUI(data: data!)
        
        return cell
    }
}
