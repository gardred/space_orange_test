//
//  LaunchListViewController.swift
//  SpaceTest
//
//  Created by M1 Pro on 17.05.2025.
//

import UIKit

public final class LaunchListViewController: UIViewController {
    
    private lazy var tableView = makeTableView()
    
    private let viewModel: LaunchListViewModel
    
    init(viewModel: LaunchListViewModel) {
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

extension LaunchListViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
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

extension LaunchListViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.showLaunchDetailsScreen(id: "")
    }
}

private extension LaunchListViewController {
    
    func setupUI() {
        navigationItem.title = viewModel.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "heart"),
            style: .done,
            target: self,
            action: #selector(didTapHeartButton)
        )
        navigationItem.rightBarButtonItem?.tintColor = .red
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
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
    
    @objc func didTapHeartButton() {
        viewModel.showLaunchFavoritesScreen()
    }
}
