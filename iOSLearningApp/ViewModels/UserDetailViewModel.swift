//
//  UserDetailViewModel.swift
//  iOSLearningApp
//
//  Created by Akshay Rathi on 15/09/22.
//

import Foundation
import UIKit
import AKNetworkManager
import AKDatabaseManager

class UserDetailViewModel {
    weak var userDetailViewModelDelegate: (UserDetailViewModelDelegate)?
    private var userDetail: User
    private var cellViewModels: [cellModel] = []
    
    init(user: User) {
        userDetail = user
    }
    
    func viewDidLoad(user: User) {
        userDetailViewModelDelegate?.showLoader(true)
        let userData = getDataFromCache(user: user)
        if userData == nil {
            self.userDetailViewModelDelegate?.setupRightBarButton(buttonName: UIImage.NameConstants.saveButtonName)
            if let userName = user.login {
                NetworkManager.shared.fetchData(UserDetailApi(username: userName), completionHandler: {
                (userResponse: User) in
                    self.userDetail = userResponse
                    self.userDetail.is_favourite = user.is_favourite
                    self.formatResponseData()
                    self.userDetailViewModelDelegate?.showLoader(false)
                    self.userDetailViewModelDelegate?.loadData(self.cellViewModels)
                })
            }
        }
        else {
            guard let userDetail = userData else {
                return
            }
            self.userDetail = userDetail
            self.userDetail.is_favourite = user.is_favourite
            self.formatResponseData()
            self.userDetailViewModelDelegate?.showLoader(false)
            self.userDetailViewModelDelegate?.setupRightBarButton(buttonName: UIImage.NameConstants.unsaveButtonName)
            self.userDetailViewModelDelegate?.loadData(self.cellViewModels)
        }
        
        if(userDetail.is_favourite == true) {
            self.userDetailViewModelDelegate?.setupFavouriteButton(buttonName: UIImage.NameConstants.unfavouriteButtonName)
        }
        else {
            self.userDetailViewModelDelegate?.setupFavouriteButton(buttonName: UIImage.NameConstants.favouriteButtonName)
        }
    }
    
    func getDataFromCache(user: User)-> User? {
        guard let userid = user.login else {
            print(Constants.ErrorMessage.invalidUserIdError)
            return nil
        }
        guard let userData: User = DBManager(key: userid).getKey() else {
            print(Constants.ErrorMessage.cacheError)
            return nil
        }
        return userData
    }
    
    
    func formatResponseData() {
        if let name = userDetail.name {
            let model = cellModel(leftLabel: Constants.CellModelLabel.name, rightLabel: name)
            cellViewModels.append(model)
        }

        if let email = userDetail.email {
            let model = cellModel(leftLabel: Constants.CellModelLabel.email, rightLabel: email)
            cellViewModels.append(model)
        }


        if let type = userDetail.type {
            let model = cellModel(leftLabel: Constants.CellModelLabel.type, rightLabel: type)
            cellViewModels.append(model)
        }
        
        if let company = userDetail.company {
            let model = cellModel(leftLabel: Constants.CellModelLabel.company, rightLabel: company)
            cellViewModels.append(model)
        }
        
        if let public_repos = userDetail.public_repos {
            let model = cellModel(leftLabel: Constants.CellModelLabel.repoCount, rightLabel: String(public_repos))
            cellViewModels.append(model)
        }
        
        if let followers = userDetail.followers {
            let model = cellModel(leftLabel: Constants.CellModelLabel.followerCount, rightLabel: String(followers))
            cellViewModels.append(model)
        }
        
        if let following = userDetail.following {
            let model = cellModel(leftLabel: Constants.CellModelLabel.followingCount, rightLabel: String(following))
            cellViewModels.append(model)
        }
    }

    
    func rightSideBarButtonItemTapped() {
        if getDataFromCache(user: userDetail) == nil {
            guard let userid = userDetail.login else {
                print(Constants.ErrorMessage.invalidUserIdError)
                return
            }
            DBManager(key: userid).setKey(object: userDetail)
            userDetailViewModelDelegate?.setupRightBarButton(buttonName: UIImage.NameConstants.unsaveButtonName)
            userDetailViewModelDelegate?.showToast(message: Constants.String.saveToastMessage)
        } else {
            guard let userid = userDetail.login else {
                print(Constants.ErrorMessage.invalidUserIdError)
                return
            }
            DBManager(key: userid).removeKey()
            userDetailViewModelDelegate?.setupRightBarButton(buttonName: UIImage.NameConstants.saveButtonName)
            userDetailViewModelDelegate?.showToast(message: Constants.String.unsaveToastMessage)
        }
    }
    
    func favouriteButtonTapped() {
        if(userDetail.is_favourite == true) {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Notification.Name.favouriteNotificationName), object: self.userDetail.login)
            self.userDetailViewModelDelegate?.setupFavouriteButton(buttonName: UIImage.NameConstants.favouriteButtonName)
            userDetail.is_favourite = false
        }
        else {
            userDetail.is_favourite = true
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Notification.Name.favouriteNotificationName), object: self.userDetail.login)
            self.userDetailViewModelDelegate?.setupFavouriteButton(buttonName: UIImage.NameConstants.unfavouriteButtonName)
        }
    }
    
}
