//
//  SearchViewController.swift
//  Allergykimi
//
//  Created by 은서우 on 3/12/24.
//

import UIKit
import Kingfisher

final class SearchViewController: BaseViewController {
    
    enum Section: Int, CaseIterable {
        case filiter
        case main
    }
    
    let viewModel = SearchViewModel()
    let searchBar = UISearchBar()
    private lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.delegate = self
        return view
    }()
    var filiterAllergies: [Allergy] = []
    private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>!
    var list: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filiterAllergies = UserDefaultsManager.shared.myAllergies.compactMap { $0 }
        configureDataSource()
        updateSnapshot()
        viewModel.outputData.bind { data in
            self.list = data
            self.updateSnapshot()
        }
    }
    
    // SnapShot
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(filiterAllergies, toSection: .filiter)
        snapshot.appendItems(list, toSection: .main)
        dataSource.apply(snapshot)
    }
    
    
    // dataSource 설정
    private func configureDataSource() {
        // 셀 등록
        let productsCellRegistertaion = productsCellRegistertaion()
        let filiterCellRegistertaion = filiterCellRegistertaion()
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            if let section = Section(rawValue: indexPath.section) {
                switch section {
                case .filiter:
                    let cell = collectionView.dequeueConfiguredReusableCell(using: filiterCellRegistertaion, for: indexPath, item: itemIdentifier as? Allergy)
                    
                    return cell
                case .main:
                    let cell = collectionView.dequeueConfiguredReusableCell(using: productsCellRegistertaion, for: indexPath, item: itemIdentifier as? Item)
                    
                    return cell
                }
            } else {
                return nil
            }
        })
    }
    
    
    override func configureHierarchy() {
        navigationItem.titleView = searchBar
        view.addSubview(collectionView)
        
    }
    
    @objc private func editSearchController() {
        viewModel.inputViewDidLoadTrigger.value = searchBar.text
    }
    
    override func configureView() {
        super.configureView()
        
        searchBar.searchTextField.addTarget(self, action: #selector(editSearchController), for: .editingChanged)
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIdx, environment in
            
            guard let section = Section(rawValue: sectionIdx) else { return nil }
            let layoutSection: NSCollectionLayoutSection
            switch section {
            case .filiter:
                let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(40),
                                                      heightDimension: .absolute(40))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(40),
                                                       heightDimension: .absolute(40))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.interItemSpacing = .fixed(10)
                
                layoutSection = NSCollectionLayoutSection(group: group)
                layoutSection.orthogonalScrollingBehavior = .continuous
                layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                return layoutSection
            case .main:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                      heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .fractionalHeight(1.0 / 2.5))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                layoutSection = NSCollectionLayoutSection(group: group)
                layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
                
                return layoutSection
            }
            
        }
        return layout
    }
}

extension SearchViewController {
    
    private func filiterCellRegistertaion() -> UICollectionView.CellRegistration<FiliterTagCollectionViewCell, Allergy> {
        
        UICollectionView.CellRegistration<FiliterTagCollectionViewCell, Allergy> { cell, indexPath, item in
            cell.updateTagUI(data: item)
            cell.cancelBtn.tag = indexPath.item
            cell.cancelBtn.addTarget(self, action: #selector(self.tapCancelBtn(_:)), for: .touchUpInside)
        }
    }
    
    @objc func tapCancelBtn(_ sender: UIButton) {
        let indexToRemove = sender.tag
        filiterAllergies.remove(at: indexToRemove)
        updateSnapshot()
    }
    
    private func productsCellRegistertaion() -> UICollectionView.CellRegistration<ProductsCollectionViewCell, Item> {
        
        UICollectionView.CellRegistration<ProductsCollectionViewCell, Item> { cell, indexPath, item in
            cell.filiterAllergies = self.filiterAllergies
            cell.updateUI(productData: item.item)
        }
    }
    
    
    
}

extension SearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let section = Section(rawValue: indexPath.section) {
            switch section {
            case .filiter:
                //code
                break
            case .main:
                let vc = ProductDetailViewController()
                vc.productData = list[indexPath.item].item
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
