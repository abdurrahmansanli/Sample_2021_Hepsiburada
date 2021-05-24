//
//  ObjectConverterService.swift
//  hepsiexpress
//
//  Created by Abdurrahman Şanlı on 23.05.2021.
//

import Foundation

import Foundation
import SwiftyJSON

class ObjectConverterService {

    static func convert<T: Codable>(toDict obj: T?) -> [String: Any]? {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(obj), let json = try? JSON(data: data) else { return nil }
        return ObjectConverterService.convertIntsToBooleans(dict: json.dictionaryObject)
    }

    static func convert<T: Codable>(toJson obj: T?) -> String? {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(obj), let json = try? JSON(data: data) else { return nil }
        return json.description
    }

    static func convertIntsToBooleans(dict: [String: Any]?) -> [String: Any]? {
        guard var dict = dict else { return nil }
        dict.forEach { key, value in
            if let value = value as? [String: Any] {
                dict[key] = ObjectConverterService.convertIntsToBooleans(dict: value)
            } else if type(of: value) == type(of: NSNumber(value: true)) {
                dict[key] = value as? Int == 1
            }
        }
        return dict
    }
}
