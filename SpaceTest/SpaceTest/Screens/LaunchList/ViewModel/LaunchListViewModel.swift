//
//  LaunchListViewModel.swift
//  SpaceTest
//
//  Created by M1 Pro on 17.05.2025.
//

import Foundation
import Combine

protocol LaunchListViewModel {
    var launchList: [Launch] { get }
    var title: String { get }
    
    func getLaunchListData() async
    func showLaunchDetailsScreen(for launch: Launch)
    func showLaunchFavoritesScreen()
    func toggleFavoriteState(at index: Int)
}

final class LaunchListViewModelImp: LaunchListViewModel {
   
    private(set) var launchList: [Launch] = []
    let title: String
    
    private let coordinator: LaunchListCoordinator
    private let networking: LaunchListNetworking
    
    private var isLoading: Bool = false {
        didSet {
            delegate?.isLoading(isLoading)
        }
    }
    
    weak var delegate: LaunchListViewControllerDelegate?
    
    init(
        coordinator: LaunchListCoordinator,
        networking: LaunchListNetworking
    ) {
        self.coordinator = coordinator
        self.networking = networking
        
        self.title = "SpaceX"
    }
    
    func getLaunchListData() async {
        isLoading = true
        guard let launchListItems = try? await networking.getLaunchListData() else { return }
        let favoriteIDs = fetchFavoriteLaunches()
        
        launchListItems.forEach { launch in
            launchList.append(
                .init(
                    rocket: launch.rocket,
                    name: launch.name,
                    date: launch.date,
                    details: launch.details,
                    links: launch.links
                )
            )
        }

        
        favoriteIDs.forEach { id in
            if let index = launchList.firstIndex(where: { $0.rocket == id }) {
                launchList[index].isFavorite = true
            }
        }
        
        delegate?.updateLaunchList()
        isLoading = false
    }
    
    func showLaunchFavoritesScreen() {
        let favoriteLaunches = launchList.filter { $0.isFavorite == true }
        coordinator.showLaunchFavoritesScreen(with: favoriteLaunches, animated: true)
    }
    
    func showLaunchDetailsScreen(for launch: Launch) {
        coordinator.showLaunchDetailsScreen(with: launch, animated: true)
    }
    
    func toggleFavoriteState(at index: Int) {
        let launch = launchList[index]
        
        if launch.isFavorite {
            CoreDataManager.shared.removeLaunch(by: launch.rocket)
        } else {
            CoreDataManager.shared.add(launch)
        }
        
        launchList[index].isFavorite.toggle()
        
        delegate?.updateLaunchList()
    }
}

private extension LaunchListViewModelImp {
    
    func fetchFavoriteLaunches() -> [String] {
        let data = CoreDataManager.shared.getAllLaunches()
        let ids = data.compactMap { $0.id }
        
        return ids
    }
}
