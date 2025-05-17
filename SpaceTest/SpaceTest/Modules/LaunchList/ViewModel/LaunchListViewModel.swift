//
//  LaunchListViewModel.swift
//  SpaceTest
//
//  Created by M1 Pro on 17.05.2025.
//

import Foundation

protocol LaunchListViewModel {
    var title: String { get }
    
    func showLaunchDetailsScreen(id: String)
    func showLaunchFavoritesScreen()
}

@MainActor
final class LaunchListViewModelImp: @preconcurrency LaunchListViewModel {
    let title: String
    
    private let coordinator: LaunchListCoordinator
    private let networking: LaunchListNetworking
    
    init(
        coordinator: LaunchListCoordinator,
        networking: LaunchListNetworking
    ) {
        self.coordinator = coordinator
        self.networking = networking
        
        self.title = "SpaceX"
        
        getLaunchListData()
    }
    
    func getLaunchListData() {
        Task {
            try? await networking.getLaunchListData()
        }
    }
    
    func showLaunchFavoritesScreen() {
        coordinator.showLaunchFavoritesScreen(animated: true)
    }
    
    func showLaunchDetailsScreen(id: String) {
        coordinator.showLaunchDetailsScreen(with: id, animated: true)
    }
}
