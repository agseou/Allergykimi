//
//  SearchBarContainer.swift
//  Allergykimi
//
//  Created by 은서우 on 3/23/24.
//

import UIKit

class SearchBarContainer: BaseView {
    
    // MARK: - Components
    private let title = UILabel()
    private let searchBarButton = UIButton()
    
    // MARK: - Properties
    var onSearchBarButtonTapped: (() -> Void)?
    
    // MARK: - Functions
    override func configureHierarchy() {
        super.configureHierarchy()
        
        addSubviews([title, searchBarButton])
    }
    
    override func configureView() {
        super.configureView()
        backgroundColor = .accent
        
        title.text = "알러지키미와 함께하는\n\(UserDefaultsManager.shared.nickName)님!"
        title.numberOfLines = 0
        title.textColor = .white
        title.font = AllergykimiFonts.TmoneyRoundWind.extraBold(size: 20)
        
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.baseForegroundColor = .gray
        config.baseBackgroundColor = .white
        config.image = UIImage(systemName: "magnifyingglass")
        config.imagePlacement = .leading
        config.title = "식품을 검색하세요!"
        searchBarButton.configuration = config
        DispatchQueue.main.async {
            self.searchBarButton.layer.cornerRadius = self.searchBarButton.bounds.height/2
        }
        searchBarButton.addTarget(self, action: #selector(tapSearchBarButton), for: .touchUpInside)
    }
    
    @objc private func tapSearchBarButton() {
        onSearchBarButtonTapped?()
    }
    
    override func setConstraints() {
        super.setConstraints()
        title.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(40)
            $0.leading.equalTo(searchBarButton.snp.leading).offset(20)
        }
        searchBarButton.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().inset(25)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
    }
    
}
