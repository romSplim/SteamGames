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
    private var apps: [App]?
    private var searchingResult: [App]?
    private let filteringQueue = DispatchQueue(label: "filteringQueue")
    
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
        return apps?.count ?? 0
    }
    
    func getAppForRow(from indexPath: IndexPath,
                      isFiltering: Bool) -> App? {
        if isFiltering {
            return searchingResult?[indexPath.row]
        }
        return apps?[indexPath.row]
    }
    
    func getAppList(requestType: RequestType) {
        networkService.getAllApps { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let apps):
                self.removeEmptyApps(from: apps) { filteredApps in
                    self.apps = filteredApps
                    DispatchQueue.main.async {
                        self.updateUI(for: requestType)
                    }
                }
            case .failure(let failure):
                print(failure)
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
            self.searchingResult = self.apps?.filter { app in app.name.lowercased().contains(name.lowercased())
            }
            
            DispatchQueue.main.async {
                self.view?.reloadTableView()
            }
        }
    }
    
    func removeEmptyApps(from appsData: [App],
                         completion: @escaping ([App]) -> Void) {
        filteringQueue.async {
            let filteredData = appsData.filter { !$0.name.isEmpty }
            completion(filteredData)
        }
    }
    
    func showNews(for model: App?) {
        guard let model else { return }
        router.pushGameNewsView(with: model)
    }
}

