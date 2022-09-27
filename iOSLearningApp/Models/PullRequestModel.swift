//
//  PullRequestModel.swift
//  iOSLearningApp
//
//  Created by Akshay Rathi on 14/09/22.
//

import Foundation

struct PullRequest:Codable {
    let id: Double?
    let title: String?
    var user: User?
    let body: String?
    let state: String?
}
