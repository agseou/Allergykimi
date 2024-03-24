//
//  HomeViewController.swift
//  Allergykimi
//
//  Created by 은서우 on 3/11/24.
//

import UIKit

class HomeViewController: BaseNavBarViewController {
    
    // MARK: - Components
    private let scrollView = UIScrollView()
    private let searchBarContainer = SearchBarContainer()
    private let productsContainer = ProductsContainer()
    private let bannerContainer = BannerContainer()
    
    // MARK: - Properties
    
    // MARK: - Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBarContainer.onSearchBarButtonTapped = { [weak self] in
            let vc = SearchViewController()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        productsContainer.updateLists()
    }
    
    // MARK: - Functions
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        isHiddenNavBarBackButton(true)
        setNavBarBackgroundColor(.accent)
        setNavLogoImageColor(.white)
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        contentView.addSubview(scrollView)
        scrollView.addSubviews([searchBarContainer, productsContainer, bannerContainer])
    }
    
    override func configureView() {
        super.configureView()
        
        productsContainer.tapProductCell = { [weak self] data in
            let vc = ProductDetailViewController()
            vc.productNo = data
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
        searchBarContainer.snp.makeConstraints {
            $0.horizontalEdges.width.top.equalTo(scrollView)
            $0.height.equalTo(160)
        }
        productsContainer.snp.makeConstraints {
            $0.top.equalTo(searchBarContainer.snp.bottom).offset(40)
            $0.height.equalTo(400)
            $0.horizontalEdges.width.equalTo(scrollView)
        }
        bannerContainer.snp.makeConstraints {
            $0.top.equalTo(productsContainer.snp.bottom).offset(40)
            $0.horizontalEdges.width.bottom.equalTo(scrollView)
        }
    }
    
}
