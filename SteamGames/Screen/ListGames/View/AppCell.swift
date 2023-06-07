//
//  AppCell.swift
//  SteamGames
//
//  Created by ramil on 29.05.2023.
//

import UIKit

class AppCell: UITableViewCell {
    
    //MARK: - Properties
    var appNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    var appTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Ololo"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func configure(with model: AppItem?) {
        guard let model else { return }
        appNameLabel.text = model.name
    }
    
    
    //MARK: - Private methods
    private func setupSubviews() {
        contentView.addSubview(appNameLabel)
        
        let safeArea = contentView.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            appNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            appNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            appNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            appNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            appNameLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -15),
            
        ])
    }
}
