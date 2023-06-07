//
//  ArticleDescriptionCell.swift
//  SteamGames
//
//  Created by ramil on 29.05.2023.
//

import UIKit
import WebKit

final class ArticleDescriptionCell: UITableViewCell {

    var articleDescriptionTextView: UITextView = {
        let textVIew = UITextView()
        textVIew.textColor = .red
        textVIew.translatesAutoresizingMaskIntoConstraints = false
        textVIew.sizeToFit()
        textVIew.isScrollEnabled = false
        return textVIew
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
        articleDescriptionTextView.attributedText = title.htmlAttributedString(from: title,
                                        size: 15)
    }
    
    private func setupSubviews() {
        contentView.addSubview(articleDescriptionTextView)

        NSLayoutConstraint.activate([
            articleDescriptionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            articleDescriptionTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            articleDescriptionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            articleDescriptionTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
        ])
    }
}
