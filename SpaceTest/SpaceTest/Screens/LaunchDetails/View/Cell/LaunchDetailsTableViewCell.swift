//
//  LaunchDetailsTableViewCell.swift
//  SpaceTest
//
//  Created by M1 Pro on 17.05.2025.
//

import UIKit
import YouTubeiOSPlayerHelper

protocol LaunchDetailsTableViewCellDelegate: AnyObject {
    func didTapWikipediaButton()
}

final class LaunchDetailsTableViewCell: UITableViewCell {
    
    static var identifier: String {
        String(describing: self)
    }
    
    private lazy var youtubePlayerView = makeYoutubePlayerView()
    private lazy var dateLabel = makeDateLabel()
    private lazy var descriptionLabel = makeDescriptionLabel()
    private lazy var rocketName = makeRocketName()
    private lazy var massLabel = makeMassLabel()
    private lazy var wikipediaButton = makeWikipediaButton()
    
    weak var delegate: LaunchDetailsTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupActions()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with details: LaunchList) {
        let videoID = details.links.youtubeID ?? ""
        youtubePlayerView.load(withVideoId: videoID)
        dateLabel.text = details.date
        descriptionLabel.text = details.details
        rocketName.text = "Rocket name: \(details.name)"
        massLabel.text = "Payload mass: "
    }
}

private extension LaunchDetailsTableViewCell {
    
    func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.isHidden = true 
        
        addSubview(youtubePlayerView)
        addSubview(dateLabel)
        addSubview(descriptionLabel)
        addSubview(rocketName)
        addSubview(massLabel)
        addSubview(wikipediaButton)
    }
    
    func setupActions() {
        let wikipediaAction = UIAction { [weak self] _ in
            self?.delegate?.didTapWikipediaButton()
        }
        
        wikipediaButton.addAction(wikipediaAction, for: .touchUpInside)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            youtubePlayerView.topAnchor.constraint(equalTo: topAnchor),
            youtubePlayerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            youtubePlayerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            youtubePlayerView.heightAnchor.constraint(equalToConstant: 200),
            
            dateLabel.topAnchor.constraint(equalTo: youtubePlayerView.bottomAnchor, constant: 15),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            descriptionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 15),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            rocketName.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 15),
            rocketName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            rocketName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            massLabel.topAnchor.constraint(equalTo: rocketName.bottomAnchor, constant: 15),
            massLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            massLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            wikipediaButton.topAnchor.constraint(equalTo: massLabel.bottomAnchor, constant: 15),
            wikipediaButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            wikipediaButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            wikipediaButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
    }
    
    func makeYoutubePlayerView() -> YTPlayerView {
        let view = YTPlayerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func makeDateLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func makeDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func makeRocketName() -> UILabel {
        let label = UILabel()
        label.textColor = .cyan
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func makeMassLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .cyan
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func makeWikipediaButton() -> UIButton {
        let button = UIButton()
        button.setTitle("Wikipedia", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
