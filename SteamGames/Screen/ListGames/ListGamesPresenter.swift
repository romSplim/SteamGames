//
//  ListGamesPresenter.swift
//  SteamGames
//
//  Created by ramil on 27.05.2023.
//

import UIKit

final class ListGamesPresenter {
    
    //MARK: - Properties
    weak var view: ListGamesControllerProtocol?
    private var router: Router
    var networkService: NetworkService
    var apps: [App]?
    var filteredApps: [App]?
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
    func getAppsCount() -> Int {
        return apps?.count ?? 0
    }
    
    func getFilteredAppsCount() -> Int {
        return filteredApps?.count ?? 0
    }
    
    func getAppForRow(from indexPath: IndexPath) -> App? {
        return apps?[indexPath.row]
    }
    
    func getFilteredAppForRow(from indexPath: IndexPath) -> App? {
        return filteredApps?[indexPath.row]
    }
    
    func getAppList() {
        networkService.getAllApps { result in
            switch result {
            case .success(let apps):
                self.apps = apps
                DispatchQueue.main.async {
                    self.view?.reloadTableView()
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func searchApp(with name: String) {
        filteringQueue.async {
            self.filteredApps = self.apps?.filter { app in app.name.lowercased().contains(name.lowercased())
            }
            
            DispatchQueue.main.async {
                self.view?.reloadTableView()
            }
        }
    }
    
    func showNewsForApp(with model: App?) {
        guard let model else { return }
        router.pushCurrencyPairsView(with: model)
    }

}
