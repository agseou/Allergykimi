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
    
    private var productImageScrollView = UIScrollView()
    private var productImagePageControl = UIPageControl()
    private var productImageURLs: [String] = []
    private var allergyList: [Allergy] = []
    private let productName = UILabel()
    private let allergyLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        allergyList = productData.allergy.findMatchingAllergies()
    }
    
    override func configureHierarchy() {
        view.addSubview(productImageScrollView)
        view.addSubview(productImagePageControl)
        view.addSubview(productName)
        view.addSubview(allergyLabel)
    }
    
    override func configureView() {
        super.configureView()
        productImageScrollView.isPagingEnabled = true
        productImageScrollView.showsHorizontalScrollIndicator = true
        productImageScrollView.delegate = self
        
        productName.text = productData.prdlstNm
        
        allergyLabel.text = productData.allergy.findMatchingAllergiesString()
        
        setupURLsToImages()
    }
    
    override func setConstraints() {
        productImageScrollView.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(150)
        }
        productImagePageControl.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(productImageScrollView.snp.bottom).offset(10)
        }
        productName.snp.makeConstraints {
            $0.top.equalTo(productImageScrollView.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        allergyLabel.snp.makeConstraints {
            $0.top.equalTo(productName.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    func setupURLsToImages() {
        productImageURLs.append(productData.imgurl1)
        productImageURLs.append(productData.imgurl2)
        productImagePageControl.numberOfPages = productImageURLs.count
        
        for (index, urlString) in productImageURLs.enumerated() {
            guard let url = URL(string: urlString) else { continue }
            let imageView = UIImageView()
            imageView.kf.setImage(with: url)
            imageView.contentMode = .scaleAspectFit
            productImageScrollView.addSubview(imageView)
            
            imageView.snp.makeConstraints { make in
                make.width.equalTo(productImageScrollView)
                make.height.equalTo(productImageScrollView)
                make.top.bottom.equalTo(productImageScrollView)
                make.leading.equalTo(productImageScrollView.snp.leading).offset(view.frame.size.width * CGFloat(index))
            }
        }
        
        productImageScrollView.contentSize = CGSize(width: view.frame.width * CGFloat(productImageURLs.count), height: 150)
    }
}

extension ProductDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIdx = round(scrollView.contentOffset.x / view.frame.width)
        productImagePageControl.currentPage = Int(pageIdx)
    }
    
}
