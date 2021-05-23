//
//  CampaignsViewModel.swift
//  hepsiexpress
//
//  Created by Abdurrahman Şanlı on 21.05.2021.
//

import UIKit
import ReactiveKit
import Bond

class CampaignsViewModel: BaseViewModel {
    
    let arrayCampaigns = Observable<[CampaignItem]>([CampaignItem]())
    
    let campaignsAPI: CampaignsAPI
    
    init(api: CampaignsAPI) {
        self.campaignsAPI = api
        super.init()
    }
    
    convenience required init() {
        self.init(api: CampaignsAPI())
    }
    
    func refresh() {
        campaignsAPI.getCampaigns { [weak self] campaignsResponse in
            let arrayBanners: [CampaignItem] = campaignsResponse.banners ?? [CampaignItem]()
            let arrayHotDeals: [CampaignItem] = campaignsResponse.hotDeals ?? [CampaignItem]()
            let arrayPairs = ObjectPairingService.createAvailablePairsFrom(array1: arrayBanners, array2: arrayHotDeals)
            self?.arrayCampaigns.send(arrayPairs)
        } failure: {
            // Intentionally unimplemented
        }
    }
}
