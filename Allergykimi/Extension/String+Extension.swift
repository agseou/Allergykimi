//
//  String+Extension.swift
//  Allergykimi
//
//  Created by 은서우 on 3/15/24.
//

import Foundation

extension String {
    func findMatchingAllergies() -> [Allergy] {
        Allergy.allCases.filter { allergy in
            // "none"은 제외합니다.
            guard allergy != .none else { return false }
            return allergy.name.contains(where: self.contains)
        }
    }
    
    func findMatchingAllergiesString() -> String {
        let allergies = findMatchingAllergies()
        let allergyStrings = allergies.map { "\($0.icon) \($0.name.first!)" }
        return allergyStrings.joined(separator: ", ")
    }
}
