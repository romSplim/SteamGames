//
//  ListGamesController.swift
//  SteamGames
//
//  Created by ramil on 27.05.2023.
//

import UIKit

protocol ListGamesControllerProtocol: AnyObject {
    func reloadTableView()
    func hidePulledRefreshIndicator()
    func updateContentState(_ state: ListGamesController.ContentState)
}

fileprivate enum Constant {
    static let screenTitle = "Каталог"
    static let searchPlaceholder = "Введите название игры"
}

final class ListGamesController: UIViewController {
    
    enum ContentState {
        case loading
        case populated
    }
    
    //MARK: - Properties
    var presenter: ListGamesPresenter?
    
    private let activityIndicator = UIActivityIndicatorView()
    private let searchController = UISearchController()
    private let searchingSegments = AppCategory.allCases
    
    private var contentState: ContentState = .loading {
        didSet {
            applyStateToView()
        }
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AppCell.self, forCellReuseIdentifier: AppCell.identifier)
        return tableView
    }()
    
    private var selectedSearchingIndex: Int {
        return searchController.searchBar.selectedScopeButtonIndex
    }
    
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.color = .red
        setupView()
        setupSubviews()
        setupSearchBar()
        setupRefreshControl()
        presenter?.getAppsByCategory(category: .games,
                                         requestType: .initialLoad)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        activityIndicator.center = view.center
    }
    
    //MARK: - Private methods
    private func applyStateToView() {
        switch contentState {
            
        case .loading:
            tableView.isHidden = true
            activityIndicator.startAnimating()
            activityIndicator.isHidden = false
            
        case .populated:
            tableView.isHidden = false
            activityIndicator.stopAnimating()
        }
    }
    
    private func setupView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        title = Constant.screenTitle
    }
    
    private func setupRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action:
                                            #selector(handleRefreshControl),
                                            for: .valueChanged)
    }
    
    @objc
    private func handleRefreshControl(_ sender: UIRefreshControl) {
        let category = searchingSegments[selectedSearchingIndex]
        presenter?.getAppsByCategory(category: category,
                                     requestType: .refreshLoad)
    }
    
    private func setupSearchBar() {
        let searchBar = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchBar.placeholder = Constant.searchPlaceholder
        searchBar.showsScopeBar = true
        searchBar.delegate = self
        searchBar.scopeButtonTitles = searchingSegments.map { $0.name }
        navigationItem.searchController = searchController
    }
    
    private func setupSubviews() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension ListGamesController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        contentState = .loading
        let categoty = searchingSegments[selectedScope]
        presenter?.getAppsByCategory(category: categoty,
                                     requestType: .initialLoad)
    }
}

//MARK: - UISearchController delegate
extension ListGamesController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text,
              !searchText.isEmpty else {
            return
        }
        presenter?.searchApp(with: searchText)
    }
}

//MARK: - UITableView dataSource
extension ListGamesController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        return presenter?.getAppsCount(isFiltering: isFiltering) ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let app = presenter?.getAppForRow(from: indexPath,
                                          isFiltering: isFiltering)
        presenter?.showNews(for: app)
    }
}

//MARK: - ListGamesPresenter delegate
extension ListGamesController: ListGamesControllerProtocol {
    func updateContentState(_ state: ContentState) {
        self.contentState = state
    }
    
    func hidePulledRefreshIndicator() {
        tableView.refreshControl?.endRefreshing()
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
}
