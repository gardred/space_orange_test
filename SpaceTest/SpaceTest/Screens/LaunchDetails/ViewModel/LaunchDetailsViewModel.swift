//
//  LaunchDetailsViewModel.swift
//  SpaceTest
//
//  Created by M1 Pro on 17.05.2025.
//

import Foundation

protocol LaunchDetailsViewModel {
    var launch: Launch { get }
    var title: String { get }
}

final class LaunchDetailsViewModelImp: LaunchDetailsViewModel {
    let launch: Launch
    let title: String
    
    init(launch: Launch) {
        self.launch = launch
        self.title = launch.name
    }
}
