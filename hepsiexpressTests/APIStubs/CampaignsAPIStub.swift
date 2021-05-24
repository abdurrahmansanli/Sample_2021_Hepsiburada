//
//  CampaignsAPIStub.swift
//  hepsiexpressTests
//
//  Created by Abdurrahman Şanlı on 23.05.2021.
//

@testable import hepsiexpress
import Foundation

class CampaignsAPIStub: CampaignsAPI {
    
    let jsonFileName: String
    
    init(jsonFileName: String) {
        self.jsonFileName = jsonFileName
    }
    
    override func getCampaigns(params: [String : Any]?,
                               success: @escaping (CampaignResponse) -> Void,
                               failure: @escaping () -> Void) {
        
        // TODO: This code block should be reusable elsewhere.
        let bundle = Bundle(for: type(of: self))
        let fileUrl = bundle.url(forResource: jsonFileName, withExtension: "json")
        guard let url = fileUrl, let data = try? Data(contentsOf: url) else { return }
        guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: [.mutableLeaves]) as? [String: Any] else { return }
        guard let response = CampaignResponse(JSON: jsonObject) else { return }
        
        success(response)
    }
}
