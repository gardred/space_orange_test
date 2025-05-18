//
//  NetworkingURLs.swift
//  SpaceTest
//
//  Created by M1 Pro on 18.05.2025.
//

import Foundation

enum NetworkingURL {
    case launches
    
    var path: String {
        switch self {
        case .launches:
            return "https://api.spacexdata.com/v4/launches/"
        }
    }
}
