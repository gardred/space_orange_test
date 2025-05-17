//
//  LaunchListCoordinator.swift
//  SpaceTest
//
//  Created by M1 Pro on 17.05.2025.
//

import UIKit

protocol LaunchListCoordinator {
    func showLaunchFavoritesScreen(animated: Bool)
    func showLaunchDetailsScreen(with launch: LaunchList, animated: Bool)
}

final class LaunchListCoordinatorImp: LaunchListCoordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showLaunchFavoritesScreen(animated: Bool) {
        let viewController = LaunchFavoritesBuilder.build()
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func showLaunchDetailsScreen(with launch: LaunchList, animated: Bool) {
        let viewController = LaunchDetailsBuilder.build(with: navigationController, launch: launch)
        navigationController.pushViewController(viewController, animated: animated)
    }
}
