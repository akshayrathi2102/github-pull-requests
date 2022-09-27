//
//  UserDetailTableCell.swift
//  iOSLearningApp
//
//  Created by Akshay Rathi on 15/09/22.
//

import Foundation
import SnapKit
import UIKit

class UserDetailTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let keyLabel = UILabel()
    private let valueLabel = UILabel()
    private let containerView = UIView()

    private func configure() {
        setupKeyLabel()
        setupValueLabel()
        setupContainerView()
    }

    func setData(key: String, value: String) {
        keyLabel.text = key
        valueLabel.text = value
    }
    
}

// MARK: Private methods
private extension UserDetailTableViewCell {
    func setupContainerView() {
        self.contentView.addSubview(containerView)
        containerView.snp.makeConstraints({
            make in
            make.top.bottom.leading.trailing.equalToSuperview().inset(Constants.Theme.margin)
        })
    }
    
    func setupKeyLabel() {
        self.containerView.addSubview(keyLabel)
        keyLabel.font = UIFont.boldSystemFont(ofSize: Constants.Theme.titleFontSize)
        keyLabel.snp.makeConstraints({
            make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(Constants.Theme.margin)
        })
    }
    
    func setupValueLabel() {
        self.containerView.addSubview(valueLabel)
        valueLabel.snp.makeConstraints({
            make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().inset(Constants.Theme.margin)
        })
    }
}
