//
//  NetworkError.swift
//  SteamGames
//
//  Created by ramil on 27.05.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case cannotDecode
    
    var message: String {
        switch self {
        case .invalidURL:
            return ""
        case .cannotDecode:
            return ""
        }
    }
}
