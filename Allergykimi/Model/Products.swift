//
//  Products.swift
//  Allergykimi
//
//  Created by 은서우 on 2024/03/07.
//

import Foundation

// MARK: - Products
struct Products: Decodable {
    let body: Body
}

// MARK: - Body
struct Body: Decodable {
    let items: [Item]
    let totalCount: String
    let pageNo: String
    let numOfRows: String
}

// MARK: - ItemElement
struct Item: Decodable, Hashable {
    let item: ItemInfo
}

// MARK: - ItemItem
struct ItemInfo: Decodable, Hashable {
    let prdkindstate: String
    let manufacture: String
    let rnum: String
    let prdkind: String
    let rawmtrl: String
    let prdlstNm: String
    let imgurl2: String
    let imgurl1: String
    let productGb: String
    let prdlstReportNo: String
    let allergy: String
    let nutrient: String?
    let seller: String?
    let barcode: String?
}

