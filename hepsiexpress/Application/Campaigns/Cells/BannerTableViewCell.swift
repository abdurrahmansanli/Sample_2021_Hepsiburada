//
//  BannerTableViewCell.swift
//  hepsiexpress
//
//  Created by Abdurrahman Şanlı on 22.05.2021.
//

import UIKit
import SnapKit
import Kingfisher

class BannerTableViewCell: UITableViewCell {
    
    var constraintImageViewBannerHeight: Constraint?
    var constraintImageViewBannerWidth: Constraint?
    
    lazy var imageViewBanner: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        contentView.addSubview(imageViewBanner)
        imageViewBanner.snp.makeConstraints { maker in
            maker.top.bottom.equalToSuperview()
            constraintImageViewBannerHeight = maker.height.equalTo(0).priority(.low).constraint
            constraintImageViewBannerWidth = maker.width.equalTo(0).priority(.low).constraint
            maker.centerX.equalToSuperview()
        }
    }
    
    func refreshWithBanner(_ banner: Banner) {
        contentView.backgroundColor = .white
        
        guard let bannerHeight = banner.image?.height else { return }
        guard let bannerWidth = banner.image?.width else { return }
        let widthHeightRatio: CGFloat = CGFloat(bannerHeight)/CGFloat(bannerWidth)
        let screenWidth = UIScreen.main.bounds.width
        
        let desiredBannerWidth = min(screenWidth, CGFloat(bannerWidth))
        let desiredBannerHeight = desiredBannerWidth*widthHeightRatio
        
        constraintImageViewBannerWidth?.update(offset: desiredBannerWidth)
        constraintImageViewBannerHeight?.update(offset: desiredBannerHeight)
        
        if let urlString = banner.image?.url {
            imageViewBanner.kf.setImage(with: URL(string: urlString))
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageViewBanner.image = nil
    }
}
