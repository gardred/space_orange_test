//
//  LaunchListViewController.swift
//  SpaceTest
//
//  Created by M1 Pro on 17.05.2025.
//

import UIKit

protocol LaunchListViewControllerDelegate: AnyObject {
    func isLoading(_ loading: Bool)
    func updateLaunchList()
}

public final class LaunchListViewController: UIViewController {
    
    private lazy var tableView = makeTableView()
    private lazy var activityIndicator = makeActivityIndicator()
    
    private let viewModel: LaunchListViewModel
    
    init(viewModel: LaunchListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Task {
            await viewModel.getLaunchListData()
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureConstraints()
    }
}

extension LaunchListViewController: LaunchListViewControllerDelegate {
    func updateLaunchList() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func isLoading(_ loading: Bool) {
        DispatchQueue.main.async {
            self.tableView.alpha = loading ? 0.5 : 1.0
            loading
            ? self.activityIndicator.startAnimating()
            : self.activityIndicator.stopAnimating()
        }
    }
}

extension LaunchListViewController: LaunchListTableViewCellDelegate {
    func didTapFavoriteButton(_ cell: LaunchListTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        viewModel.toggleFavoriteState(at: indexPath.row)
    }
}

extension LaunchListViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.launchList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: LaunchListTableViewCell.identifier,
                for: indexPath) as? LaunchListTableViewCell
        else { return UITableViewCell() }
        
        let launch = viewModel.launchList[indexPath.row]
        cell.configure(with: launch)
        cell.delegate = self
        
        return cell
    }
}

extension LaunchListViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let launch = viewModel.launchList[indexPath.row]
        viewModel.showLaunchDetailsScreen(for: launch)
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
        view.addSubview(activityIndicator)
        
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
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func makeTableView() -> UITableView {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .black
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }
    
    func makeActivityIndicator() -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .large)
        view.tintColor = .white
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    @objc func didTapHeartButton() {
        viewModel.showLaunchFavoritesScreen()
    }
}
