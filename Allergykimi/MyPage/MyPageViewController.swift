//
//  MyPageViewController.swift
//  Allergykimi
//
//  Created by 은서우 on 3/11/24.
//

import UIKit

final class MyPageViewController: BaseViewController {

    private var scrollView = UIScrollView()
    private let profileView = ProfileView()
    //private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout)
    
    override func configureHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(profileView)
    }
    
    override func configureView() {
        super.configureView()
        
        profileView.backgroundColor = .blue
    }
    
    override func setConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        profileView.snp.makeConstraints {
            $0.width.top.equalTo(scrollView)
            $0.height.equalTo(200)
        }
    }
}
