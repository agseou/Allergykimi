//
//  ProfileView.swift
//  Allergykimi
//
//  Created by 은서우 on 3/23/24.
//

import UIKit

class ProfileView: BaseView {

    private let profileContentView = UIView()
    let profileImage = UIImageView()
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        addSubview(profileContentView)
        profileContentView.addSubview(profileImage)
    }
    override func configureView() {
        super.configureView()
        
        profileContentView.clipsToBounds = true
        profileContentView.backgroundColor = .accent
        profileImage.contentMode = .scaleAspectFill
        profileImage.image = UIImage(resource: .profile)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileContentView.layer.cornerRadius = profileContentView.bounds.height / 2
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        profileContentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        profileImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}
