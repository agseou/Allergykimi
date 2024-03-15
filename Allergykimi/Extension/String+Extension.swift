//
//  String+Extension.swift
//  Allergykimi
//
//  Created by 은서우 on 3/15/24.
//

import Foundation

extension String {
    func findMatchingAllergies() -> [Allergy] {
        Allergy.allCases.filter { self.contains($0.rawValue) }
    }
    
    func findMatchingAllergiesString() -> String {
        let allergies = findMatchingAllergies()
        let allergyStrings = allergies.map { "\($0.icon) \($0.rawValue)" }
        return allergyStrings.joined(separator: ", ")
    }
}
