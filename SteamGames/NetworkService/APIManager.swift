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
    
    //MARK: - Private properties
    private var baseUrl: String {
        return "https://api.steampowered.com"
    }
    
    private var path: String {
        switch self {
        case .getAllApps:
            return "/ISteamApps/GetAppList/v2"
        case .getNewsForApp(_):
            return "/ISteamNews/GetNewsForApp/v2/"
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
        }
    }
    
    var url: URL? {
        var components = URLComponents(string: baseUrl)
        components?.path = path
        components?.queryItems = queryItems
        return components?.url
    }
}
