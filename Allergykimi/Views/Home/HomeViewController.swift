//
//  HomeViewController.swift
//  Allergykimi
//
//  Created by 은서우 on 3/11/24.
//

import UIKit

class HomeViewController: BaseViewController {

    let searchBar = UISearchBar()
    
    override func configureHierarchy() {
        view.addSubview(searchBar)
    }
    
    override func configureView() {
        super.configureView()
        print(UserDefaultsManager.shared.myAllergies)
        searchBar.delegate = self
        searchBar.placeholder = "식품을 검색하세요!"
        searchBar.searchBarStyle = .minimal
    }

    override func setConstraints() {
        searchBar.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(100)
        }
    }
}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let vc = SearchViewController()
        //vc.navigationItem.searchController?
        navigationController?.pushViewController(vc, animated: true)
    }
}
