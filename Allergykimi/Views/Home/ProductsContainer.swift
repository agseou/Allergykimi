//
//  ProductsContainer.swift
//  Allergykimi
//
//  Created by 은서우 on 3/23/24.
//

import UIKit

class ProductsContainer: BaseView {
    
    // MARK: - Components
    lazy var productCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    // MARK: - Properties
    var tapProductCell: ((String) -> Void)?
    
    lazy var repository: RealmRepository = {
        do {
            return try RealmRepository()
        } catch {
            fatalError("Failed to initialize the RealmRepository: \(error)")
        }
    }()
    var recentList: [recentProduct] = []
    var favoriteList: [favoriteProduct] = []
    
    
    
    // MARK: - Functions
    override func setupDelegate() {
        super.setupDelegate()
        
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        addSubview(productCollectionView)
    }
    
    override func configureView() {
        super.configureView()
        
        productCollectionView.register(EmptyCollectionViewCell.self, forCellWithReuseIdentifier: "EmptyCollectionViewCell")
        productCollectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: "ProductCollectionViewCell")
        productCollectionView.register(ProductHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        productCollectionView.isScrollEnabled = false
        
        recentList = Array(repository.fetchItem(ofType: recentProduct.self))
    }
    
    
    override func setConstraints() {
        super.setConstraints()
        
        productCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func updateLists() {
        
        recentList = Array(self.repository.fetchItem(ofType: recentProduct.self)).reversed()
        favoriteList = Array(self.repository.fetchItem(ofType: favoriteProduct.self)).reversed()
        DispatchQueue.main.async {
            self.productCollectionView.reloadData()
        }
    }
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            // 아이템 크기 설정
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // 그룹 크기 설정
            let groupSize: NSCollectionLayoutSize
            if (sectionIndex == 0 && self.recentList.isEmpty) || (sectionIndex == 1 && self.favoriteList.isEmpty) {
                // 비어 있는 경우
                groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
            } else {
                // 데이터가 있는 경우
                groupSize = NSCollectionLayoutSize(widthDimension: .absolute(230), heightDimension: .absolute(100))
            }
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 4
            section.orthogonalScrollingBehavior = .continuous
            
            // 헤더 설정
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            section.boundarySupplementaryItems = [header]
            
            return section
        }
        return layout
    }
    
}

// MARK: - CollectionViewDelegate
extension ProductsContainer: UICollectionViewDelegate, UICollectionViewDataSource {
    // numberOfSections
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return max(1, recentList.count)
        case 1:
            return max(1, favoriteList.count)
        default:
            return 0
        }
        
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.section == 0 && recentList.isEmpty) || (indexPath.section == 1 && favoriteList.isEmpty) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyCollectionViewCell", for: indexPath) as! EmptyCollectionViewCell
            cell.setMessage(indexPath.section == 0 ? "최근 본 상품이 없습니다." : "즐겨찾기한 상품이 없습니다.")
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        if indexPath.section == 0 {
            cell.updateUI(productData: recentList[indexPath.item])
        }else {
            cell.updateUI(productData:favoriteList[indexPath.item])
        }
        return cell
    }
    
    // Header Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50)
    }
    
    
    // Header configuration
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView()}
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! ProductHeaderReusableView
        
        if indexPath.section == 0 {
            header.title.text = "최근 본 상품"
        } else {
            header.title.text = "즐겨찾기한 상품"
        }
        
        return header
    }
    
    // didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 && !recentList.isEmpty {
            let selectedProduct = recentList[indexPath.item]
            tapProductCell?(selectedProduct.prdlstReportNo)
        } else if indexPath.section == 1 && !favoriteList.isEmpty {
            let selectedProduct = favoriteList[indexPath.item]
            tapProductCell?(selectedProduct.prdlstReportNo)
        }
    }
}

