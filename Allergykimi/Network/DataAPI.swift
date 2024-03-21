//
//  ProductsAPI.swift
//  Allergykimi
//
//  Created by 은서우 on 2024/03/07.
//

import Foundation
import Alamofire

enum DataAPI {
    
    case Products(pages: String, prdname: String, prdkind: String, prdlstReportNo: String)
    case Pharmacy(LON: String, LAT: String)
    
    var baseURL: String {
        return "https://apis.data.go.kr/"
    }
    
    var endpoint: URL {
        switch self {
        case .Products:
            return URL(string: baseURL + "B553748/CertImgListServiceV3/getCertImgListServiceV3")!
        case .Pharmacy:
            return URL(string: baseURL + "B552657/ErmctInsttInfoInqireService/getParmacyLcinfoInqire")!
        }
    }
    
    var header: HTTPHeaders {
        return ["accept": "*/*"]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters {
        switch self {
        case .Products(let pages, let prdname, let prdkind, let prdlstReportNo):
            var params: Parameters = [
                "serviceKey": APIKey.serviceKey,
                "returnType": "json",
                "pageNo": pages,
                "numOfRows": "30"
            ]
            
            if !prdname.isEmpty {
                params["prdlstNm"] = prdname
            }
            if !prdkind.isEmpty {
                params["prdkind"] = prdkind
            }
            if !prdlstReportNo.isEmpty {
                params["prdlstReportNo"] = prdlstReportNo
            }
            
            return params
            
        case .Pharmacy(let LON, let LAT):
            return [
                "serviceKey": APIKey.serviceKey,
                "WGS84_LON": LON,
                "WGS84_LAT": LAT
            ]
        }
    }
}
