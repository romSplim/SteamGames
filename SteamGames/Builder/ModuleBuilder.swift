//
//  ModuleBuilder.swift
//  SteamGames
//
//  Created by ramil on 27.05.2023.
//

import UIKit

class ModuleBuilder {
    
    func buildListAppsModule(router: Router) -> UIViewController {
        let view = ListGamesController()
        let networkService = NetworkService()
        let presenter = ListGamesPresenter(view: view,
                                           networkService: networkService)
        view.presenter = presenter
        return view
    }
//    
//    func buildCurrencyPairsView(for picker: PickerType, with data: [String], router: Router, delegate: ListPairsPresenterDelegate) -> UIViewController {
//        let view = ListPairsView()
//        let networkService = NetworkService()
//        let presenter = ListPairsPresenter(for: picker, data: data, view: view, router: router, networkService: networkService)
//        presenter.delegate = delegate
//        view.presenter = presenter
//        return view
//    }
}
