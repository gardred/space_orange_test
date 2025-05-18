//
//  LaunchListTableViewCell.swift
//  SpaceTest
//
//  Created by M1 Pro on 17.05.2025.
//

import UIKit
import SDWebImage

protocol LaunchListTableViewCellDelegate: AnyObject {
    func didTapFavoriteButton(_ cell: LaunchListTableViewCell)
}

final class LaunchListTableViewCell: UITableViewCell {
    
    private lazy var launchImageView = makeLaunchImageView()
    private lazy var titleLabel = makeTitleLabel()
    private lazy var dateLabel = makeDateLabel()
    private lazy var favoriteButton = makeFavoriteButton()
    
    weak var delegate: LaunchListTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupActions()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with launch: Launch) {
        titleLabel.text = launch.name
        dateLabel.text = launch.date.formattedAsLongDate()
        
        if let imageURL = launch.links.patch.imageURL {
            launchImageView.sd_setImage(with: URL(string: imageURL))
        }
        
        let image = launch.isFavorite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: image), for: .normal)
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
    
    func setupActions() {
        let favoriteButtonAction = UIAction { [weak self] _ in
            guard let self else { return }
            delegate?.didTapFavoriteButton(self)
        }
        
        favoriteButton.addAction(favoriteButtonAction, for: .touchUpInside)
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
        imageView.layer.cornerRadius = 16
        imageView.layer.borderWidth = 1
        imageView.contentMode = .scaleAspectFit
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
