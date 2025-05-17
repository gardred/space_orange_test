//
//  LaunchFavoritesBuilder.swift
//  SpaceTest
//
//  Created by M1 Pro on 17.05.2025.
//

import Foundation

struct LaunchFavoritesBuilder {
    
    static func build(with favoriteLaunches: [Launch]) -> LaunchFavoritesViewController {
        let viewModel = LaunchFavoritesViewModelImp(launchFavorites: favoriteLaunches)
        let viewController = LaunchFavoritesViewController(viewModel: viewModel)
        
        return viewController
    }
}
