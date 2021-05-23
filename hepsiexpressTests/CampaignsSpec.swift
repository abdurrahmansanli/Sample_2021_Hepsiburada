//
//  CampaignsSpec.swift
//  hepsiexpressTests
//
//  Created by Abdurrahman Şanlı on 23.05.2021.
//

import Foundation

@testable import hepsiexpress
import Quick
import Nimble
import ReactiveKit

class CampaignsSpec: QuickSpec {
    
    override func spec() {
        var viewModel: CampaignsViewModel!
        
        describe("Test campaing pairing logics.") {
            
            it("Campaigns paired with exceeding banners.") {
                viewModel = CampaignsViewModel(api: CampaignsAPIStub(jsonFileName: "Campaigns1"))
                viewModel.refresh()
                expect(viewModel.arrayCampaigns.value[0] is Banner) == true
                expect(viewModel.arrayCampaigns.value[1] is HotDeal) == true
                expect(viewModel.arrayCampaigns.value[2] is Banner) == true
                expect(viewModel.arrayCampaigns.value[3] is HotDeal) == true
                expect(viewModel.arrayCampaigns.value[4] is Banner) == true
                expect(viewModel.arrayCampaigns.value[5] is Banner) == true
            }
            
            it("Campaigns paired with exceeding hot deals.") {
                viewModel = CampaignsViewModel(api: CampaignsAPIStub(jsonFileName: "Campaigns2"))
                viewModel.refresh()
                expect(viewModel.arrayCampaigns.value[0] is Banner) == true
                expect(viewModel.arrayCampaigns.value[1] is HotDeal) == true
                expect(viewModel.arrayCampaigns.value[2] is HotDeal) == true
                expect(viewModel.arrayCampaigns.value[3] is HotDeal) == true
                expect(viewModel.arrayCampaigns.value[4] is HotDeal) == true
            }
        }
    }
}

