//
//  PullRequestListViewModel.swift
//  iOSLearningApp
//
//  Created by Akshay Rathi on 14/09/22.
//

import Foundation
import UIKit
import Network
import AKNetworkManager


class PullRequestListViewModel {
    weak var pullRequestViewModelDelegate: (PullRequestViewModelDelegate)?
    private var pullRequestResponse: [PullRequest] = []
    private var page: Int = 1
    
    func viewDidLoad() {
        pullRequestViewModelDelegate?.showLoader(true)
        NetworkManager.shared.fetchData(PullRequestApi(pageNumber: page), completionHandler: {
            (pullRequestData: [PullRequest]) in
            if(pullRequestData.count == 0) {
                self.pullRequestViewModelDelegate?.moreDataAvailable = 0
            }
            else {
                self.pullRequestResponse += pullRequestData
                self.page += 1
            }
            self.pullRequestViewModelDelegate?.showLoader(false)
            self.pullRequestViewModelDelegate?.loadData(self.pullRequestResponse)
        })
    }
    
    func willDisplayTableCell(indexPath: IndexPath) {
        if self.pullRequestViewModelDelegate?.moreDataAvailable == 1 && pullRequestResponse.count == indexPath.row + 2 {
            NetworkManager.shared.fetchData(PullRequestApi(pageNumber: page) , completionHandler: {
                (pullRequestData: [PullRequest]) in
                if(pullRequestData.count == 0) {
                    self.pullRequestViewModelDelegate?.moreDataAvailable = 0
                }
                else {
                    self.pullRequestResponse += pullRequestData
                    self.page += 1
                }
                self.pullRequestViewModelDelegate?.loadData(self.pullRequestResponse)
            })
        }
    }
    
    func toggleFavourite(username: String) {
        for i in 0 ... pullRequestResponse.count - 1 {
            if(pullRequestResponse[i].user?.login == username) {
                if(pullRequestResponse[i].user?.is_favourite == true) {
                    pullRequestResponse[i].user?.is_favourite = false
                }
                else {
                    pullRequestResponse[i].user?.is_favourite = true
                }
                pullRequestViewModelDelegate?.loadCellData(pullRequestResponse[i], indexPath: IndexPath(row: i, section: 0))
            }
        }
    }
}
