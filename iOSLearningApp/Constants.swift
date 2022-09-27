//
//  Constants.swift
//  iOSLearningApp
//
//  Created by Akshay Rathi on 14/09/22.
//

import Foundation
import UIKit

struct Constants {
    struct Theme {
        static let primaryColor = UIColor.white
        static let secondaryColor = UIColor.gray
        static let primaryBgColor = UIColor.white
        static let secondaryBgColor = UIColor.black
        static let margin: CGFloat = 15
        static let cornerRadius: CGFloat = 20
        static let imageWidth: CGFloat = 100
        static let imageHeight: CGFloat = 100
        static let primaryFontSize: CGFloat = 12
        static let titleFontSize: CGFloat = 16
        static let subtiteFontSize: CGFloat = 10
    }
    
    struct ErrorMessage {
        static let defaultErrorMessage = "error"
        static let invalidUserIdError = "Invalid user id"
        static let cacheError = "could not get data from cache"
        static let dataEncodeError = "Unable to encode data"
    }
    
    struct String {
        static let tableViewTitle = "Pull Requests"
        static let okActionTitle = "Yes"
        static let cancelActionTitle = "No"
        static let alertControllerTitle = "Remove User"
        static let alertControllerMessage = "Are you sure that you want to remove this user data?"
        static let saveToastMessage = "User saved successfully"
        static let unsaveToastMessage = "User unsaved successfully"
    }
    
    struct CellModelLabel {
        static let name = "Name"
        static let email = "Email"
        static let type = "Type"
        static let company = "Company"
        static let repoCount =  "Public Repo Count"
        static let followerCount = "Follower's Count"
        static let followingCount = "Following Count"
    }
}
