//
//  AppCategory.swift
//  SteamGames
//
//  Created by ramil on 03.06.2023.
//

import Foundation

enum AppCategory: CaseIterable {
    case games
    case dlc
    case other
    
    var name: String {
        switch self {
        case .games:
            return "Игры"
        case .dlc:
            return "Дополнения"
        case .other:
            return "Остальное"
        }
    }
    
    private var allQuery: [String: String] {
        return ["key": "7A0996180F48AB5A094358860BF95F9E",
                "include_games": "false",
                "include_dlc": "false",
                "include_videos": "false",
                "include_software": "false",
                "include_hardware": "false",
                "max_results": "50000"]
    }
    
    var searchQuery: [String: String] {
        var query = allQuery
        
        switch self {
        case .games:
            query["include_games"] = "true"
            return query
                  
            
        case .dlc:
            query["include_dlc"] = "true"
            return query
            
            
        case .other:
            query["include_videos"] = "true"
            query["include_software"] = "true"
            query["include_hardware"] = "true"
            return query
        }
    }
}
