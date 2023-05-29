//
//  DetailArticlePresenter.swift
//  SteamGames
//
//  Created by ramil on 29.05.2023.
//

import UIKit

final class DetailArticlePresenter {
    
    private weak var view: DetailArticleViewProtocol?
    private var router: Router
    
    private var article: NewsItem?
    
    init(article: NewsItem,
         view: DetailArticleViewProtocol,
         router: Router) {
        
        self.article = article
        self.view = view
        self.router = router
    }
    
    func getArticle() -> NewsItem? {
        return article
    }
}
