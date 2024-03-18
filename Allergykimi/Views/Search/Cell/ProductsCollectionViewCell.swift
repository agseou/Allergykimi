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
        view.delegate = self
        view.dataSource = self
        view.register(ProductTagCollectionViewCell.self, forCellWithReuseIdentifier: "ProductTagCollectionViewCell")
        view.backgroundColor = .blue
        return view
    }()
    var list: [Allergy] = [] {
        didSet { collectionView.reloadData() }
    }
    
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
        productName.text = "상품 이름"
        productName.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    override func setConstraints() {
        productImageView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(contentView).inset(10)
            $0.top.equalTo(contentView).offset(10)
        }
        productName.snp.makeConstraints {
            $0.top.equalTo(productImageView.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(contentView).inset(10)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(productName.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(contentView).inset(10)
            $0.bottom.equalTo(contentView)
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
       let layout = LeftAlignedCollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 100, height: 40)
        //UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }
    
    func updateUI(productData: ItemInfo) {
        productImageView.kf.setImage(with: URL(string: productData.imgurl1))
        productName.text = productData.prdlstNm
        list = productData.allergy.findMatchingAllergies()
        collectionView.reloadData()
    }
}

extension ProductsCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("numberOfItemsInSection: \(list.count)")
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductTagCollectionViewCell", for: indexPath) as! ProductTagCollectionViewCell
        
        let data = list[indexPath.row]
        cell.updateUI(data: data)
        print("cellForItemAt: \(indexPath.row)")
        
        return cell
    }
}
