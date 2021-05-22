//
//  CampaignResponse.swift
//  hepsiexpress
//
//  Created by Abdurrahman Şanlı on 22.05.2021.
//

import Foundation
import ObjectMapper

protocol CampaignItem {}

class CampaignResponse: Mappable {

    var banners: [Banner]?
    var hotDeals: [HotDeal]?

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        banners <- map["banners"]
        hotDeals <- map["hotDeals"]
    }
}

class Banner: Mappable, CampaignItem {
    
    var image: Image?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        image <- map["image"]
    }
}

class Image: Mappable {
    
    var width: Int?
    var height: Int?
    var url: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        width <- map["width"]
        height <- map["height"]
        url <- map["url"]
    }
}

class HotDeal: Mappable, CampaignItem {
    
    var title: String?
    var expirationDate: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        expirationDate <- map["expirationDate"]
    }
}
