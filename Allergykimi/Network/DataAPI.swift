//
//  ProductsAPI.swift
//  Allergykimi
//
//  Created by 은서우 on 2024/03/07.
//

import Foundation
import Alamofire

enum DataAPI {
    
    case Products(query: String)
    case Pharmacy(LON: String, LAT: String)
    
    var baseURL: String {
        return "https://apis.data.go.kr/"
    }
    
    var endpoint: URL {
        switch self {
        case .Products:
            return URL(string: baseURL + "B553748/CertImgListServiceV3/getCertImgListServiceV3")!
        case .Pharmacy:
            return URL(string: baseURL + "B552657/ErmctInsttInfoInqireService")!
        }
    }
   
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters {
        switch self {
        case .Products(let item):
            ["serviceKey": APIKey.serviceKey,
             "returnType": "json",
             "prdlstNm": item]
        case .Pharmacy(let LON, let LAT):
            ["serviceKey": APIKey.serviceKey,
             "WGS84_LON": LON,
             "WGS84_LAT": LAT]
        }
    }
}
