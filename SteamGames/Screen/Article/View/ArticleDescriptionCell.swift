//
//  ArticleDescriptionCell.swift
//  SteamGames
//
//  Created by ramil on 29.05.2023.
//

import UIKit

class ArticleDescriptionCell: UITableViewCell {

    var articleDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = TestData.description
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        isUserInteractionEnabled = false
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with title: String?) {
        guard let title else { return }
        articleDescriptionLabel.text = title
    }
    
    private func setupSubviews() {
        contentView.addSubview(articleDescriptionLabel)
        
        NSLayoutConstraint.activate([
            articleDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            articleDescriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            articleDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            articleDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
        ])
    }


}
