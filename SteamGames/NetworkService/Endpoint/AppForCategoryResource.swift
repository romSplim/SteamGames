//
//  AppForCategoryResource.swift
//  SteamGames
//
//  Created by ramil on 19.06.2023.
//

import UIKit

struct AppForCategoryResource: APIResource {
    
    //MARK: - Properties
    var searchCategory: AppCategory
    var path: String = "/IStoreService/GetAppList/v1/"
    
    var queryItems: [String: String]? {
        return searchCategory.searchQuery
    }
    
    //MARK: - Init
    init(category: AppCategory) {
        self.searchCategory = category
    }
}
