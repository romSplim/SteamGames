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
//        label.numberOfLines = 0
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
    func configure(with model: App?) {
        guard let model else { return }
        appNameLabel.text = model.name
        appTypeLabel.text = model.type
    }
    
    
    //MARK: - Private methods
    private func setupSubviews() {
        contentView.addSubview(appNameLabel)
        contentView.addSubview(appTypeLabel)
        
        let safeArea = contentView.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            appNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            appNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            appNameLabel.heightAnchor.constraint(equalToConstant: 40),
//            appNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            appNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            appNameLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -15),
            
            appTypeLabel.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: 5),
            appTypeLabel.widthAnchor.constraint(equalToConstant: 40),
            appTypeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            appTypeLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
