//
//  ProductDetailViewController.swift
//  Allergykimi
//
//  Created by 은서우 on 3/12/24.
//

import UIKit
import Kingfisher

final class ProductDetailViewController: BaseViewController {

    var productData: ItemInfo!
    
    private let productImageView = UIImageView()
    private let productName = UILabel()
    
    override func configureHierarchy() {
        view.addSubview(productImageView)
        view.addSubview(productName)
    }

    override func configureView() {
        super.configureView()
        
        productImageView.kf.setImage(with: URL(string: productData.imgurl1))
        
        productName.text = productData.prdlstNm
    }
    
    override func setConstraints() {
        productImageView.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(150)
        }
        productName.snp.makeConstraints {
            $0.top.equalTo(productImageView.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
}
