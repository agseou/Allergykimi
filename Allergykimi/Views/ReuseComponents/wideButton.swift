//
//  wideButton.swift
//  Allergykimi
//
//  Created by 은서우 on 3/19/24.
//

import UIKit

enum AllergykimiButtonType {
    case next
    case prev
    case complete
    case none
    
    var title: String {
        switch self {
        case .next:
            "다음"
        case .prev:
            "이전"
        case .complete:
            "완료"
        case .none:
            "없음"
        }
    }
    
    var color: UIColor {
        switch self {
        case .next:
                .accent
        case .prev:
                .gray
        case .complete:
                .accent
        case .none:
                .complementary
        }
    }
}

class WideButton: UIButton {
    
    init(frame: CGRect = .zero, type: AllergykimiButtonType) {
       super.init(frame: frame)
       
       var config = UIButton.Configuration.filled()
       config.title = type.title
       config.baseBackgroundColor = type.color
       self.configuration = config
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
