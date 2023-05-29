//
//  Router.swift
//  SteamGames
//
//  Created by ramil on 27.05.2023.
//

import UIKit

final class Router {
    
    //MARK: - Private properties
    private var builder: ModuleBuilder?
    private var navigationController: UINavigationController?
    
    //MARK: - Init
    init(navigationController: UINavigationController,
         builder: ModuleBuilder) {
        
        self.navigationController = navigationController
        self.builder = builder
    }

    //MARK: - Methods
    func initialController() {
        guard
            let navigationController = navigationController,
            let initialController = builder?.buildListAppsModule(router: self) else { return }
        
        navigationController.viewControllers = [initialController]
    }
    
    func pushGameNewsView(with model: App) {
        guard
            let navigationController,
            let gameNewsController = builder?.buildGameNewsView(with: model, router: self) else { return }
        
        navigationController.pushViewController(gameNewsController, animated: true)
    }
    
    func pushDetailArticleView(with model: NewsItem) {
        guard
            let navigationController,
            let detailArticleController = builder?.buildDetailArticleView(with: model, router: self) else { return }
        
        navigationController.pushViewController(detailArticleController, animated: true)
    }
}

