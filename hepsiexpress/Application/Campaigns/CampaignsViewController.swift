//
//  CampaignsViewController.swift
//  hepsiexpress
//
//  Created by Abdurrahman Şanlı on 21.05.2021.
//

import UIKit

class CampaignsViewController: BaseViewController<CampaignsViewModel> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.refresh()
    }
    
    override func layout() {
        super.layout()
        view.backgroundColor = .green
    }
}
