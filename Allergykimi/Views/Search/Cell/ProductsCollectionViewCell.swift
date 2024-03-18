//
//  ProductsCollectionViewCell.swift
//  Allergykimi
//
//  Created by 은서우 on 3/12/24.
//

import UIKit

final class ProductsCollectionViewCell: BaseCollectionViewCell {

    private let productImageView = UIImageView()
    private let productName = UILabel()
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.isScrollEnabled = false
        view.delegate = self
        view.dataSource = self
        view.register(ProductTagCollectionViewCell.self, forCellWithReuseIdentifier: "ProductTagCollectionViewCell")
        return view
    }()
    var productAllergiesTaglist: [Allergy] = [] {
        didSet { collectionView.reloadData() }
    }
    var filiterAllergies: [Allergy] = []
    
    override func configureHierarchy() {
        contentView.addSubview(productImageView)
        contentView.addSubview(productName)
        contentView.addSubview(collectionView)
    }
    
    override func configureView() {
        productImageView.backgroundColor = .gray
        DispatchQueue.main.async {
            self.productImageView.layer.cornerRadius = 15
        }
        productImageView.clipsToBounds = true
        productName.text = "상품 이름"
        productName.font = .systemFont(ofSize: 17, weight: .bold)
    }
    
    override func setConstraints() {
        productImageView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(contentView).inset(10)
            $0.height.lessThanOrEqualTo(contentView).multipliedBy(0.6)
            $0.top.equalTo(contentView).offset(10)
        }
        productName.snp.makeConstraints {
            $0.top.equalTo(productImageView.snp.bottom).offset(5)
            $0.horizontalEdges.equalTo(contentView).inset(10)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(productName.snp.bottom).offset(5)
            $0.horizontalEdges.equalTo(contentView).inset(10)
            $0.bottom.equalTo(contentView)
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
       let layout = LeftAlignedCollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }
    
    func updateUI(productData: ItemInfo) {
        productImageView.kf.setImage(with: URL(string: productData.imgurl1))
        productName.text = productData.prdlstNm
        productAllergiesTaglist = productData.allergy.findMatchingAllergies()
    }
}

extension ProductsCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productAllergiesTaglist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductTagCollectionViewCell", for: indexPath) as! ProductTagCollectionViewCell
        
        let data = productAllergiesTaglist[indexPath.row]
        cell.updateUI(data: data, list: filiterAllergies)
        
        return cell
    }
}
