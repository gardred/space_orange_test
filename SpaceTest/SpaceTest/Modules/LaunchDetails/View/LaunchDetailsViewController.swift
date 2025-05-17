//
//  LaunchDetailsViewController.swift
//  SpaceTest
//
//  Created by M1 Pro on 17.05.2025.
//

import UIKit

public final class LaunchDetailsViewController: UIViewController {
    
    private lazy var tableView = makeTableView()
    
    private let viewModel: LaunchDetailsViewModel
    
    init(viewModel: LaunchDetailsViewModel) {
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

extension LaunchDetailsViewController: LaunchDetailsTableViewCellDelegate {
    func didTapWikipediaButton() {
        guard let wikipediaURL = viewModel.launch.links.wikipedia,
              let url = URL(string: wikipediaURL)
        else { return }
        
        UIApplication.shared.open(url)
    }
}

extension LaunchDetailsViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: LaunchDetailsTableViewCell.identifier,
                for: indexPath) as? LaunchDetailsTableViewCell
        else { return UITableViewCell() }
        
        let details = viewModel.launch
        cell.delegate = self
        cell.configure(with: details)
        
        return cell
    }
}

private extension LaunchDetailsViewController {
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        navigationItem.title = viewModel.title
        
        tableView.dataSource = self
        tableView.register(
            LaunchDetailsTableViewCell.self,
            forCellReuseIdentifier: LaunchDetailsTableViewCell.identifier
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
