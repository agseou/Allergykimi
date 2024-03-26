//
//  ProductHeaderReusableView.swift
//  Allergykimi
//
//  Created by 은서우 on 3/24/24.
//

import UIKit

class ProductHeaderReusableView: BaseCollectionReusableView {
    // MARK: - Components
    let title = UILabel()
    
    // MARK: - Functions
    override func configureHierarchy() {
        super.configureHierarchy()
        
        self.addSubview(title)
    }
    
    override func configureView() {
        super.configureView()
        
        title.font = AllergykimiFonts.TmoneyRoundWind.extraBold(size: 18)
        title.textColor = .black
        title.text = "Title"
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        title.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.verticalEdges.equalToSuperview().offset(4)
        }
    }
}
