//
//  SearchViewController.swift
//  Allergykimi
//
//  Created by 은서우 on 3/12/24.
//

import UIKit
import Kingfisher

final class SearchViewController: BaseViewController {
    
    enum Section: CaseIterable {
        case main
    }
    
    let viewModel = SearchViewModel()
    private let searchController = UISearchController()
    private lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        return view
    }()
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    var list: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDataSource()
        updateSnapshot()
        viewModel.outputData.bind { data in
            self.list = data
            self.updateSnapshot()
        }
    }
    
    // SnapShot
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(list)
        dataSource.apply(snapshot)
    }
    
    // dataSource 설정
    private func configureDataSource() {
        // 셀 등록
        let cellResitration = UICollectionView.CellRegistration<ProductsCollectionViewCell, Item> { cell, indexPath, item in
            print(item)
            cell.productImageView.kf.setImage(with: URL(string: item.item.imgurl1))
            cell.productName.text = item.item.prdlstNm
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellResitration, for: indexPath, item: itemIdentifier)
            
            return cell
        })
    }
    
    override func configureHierarchy() {
        navigationItem.searchController = searchController
        view.addSubview(collectionView)
        
    }
    
    @objc private func editSearchController() {
        viewModel.inputViewDidLoadTrigger.value = searchController.searchBar.text
    }
    
    override func configureView() {
        super.configureView()
        
        searchController.searchBar.searchTextField.addTarget(self, action: #selector(editSearchController), for: .editingChanged)
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(1.0 / 3.0))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            // 섹션을 설정합니다.
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0) // 섹션의 contentInsets를 설정합니다.
            
            return section
        }
        return layout
    }
}
