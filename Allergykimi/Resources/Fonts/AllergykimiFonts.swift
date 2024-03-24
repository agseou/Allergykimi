//
//  AllergykimiFonts.swift
//  Allergykimi
//
//  Created by 은서우 on 3/22/24.
//

import UIKit

struct AllergykimiFonts {
    
    // 티머니둥근바람체
    struct TmoneyRoundWind {
        static func extraBold(size: CGFloat) -> UIFont {
            return UIFont(name: "TmoneyRoundWind-ExtraBold", size: size) ?? UIFont.systemFont(ofSize: size)
        }
        
        static func regular(size: CGFloat) -> UIFont {
            return UIFont(name: "TmoneyRoundWind-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
        }
    }
}
