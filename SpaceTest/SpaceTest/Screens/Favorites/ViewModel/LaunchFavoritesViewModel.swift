//
//  LaunchFavoritesViewModel.swift
//  SpaceTest
//
//  Created by M1 Pro on 17.05.2025.
//

import Foundation

protocol LaunchFavoritesViewModel {
    var launchFavorites: [Launch] { get }
    
    func removeLaunch(at index: Int)
}

final class LaunchFavoritesViewModelImp: LaunchFavoritesViewModel {
    
    private(set) var launchFavorites: [Launch] = []
    
    init(launchFavorites: [Launch]) {
        self.launchFavorites = launchFavorites
    }
    
    func removeLaunch(at index: Int) {
        let launch = launchFavorites[index]
        launchFavorites.remove(at: index)
        CoreDataManager.shared.removeLaunch(by: launch.rocket)
    }
}
