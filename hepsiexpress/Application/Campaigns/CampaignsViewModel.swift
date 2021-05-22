//
//  CampaignsViewModel.swift
//  hepsiexpress
//
//  Created by Abdurrahman Şanlı on 21.05.2021.
//

import UIKit

class CampaignsViewModel: BaseViewModel {
    
    func refresh() {
        CampaignsAPI().getCampaigns { campaignsResponse in
            let arrayBanners: [CampaignItem] = campaignsResponse.banners ?? [CampaignItem]()
            let arrayHotDeals: [CampaignItem] = campaignsResponse.hotDeals ?? [CampaignItem]()
            let arrayPairs = ObjectPairingService.createAvailablePairsFrom(array1: arrayBanners, array2: arrayHotDeals)
            print("")
        } failure: {
            print("")
        }
    }
}
