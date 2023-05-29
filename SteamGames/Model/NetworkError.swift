//
//  NetworkError.swift
//  SteamGames
//
//  Created by ramil on 27.05.2023.
//

import Foundation

enum NetworkError: String, Error {
    case invalidURL
    case cannotDecode
    
    var message: String {
        switch self {
        case .invalidURL:
            return self.rawValue
        case .cannotDecode:
            return self.rawValue
        }
    }
}
