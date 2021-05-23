//
//  RequestBodyConvertable.swift
//  hepsiexpress
//
//  Created by Abdurrahman Şanlı on 23.05.2021.
//

import Foundation

protocol RequestBodyConvertible {
    func toDict() -> [String: Any]?
    func toJson() -> String?
}

extension RequestBodyConvertible {

    func toJson() -> String? {
        return nil
    }

    func toDict() -> [String:Any]? {
        return nil
    }

}
