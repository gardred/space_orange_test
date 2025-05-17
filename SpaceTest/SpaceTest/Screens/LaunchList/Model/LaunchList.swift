//
//  LaunchList.swift
//  SpaceTest
//
//  Created by M1 Pro on 17.05.2025.
//

import Foundation

struct Launch {
    let rocket: String
    let name: String
    let date: String
    let details: String?
    let links: LaunchListLinks
    
    var isFavorite: Bool = false
}

struct LaunchList: Codable {
    let rocket: String
    let name: String
    let date: String
    let details: String?
    let links: LaunchListLinks
    
    enum CodingKeys: String, CodingKey {
        case rocket,
             name,
             links,
             details
        case date = "date_utc"
    }
}

struct LaunchListLinks: Codable {
    let patch: LaunchListPatch
    let wikipedia: String?
    let youtubeID: String?
 
    enum CodingKeys: String, CodingKey {
        case wikipedia, patch
        case youtubeID = "youtube_id"
    }
}

struct LaunchListPatch: Codable {
    let imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "large"
    }
}
