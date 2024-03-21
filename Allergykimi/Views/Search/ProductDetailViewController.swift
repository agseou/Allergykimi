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
    let viewModel = ProductDetailViewModel()
    var productNo: String!
    var productData: ItemInfo!
    
    private lazy var productImagesScrollView = {
        let view = UIScrollView()
        return view
    }()
    private var dataSource: UICollectionViewDiffableDataSource<Section, String>!
    private var allergyList: [Allergy] = []
    private let productName = UILabel()
    private let allergyLabel = UILabel()
    private let productRawmtrl = UILabel()
    private let productNutrient = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.inputViewDidLoadTrigger.value = productNo
        viewModel.outputData.bind { data in
            guard let data = data else { return }
            self.productData = data
            self.updateUI(data: data)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let data = recentProduct(prdlstReportNo: productData.prdlstReportNo, prductName: productData.prdlstNm, prductImgURL: productData.imgurl1, allergy:  productData.allergy, prdkind:  productData.prdkind)
        repository.createItem(data)
    }
    
    override func configureHierarchy() {
        view.addSubview(productImagesScrollView)
        view.addSubview(productName)
        view.addSubview(allergyLabel)
        view.addSubview(productRawmtrl)
        view.addSubview(productNutrient)
    }
    
    override func configureView() {
        super.configureView()
        
        productName.text = "productName"
        
        allergyLabel.text = "allergy"
        
        productRawmtrl.text = "productRawmtrl"
        productRawmtrl.numberOfLines = 0
        
        productNutrient.text = "productNutrient"
        productNutrient.numberOfLines = 0
    }
    
    override func setConstraints() {
        productImagesScrollView.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(200)
        }
        productName.snp.makeConstraints {
            $0.top.equalTo(productImagesScrollView.snp.bottom).offset(20)
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
    
    
    func updateUI(data: ItemInfo) {
        productName.text = data.prdlstNm
        allergyLabel.text = data.allergy.findMatchingAllergiesString()
        productRawmtrl.text = data.rawmtrl
        productNutrient.text = data.nutrient
    }
}
