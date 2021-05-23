//
//  MainViewController.swift
//  hepsiexpress
//
//  Created by Abdurrahman Şanlı on 21.05.2021.
//

import UIKit
import SnapKit

class MainViewController: BaseViewController<MainViewModel> {
    
    let campaignsViewController = CampaignsViewController()
    
    override func layout() {
        super.layout()
        
        view.backgroundColor = .white
        
        title = "Campaigns"
        navigationController?.navigationBar.tintColor = .green
        
        view.addSubview(campaignsViewController.view)
        campaignsViewController.view.snp.makeConstraints { maker in
            maker.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            maker.left.right.bottom.equalToSuperview()
        }
    }
}
