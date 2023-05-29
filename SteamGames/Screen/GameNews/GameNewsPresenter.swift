//
//  GameNewsPresenter.swift
//  SteamGames
//
//  Created by ramil on 29.05.2023.
//

import Foundation

final class GameNewsPresenter {
    
    //MARK: - Properties
    private weak var view: GameNewsViewProtocol?
    private var networkService: NetworkService
    private var router: Router
    
    private var app: App
    private var appNews: Appnews?
    
    //MARK: - Init
    init(app: App,
         view: GameNewsViewProtocol?,
         networkService: NetworkService,
         router: Router) {
        
        self.app = app
        self.view = view
        self.networkService = networkService
        self.router = router
    }
    
    //MARK: - Methods
    func getAppNewsCount() -> Int {
        return appNews?.count ?? 0
    }
    
    func getArticleForApp(from indexPath: IndexPath) -> NewsItem? {
        return appNews?.newsItems[indexPath.row]
    }
    
    func getGameNews() {
        networkService.getAppNews(with: app.appID) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let news):
                self.appNews = news
                DispatchQueue.main.async {
                    self.view?.reloadTableView()
                }
            case .failure(let failure):
                print(failure.message)
            }
        }
    }
    
    func showDetailArticle(for article: NewsItem?) {
        guard let article else { return }
        router.pushDetailArticleView(with: article)
    }
}
