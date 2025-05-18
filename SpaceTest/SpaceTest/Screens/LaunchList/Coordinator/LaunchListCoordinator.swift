//
//  LaunchListCoordinator.swift
//  SpaceTest
//
//  Created by M1 Pro on 17.05.2025.
//

import UIKit

protocol LaunchListCoordinator {
    func showLaunchFavoritesScreen(with favoriteLaunches: [Launch], animated: Bool)
    func showLaunchDetailsScreen(with launch: Launch, animated: Bool)
    func showNoInternetAlert(title: String, message: String)
}

final class LaunchListCoordinatorImp: LaunchListCoordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showLaunchFavoritesScreen(
        with favoriteLaunches: [Launch],
        animated: Bool
    ) {
        let viewController = LaunchFavoritesBuilder.build(with: favoriteLaunches)
        navigationController.pushViewController(
            viewController,
            animated: animated
        )
    }
    
    func showLaunchDetailsScreen(
        with launch: Launch,
        animated: Bool
    ) {
        let viewController = LaunchDetailsBuilder.build(
            with: navigationController,
            launch: launch
        )
        navigationController.pushViewController(
            viewController,
            animated: animated
        )
    }
    
    func showNoInternetAlert(
        title: String,
        message: String
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(
            .init(
                title: "Cancel",
                style: .cancel
            )
        )
        
        DispatchQueue.main.async {
            self.navigationController.present(
                alert,
                animated: true
            )
        }
    }
}
