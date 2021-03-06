//
//  CampaignsAPI.swift
//  hepsiexpress
//
//  Created by Abdurrahman Şanlı on 22.05.2021.
//

import Alamofire

class CampaignsAPI {
    
    func getCampaigns(params: [String: Any]?,
                      success: @escaping (CampaignResponse) -> Void,
                      failure: @escaping () -> Void) {
        BaseAPI.shared.request(method: .get,
                               url: URL(string: "http://private-d190ab-campaigns19.apiary-mock.com/campaigns/_pageId")!,
                               parameters: params,
                               success: success,
                               failure: failure)
    }
}
