//
//  Allergy.swift
//  Allergykimi
//
//  Created by 은서우 on 3/12/24.
//

import Foundation

enum Allergy: String, CaseIterable, Codable, Hashable {
    case shrimp
    case crab
    case squid
    case mackerel
    case shellfish
    case oyster
    case abalone
    case mussel
    case buckWheat
    case wheat
    case soybean
    case walnut
    case peanut
    case pineNut
    case eggs
    case milk
    case beef
    case pork
    case chicken
    case peaches
    case tomatoes
    case sulfurousAcids
    case none
    case unknowned
    
    var name: [String] {
        switch self {
        case .shrimp:
            ["새우"]
        case .crab:
            ["게"]
        case .squid:
            ["오징어"]
        case .mackerel:
            ["고등어"]
        case .shellfish:
            ["조개류"]
        case .oyster:
            ["굴"]
        case .abalone:
            ["전복"]
        case .mussel:
            ["홍합"]
        case .buckWheat:
            ["메밀"]
        case .wheat:
            ["밀"]
        case .soybean:
            ["대두"]
        case .walnut:
            ["호두"]
        case .peanut:
            ["땅콩"]
        case .pineNut:
            ["잣"]
        case .eggs:
            ["알류", "계란", "달걀"]
        case .milk:
            ["우유"]
        case .beef:
            ["쇠고기"]
        case .pork:
            ["돼지고기"]
        case .chicken:
            ["닭고기"]
        case .peaches:
            ["복숭아"]
        case .tomatoes:
            ["토마토"]
        case .sulfurousAcids:
            ["아황산류", "와인"]
        case .none:
            ["없음"]
        case .unknowned:
            ["알수없음"]
        }
    }
    
    var icon: String {
        switch self {
        case .shrimp:
            "🦐"
        case .crab:
            "🦀"
        case .squid:
            "🦑"
        case .mackerel:
            "🐟"
        case .shellfish:
            "🐚"
        case .oyster:
            "🦪"
        case .abalone:
            "🦪"
        case .mussel:
            "🦪"
        case .buckWheat:
            "🫘"
        case .wheat:
            "🌾"
        case .soybean:
            "🫛"
        case .walnut:
            "🧠"
        case .peanut:
            "🥜"
        case .pineNut:
            "🫘"
        case .eggs:
            "🥚"
        case .milk:
            "🥛"
        case .beef:
            "🐮"
        case .pork:
            "🐷"
        case .chicken:
            "🐔"
        case .peaches:
            "🍑"
        case .tomatoes:
            "🍅"
        case .sulfurousAcids:
            "🍷"
        case .none:
            "❌"
        case .unknowned:
            "❓"
        }
    }
}
