//
//  ViewModelDelegate.swift
//  iOSLearningApp
//
//  Created by Akshay Rathi on 14/09/22.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func showLoader(_ show: Bool)
    func showError()
    func setupTableView()
}

protocol PullRequestViewModelDelegate: ViewModelDelegate {
    var moreDataAvailable: Int { get set }
    func loadData(_ data: [PullRequest])
    func loadCellData(_ data: PullRequest, indexPath: IndexPath)
}

protocol UserDetailViewModelDelegate: ViewModelDelegate {
    func loadData(_ data: [cellModel])
    func setupRightBarButton(buttonName: String)
    func setupFavouriteButton(buttonName: String)
    func showToast(message: String)
}
