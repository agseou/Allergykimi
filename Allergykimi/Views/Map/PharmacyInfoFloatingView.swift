//
//  PharmacyInfoFloatingView.swift
//  Allergykimi
//
//  Created by 은서우 on 3/21/24.
//

import UIKit

class PharmacyInfoFloatingView: BaseView {
    
    let contentView = UIStackView()
    let pharmacyName = UILabel()
    let pharmacyTel = UIButton()
    let pharmacyAddr = UILabel()
    
    override func configureHierarchy() {
        addSubview(contentView)
        contentView.addArrangedSubview(pharmacyName)
        contentView.addArrangedSubview(pharmacyTel)
        contentView.addArrangedSubview(pharmacyAddr)
    }
    
    override func configureView() {
        backgroundColor = .white
        
        pharmacyTel.addTarget(self, action: #selector(tapTel), for: .touchUpInside)
        
        contentView.axis = .vertical
        contentView.distribution = .fill
        contentView.spacing = 4
        contentView.alignment = .leading
    }
    
    @objc private func tapTel() {
        let phoneNumber = "1234567890" // 전화하고 싶은 번호로 교체하세요.
        if let phoneURL = URL(string: "tel://\(phoneNumber)") {
            
            if UIApplication.shared.canOpenURL(phoneURL) {
                UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
            } else {
                // 전화 기능을 지원하지 않는 장치에서의 오류 처리
                print("이 장치에서는 전화 기능을 사용할 수 없습니다.")
            }
        }
    }
    
    override func setConstraints() {
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(4)
        }
    }
    
}
