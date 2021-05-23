//
//  HotDealTableViewCell.swift
//  hepsiexpress
//
//  Created by Abdurrahman Şanlı on 22.05.2021.
//

import UIKit

class HotDealTableViewCell: UITableViewCell {
    
    let labelTitle: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let labelDescription: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        contentView.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
        
        contentView.addSubview(labelTitle)
        labelTitle.snp.makeConstraints { maker in
            maker.left.right.top.equalToSuperview().offset(16)
        }
        
        contentView.addSubview(labelDescription)
        labelDescription.snp.makeConstraints { maker in
            maker.top.equalTo(labelTitle.snp.bottom).offset(16)
            maker.left.right.equalToSuperview().offset(16)
            maker.bottom.equalToSuperview().inset(16)
        }
    }
    
    func refreshWithHotDeal(_ hotDeal: HotDeal) {
        if let title = hotDeal.title {
            labelTitle.text = title
        }
        if let expirationDate = hotDeal.expirationDate {
            labelDescription.text = expirationDate
        }
    }
}
