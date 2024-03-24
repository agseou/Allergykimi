//
//  EmptyCollectionViewCell.swift
//  Allergykimi
//
//  Created by 은서우 on 3/24/24.
//

import UIKit

class EmptyCollectionViewCell: BaseCollectionViewCell {
    
    private let messageLabel = UILabel()
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        contentView.addSubview(messageLabel)
    }
    override func configureView() {
        super.configureView()
        
        messageLabel.text = "데이터가 없습니다."
        messageLabel.textColor = .gray
        messageLabel.font = AllergykimiFonts.TmoneyRoundWind.extraBold(size: 15)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        messageLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func setMessage(_ message: String) {
        messageLabel.text = message
    }
    
}
