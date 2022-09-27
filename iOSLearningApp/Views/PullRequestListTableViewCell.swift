//
//  PullRequestTableCell.swift
//  iOSLearningApp
//
//  Created by Akshay Rathi on 14/09/22.
//

import Foundation
import UIKit
import SnapKit

class PullRequestListTableViewCell: UITableViewCell {

    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let profileImageView = UIImageView()
    private let contentLabel = UILabel()
    private let containerView = UIView()
    private let buttonView = UIButton()
    private let shadowContainerView = UIView()
    var buttonTapCallback: () -> ()  = { }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    private func configure() {
        self.backgroundColor = .clear
        setupShadowContainerViewContainerView()
        setupContainerView()
        setupProfileImageView()
        setupButtonView()
        setupTitleLabel()
        setupSubtitleLabel()
        setupContentLabel()
    }
    
    func setData(item: PullRequest) {
        if let imageUrl = item.user?.avatar_url {
            profileImageView.fetchImage(with: imageUrl, placeHolderImage: .Assets.user.image)
        }
        
        if(item.user?.is_favourite == true) {
            buttonView.setBackgroundImage(UIImage(systemName: UIImage.NameConstants.unfavouriteButtonName), for: .normal)
        }
        else {
            buttonView.setBackgroundImage(UIImage(systemName: UIImage.NameConstants.favouriteButtonName), for: .normal)
        }
        titleLabel.text = item.user?.login
        subtitleLabel.text = item.title
        contentLabel.text = item.body
    }
    
    func setFavouriteButton(buttonName: String) {
        buttonView.setBackgroundImage(UIImage(systemName: buttonName), for: .normal)
    }
    
    @objc func didTapButton() {
        buttonTapCallback()
    }
}

// MARK: private methods

private extension PullRequestListTableViewCell {
    
    func setupShadowContainerViewContainerView() {
        self.contentView.addSubview(shadowContainerView)
        shadowContainerView.layer.shadowOpacity = 0.1
        shadowContainerView.layer.shadowRadius = 5
        shadowContainerView.layer.shadowOffset = .zero
        shadowContainerView.snp.makeConstraints({
            make in
            make.top.bottom.leading.trailing.equalToSuperview().inset(Constants.Theme.margin)
        })
    }
    
    func setupContainerView() {
        shadowContainerView.addSubview(containerView)
        containerView.layer.cornerRadius = Constants.Theme.cornerRadius
        containerView.layer.borderColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1).cgColor
        containerView.layer.borderWidth = 1
        containerView.backgroundColor = .white
        containerView.snp.makeConstraints({
            make in
            make.top.bottom.leading.trailing.equalToSuperview()
        })
    }
    
    func setupProfileImageView() {
        containerView.addSubview(profileImageView)
        profileImageView.layer.cornerRadius = Constants.Theme.imageWidth/2
        profileImageView.clipsToBounds = true
        profileImageView.snp.makeConstraints({
            make in
            make.leading.equalToSuperview().offset(Constants.Theme.margin)
            make.width.height.equalTo(Constants.Theme.imageWidth)
            make.centerY.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview().offset(-Constants.Theme.margin).priority(.high)
        })
    }
    
    func setupButtonView() {
        containerView.addSubview(buttonView)
        buttonView.setBackgroundImage(UIImage(systemName: UIImage.NameConstants.favouriteButtonName), for: .normal)
        buttonView.tintColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1)
        buttonView.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        buttonView.snp.makeConstraints({
            make in
            make.top.greaterThanOrEqualToSuperview().offset(Constants.Theme.margin).priority(.high)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-Constants.Theme.margin)
            make.height.equalTo(Constants.Theme.margin*1.8)
            make.width.equalTo(Constants.Theme.margin*2)
        })
    }
    
    func setupTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints({
            make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(Constants.Theme.margin)
            make.trailing.equalTo(buttonView.snp.leading).offset(-Constants.Theme.margin)
            make.top.equalToSuperview().offset(Constants.Theme.margin)
        })
    }
    
    func setupSubtitleLabel() {
        containerView.addSubview(subtitleLabel)
        subtitleLabel.font = UIFont.systemFont(ofSize: Constants.Theme.subtiteFontSize)
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textColor = .darkGray
        subtitleLabel.snp.makeConstraints({
            make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(Constants.Theme.margin)
            make.trailing.equalTo(buttonView.snp.leading).offset(-Constants.Theme.margin)
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Theme.margin)
        })
    }
    
    
    func setupContentLabel() {
        containerView.addSubview(contentLabel)
        contentLabel.font = UIFont.systemFont(ofSize: Constants.Theme.primaryFontSize)
        contentLabel.numberOfLines = 0
        contentLabel.snp.makeConstraints({
            make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(Constants.Theme.margin)
            make.trailing.equalTo(buttonView.snp.leading).offset(-Constants.Theme.margin)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(Constants.Theme.margin)
            make.bottom.equalToSuperview().offset(-Constants.Theme.margin)
        })
    }
}
