//
//  ListGamesController.swift
//  SteamGames
//
//  Created by ramil on 27.05.2023.
//

import UIKit

protocol ListGamesControllerProtocol: AnyObject {
    func reloadTableView()
}

fileprivate enum Constant {
    static let screenTitle = "Игры"
    static let searchPlaceholder = "Type something here to search"
}

final class ListGamesController: UIViewController {
    
    //MARK: - Properties
    var presenter: ListGamesPresenter?
    
    private var searchController = UISearchController()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AppCell.self, forCellReuseIdentifier: AppCell.identifier)
        return tableView
    }()
    
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupSearchBar()
        presenter?.getAppList()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        title = Constant.screenTitle
    }
    
    //MARK: - Private methods
    private func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Constant.searchPlaceholder
        navigationItem.searchController = searchController
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

//MARK: - UISearchController delegate
extension ListGamesController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        presenter?.searchApp(with: searchText)
    }
}

//MARK: - UITableView dataSource
extension ListGamesController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getAppsCount(isFiltering: isFiltering) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppCell.identifier, for: indexPath) as? AppCell else {
            return UITableViewCell()
        }

        let app = presenter?.getAppForRow(from: indexPath,
                                          isFiltering: isFiltering)
        cell.configure(with: app)
        
        return cell
    }
}

//MARK: - UITableView delegate
extension ListGamesController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let app = presenter?.getAppForRow(from: indexPath,
                                          isFiltering: isFiltering)
        presenter?.showNews(for: app)
    }
}

//MARK: - ListGamesPresenter delegate
extension ListGamesController: ListGamesControllerProtocol {
    func reloadTableView() {
        self.tableView.reloadData()
    }
}
