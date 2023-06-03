//
//  AppType.swift
//  SteamGames
//
//  Created by ramil on 01.06.2023.
//

import Foundation


// MARK: - AppType
struct AppTypeResponse: Decodable {
    let appData: AppData

    
    private struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int?
        
        init?(intValue: Int) {
            return nil
        }
        
    }
    
    init(from decoder: Decoder) throws {
        
        // 1
        // Create a decoding container using DynamicCodingKeys
        // The container will contain all the JSON first level key
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        var tempApp: AppData?
        print(container.allKeys)
        // 2
        // Loop through each key (student ID) in container
        for case let key in container.allKeys {
            print(key.stringValue)
            
            // Decode Student using key & keep decoded Student object in tempArray
            let object = try container.decode(AppData.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            tempApp = object
        }
        
        
        appData = tempApp!
    }
}


struct AppData: Decodable {
    let success: Bool
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let type, name: String
    let steam_appid: Int
}




