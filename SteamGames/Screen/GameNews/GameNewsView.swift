//
//  GameNewsView.swift
//  SteamGames
//
//  Created by ramil on 29.05.2023.
//

import UIKit

protocol GameNewsViewProtocol: AnyObject {
    func reloadTableView()
    func hidePulledRefreshIndicator()
}

fileprivate enum Constant {
    static let screenTitle = "Новости"
}

final class GameNewsView: UIViewController {

    //MARK: - Properties
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
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSubviews()
        configureRefreshControl()
        presenter?.getGameNews(requestType: .initialLoad)
    }
    
    //MARK: - Private methods
    private func setupView() {
        navigationItem.largeTitleDisplayMode = .never
        title = Constant.screenTitle
        view.backgroundColor = Color.lightGray
    }
    
    private func configureRefreshControl() {
       tableView.refreshControl = UIRefreshControl()
       tableView.refreshControl?.addTarget(self, action:
                                          #selector(handleRefreshControl),
                                          for: .valueChanged)
    }
    
    @objc
    private func handleRefreshControl(_sender: UIRefreshControl) {
        presenter?.getGameNews(requestType: .refreshLoad)
    }
    
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
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return presenter?.getAppNewsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let article = presenter?.getArticleForApp(from: indexPath)
        presenter?.showDetailArticle(for: article)
    }
}

//MARK: - GameNewsPresenter delegate
extension GameNewsView: GameNewsViewProtocol {
    
    func hidePulledRefreshIndicator() {
        tableView.refreshControl?.endRefreshing()
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
}
