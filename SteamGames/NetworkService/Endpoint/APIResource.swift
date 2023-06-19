//
//  Request.swift
//  SteamGames
//
//  Created by ramil on 19.06.2023.
//

import Foundation

protocol APIResource {
    var path: String { get }
    var queryItems: [String: String]? { get }
}

extension APIResource {

    private static var key: String {
        return "7A0996180F48AB5A094358860BF95F9E"
    }
        
    var url: URL? {
        var components = URLComponents(string: "https://api.steampowered.com")
        components?.path = path
    
        if let queryItems {
            components?.queryItems = queryItems.map {
                URLQueryItem(name: $0.key,
                             value: $0.value)
            }
        }
        components?.queryItems?.append(URLQueryItem(name: "key",
                                                    value: Self.key))
        return components?.url
    }
}
