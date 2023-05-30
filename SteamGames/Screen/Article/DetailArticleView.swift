//
//  DetailArticleView.swift
//  SteamGames
//
//  Created by ramil on 29.05.2023.
//

import UIKit

protocol DetailArticleViewProtocol: AnyObject {}

final class DetailArticleView: UIViewController {
    
    //MARK: - Properties
    var presenter: DetailArticlePresenter?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .secondarySystemBackground
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ArticleTitleCell.self, forCellReuseIdentifier: ArticleTitleCell.identifier)
        tableView.register(ArticleDescriptionCell.self, forCellReuseIdentifier: ArticleDescriptionCell.identifier)
        return tableView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = tableView.backgroundColor
        setupSubviews()
    }

    //MARK: - Private methods
    private func setupSubviews() {
        view.addSubview(tableView)
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

//MARK: - UITableView dataSource
extension DetailArticleView: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        return RowType.allCases.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rowType = RowType(rawValue: indexPath.row)
        let newsItem = presenter?.getArticle()
        
        switch rowType {
        case .title:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTitleCell.identifier, for: indexPath) as? ArticleTitleCell else { return UITableViewCell() }
            cell.configure(with: newsItem?.title)
            return cell
        case .description:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleDescriptionCell.identifier, for: indexPath) as? ArticleDescriptionCell else { return UITableViewCell() }
            cell.configure(with: newsItem?.contents)
            return cell
        case .none:
            break
        }
        return UITableViewCell()
    }
}

//MARK: - DetailArticlePresenter delegate
extension DetailArticleView: DetailArticleViewProtocol {}

//MARK: - RowType Enum
extension DetailArticleView {
    enum RowType: Int, CaseIterable {
        case title
        case description
    }
}
