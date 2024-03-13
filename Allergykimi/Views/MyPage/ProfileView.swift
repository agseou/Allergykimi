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
    
    override func configureHierarchy() {
        addSubview(myProfileImage)
        addSubview(nameLabel)
    }
    
    override func configureView() {
        myProfileImage.backgroundColor = .yellow
        DispatchQueue.main.async {
            self.myProfileImage.layer.cornerRadius =  self.myProfileImage.bounds.width/2
        }
        
        nameLabel.text = "NICKNAME"
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
}
