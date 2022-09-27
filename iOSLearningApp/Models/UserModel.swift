//
//  UserModel.swift
//  iOSLearningApp
//
//  Created by Akshay Rathi on 14/09/22.
//

import Foundation
import UIKit

struct User: Codable {
    let id: Double?
    let login: String?
    let type: String?
    let avatar_url: String?
    let name: String?
    let company: String?
    let location: String?
    let email: String?
    let hireable: Bool?
    let bio: String?
    let twitter_username: String?
    let public_repos: Int?
    let public_gists: Int?
    let followers: Int?
    let following: Int?
    var is_favourite: Bool?
}


struct cellModel {
    let leftLabel: String
    let rightLabel: String
}





