//
//  APIManager.swift
//  Allergykimi
//
//  Created by 은서우 on 2024/03/07.
//

import Foundation
import Alamofire
import SwiftyXMLParser

class APIManager {
    
    static let shared = APIManager()
    
    private init() { }
    
    // Request
    func request<T: Decodable>(type: T.Type,
                               api: DataAPI,
                               completionHandler: @escaping ((T) -> Void)) {
        
        AF.request(api.endpoint,
                   method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let success):
                dump(success)
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    // XML Request
    func XMLrequest(api: DataAPI,completionHandler: @escaping ((XML.Accessor) -> Void)) {
        
        AF.request(api.endpoint,
                   method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header).responseData { response in
            switch response.result {
            case .success(let success):
                print(success)
                let xml = XML.parse(success)
                completionHandler(xml)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
