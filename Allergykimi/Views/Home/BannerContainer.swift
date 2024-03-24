//
//  BannerContainer.swift
//  Allergykimi
//
//  Created by 은서우 on 3/24/24.
//

import UIKit

class BannerContainer: BaseView {
    
    
    // MARK: - Components
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    // MARK: - Properties
    
    struct BannerBox {
        let title: String
        let subTitle: String
        let image: UIImage
        let url: String
    }
    let bannerdata = [BannerBox(title: "표기대상 알레르기 유발 물질을 알아보세요", 
                                subTitle: "",
                                image: UIImage(resource: .noCrustaceans),
                                url: "https://www.foodsafetykorea.go.kr/portal/board/boardDetail.do?menu_no=3120&menu_grp=MENU_NEW01&bbs_no=bbs001&ntctxt_no=1091412"),
                      BannerBox(title: "청록 호박 캠페인에 대해 알아보세요", 
                                subTitle: "배려담긴 캠페인",
                                image: UIImage(resource: .bread),
                                url: "https://www.foodallergy.org/our-initiatives/awareness-campaigns/living-teal/teal-pumpkin-project")]
    
    // MARK: - Function
    override func setupDelegate() {
        super.setupDelegate()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        addSubview(collectionView)
    }
    
    override func configureView() {
        super.configureView()
        
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumInteritemSpacing = 4
        return layout
    }
    
}

extension BannerContainer: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 데이터 배열 크기의 100배를 반환하여 인피니트 스크롤 효과를 만듭니다.
        return bannerdata.count * 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        //as! CustomCell
        //        // 실제 데이터 인덱스를 계산합니다.
        //        let dataIndex = indexPath.item % data.count
        //        // 데이터를 셀에 구성합니다.
        //        cell.configure(with: data[dataIndex])
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPosition = scrollView.contentOffset.x
        let contentWidth = scrollView.contentSize.width
        
        // 시작 또는 끝 지점에 도달했을 때 중간 지점으로 조정합니다.
        if currentPosition < contentWidth / 4 || currentPosition > contentWidth / 4 * 3 {
            let newPosition = contentWidth / 2
            scrollView.setContentOffset(CGPoint(x: newPosition, y: 0), animated: false)
            // 여기서 newPosition은 스크롤 위치를 중간 지점으로 조정하는 데 사용됩니다.
            // 이는 사용자가 무한 스크롤 효과를 체감하게 하는 핵심입니다.
        }
    }
}
