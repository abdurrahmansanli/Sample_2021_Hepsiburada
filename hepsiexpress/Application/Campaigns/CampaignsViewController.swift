//
//  CampaignsViewController.swift
//  hepsiexpress
//
//  Created by Abdurrahman Şanlı on 21.05.2021.
//

import UIKit

class CampaignsViewController: BaseViewController<CampaignsViewModel> {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(BannerTableViewCell.self, forCellReuseIdentifier: BannerTableViewCell.description())
        tableView.register(HotDealTableViewCell.self, forCellReuseIdentifier: HotDealTableViewCell.description())
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.refresh()
    }
    
    override func layout() {
        super.layout()
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }
    
    override func bind() {
        super.bind()
        
        viewModel.arrayCampaigns.bind(to: tableView) { arrayCampaignItems, indexPath, tableView in
            let currentCampaignItem = arrayCampaignItems[indexPath.row]
            if let banner = currentCampaignItem as? Banner,
               let cell = tableView.dequeueReusableCell(withIdentifier: BannerTableViewCell.description())
                as? BannerTableViewCell {
                cell.refreshWithBanner(banner)
                return cell
            } else if let hotDeal = currentCampaignItem as? HotDeal,
                      let cell = tableView.dequeueReusableCell(withIdentifier: HotDealTableViewCell.description())
                        as? HotDealTableViewCell {
                cell.refreshWithHotDeal(hotDeal)
                return cell
            }
            return UITableViewCell()
        }
    }
}


extension CampaignsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
