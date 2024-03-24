//
//  MyPageViewController.swift
//  Allergykimi
//
//  Created by 은서우 on 3/11/24.
//

import UIKit

final class MyPageViewController: BaseNavBarViewController {
    
    // MARK: - Components
    private var scrollView = UIScrollView()
    private let profileView = MyPageProfileView()
    private let subView = UIView()
    private let subViewLabel = UILabel()
    
    // MARK: - Functions
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        isHiddenNavBarBackButton(true)
    }
    
    
    // MARK: - Functions
    override func configureHierarchy() {
        super.configureHierarchy()
        
        contentView.addSubview(scrollView)
        scrollView.addSubviews([profileView, subView])
        subView.addSubview(subViewLabel)
    }
    
    override func configureView() {
        super.configureView()
//        profileView.onEditButtonTapped = { [weak self] in
//            let editPageVC = RegisterProfileViewController()
//            self?.navigationController?.pushViewController(editPageVC, animated: true)
//        }
        
        subView.backgroundColor = .systemGray6
        
        subViewLabel.text = "새로운 기능을 준비 중 입니다!"
        subViewLabel.font = AllergykimiFonts.TmoneyRoundWind.regular(size: 17)
        subViewLabel.textColor = .gray
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
        profileView.snp.makeConstraints {
            $0.width.horizontalEdges.top.equalTo(scrollView)
            $0.height.equalTo(160)
        }
        subView.snp.makeConstraints {
            $0.width.horizontalEdges.equalTo(scrollView)
            $0.top.equalTo(profileView.snp.bottom).offset(20)
            $0.height.greaterThanOrEqualTo(400)
            $0.bottom.equalTo(scrollView)
        }
        subViewLabel.snp.makeConstraints {
            $0.center.equalTo(subView)
        }
    }
}
