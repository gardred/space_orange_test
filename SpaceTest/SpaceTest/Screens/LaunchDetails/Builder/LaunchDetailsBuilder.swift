//
//  LaunchDetailsBuilder.swift
//  SpaceTest
//
//  Created by M1 Pro on 17.05.2025.
//

import UIKit

struct LaunchDetailsBuilder {
    
    static func build(with navigationController: UINavigationController, launch: LaunchList) -> LaunchDetailsViewController {
        let viewModel = LaunchDetailsViewModelImp(launch: launch)
        let viewController = LaunchDetailsViewController(viewModel: viewModel)
        
        return viewController
    }
}
