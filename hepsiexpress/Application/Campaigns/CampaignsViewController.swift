//
//  CampaignsViewController.swift
//  hepsiexpress
//
//  Created by Abdurrahman Şanlı on 21.05.2021.
//

import UIKit
import Bond
import ReactiveKit

class CampaignsViewController: BaseViewController<CampaignsViewModel> {
    
    let disposeBag = DisposeBag()
    
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
    
    private lazy var viewLoadMore: UIView = {
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 80))
        customView.backgroundColor = .clear
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.startAnimating()
        customView.addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalToSuperview().offset(10)
        }
        return customView
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
        
        tableView.tableFooterView = viewLoadMore
    }
    
    override func bind() {
        super.bind()
        
        viewModel.arrayCampaigns.bind(to: tableView) { arrayCampaignItems, indexPath, tableView in
            let currentCampaignItem = arrayCampaignItems[indexPath.row]
            if let banner = currentCampaignItem as? Banner,
               let cell = tableView.dequeueReusableCell(withIdentifier: BannerTableViewCell.description())
                as? BannerTableViewCell {
                cell.refreshWithBanner(banner)
                cell.selectionStyle = .none
                return cell
            } else if let hotDeal = currentCampaignItem as? HotDeal,
                      let cell = tableView.dequeueReusableCell(withIdentifier: HotDealTableViewCell.description())
                        as? HotDealTableViewCell {
                cell.refreshWithHotDeal(hotDeal)
                cell.selectionStyle = .none
                return cell
            }
            return UITableViewCell()
        }
        
        viewModel.isLoadingMore.observeNext { (isLoadingMore) in
            if isLoadingMore {
                self.viewLoadMore.isHidden = false
            } else {
                self.viewLoadMore.isHidden = true
            }
        }.dispose(in: disposeBag)
    }
}


extension CampaignsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.arrayCampaigns.value.count - 2 {
            viewModel.loadMoreIfAppropriate()
        }
    }
}
