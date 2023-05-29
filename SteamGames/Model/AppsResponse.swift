//
//  GamesResponse.swift
//  SteamGames
//
//  Created by ramil on 27.05.2023.
//

import Foundation

struct AppsResponse: Decodable {
    let appList: Apps
}

//MARK: - CodingKeys
extension AppsResponse {
    
    enum CodingKeys: String, CodingKey {
        case appList = "applist"
    }
}

struct Apps: Decodable {
    let apps: [App]
}

struct App: Decodable {
    let appID: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case appID = "appid"
        case name
    }
}
