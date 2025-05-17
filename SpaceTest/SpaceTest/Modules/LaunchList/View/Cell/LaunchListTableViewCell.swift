//
//  LaunchListTableViewCell.swift
//  SpaceTest
//
//  Created by M1 Pro on 17.05.2025.
//

import UIKit

final class LaunchListTableViewCell: UITableViewCell {
    
    static var identifier: String {
        String(describing: self)
    }
    
    private lazy var launchImageView = makeLaunchImageView()
    private lazy var titleLabel = makeTitleLabel()
    private lazy var dateLabel = makeDateLabel()
    private lazy var favoriteButton = makeFavoriteButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LaunchListTableViewCell {
    
    func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        contentView.isHidden = true
        
        addSubview(launchImageView)
        addSubview(titleLabel)
        addSubview(dateLabel)
        addSubview(favoriteButton)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            launchImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            launchImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            launchImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            launchImageView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: launchImageView.bottomAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            
            dateLabel.topAnchor.constraint(equalTo: launchImageView.bottomAnchor, constant: 15),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            
            favoriteButton.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            favoriteButton.widthAnchor.constraint(equalToConstant: 30),
            favoriteButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
 
    func makeLaunchImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        imageView.layer.cornerRadius = 16
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.text = "Title"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func makeDateLabel() -> UILabel {
        let label = UILabel()
        label.text = "Date"
        label.textColor = .white
        label.backgroundColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func makeFavoriteButton() -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
