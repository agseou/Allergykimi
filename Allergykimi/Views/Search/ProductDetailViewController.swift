//
//  ProductDetailViewController.swift
//  Allergykimi
//
//  Created by 은서우 on 3/12/24.
//

import UIKit
import Kingfisher

final class ProductDetailViewController: BaseNavBarViewController {
    
    // MARK: - Components
    private let likeButton = UIButton()
    private let scrollView =  UIScrollView()
    private let stackView = UIStackView()
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
    
    
    // MARK: - Properties
    let repository = RealmRepository()
    let viewModel = ProductDetailViewModel()
    
    var productNo: String!
    var productData: ItemInfo!
    private var allergyList: [Allergy] = [] {
        didSet { tagCollectionView.reloadData() }
    }
    
    // MARK: - Life Cycle Functions
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
        let data = recentProduct(prdlstReportNo: productData.prdlstReportNo, prductName: productData.prdlstNm, prductImgURL: productData.imgurl1, allergy:  productData.allergy, prdkind:  productData.prdkind, dateAdded: Date())
        repository.addOrUpdateRecentProduct(data)
    }
    
    // MARK: - Functions
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        isHiddenNavBarSettingsButton(true)
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        contentView.addSubview(scrollView)
        scrollView.addSubviews([imageView, stackView])
        stackView.addArrangedSubview(productName)
        stackView.addArrangedSubview(tagCollectionView)
        stackView.addArrangedSubview(productRawmtrl)
        stackView.addArrangedSubview(productNutrient)
        imageView.addSubview(likeButton)
    }
    
    override func configureView() {
        super.configureView()
        
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        
        productName.text = "productName"
        productName.numberOfLines = 0
        productName.font = .systemFont(ofSize: 24, weight: .bold)
        
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        stackView.distribution = .fill
        
        productRawmtrl.text = "productRawmtrl"
        productRawmtrl.numberOfLines = 0
        
        productNutrient.text = "productNutrient"
        productNutrient.numberOfLines = 0
        
        if repository.isFavoriteProductExists(withPrdlstReportNo: productNo) {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        likeButton.addTarget(self, action: #selector(toggleLike), for: .touchUpInside)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
        imageView.snp.makeConstraints {
            $0.top.width.horizontalEdges.equalTo(scrollView)
            $0.height.equalTo(170)
        }
        likeButton.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().inset(4)
        }
        stackView.snp.makeConstraints {
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
    
    @objc private func toggleLike() {
        if repository.isFavoriteProductExists(withPrdlstReportNo: productData.prdlstReportNo) {
            // 이미 즐겨찾기에 추가된 상품이라면 삭제
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            repository.deleteFavoriteProduct(withPrdlstReportNo: productData.prdlstReportNo)
        } else {
            // 즐겨찾기에 없는 상품이라면 추가
            let newFavoriteProduct = favoriteProduct(prdlstReportNo: productData.prdlstReportNo, prductName: productData.prdlstNm, prductImgURL: productData.imgurl1, allergy: productData.allergy)
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            repository.addFavoriteProduct(newFavoriteProduct)
        }
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
