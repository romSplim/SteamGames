//
//  ListGamesPresenter.swift
//  SteamGames
//
//  Created by ramil on 27.05.2023.
//

import UIKit

final class ListGamesPresenter {
    
    //MARK: - Properties
    private weak var view: ListGamesControllerProtocol?
    private var router: Router
    private var networkService: NetworkService
    
    private var appResponse: Response?
    private var searchingResult: [AppItem]?
    
    private let filteringQueue = DispatchQueue(label: "filteringQueue",
                                               qos: .userInitiated)
    
    //MARK: - Init
    init(view: ListGamesControllerProtocol?,
         networkService: NetworkService,
         router: Router) {
        
        self.view = view
        self.networkService = networkService
        self.router = router
    }
    
    //MARK: - Methods
    func getAppsCount(isFiltering: Bool) -> Int {
        if isFiltering {
            return searchingResult?.count ?? 0
        }
        return appResponse?.apps.count ?? 0
    }
    
    func getAppForRow(from indexPath: IndexPath,
                      isFiltering: Bool) -> AppItem? {
        if isFiltering {
            return searchingResult?[indexPath.row]
        }
        return appResponse?.apps[indexPath.row]
    }
    
    func getAppsByCategory(category: AppCategory,
                           requestType: RequestType) {
        self.view?.updateContentState(.loading)
        
        networkService.getAppByCategory(with: category) { result in
            switch result {
            case .success(let apps):
                self.appResponse = apps
                
                DispatchQueue.main.async {
                    self.updateUI(for: requestType)
                    self.view?.updateContentState(.populated)
                }
                
            case .failure(let failure):
                print(failure.message)
            }
        }
    }
    
    private func updateUI(for type: RequestType) {
        switch type {
        case .initialLoad:
            self.view?.reloadTableView()
        case .refreshLoad:
            self.view?.hidePulledRefreshIndicator()
        }
    }
    
    func searchApp(with name: String) {
        filteringQueue.async {
            self.searchingResult = self.appResponse?.apps.filter { $0.name.lowercased().contains(name.lowercased())
            }
            
            DispatchQueue.main.async {
                self.view?.reloadTableView()
            }
        }
    }
    
    func showNews(for model: AppItem?) {
        guard let model else { return }
        router.pushGameNewsView(with: model)
    }
}

