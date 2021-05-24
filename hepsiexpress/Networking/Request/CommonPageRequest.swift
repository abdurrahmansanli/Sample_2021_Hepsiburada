//
//  CommonPageRequest.swift
//  hepsiexpress
//
//  Created by Abdurrahman Şanlı on 23.05.2021.
//

class CommonPageRequest: Codable, RequestBodyConvertible {

    let _pageId: Int

    init(pageId: Int) {
        self._pageId = pageId
    }

    func toDict() -> [String: Any]? {
        return ObjectConverterService.convert(toDict: self)
    }
}
