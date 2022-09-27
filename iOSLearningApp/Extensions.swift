//
//  Extensions.swift
//  iOSLearningApp
//
//  Created by Akshay Rathi on 27/09/22.
//

import Foundation
import UIKit
import AKNetworkManager

extension UIImage {
    struct NameConstants {
        static let defaultProfileImageName = "user"
        static let favouriteButtonName = "star"
        static let unfavouriteButtonName = "star.fill"
        static let saveButtonName = "icloud.and.arrow.down"
        static let unsaveButtonName = "checkmark.icloud.fill"
    }
    
    enum Assets: String {
        case user
        
        var image: UIImage? {
            return UIImage(named: self.rawValue)
        }
    }
}


extension UIImageView {
    func fetchImage(with url: String, placeHolderImage: UIImage? = nil) {
        NetworkManager.shared.fetchImage(urlString: url, completionHandler: { [weak self]
            image in
            self?.image = image
        })
    }
}


extension Notification.Name {
    static let favouriteNotificationName = "Favourite"
}
