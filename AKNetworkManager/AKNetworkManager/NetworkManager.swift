//
//  NetworkManager.swift
//  iOSLearningApp
//
//  Created by Akshay Rathi on 14/09/22.
//

import Foundation
import UIKit

public class NetworkManager {
    public static let shared = NetworkManager()
    private init() {}
    
    public func fetchData<T: Decodable>(_ api: API,  completionHandler: @escaping (T) -> Void) {
        var components = URLComponents()
        components.scheme = api.scheme
        components.host = api.baseUrl
        components.path = api.path
        var urlQueryItems : [URLQueryItem] = []
        if let queryParams = api.queryParams {
            queryParams.forEach({
                element in
                let urlQueryItem = URLQueryItem(name: element.key, value: element.value)
                urlQueryItems.append(urlQueryItem)
            })
        }
        components.queryItems = urlQueryItems
        
        guard let url = components.url else {
            print("invalid URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        fetchResponse(urlRequest, completionHandler: completionHandler)
        
    }
    
    private func fetchData<T: Decodable>(_ urlString: String,  completionHandler: @escaping (T) -> Void) {
        guard let url = URL(string: urlString) else {
            print("invalid URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        fetchResponse(urlRequest, completionHandler: completionHandler)
    }
    
    private func fetchResponse<T: Decodable>(_ urlRequest: URLRequest,  completionHandler: @escaping (T) -> Void) {
            
        URLSession.shared.dataTask(with: urlRequest , completionHandler: {
            (data, resposone, error)-> Void in
            if error != nil {
                print(error as Any)
                return
            }
            guard let data = data else {
                print("Data does not exist")
                return
            }
            if let object = try? JSONDecoder().decode(T.self, from: data) {
                DispatchQueue.main.async(execute: {
                    completionHandler(object)
                })
            } else {
                print("Invalid data format \(data)")
            }
        }).resume()
    }
    
    public func fetchImage(urlString: String, completionHandler: @escaping (UIImage)->()) {
        guard let url = URL(string: urlString) else {
            print("invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: {
            (data, response, error) -> Void in
                if error != nil {
                    print(error as Any )
                    return
                }
            guard let data = data else {
                return
            }
            guard let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                completionHandler(image)
            }
        }).resume()
    }
}


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
        return [
            "authorization":"token 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"
        ]
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
