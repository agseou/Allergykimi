//
//  ProductDetailViewController.swift
//  Allergykimi
//
//  Created by 은서우 on 3/12/24.
//

import UIKit
import Kingfisher

final class ProductDetailViewController: BaseViewController {
    
    private let scrollView =  UIScrollView()
    private let contentView = UIStackView()
    
    private let imageView =  UIImageView()
    private let productName = UILabel()
    lazy var tagCollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.isScrollEnabled = false
        view.delegate = self
        view.dataSource = self
        view.register(ProductTagCollectionViewCell.self, forCellWithReuseIdentifier: "ProductTagCollectionViewCell")
        return view
    }()
    private let productRawmtrl = UILabel()
    private let productNutrient = UILabel()
    
    let repository = RealmRepository()
    let viewModel = ProductDetailViewModel()
    
    var productNo: String!
    var productData: ItemInfo!
    private var allergyList: [Allergy] = [] {
        didSet { tagCollectionView.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.inputViewDidLoadTrigger.value = productNo
        viewModel.outputData.bind { data in
            guard let data = data else { return }
            self.productData = data
            self.allergyList = self.productData.allergy.findMatchingAllergies()
            self.updateUI()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let data = recentProduct(prdlstReportNo: productData.prdlstReportNo, prductName: productData.prdlstNm, prductImgURL: productData.imgurl1, allergy:  productData.allergy, prdkind:  productData.prdkind)
        repository.createItem(data)
    }
    
    override func configureHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(contentView)
        contentView.addArrangedSubview(productName)
        contentView.addArrangedSubview(tagCollectionView)
        contentView.addArrangedSubview(productRawmtrl)
        contentView.addArrangedSubview(productNutrient)
    }
    
    override func configureView() {
        super.configureView()
        
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFit
        
        productName.text = "productName"
        productName.numberOfLines = 0
        productName.font = .systemFont(ofSize: 24, weight: .bold)
        
        contentView.axis = .vertical
        contentView.spacing = 5
        contentView.alignment = .leading
        contentView.distribution = .fill
        
        productRawmtrl.text = "productRawmtrl"
        productRawmtrl.numberOfLines = 0
        
        productNutrient.text = "productNutrient"
        productNutrient.numberOfLines = 0
    }
    
    override func setConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        imageView.snp.makeConstraints {
            $0.top.width.horizontalEdges.equalTo(scrollView)
            $0.height.equalTo(170)
        }
        contentView.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(scrollView).inset(10)
            $0.bottom.equalTo(scrollView)
        }
        tagCollectionView.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(40)
            $0.width.equalToSuperview()
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
    
    func updateUI() {
        productName.text = productData.prdlstNm
        imageView.kf.setImage(with: URL(string: productData.imgurl1))
        productRawmtrl.text = productData.rawmtrl
        productNutrient.text = productData.nutrient
    }
}

extension ProductDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allergyList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductTagCollectionViewCell", for: indexPath) as! ProductTagCollectionViewCell
        
        let data = allergyList[indexPath.item]
        cell.tagLabel.text = data.name.first
        
        return cell
    }
}
