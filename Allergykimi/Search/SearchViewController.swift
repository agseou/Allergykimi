//
//  SearchViewController.swift
//  Allergykimi
//
//  Created by 은서우 on 3/12/24.
//

import UIKit

class SearchViewController: BaseViewController {

    let searchController = UISearchController()
    private lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        
        return view
    }()
    
    override func configureHierarchy() {
        navigationItem.searchController = searchController
        
    }
    
    override func configureView() {
        super.configureView()
        
        
    }

    private func createLayout() -> UICollectionViewLayout {
        
        
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.backgroundColor = .white
        configuration.showsSeparators = false
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
}
