//
//  HomeViewController.swift
//  Allergykimi
//
//  Created by 은서우 on 3/11/24.
//

import UIKit

class HomeViewController: BaseViewController {
    
    enum Section: Int, CaseIterable {
        case banner
        case searchBar
        case category
        case magagine
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>!
    private lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.delegate = self
        return view
    }()
    
    override func configureHierarchy() {
        view.addSubview(collectionView)
    }
    
    override func configureView() {
        super.configureView()
        
        configureDataSource()
        updateSnapshot()
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    let bannerdata = [BannerBox(title: "표기대상 알레르기 유발 물질을 알아보세요", subTitle: "", image: UIImage(resource: .noCrustaceans), url: "https://www.foodsafetykorea.go.kr/portal/board/boardDetail.do?menu_no=3120&menu_grp=MENU_NEW01&bbs_no=bbs001&ntctxt_no=1091412"),
                      BannerBox(title: "청록 호박 캠페인에 대해 알아보세요", subTitle: "배려담긴 캠페인", image: UIImage(resource: .bread), url: "https://www.foodallergy.org/our-initiatives/awareness-campaigns/living-teal/teal-pumpkin-project")]
    
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(bannerdata, toSection: .banner)
        snapshot.appendItems([UUID()], toSection: .searchBar)
        snapshot.appendItems([UUID()], toSection: .category)
        dataSource.apply(snapshot)
    }
    
    private func configureDataSource() {
        // 셀 등록
        let bannerCellRegistertaion = bannerCellRegistertaion()
        let searchCellRegistertaion = searchCellRegistertaion()
        let categoryCellRegistertaion = categoryCellRegistertaion()
        let recentlyCellRegistertaion = recentlyCellRegistertaion()
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            if let section = Section(rawValue: indexPath.section) {
                switch section {
                case .banner:
                    let cell = collectionView.dequeueConfiguredReusableCell(using: bannerCellRegistertaion, for: indexPath, item: itemIdentifier as? BannerBox)
                    
                    return cell
                case .searchBar:
                    let cell = collectionView.dequeueConfiguredReusableCell(using: searchCellRegistertaion, for: indexPath, item: itemIdentifier as? UUID)
                    
                    return cell
                case .category:
                    let cell = collectionView.dequeueConfiguredReusableCell(using: categoryCellRegistertaion, for: indexPath, item: itemIdentifier as? UUID)
                    
                    return cell
                case .magagine:
                    let cell = collectionView.dequeueConfiguredReusableCell(using: recentlyCellRegistertaion, for: indexPath, item: itemIdentifier as? Int)
                    
                    return cell
                }
            } else {
                return nil
            }
        })
    }
    
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIdx, environment in
            guard let section = Section(rawValue: sectionIdx) else { return nil }
            let layoutSection: NSCollectionLayoutSection
            switch section {
            case .banner:
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .absolute(150))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = .init(top: 0, leading: 15, bottom: 0, trailing: 15)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .absolute(150))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                layoutSection = NSCollectionLayoutSection(group: group)
                layoutSection.orthogonalScrollingBehavior = .paging
                return layoutSection
                
            case .searchBar:
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .absolute(100))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .absolute(100))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                layoutSection = NSCollectionLayoutSection(group: group)
                layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)
                return layoutSection
                
            case .category:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .absolute(100))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .absolute(100))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                layoutSection = NSCollectionLayoutSection(group: group)
                layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 15, bottom: 15, trailing: 15)
                
                return layoutSection
                
            case .magagine:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 8)
               
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6),
                    heightDimension: .fractionalHeight(0.3))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,subitems: [item])
                
                // header
//                let headerSize = NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(1.0),
//                    heightDimension: .absolute(40)
//                )
//                let header = NSCollectionLayoutBoundarySupplementaryItem(
//                    layoutSize: headerSize,
//                    elementKind: UICollectionView.elementKindSectionHeader,
//                    alignment: .top
//                )
                
                // section
                layoutSection = NSCollectionLayoutSection(group: group)
               // layoutSection.boundarySupplementaryItems = [header]
                layoutSection.orthogonalScrollingBehavior = .groupPaging
                layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 10, trailing: 5)
                
                return layoutSection
            }
        }
        return layout
    }
}


extension HomeViewController {
    
    private func bannerCellRegistertaion() -> UICollectionView.CellRegistration<BannerCollectionViewCell, BannerBox> {
        UICollectionView.CellRegistration<BannerCollectionViewCell, BannerBox> { cell, indexPath, item in
            cell.uppdateUI(data: item)
        }
    }
    
    private func searchCellRegistertaion() -> UICollectionView.CellRegistration<SearchBarCollectionViewCell, UUID> {
        UICollectionView.CellRegistration<SearchBarCollectionViewCell, UUID> { cell, indexPath, item in
            cell.searchBar.addTarget(self, action: #selector(self.tapSearchBar), for: .touchUpInside)
        }
    }
    
    @objc func tapSearchBar() {
        let vc = SearchViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func categoryCellRegistertaion() -> UICollectionView.CellRegistration<CategoryCollectionViewCell, UUID> {
        UICollectionView.CellRegistration<CategoryCollectionViewCell, UUID> { cell, indexPath, item in
        }
    }
    
    private func recentlyCellRegistertaion() -> UICollectionView.CellRegistration<RecentlyCollectionViewCell, Int> {
        UICollectionView.CellRegistration<RecentlyCollectionViewCell, Int> { cell, indexPath, item in
            
        }
    }
    
}

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let section = Section(rawValue: indexPath.section) {
            switch section {
            case .banner:
                
                guard let urlString = bannerdata[indexPath.item].url else { return }
                let vc = WebViewController()
                vc.urlString = urlString
                navigationController?.pushViewController(vc, animated: true)
                break
            case .searchBar:
                break
            case .category:
                break
            case .magagine:
                break
            }
        }
    }
}
