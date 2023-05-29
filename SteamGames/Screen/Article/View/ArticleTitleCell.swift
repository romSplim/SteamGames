//
//  ArticleTitleCell.swift
//  SteamGames
//
//  Created by ramil on 29.05.2023.
//

import UIKit

class ArticleTitleCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        isUserInteractionEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var articleTitleLabel: UILabel = {
        let label = UILabel()
//        label.text = TestData.title
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    func configure(with title: String?) {
        guard let title else { return }
        articleTitleLabel.text = title
    }
    
    private func setupSubviews() {
        contentView.addSubview(articleTitleLabel)
        
        NSLayoutConstraint.activate([
            articleTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            articleTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            articleTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            articleTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
        ])
    }
}
