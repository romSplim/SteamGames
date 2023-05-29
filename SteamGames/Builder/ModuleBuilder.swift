//
//  ModuleBuilder.swift
//  SteamGames
//
//  Created by ramil on 27.05.2023.
//

import UIKit

final class ModuleBuilder {
    
    func buildListAppsModule(router: Router) -> UIViewController {
        let view = ListGamesController()
        let networkService = NetworkService()
        let presenter = ListGamesPresenter(view: view,
                                           networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func buildGameNewsView(with model: App, router: Router) -> UIViewController {
        let view = GameNewsView()
        let networkService = NetworkService()
        let presenter = GameNewsPresenter(app: model, view: view,
                                          networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
}
