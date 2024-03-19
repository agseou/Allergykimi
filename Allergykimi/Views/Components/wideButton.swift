//
//  wideButton.swift
//  Allergykimi
//
//  Created by 은서우 on 3/19/24.
//

import UIKit

class wideButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        var config = UIButton.Configuration.filled()
        config.title = "다음"
        self.configuration = config
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
