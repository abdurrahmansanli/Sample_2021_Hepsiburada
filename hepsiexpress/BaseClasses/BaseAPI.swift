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
        
        let urlWithPaths = replaceUrlPathsWithMatchingParameters(parameters, url)
        
        let underscoreFilteredParameters = (parameters ?? [:]).filter { $0.key.first != "_" }
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: underscoreFilteredParameters, options: []) else {
            failure()
            return nil
        }
        
        let jsonString = String(data: jsonData, encoding: .utf8) ?? ""
        
        guard let encoding = (method == HTTPMethod.get ? URLEncoding.queryString : jsonString as? ParameterEncoding) else {
            failure()
            return nil
        }
        
        let request = Alamofire.Session.default.request(urlWithPaths,
                                                        method: method,
                                                        parameters: [:],
                                                        encoding: encoding,
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
    
    private func replaceUrlPathsWithMatchingParameters(_ parameters: Parameters?, _ url: URL) -> URL {
        var finalURL = url
        if let parameters = parameters {
            for key in parameters.keys {
                if key.first == "_" {
                    var finalValue: String?
                    if let value = parameters[key] as? String {
                        finalValue = value
                    } else if let value = parameters[key] as? Int {
                        finalValue = "\(value)"
                    } else if let value = parameters[key] as? Double {
                        finalValue = "\(value)"
                    }
                    if finalURL.absoluteString.contains(key), let finalValue = finalValue {
                        let latestURLString = finalURL.absoluteString
                        let latestURLStringModified = latestURLString.replacingOccurrences(of: key, with: finalValue)
                        if let newURL = URL(string: latestURLStringModified) {
                            finalURL = newURL
                        }
                    }
                }
            }
        }
        return finalURL
    }
}
