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

    var isLoadingMore = Observable<Bool>(false)
    var isEndOfPageReached = Observable<Bool>(false)
    var isRefreshing = Observable<Bool>(false)
    
    private var currentPageIndex: Int = 0
    
    var timerVisibleCellRefresher: Timer?
    
    let actionRefreshVisibleCells = PassthroughSubject<Void,Never>()
    
    let campaignsAPI: CampaignsAPI
    
    init(api: CampaignsAPI) {
        self.campaignsAPI = api
        super.init()
    }
    
    convenience required init() {
        self.init(api: CampaignsAPI())
    }
    
    func refresh() {
        self.isRefreshing.send(true)
        let commonPageRequest = CommonPageRequest(pageId: 0)
        campaignsAPI.getCampaigns(params: commonPageRequest.toDict()) { [weak self] campaignsResponse in
            self?.isEndOfPageReached.send(false)
            self?.currentPageIndex = 0
            self?.refreshSuccessBlock(campaignsResponse: campaignsResponse)
            self?.isRefreshing.send(false)
        } failure: {
            self.currentPageIndex = 0
            self.isRefreshing.send(false)
        }
    }
    
    private func refreshSuccessBlock(campaignsResponse: CampaignResponse) {
        let arrayBanners: [CampaignItem] = campaignsResponse.banners ?? [CampaignItem]()
        let arrayHotDeals: [CampaignItem] = campaignsResponse.hotDeals ?? [CampaignItem]()
        let arrayPairs = ObjectPairingService.createAvailablePairsFrom(array1: arrayBanners, array2: arrayHotDeals)
        arrayCampaigns.send(arrayPairs)
    }
    
    func loadMoreIfAppropriate() {
        if (isLoadingMore.value == true) { return }
        if (isEndOfPageReached.value == true) { return }
        isLoadingMore.send(true)
        currentPageIndex += 1
        let commonPageRequest = CommonPageRequest(pageId: currentPageIndex)
        campaignsAPI.getCampaigns(params: commonPageRequest.toDict()) { [weak self] campaignsResponse in
            if campaignsResponse.banners?.count == 0 && campaignsResponse.hotDeals?.count == 0 {
                self?.isEndOfPageReached.send(true)
                return
            }
            self?.loadMoreSuccessBlock(campaignsResponse: campaignsResponse)
            self?.isLoadingMore.send(false)
        } failure: {
            self.isLoadingMore.send(false)
        }
    }
    
    private func loadMoreSuccessBlock(campaignsResponse: CampaignResponse) {
        let arrayBanners: [CampaignItem] = campaignsResponse.banners ?? [CampaignItem]()
        let arrayHotDeals: [CampaignItem] = campaignsResponse.hotDeals ?? [CampaignItem]()
        let arrayNewPairs: [CampaignItem] = ObjectPairingService.createAvailablePairsFrom(array1: arrayBanners, array2: arrayHotDeals)
        let arrayAllCampaigns: [CampaignItem] = arrayCampaigns.value
        var arrayPairsAddedToArrayAllCampaigns = [CampaignItem]()
        arrayPairsAddedToArrayAllCampaigns.append(contentsOf: arrayAllCampaigns)
        arrayPairsAddedToArrayAllCampaigns.append(contentsOf: arrayNewPairs)
        arrayCampaigns.send(arrayPairsAddedToArrayAllCampaigns)
    }
    
    func initializeTimerRemainingTimeRefresher() {
        timerVisibleCellRefresher
            = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [unowned self] timer in
                actionRefreshVisibleCells.send()
        }
    }
    
    /* TODO: When you stop using this controller as a subview and start using it as an individual view;
     make sure to call deinitializeTimerRemainingTimeRefresher() on viewWillDisappear and move call for
     initializeTimerRemainingTimeRefresher to viewWillAppear. This controller was used as a subview due
     to tutorial purposes and app structure not being ready yet.
     */
    func deinitializeTimerRemainingTimeRefresher() {
        timerVisibleCellRefresher?.invalidate()
    }
}
