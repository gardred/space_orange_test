//
//  LaunchListViewModel.swift
//  SpaceTest
//
//  Created by M1 Pro on 17.05.2025.
//

import Foundation
import Combine

protocol LaunchListViewModel {
    var launchList: Observable<[Launch]> { get }
    var isLoading: Observable<Bool> { get }
    var title: String { get }
    
    func launch(at index: Int) -> Launch?
    func didTapLaunch(_ launch: Launch)
    func didTapFavorites()
    func toggleFavoriteState(at index: Int)
}

final class LaunchListViewModelImp: LaunchListViewModel {
    
    private(set) var launchList: Observable<[Launch]> = Observable([])
    private(set) var isLoading: Observable<Bool> = Observable(false)
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
        
        Task {
            await getLaunchListData()
        }
    }
    
    func launch(at index: Int) -> Launch? {
        guard index < launchList.value.count else {
            return nil
        }
        
        return launchList.value[index]
    }
    
    func didTapFavorites() {
        let favoriteLaunches = launchList.value.filter { $0.isFavorite == true }
        coordinator.showLaunchFavoritesScreen(
            with: favoriteLaunches,
            animated: true
        )
    }
    
    func didTapLaunch(_ launch: Launch) {
        coordinator.showLaunchDetailsScreen(with: launch, animated: true)
    }
    
    func toggleFavoriteState(at index: Int) {
        let launch = launchList.value[index]
        
        if launch.isFavorite {
            CoreDataManager.shared.removeLaunch(by: launch.rocket)
        } else {
            CoreDataManager.shared.add(launch)
        }
        
        launchList.value[index].isFavorite.toggle()
    }
}

private extension LaunchListViewModelImp {
    
    func getLaunchListData() async {
        isLoading.value = true
        
        guard NetworkMonitor.shared.isConnected else {
            coordinator.showNoInternetAlert(title: "Ooooops....", message: "You are not connected to the internet.")
            return
        }
        
        guard let launchListItems = try? await networking.getLaunchListData() else { return }
        let favoriteIDs = fetchFavoriteLaunches()
        var launchList = [Launch]()
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
        
        self.launchList.value = launchList
        isLoading.value = false
    }
    
    func fetchFavoriteLaunches() -> [String] {
        let data = CoreDataManager.shared.getAllLaunches()
        let ids = data.compactMap { $0.id }
        
        return ids
    }
}
