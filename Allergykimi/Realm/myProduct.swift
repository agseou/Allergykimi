//
//  myProduct.swift
//  Allergykimi
//
//  Created by 은서우 on 3/20/24.
//

import Foundation
import RealmSwift

class recentProduct: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted  var prdlstReportNo: String // 상품 고유번호
    @Persisted var prductName: String // 상품 이름
    @Persisted var prductImgURL: String // 상품 이미지 url
    @Persisted var allergy: String // 상품 알러지
    @Persisted var prdkind: String // 상품 종류
    
    convenience init(
        prdlstReportNo: String,
        prductName: String,
        prductImgURL: String,
        allergy: String,
        prdkind: String
    ) {
        self.init()
        self.prdlstReportNo = prdlstReportNo
        self.prductName = prductName
        self.prductImgURL = prductImgURL
        self.allergy = allergy
        self.prdkind = prdkind
    }
}

class favoriteProduct: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted  var prdlstReportNo: String // 상품 고유번호
    @Persisted var prductName: String // 상품 이름
    @Persisted var prductImgURL: String // 상품 이미지 url
    @Persisted var allergy: String // 상품 알러지
    
    convenience init(
        prductName: String,
        prductImgURL: String,
        allergy: String
    ) {
        self.init()
        self.prductName = prductName
        self.prductImgURL = prductImgURL
        self.allergy = allergy
    }
}
