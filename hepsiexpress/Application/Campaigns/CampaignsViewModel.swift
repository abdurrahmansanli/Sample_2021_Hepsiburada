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
            print("")
        } failure: {
            print("")
        }
    }
}
