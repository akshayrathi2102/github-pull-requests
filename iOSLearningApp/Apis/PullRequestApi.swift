//
//  PullRequestApi.swift
//  iOSLearningApp
//
//  Created by Akshay Rathi on 14/09/22.
//

import Foundation
import AKNetworkManager

struct PullRequestApi: API {
    let pageNumber: Int
    let pageSize: Int = APIConstants.PULL_REQUEST_PAGE_SIZE
        
    
    var path: String {
        return APIConstants.PULL_REQUEST_PATH
    }
    
    var queryParams: [String : String]? {
        return ["page": "\(pageNumber)", "per_page": "\(pageSize )"]
    }
    
}
