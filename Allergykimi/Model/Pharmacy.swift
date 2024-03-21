//
//  Pharmacy.swift
//  Allergykimi
//
//  Created by 은서우 on 2024/03/07.
//

import Foundation
import SwiftyXMLParser

// MARK: - Pharmacy
struct Pharmacy: Decodable {
    let response: Response
    
    init(xml: XML.Accessor) {
        self.response = Response(xml: xml["response"])
    }
}

// MARK: - Response
struct Response: Decodable {
    let body: Data
    init(xml: XML.Accessor) {
        self.body = Data(xml: xml["body"])
    }
}

// MARK: - Body
struct Data: Decodable {
    let items: PharmacyItems
    let numOfRows: Int
    let pageNo: Int
    let totalCount: Int
    init(xml: XML.Accessor) {
        self.items = PharmacyItems(xml: xml["items"])
        self.numOfRows = xml["numOfRows"].int ?? 0
        self.pageNo = xml["pageNo"].int ?? 0
        self.totalCount = xml["totalCount"].int ?? 0
    }
}

// MARK: - Items
struct PharmacyItems: Decodable {
    let item: [PharmacyInfo]
    
    init(xml: XML.Accessor) {
        self.item = xml["item"].map { PharmacyInfo(xml: $0)}
    }
}

// MARK: - Item
struct PharmacyInfo: Decodable {
    let cnt: Int
    let distance: Double
    let dutyAddr: String
    let dutyName: String
    let dutyTel1: String
    let hpid: String
    let latitude: Double
    let longitude: Double
    let rnum: Int
    let startTime: Int
    
    init(xml: XML.Accessor) {
        self.cnt = xml["cnt"].int ?? 0
        self.distance = xml["distance"].double ?? 0.0
        self.dutyAddr = xml["dutyAddr"].text ?? ""
        self.dutyName = xml["dutyName"].text ?? ""
        self.dutyTel1 = xml["dutyTel1"].text ?? ""
        self.hpid = xml["hpid"].text ?? ""
        self.latitude = xml["latitude"].double ?? 0.0
        self.longitude = xml["longitude"].double ?? 0.0
        self.rnum = xml["rnum"].int ?? 0
        self.startTime = xml["startTime"].int ?? 0
    }
}
