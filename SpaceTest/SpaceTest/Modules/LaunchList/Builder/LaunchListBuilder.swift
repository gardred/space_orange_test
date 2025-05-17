//
//  LaunchListBuilder.swift
//  SpaceTest
//
//  Created by M1 Pro on 17.05.2025.
//

import UIKit

struct LaunchListBuilder {
    
    @MainActor
    static func build(with navigationController: UINavigationController) -> LaunchListViewController {
        let coordinator = LaunchListCoordinatorImp(navigationController: navigationController)
        let networking = LaunchListNetworkingImp()
        let viewModel = LaunchListViewModelImp(coordinator: coordinator, networking: networking)
        let viewController = LaunchListViewController(viewModel: viewModel)
        
        return viewController
    }
}
