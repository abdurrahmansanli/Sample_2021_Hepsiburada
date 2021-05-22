//
//  BaseAPI.swift
//  hepsiexpress
//
//  Created by Abdurrahman Şanlı on 22.05.2021.
//

import Alamofire
import ObjectMapper

class BaseAPI {
    
    static let shared = BaseAPI()
    
    // TODO: Add retry capability on failure
    @discardableResult
    func request<ResponseType: Mappable>(method: HTTPMethod,
                                         url: URL,
                                         parameters: Parameters?,
                                         success: @escaping ((ResponseType) -> Void),
                                         failure: @escaping (() -> Void),
                                         retry: Int = 0) -> DataRequest? {
        
        let request = Alamofire.Session.default.request(url,
                                                        method: method,
                                                        parameters: [:],
                                                        encoding: URLEncoding.queryString,
                                                        headers: [:]).responseJSON { (response) in
                                                            switch response.result {
                                                            case .success(let result):
                                                                if let json = result as? [String:Any],
                                                                   let responseObject = ResponseType(JSON: json) {
                                                                    success(responseObject)
                                                                } else {
                                                                    failure()
                                                                }
                                                            case .failure:
                                                                failure()
                                                            }
                                                        }
        return request
    }
}
