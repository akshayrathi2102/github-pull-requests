//
//  ProfileImageViewCell.swift
//  iOSLearningApp
//
//  Created by Akshay Rathi on 15/09/22.
//

import Foundation
import UIKit
import SnapKit


class ProfileImageTableViewCell: UITableViewCell {
    private let defaultProfiileImageName = "user"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let profileImageView = UIImageView()

    private func configure() {
        profileImageView.layer.cornerRadius = Constants.Theme.imageWidth/2
        profileImageView.clipsToBounds = true
        self.contentView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints({
            make in
            make.height.width.equalTo(Constants.Theme.imageWidth)
            make.centerX.centerY.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(Constants.Theme.margin)
        })
    }

    func setData(imageUrl: String) {
        profileImageView.fetchImage(with: imageUrl, placeHolderImage: .Assets.user.image)
    }
}
