//
//  ApiConstants.swift
//  AKNetworkManager
//
//  Created by Akshay Rathi on 27/09/22.
//

import Foundation

public protocol API {
    var scheme: String { get }
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryParams: [String: String]? { get }
    var headers: [String: String]? { get }
    var body: [String: String]? { get }
}

public extension API {
    var scheme: String {
        return APIConstants.SCHEME
    }
    var baseUrl: String {
        return APIConstants.BASE_URL
    }
    var method: HTTPMethod {
        return .GET
    }
    var headers: [String: String]? {
        return nil
    }
    var body: [String: String]? {
        return nil
    }
}

public enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case PATCH
    case DELETE
}

public struct APIConstants {
    public static var SCHEME = "https"
    public static var METHOD = HTTPMethod.GET
    public static var BASE_URL = "api.github.com"
    public static var PULL_REQUEST_PATH = "/repos/ros-planning/moveit_tutorials/pulls"
    public static var PULL_REQUEST_PAGE_SIZE = 10
    public static var USER_DETAIL_PATH = "/users"
}
