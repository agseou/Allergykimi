//
//  APIManager.swift
//  Allergykimi
//
//  Created by 은서우 on 2024/03/07.
//

import Foundation
import Alamofire

class APIManager {
    
    static let shared = APIManager()
    
    private init() { }
    
    func request<T: Decodable>(type: T.Type,
                               api: DataAPI,
                               completionHandler: @escaping ((T) -> Void)) {
        
        AF.request(api.endpoint,
                   method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString)).responseDecodable(of: T.self) { respose in
            switch respose.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
        
    }
}
