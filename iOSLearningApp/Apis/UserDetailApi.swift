//
//  UserDetailApi.swift
//  iOSLearningApp
//
//  Created by Akshay Rathi on 14/09/22.
//

import Foundation
import AKNetworkManager

struct UserDetailApi: API {
    let username: String
        
    var path: String {
        return APIConstants.USER_DETAIL_PATH + "/\(username)"
    }
    
    var queryParams: [String : String]? {
        return nil
    }
    
}
