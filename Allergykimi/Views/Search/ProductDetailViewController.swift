//
//  ProductDetailViewController.swift
//  Allergykimi
//
//  Created by 은서우 on 3/12/24.
//

import UIKit
import Kingfisher

final class ProductDetailViewController: BaseViewController {
    
    enum Section: Int, CaseIterable {
        case main
    }
    
    let repository = RealmRepository()
    var productData: ItemInfo!
    
    private lazy var productImagesCollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        return view
    }()
    private var dataSource: UICollectionViewDiffableDataSource<Section, String>!
    private var imageURLList: [String] = []
    private var allergyList: [Allergy] = []
    private let productName = UILabel()
    private let allergyLabel = UILabel()
    private let productRawmtrl = UILabel()
    private let productNutrient = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageURLList.append(productData.imgurl1)
        if productData.imgurl1 != productData.imgurl2 {
            imageURLList.append(productData.imgurl2)
        }
        configureDataSource()
        updateSnapshot()
        allergyList = productData.allergy.findMatchingAllergies()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let data = recentProduct(prductName: productData.prdlstNm, prductImgURL: productData.imgurl1, allergy:  productData.allergy, prdkind:  productData.prdkind)
        repository.createItem(data)
    }
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(imageURLList)
        dataSource.apply(snapshot) // reloadData
    }
    
    private func configureDataSource() {
        
        let cellResitration = UICollectionView.CellRegistration<PagingProductImageCollectionViewCell, String> { cell, indexPath, itemIdentifier in
            cell.updateUI(url: itemIdentifier)
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: productImagesCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            if let section = Section(rawValue: indexPath.section) {
                switch section {
                case .main:
                    let cell = collectionView.dequeueConfiguredReusableCell(using: cellResitration, for: indexPath, item: itemIdentifier)
                    
                    return cell
                }
            } else {
                return nil
            }
        })
        
    }
    
    override func configureHierarchy() {
        view.addSubview(productImagesCollectionView)
        view.addSubview(productName)
        view.addSubview(allergyLabel)
        view.addSubview(productRawmtrl)
        view.addSubview(productNutrient)
    }
    
    override func configureView() {
        super.configureView()
        
        productName.text = productData.prdlstNm
        
        allergyLabel.text = productData.allergy.findMatchingAllergiesString()
        
        productRawmtrl.text = productData.rawmtrl
        productRawmtrl.numberOfLines = 0
        
        productNutrient.text = productData.nutrient
        productNutrient.numberOfLines = 0
    }
    
    override func setConstraints() {
        productImagesCollectionView.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(200)
        }
        productName.snp.makeConstraints {
            $0.top.equalTo(productImagesCollectionView.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        allergyLabel.snp.makeConstraints {
            $0.top.equalTo(productName.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        productRawmtrl.snp.makeConstraints {
            $0.top.equalTo(allergyLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        productNutrient.snp.makeConstraints {
            $0.top.equalTo(productRawmtrl.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(1.0))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .paging
            
            return section
        }
        return layout
    }
}
