//
//  APIManager.swift
//  SteamGames
//
//  Created by ramil on 29.05.2023.
//

import Foundation

enum APIManager {
    case getNewsForApp(appID: Int)
    case getAppsByCategory(_ category: AppCategory)
    
    //MARK: - Properties
    private var baseUrl: String {
        return "https://api.steampowered.com"
    }
    
    private var path: String {
        switch self {
        case .getNewsForApp(_):
            return "/ISteamNews/GetNewsForApp/v2/"
            
        case .getAppsByCategory(_):
            return "/IStoreService/GetAppList/v1/"
        }
    }
    
    private var queryItems: [URLQueryItem] {
        switch self {
        case .getAppsByCategory(let category):
            return category.searchQuery.map {
                URLQueryItem(name: $0.key,
                             value: $0.value)
            }
            
        case .getNewsForApp(let appID):
            return [
                URLQueryItem(name: "appid", value: "\(appID)")
            ]
        }
    }
    
    var url: URL? {
        var components = URLComponents(string: baseUrl)
        components?.path = path
        components?.queryItems = queryItems
        return components?.url
    }
}
