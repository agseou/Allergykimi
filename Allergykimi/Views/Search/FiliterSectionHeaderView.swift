//
//  FiliterSectionHeaderView.swift
//  Allergykimi
//
//  Created by 은서우 on 3/19/24.
//

import UIKit

class FiliterSectionHeaderView: BaseCollectionReusableView {

    let filterButton = {
        var config = UIButton.Configuration.filled()
        config.title = "필터"
        config.image = UIImage(systemName: "list.dash")
        let button = UIButton()
        button.configuration = config
        return button
    }()
    
    override func configureHierarchy() {
        addSubview(filterButton)
    }
    
    override func setConstraints() {
        filterButton.snp.makeConstraints {
            $0.leading.equalTo(self)
            $0.verticalEdges.equalTo(self).inset(3)
        }
    }
}
