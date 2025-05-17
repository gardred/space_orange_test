//
//  LaunchListViewModel.swift
//  SpaceTest
//
//  Created by M1 Pro on 17.05.2025.
//

import Foundation
import Combine

protocol LaunchListViewModel {
    var launchList: [LaunchList] { get }
    var title: String { get }
    
    func showLaunchDetailsScreen(id: String)
    func showLaunchFavoritesScreen()
}

final class LaunchListViewModelImp: LaunchListViewModel {
   
    private(set) var launchList: [LaunchList] = []
    let title: String
    
    private let coordinator: LaunchListCoordinator
    private let networking: LaunchListNetworking
    
    weak var delegate: LaunchListViewControllerDelegate?
    
    init(
        coordinator: LaunchListCoordinator,
        networking: LaunchListNetworking
    ) {
        self.coordinator = coordinator
        self.networking = networking
        
        self.title = "SpaceX"
        
        Task {
            await getLaunchListData()
        }
    }
    
    func getLaunchListData() async {
        guard let launchListItems = try? await networking.getLaunchListData() else { return }
        launchList = launchListItems
        
        delegate?.updateLaunchList()
    }
    
    func showLaunchFavoritesScreen() {
        coordinator.showLaunchFavoritesScreen(animated: true)
    }
    
    func showLaunchDetailsScreen(id: String) {
        coordinator.showLaunchDetailsScreen(with: id, animated: true)
    }
}
