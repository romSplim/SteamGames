//
//  ArticleCell.swift
//  SteamGames
//
//  Created by ramil on 29.05.2023.
//

import UIKit

fileprivate enum Constants {
    static let containerCornerRadius: CGFloat = 15
}

class ArticleCell: UITableViewCell {
    
    //MARK: - Propertiews
    var roundedContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = Constants.containerCornerRadius
        return view
    }()
    
    var articleTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    var articleAuthorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    lazy var vLabelStackView: UIStackView = {
        let subviews = [articleTitleLabel, articleAuthorLabel]
        let stack = UIStackView(arrangedSubviews: subviews)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .leading
        return stack
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .secondarySystemBackground
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func configure(with model: NewsItem?) {
        guard let model else { return }
        articleTitleLabel.text = model.title
        articleAuthorLabel.text = model.author
    }
    
    //MARK: - Private methods
    private func setupSubviews() {
        contentView.addSubview(roundedContainerView)
        roundedContainerView.addSubview(vLabelStackView)
        
        NSLayoutConstraint.activate([
            roundedContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            roundedContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            roundedContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            roundedContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            vLabelStackView.leadingAnchor.constraint(equalTo: roundedContainerView.leadingAnchor, constant: 10),
            vLabelStackView.topAnchor.constraint(equalTo: roundedContainerView.topAnchor, constant: 5),
            vLabelStackView.trailingAnchor.constraint(equalTo: roundedContainerView.trailingAnchor, constant: -10),
            vLabelStackView.bottomAnchor.constraint(equalTo: roundedContainerView.bottomAnchor, constant: -5),

        ])
    }
    
}
