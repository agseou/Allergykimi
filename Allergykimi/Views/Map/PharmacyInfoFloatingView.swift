//
//  PharmacyInfoFloatingView.swift
//  Allergykimi
//
//  Created by 은서우 on 3/21/24.
//

import UIKit

class PharmacyInfoFloatingView: BaseView {
    
    let pharmacy: [PharmacyInfo] = []
    var phoneNumber: String!
    
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
        pharmacyTel.setTitleColor(.black, for: .normal)
        pharmacyAddr.numberOfLines = 0
    }
    
    @objc private func tapTel() {
        if let phoneURL = URL(string: "tel://\(phoneNumber ?? "")") {
            
            if UIApplication.shared.canOpenURL(phoneURL) {
                UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
            } else {
                print("이 장치에서는 전화 기능을 사용할 수 없습니다.")
            }
        }
    }
    
    func updateView(data: PharmacyInfo) {
        phoneNumber = data.dutyTel1
        pharmacyName.text = data.dutyName
        pharmacyTel.setTitle(data.dutyTel1, for: .normal)
        pharmacyAddr.text = data.dutyAddr
    }
    
    override func setConstraints() {
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(4)
        }
    }
    
}
