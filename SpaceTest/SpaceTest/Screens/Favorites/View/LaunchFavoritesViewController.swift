//
//  LaunchFavoritesViewController.swift
//  SpaceTest
//
//  Created by M1 Pro on 17.05.2025.
//

import UIKit

public final class LaunchFavoritesViewController: UIViewController {
    
    private lazy var tableView = makeTableView()
    
    private let viewModel: LaunchFavoritesViewModel
    
    init(viewModel: LaunchFavoritesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureConstraints()
    }
}

extension LaunchFavoritesViewController: LaunchListTableViewCellDelegate {
    func didTapFavoriteButton(_ cell: LaunchListTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        viewModel.removeLaunch(at: indexPath.row)
        tableView.reloadData()
    }
}

extension LaunchFavoritesViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.launchFavorites.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: LaunchListTableViewCell.identifier,
                for: indexPath) as? LaunchListTableViewCell
        else { return UITableViewCell() }
        
        let launch = viewModel.launchFavorites[indexPath.row]
        cell.configure(with: launch)
        cell.delegate = self
        
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
        tableView.backgroundColor = .black
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }
}
