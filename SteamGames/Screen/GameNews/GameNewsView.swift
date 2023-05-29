//
//  GameNewsView.swift
//  SteamGames
//
//  Created by ramil on 29.05.2023.
//

import UIKit

protocol GameNewsViewProtocol: AnyObject {
    func reloadTableView()
}

final class GameNewsView: UIViewController {

    var presenter: GameNewsPresenter?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .secondarySystemBackground
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.lightGray
        setupSubviews()
        presenter?.getGameNews()
        
    }
    
    //MARK: - Private methods
    private func setupSubviews() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

//MARK: - UITableView dataSource
extension GameNewsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getAppNewsCount() ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.identifier, for: indexPath) as? ArticleCell else {
            return UITableViewCell()
        }
        
        let newsItem = presenter?.getArticleForApp(from: indexPath)
        cell.configure(with: newsItem)
        
        return cell
    }
}

//MARK: - UITableView delegate
extension GameNewsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
}

//MARK: - GameNewsPresenter delegate
extension GameNewsView: GameNewsViewProtocol {
    func reloadTableView() {
        tableView.reloadData()
    }
}
