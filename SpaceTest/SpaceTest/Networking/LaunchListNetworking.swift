//
//  LaunchListNetworking.swift
//  SpaceTest
//
//  Created by M1 Pro on 17.05.2025.
//

import Foundation

protocol LaunchListNetworking {
    func getLaunchListData() async throws -> [LaunchList]
}

final class LaunchListNetworkingImp: LaunchListNetworking {
    
    func getLaunchListData() async throws -> [LaunchList] {
        let url = URL(string: NetworkingURL.launches.path)!
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let launchList = try JSONDecoder().decode([LaunchList].self, from: data)
        
        return launchList
    }
}
