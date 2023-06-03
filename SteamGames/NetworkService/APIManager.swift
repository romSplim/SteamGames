//
//  APIManager.swift
//  SteamGames
//
//  Created by ramil on 29.05.2023.
//

import Foundation

enum APIManager {
    case getAllApps
    case getNewsForApp(appID: Int)
    case getAppType(appID: Int)
    
    //MARK: - Properties
    private var baseUrl: String {
        switch self {
        case .getAllApps,
                .getNewsForApp(_):
            return "https://api.steampowered.com"
            
        case .getAppType(_):
            return "https://store.steampowered.com"
        }
    }
    
    private var path: String {
        switch self {
        case .getAllApps:
            return "/ISteamApps/GetAppList/v2"
        case .getNewsForApp(_):
            return "/ISteamNews/GetNewsForApp/v2/"
        case .getAppType(_):
            return "/api/appdetails"
        }
    }
    
    private var queryItems: [URLQueryItem] {
        switch self {
        case .getAllApps:
            return []
            
        case .getNewsForApp(let appID):
            return [
                URLQueryItem(name: "appid", value: "\(appID)")
            ]
            
        case .getAppType(let appID):
            return [
                URLQueryItem(name: "appids", value: "\(appID)")
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
