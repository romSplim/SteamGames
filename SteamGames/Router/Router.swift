//
//  Router.swift
//  SteamGames
//
//  Created by ramil on 27.05.2023.
//

import UIKit

class Router {
    
    private var builder: ModuleBuilder?
    private var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController, builder: ModuleBuilder) {
        self.navigationController = navigationController
        self.builder = builder
    }

    func initialController() {
        guard
            let navigationController = navigationController,
            let initialController = builder?.buildListAppsModule(router: self) else { return }
        
        navigationController.viewControllers = [initialController]
    }
    
//    func pushCurrencyPairsView(for picker: PickerType, with data: [String], delegate: ListPairsPresenterDelegate) {
//        guard let navigationController,
//              let currencyController = builder?.buildCurrencyPairsView(for: picker, with: data, router: self, delegate: delegate) else { return }
//        
//        navigationController.pushViewController(currencyController, animated: true)
//    }
}

