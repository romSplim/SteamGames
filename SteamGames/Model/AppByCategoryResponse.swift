//
//  AppByCategoryResponse.swift
//  SteamGames
//
//  Created by ramil on 05.06.2023.
//

import Foundation

struct AppsByCategory: Decodable {
    let response: Response
}

// MARK: - Response
struct Response: Decodable {
    var apps: [AppItem]
}

// MARK: - App
struct AppItem: Decodable {
    let appID: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case appID = "appid"
        case name
    }
}
