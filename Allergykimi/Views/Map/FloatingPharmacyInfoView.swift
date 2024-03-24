//
//  PharmacyInfoFloatingView.swift
//  Allergykimi
//
//  Created by 은서우 on 3/21/24.
//

import UIKit

class FloatingPharmacyInfoView: BaseView {
    

    // MARK: - Components
    let contentView = UIStackView()
    let pharmacyName = UILabel()
    let pharmacyTel = UIButton()
    let pharmacyAddr = UILabel()
    
    
    // MARK: - Properties
    let pharmacy: [PharmacyInfo] = []
    var phoneNumber: String!
    
    // MARK: - Functions
    override func configureHierarchy() {
        super.configureHierarchy()
        
        addSubview(contentView)
        contentView.addArrangedSubview(pharmacyName)
        contentView.addArrangedSubview(pharmacyTel)
        contentView.addArrangedSubview(pharmacyAddr)
    }
    
    override func configureView() {
        super.configureView()
        
        backgroundColor = .white
        self.layer.cornerRadius = 10
        
        contentView.axis = .vertical
        contentView.distribution = .fillProportionally
        contentView.spacing = 0
        contentView.alignment = .leading
        
        pharmacyName.font = AllergykimiFonts.TmoneyRoundWind.regular(size: 17)
        
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .accent
        config.image = UIImage(systemName: "link")
        config.contentInsets = .zero
        pharmacyTel.configuration = config
        pharmacyTel.addTarget(self, action: #selector(tapTel), for: .touchUpInside)
        
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
        pharmacyTel.configuration?.title = data.dutyTel1
        pharmacyAddr.text = data.dutyAddr
    }
    
    override func setConstraints() {
        super.setConstraints()
        contentView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(4)
            $0.horizontalEdges.equalToSuperview().inset(8)
        }
    }
    
}
