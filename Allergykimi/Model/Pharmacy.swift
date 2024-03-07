//
//  Pharmacy.swift
//  Allergykimi
//
//  Created by 은서우 on 2024/03/07.
//

import Foundation

// MARK: - Pharmacy
struct Pharmacy {
    let response: Response
}

// MARK: - Response
struct Response {
    let body: Data
}

// MARK: - Body
struct Data {
    let items: PharmacyItems
    let numofrows: Int
    let pageno: Int
    let totalcount: Int
}

// MARK: - Items
struct PharmacyItems: Decodable {
    let item: [PharmacyInfo]
}

// MARK: - Item
struct PharmacyInfo: Decodable {
    let cnt: Int
    let distance: Double
    let dutyaddr: String
    let dutydiv: String
    let dutydivname: String
    let dutyname: String
    let dutytel1: String
    let endtime: Int
    let hpid: String
    let latitude: Double
    let longitude: Double
    let rnum: Int
    let starttime: Int
}
