//
//  LaunchFavoritesViewController.swift
//  SpaceTest
//
//  Created by M1 Pro on 17.05.2025.
//

import UIKit

public final class LaunchFavoritesViewController: UIViewController {
    
    private lazy var tableView = makeTableView()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureConstraints()
    }
}

extension LaunchFavoritesViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: LaunchListTableViewCell.identifier,
                for: indexPath) as? LaunchListTableViewCell
        else { return UITableViewCell() }
        
        return cell
    }
}

private extension LaunchFavoritesViewController {
    
    func setupUI() {
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.register(
            LaunchListTableViewCell.self,
            forCellReuseIdentifier: LaunchListTableViewCell.identifier
        )
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func makeTableView() -> UITableView {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }
}
