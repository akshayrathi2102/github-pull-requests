//
//  LoaderTableViewCell.swift
//  iOSLearningApp
//
//  Created by Akshay Rathi on 14/09/22.
//

import Foundation
import UIKit

class LoaderTableViewCell: UITableViewCell {
    
    private var activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure () {
        self.backgroundColor = .white
        activityIndicatorView.color = .lightGray
        self.addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints({
            make in
            make.top.bottom.leading.trailing.equalToSuperview().inset(Constants.Theme.margin)
        })
    }
    
    func showLoader(_ show: Bool) {
        if(show == true) {
            activityIndicatorView.startAnimating()
        } else {
            activityIndicatorView.stopAnimating()
        }
    }
}
